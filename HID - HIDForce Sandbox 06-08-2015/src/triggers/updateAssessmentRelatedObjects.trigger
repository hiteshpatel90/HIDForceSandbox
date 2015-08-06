trigger updateAssessmentRelatedObjects on Assessment__c (after insert, after update) {
    
	utilController uCtrl = new utilController();
	
	//Account/Account Cluster Variables
    map<Id,Assessment__c> mapAccountAssessments = new map<Id,Assessment__c>();
    map<Id,Assessment__c> mapClusterAssessments = new map<Id,Assessment__c>();
    
    //Approval Variables
    set<Assessment__c> setAssessments = new set<Assessment__c>();
    set<Id> setCreatedBys = new set<Id>();
    set<Id> setAccounts = new set<Id>();
    set<Id> setClusters = new set<Id>();
    
    for(Assessment__c a : trigger.new){
        if(a.Approval_Status__c == 'Approved'){
            if(a.Account__c != null){
            	mapAccountAssessments.put(
            		a.Account__c,
            		a
            	);
            }else if(a.Account_Cluster__c != null){
            	mapClusterAssessments.put(
            		a.Account_Cluster__c,
            		a
            	);
            }
        }else if(
            a.Approval_Status__c == 'Draft'
            || (
                a.Approval_Status__c == 'Awaiting Approval'
                && trigger.oldMap.get(a.Id).Approval_Status__c == 'Rejected'
            )
        ){
            setAssessments.add(a);
            setCreatedBys.add(a.CreatedById);
            if(a.Account__c != null){
                setAccounts.add(a.Account__c);
            }else if(a.Account_Cluster__c != null){
                setClusters.add(a.Account_Cluster__c);
            }
        }
    }
    
    //Update Approval Settings
    if(
        !setAssessments.isEmpty()
        && !utilController.bolFirstExecution
    ){
        utilController.bolFirstExecution = true;
        
        //Get Global Accounts/Account Clusters for E21/E21VP Approval
        map<Id,Account> mapAccounts = uCtrl.getMapAccounts(setAccounts);
        map<Id,Account_Cluster__c> mapClusters = uCtrl.getMapClusters(setClusters);

		//Get Approvers
        map<Id, Role_Hierarchy_Approval__c> mapRoleHierarchyApprovals = new map<Id, Role_Hierarchy_Approval__c>();
        for(Role_Hierarchy_Approval__c r : [
            SELECT
                Id,
                Full_Name__c,
                L1_Approver__c,
                E21_Approver__c,
                L2_Approver__c,
                E21VP_Approver__c,
                Program_Management_Approver__c
            FROM
                Role_Hierarchy_Approval__c
            WHERE
                Full_Name__c IN : setCreatedBys
        ]){
            mapRoleHierarchyApprovals.put(
            	r.Full_Name__c,
            	r
            );
        }
        
        //Get approved Assessments to consider previously approved Tier for Approval
        map<Id, list<Assessment__c>> mapApprovedAssessments = new map<Id, list<Assessment__c>>();
        for(Assessment__c a : [
            SELECT
                Id,
                Account__c,
                Account_Cluster__c,
                Business_Segment__c,
                Requested_Tier__c
            FROM
                Assessment__c
            WHERE
                Approval_Status__c = 'Approved'
                AND (
                    Account__c IN : setAccounts
                    OR Account_Cluster__c IN : setClusters
                )
        ]){
            Id aId;
            if(a.Account__c != null){
                aId = a.Account__c;
            }else if(a.Account_Cluster__c != null){
                aId = a.Account_Cluster__c;
            }
            list<Assessment__c> l = mapApprovedAssessments.get(aId);
            if(l == null){
                l = new list<Assessment__c>();
            }
            l.add(a);
            mapApprovedAssessments.put(
            	aId,
            	l
            );
        }
        
        try{
        	//Populate Approval Fields
            list<Assessment__c> lstAssessments = new list<Assessment__c>();
            for(Assessment__c a : setAssessments){
                Assessment__c aa = new Assessment__c(
                    Id = a.Id,
                    L1_Approval_Needed__c = false,
                    L2_Approval_Needed__c = false,
                    E21_Approval_Needed__c = false,
                    E21VP_Approval_Needed__c = false,
                    Is_Program_Management_Approval_Needed__c = false,
                    L1_Approval__c = 'Not Required',
                    L2_Approval__c = 'Not Required',
                    E21_Approval__c = 'Not Required',
                    E21VP_Approval__c = 'Not Required',
                    Program_Management_Approval__c = 'Not Required',
                    L1_Approver__c = mapRoleHierarchyApprovals.get(a.CreatedById).L1_Approver__c,
                    E21_Approver__c = mapRoleHierarchyApprovals.get(a.CreatedById).E21_Approver__c,
                    L2_Approver__c = mapRoleHierarchyApprovals.get(a.CreatedById).L2_Approver__c,
                    E21VP_Approver__c = mapRoleHierarchyApprovals.get(a.CreatedById).E21VP_Approver__c,
                    Program_Management_Approver__c = mapRoleHierarchyApprovals.get(a.CreatedById).Program_Management_Approver__c
                );
                aa.Program_Management_Approval__c = aa.Program_Management_Approver__c != null ? 'Required' : 'Not Required';
                aa.Is_Program_Management_Approval_Needed__c = aa.Program_Management_Approver__c != null ? true : false;
                
                //Get previously Approved Tier to determine required approval level
                Id aaaId;
                String aaaRequestedTier;
                if(a.Account__c != null){
                    aaaId = a.Account__c;
                }else if(a.Account_Cluster__c != null){
                    aaaId = a.Account_Cluster__c;
                }
                if(mapApprovedAssessments.containsKey(aaaId)){
                    for(Assessment__c aaa : mapApprovedAssessments.get(aaaId)){
                        if(aaa.Business_Segment__c == a.Business_Segment__c){
                            aaaRequestedTier = aaa.Requested_Tier__c;
                        }
                    }
                }
                
                //No additional Approval if all Tiers are Silver
                if(
                    aaaRequestedTier != null
                    && a.Requested_Tier__c == a.Recommended_Tier__c
                    && a.Requested_Tier__c == aaaRequestedTier
   	            ){
                    lstAssessments.add(aa);
                    continue;
                }
                if(
                    a.Requested_Tier__c != 'Silver'
                    || a.Recommended_Tier__c != 'Silver'
                    || aaaRequestedTier != 'Silver'
                ){
                    aa.L1_Approval_Needed__c = aa.L1_Approver__c != null ? true : false;
                    aa.L1_Approval__c = aa.L1_Approver__c != null ? 'Required' : 'Not Required';
                    if(a.Account__c != null){
                        aa.E21_Approval_Needed__c = (mapAccounts.get(a.Account__c).E_21_Account__c == 'Yes' && aa.E21_Approver__c != null) ? true : false;
                        aa.E21_Approval__c = (mapAccounts.get(a.Account__c).E_21_Account__c == 'Yes' && aa.E21_Approver__c != null) ? 'Required' : 'Not Required';
                    }else if(a.Account_Cluster__c != null){
                        aa.E21_Approval_Needed__c = (mapClusters.get(a.Account_Cluster__c).Cluster_Type__c == 'Global' && aa.E21_Approver__c != null) ? true : false;
                        aa.E21_Approval__c = (mapClusters.get(a.Account_Cluster__c).Cluster_Type__c == 'Global' && aa.E21_Approver__c != null) ? 'Required' : 'Not Required';
                    }
                    if(
                        a.Requested_Tier__c == 'Platinum'
                        || a.Recommended_Tier__c == 'Platinum'
                        || aaaRequestedTier == 'Platinum'
                    ){
                        aa.L2_Approval_Needed__c = aa.L2_Approver__c != null ? true : false;
                        aa.L2_Approval__c = aa.L2_Approver__c != null ? 'Required' : 'Not Required';
                        if(a.Account__c != null){
                            aa.E21VP_Approval_Needed__c = (mapAccounts.get(a.Account__c).E_21_Account__c == 'Yes' && aa.E21VP_Approver__c != null) ? true : false;
                            aa.E21VP_Approval__c = (mapAccounts.get(a.Account__c).E_21_Account__c == 'Yes' && aa.E21VP_Approver__c != null) ? 'Required' : 'Not Required';
                        }else if(a.Account_Cluster__c != null){
                            aa.E21VP_Approval_Needed__c = (mapClusters.get(a.Account_Cluster__c).Cluster_Type__c == 'Global' && aa.E21VP_Approver__c != null) ? true : false;
                            aa.E21VP_Approval__c = (mapClusters.get(a.Account_Cluster__c).Cluster_Type__c == 'Global' && aa.E21VP_Approver__c != null) ? 'Required' : 'Not Required';
                        }
                    }
                }
                lstAssessments.add(aa);
            }
            update lstAssessments;
        }catch(Exception e){
            system.debug('Exception: ' + e.getMessage());
        }
    }
    
    //Query for existing vPAFs to prevent duplicate on update
    set<Id> setVPAFAccounts = new set<Id>();
    for(Price_Authorization_Form__c p : [
        SELECT
            Account__c
        FROM
            Price_Authorization_Form__c
        WHERE
            Assessment__c IN : trigger.newMap.keySet()
    ]){
        setVPAFAccounts.add(p.Account__c);
    }
    
    //Update Cluster Assessment related objects
    if(!mapClusterAssessments.isEmpty()){
		map<Id,Account_Cluster_Member__c> mapClusterMembers = uCtrl.getMapClusterMembers(mapClusterAssessments.keySet());

        //Get Account Cluster Member Accounts, Account Regions, ERP Update Accounts and Brazilian Accounts for vPAF exclusion
        set<Id> setBrazilAccounts = new set<Id>();
        set<Id> setClusterAccounts = new set<Id>();
        list<Account> lstERPUpdateAccounts = new list<Account>();
        map<Id,set<Id>> mapClusterAccounts = new map<Id,set<Id>>();
        
        for(Account_Cluster_Member__c a : mapClusterMembers.values()){
            setClusterAccounts.add(a.Account__c);
            set<Id> s = mapClusterAccounts.get(a.Account_Cluster__c);
            if(s == null){
                s = new set<Id>();
            }
            s.add(a.Account__c);
            mapClusterAccounts.put(
                a.Account_Cluster__c,
                s
            );
        	if(a.Account__r.BillingCountry == 'Brazil'){
        		setBrazilAccounts.add(a.Account__c);
        	}
        	if(
        		a.Account__r.ERP_Update__c != true
        		&& a.Account__r.ERP_Update_Date__c == null
        		&& a.Account__r.Oracle_Customer_Number__c != null
        	){
	            Account aa = new Account(
	                Id = a.Account__c,
	                ERP_Update__c = true
	            );
	            lstERPUpdateAccounts.add(aa);
        	}
        }
        update lstERPUpdateAccounts;
        
		//Deprecate old approved assessment records (allow only one approved Assessment)
        if(!utilController.bolFirstExecution2){
            utilController.bolFirstExecution2 = true;
            uCtrl.deprecateApprovedAssessments(trigger.newMap.keySet(), mapClusterAssessments);
        }
        
        //Update Account Profile Tier
        set<Id> setClusterIds = new set<Id>();
        setClusterIds.addAll(setClusterAccounts);
        setClusterIds.addAll(mapClusterAssessments.keySet());
        list<Account_Profile__c> listProfiles = uCtrl.getLstAccountProfiles(setClusterIds);
        list<Account_Profile__c> lstUpdateProfiles = new list<Account_Profile__c>();
        map<Id,Assessment__c> mapProfileAssessments = new map<Id,Assessment__c>();
        for(Assessment__c a : mapClusterAssessments.values()){
        	for(Account_Profile__c p : listProfiles){
        		if(
        			p.Business_Segment__c == a.Business_Segment__c
	                && p.Partner_Type__c == a.Partner_Type__c
        		){
                    Id idProfile;
                    if(
                    	p.Account_Cluster__c != null
                    	&& p.Account_Cluster__c == a.Account_Cluster__c
                    ){
                    	idProfile = p.Id;
        			}else if(p.Account__c != null){
        				if(mapClusterAccounts.get(a.Account_Cluster__c).contains(p.Account__c)){
        					idProfile = p.Id;
        					mapProfileAssessments.put(
        						p.Id,
        						a
        					);
        				}
        			}
	                if(idProfile != null){
	                    Account_Profile__c aa = new Account_Profile__c(
	                        Tier__c = a.Requested_Tier__c,
	                        Recommended_Tier__c = a.Recommended_Tier__c,
	                        Requested_Tier_Expiration_Date__c = a.Requested_Tier_Expiration_Date__c
	                    );
	                	aa.Id = idProfile;
	                	lstUpdateProfiles.add(aa);
	                }
                }
            }
        }
        update lstUpdateProfiles;
        
        //Remove Accounts w. Billing Country = Brazil, Partner Program Status != In Progress, Enrolled or missing Partner Program
       	set<Id> setAccountPartnerPrograms = uCtrl.getSetAccountPartnerPrograms(setClusterAccounts);
       	setClusterAccounts.removeAll(setBrazilAccounts);
   		setClusterAccounts.retainAll(setAccountPartnerPrograms);
        for(Id i : mapClusterAccounts.keySet()){
        	set<Id> s = mapClusterAccounts.get(i);
        	s.removeAll(setBrazilAccounts);
        	s.retainAll(setAccountPartnerPrograms);
        	mapClusterAccounts.put(
        		i,
        		s
        	);
        }
        if(!utilController.bolClusterAssessment){
        	utilController.bolClusterAssessment = true;
        	uCtrl.createProfilevPAFs(setClusterAccounts, null, mapProfileAssessments);
        }
    }
    
    //Update Account Assessment related objects
    if(!mapAccountAssessments.isEmpty()){
		map<Id,Account> mapAccounts = uCtrl.getMapAccounts(mapAccountAssessments.keySet());    	

        //Set ERP Update on Account (first Assessment, required for ERP integration), get Brazilian Accounts for vPAF exclusion
        set<Id> setBrazilAccounts = new set<Id>();
        list<Account> lstAccountsUpdate = new list<Account>();
        for(Account a : mapAccounts.values()){
        	if(a.BillingCountry == 'Brazil'){
        		setBrazilAccounts.add(a.Id);
        	}
        	if(
        		a.ERP_Update__c != true
        		&& a.ERP_Update_Date__c == null
        		&& a.Oracle_Customer_Number__c != null
        	){        	
            	Account aa = new Account(
                	Id = a.Id,
                	ERP_Update__c = true
            	);
            	lstAccountsUpdate.add(aa);
        	}
        }
        update lstAccountsUpdate;
        
        //Deprecate old approved assessment records (allow only one approved Assessment)
        if(!utilController.bolFirstExecution3){
            utilController.bolFirstExecution3 = true;
            uCtrl.deprecateApprovedAssessments(trigger.newMap.keySet(), mapAccountAssessments);
        }
        
        //Update Account Profile Tier
        list<Account_Profile__c> lstAccountProfiles = uCtrl.getLstAccountProfiles(mapAccountAssessments.keySet());
        list<Account_Profile__c> lstUpdateAccountProfiles = new list<Account_Profile__c>();
        map<Id,Assessment__c> mapProfileAssessments = new map<Id,Assessment__c>();
        for(Assessment__c a : mapAccountAssessments.values()){
            for(Account_Profile__c p : lstAccountProfiles){
                if(
                    p.Account__c == a.Account__c
                    && p.Business_Segment__c == a.Business_Segment__c
                    && p.Partner_Type__c == a.Partner_Type__c
                ){
                    Account_Profile__c pp = new Account_Profile__c(
                        Id = p.Id,
                        Tier__c = a.Requested_Tier__c,
                        Recommended_Tier__c = a.Recommended_Tier__c,
                        Requested_Tier_Expiration_Date__c = a.Requested_Tier_Expiration_Date__c
                    );
                    lstUpdateAccountProfiles.add(pp);
                    mapProfileAssessments.put(
                    	p.Id,
                    	a
                    );
                    break;
                }
            }
        }
        update lstUpdateAccountProfiles;
                
        //Remove Accounts w. Billing Country = 'Brazil', Partner Program Status != In Progress, Enrolled or missing Partner Program
        set<Id> setAccountPartnerPrograms = uCtrl.getSetAccountPartnerPrograms(mapAccountAssessments.keySet());
        mapAccounts.keySet().removeAll(setBrazilAccounts);
        mapAccounts.keySet().retainAll(setAccountPartnerPrograms);
        
        if(!utilController.bolAccountAssessment){
        	utilController.bolAccountAssessment = true;
        	uCtrl.createProfilevPAFs(mapAccounts.keySet(), null, mapProfileAssessments);
        }
    }
}