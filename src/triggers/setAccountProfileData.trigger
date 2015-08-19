trigger setAccountProfileData on Account_Profile__c (before insert, before update) {
	
	utilController uCtrl = new utilController();

    map<String, Currencies__c> mapCurrencies = new map<String,Currencies__c>();
    for(Currencies__c c : Currencies__c.getAll().values()){
    	if(c.Default__c == true){
	    	mapCurrencies.put(
	    		c.Sub_Region__c,
	    		c
	    	);
    	}
    }	
    map<String,Countries__c> mapCountries = new map<String,Countries__c>();
    for(Countries__c c : Countries__c.getAll().values()){
        mapCountries.put(
        	c.Country__c,
        	c
        );
    }
    
	set<Id> setAccounts = new set<Id>();
    set<Id> setAccountClusters = new set<Id>();
    list<Account_Profile__c> lstAccountProfiles = new list<Account_Profile__c>();
    list<Account_Profile__c> lstAccountClusterProfiles = new list<Account_Profile__c>();
    list<Account_Profile__c> lstAccountProfilesAccountTierDiscountDelete = new list<Account_Profile__c>(); 

    for(Account_Profile__c a : trigger.new){
        if(a.Account__c != null){
            setAccounts.add(a.Account__c);
            lstAccountProfiles.add(a);
        }else if(a.Account_Cluster__c != null){
            setAccountClusters.add(a.Account_Cluster__c);
            lstAccountClusterProfiles.add(a);
        }
        if(
            trigger.isUpdate
            && a.Account__c != null
            && trigger.oldMap.get(a.Id).Tier__c != null
            && a.Tier__c == null
        ){
            lstAccountProfilesAccountTierDiscountDelete.add(a);
        }
    }

	//Remove obsolete Account Tier Discounts
    if(!lstAccountProfilesAccountTierDiscountDelete.isEmpty()){
        String strSql = 'SELECT Id FROM Account_Tier_Discount__c WHERE ';
        for(Account_Profile__c a : lstAccountProfilesAccountTierDiscountDelete){
        	String strAccount = a.Account__c;
        	String strBusinessSegment = a.Business_Segment__c;
        	strSql += '(Account__c =: strAccount AND Tier_Discount__r.Business_Segment__c =: strBusinessSegment) OR ';
        }
        strSql = strSql.substring(0, strSql.length() - 4);
        list<Account_Tier_Discount__c> lstAccountTierDiscountDelete = Database.query(strSql);
        delete lstAccountTierDiscountDelete;
    }

    if(!setAccounts.isEmpty()){
    	
    	//Check for duplicate Business Segment (Accounts)
        if(trigger.isInsert){
            list<Account_Profile__c> lstProfiles = uCtrl.getLstAccountProfiles(setAccounts);
            for(Account_Profile__c t : lstAccountProfiles){
            	for(Account_Profile__c a : lstProfiles){
                    if(
                        a.Account__c == t.Account__c
                        && a.Business_Segment__c == t.Business_Segment__c
                    ){
                        t.Business_Segment__c.addError('A Profile with this Program Category already exists');
                        break;
                    }
                }
            }
        }
    
        map<Id,Account> mapAccounts = uCtrl.getMapAccounts(setAccounts);
        if(!mapAccounts.isEmpty()){
            for(Account_Profile__c t : lstAccountProfiles){
            	//Set Price Book Currency
                if(
                	t.Pricebook_Currency__c == null
                	&& mapAccounts.get(t.Account__c).Sub_Region__c != null
                ){
                    t.Pricebook_Currency__c = mapCurrencies.get(mapAccounts.get(t.Account__c).Sub_Region__c).Currency__c;
                }
				//Set Market Size
                if(
                    t.Market_Size__c == null
                    && mapAccounts.get(t.Account__c).BillingCountry != null
                ){
                    if(t.Business_Segment__c == 'Identity Assurance'){
                        t.Market_Size__c = mapCountries.get(mapAccounts.get(t.Account__c).BillingCountry).Identity_Assurance_Market_Size__c;
                    }else if(t.Business_Segment__c == 'PACS'){
                        t.Market_Size__c = mapCountries.get(mapAccounts.get(t.Account__c).BillingCountry).PACS_Market_Size__c;
                    }else if(t.Business_Segment__c == 'Secure Issuance'){
                        t.Market_Size__c = mapCountries.get(mapAccounts.get(t.Account__c).BillingCountry).Secure_Issuance_Market_Size__c;
                    }
                }
            }
        }
    }else if(!setAccountClusters.isEmpty()){
    	
		//Get Account Cluster Members
		map<Id,Account_Cluster_Member__c> mapAccountClusterAccounts = uCtrl.getMapClusterMembers(setAccountClusters);
		set<Id> setAccountClusterAccounts = new set<Id>();
        map<Id,list<Id>> mapAccountClusterMembers = new map<Id,list<Id>>();
        for(Account_Cluster_Member__c a : mapAccountClusterAccounts.values()){
        	setAccountClusterAccounts.add(a.Account__c);
            list<Id> l = mapAccountClusterMembers.get(a.Account_Cluster__c);
            if(l == null){
                l = new list<Id>();
            }
            l.add(a.Account__c);
            mapAccountClusterMembers.put(
            	a.Account_Cluster__c,
            	l
            );
        }
    	
	    //Get Account Cluster and Account Profiles
	    map<String,map<Id,list<Account_Profile__c>>> mapProfiles = uCtrl.getMapProfiles(setAccountClusterAccounts, setAccountClusters);
	    map<Id,list<Account_Profile__c>> mapAccountProfiles = mapProfiles.get('Account');
	    map<Id,list<Account_Profile__c>> mapAccountClusterProfiles = mapProfiles.get('Cluster');
    	
        if(trigger.isInsert){
            //Check for duplicate Business Segment (Account Clusters)
            for(Account_Profile__c t : lstAccountClusterProfiles){
            	if(mapAccountClusterProfiles.containsKey(t.Account_Cluster__c)){
            		for(Account_Profile__c a : mapAccountClusterProfiles.get(t.Account_Cluster__c)){
	                    if(
	                        a.Account_Cluster__c == t.Account_Cluster__c
	                        && a.Business_Segment__c == t.Business_Segment__c
	                    ){
	                        t.Business_Segment__c.addError('A Profile with this Program Category already exists');
	                        break;
	                    }
            		}
            	}
            }
        }
        
        map<Id,Account> mapAccounts = uCtrl.getMapAccounts(setAccountClusterAccounts);
        map<Id,Account_Cluster__c> mapClusters = uCtrl.getMapClusters(setAccountClusters);
        list<Account_Profile__c> lstAccountProfilesUpsert = new list<Account_Profile__c>();
        for(Account_Profile__c t : lstAccountClusterProfiles){
        	//Set Market Size
            if(t.Market_Size__c == null){
                if(
                    mapClusters.get(t.Account_Cluster__c).Region__c == 'NAM'
                    || mapClusters.get(t.Account_Cluster__c).Region__c == 'LAM'
                ){
                    t.Market_Size__c = 'AME-Large';
                }else if(mapClusters.get(t.Account_Cluster__c).Region__c == 'ASI'){
                    t.Market_Size__c = 'ASI-Regional';
                }else if(mapClusters.get(t.Account_Cluster__c).Region__c == 'EMEA'){
                    t.Market_Size__c = 'EMEA-Regional';
                }
            }
            //Copy/Update Account Cluster Profiles to Account Profiles
            if(mapAccountClusterMembers.get(t.Account_Cluster__c) != null){
                for(Id i : mapAccountClusterMembers.get(t.Account_Cluster__c)){
                    Account_Profile__c objAccountProfile = new Account_Profile__c(
                    	Account__c = i,
                        Market_Size__c = t.Market_Size__c,
                        Business_Segment__c = t.Business_Segment__c,
                        Program_Category__c = t.Business_Segment__c,
                        Partner_Type__c = t.Partner_Type__c,
                        Tier__c = t.Tier__c,
                        Requested_Tier_Expiration_Date__c = t.Requested_Tier_Expiration_Date__c,
                        Recommended_Tier__c = t.Recommended_Tier__c,
                        Customer_Service_Rep__c = t.Customer_Service_Rep__c,
                        Inside_Sales_Rep__c = t.Inside_Sales_Rep__c,
                        National_Account__c = t.National_Account__c,
                        National_Account_Manager__c = t.National_Account_Manager__c,
                        Sales_Manager__c = t.Sales_Manager__c,
                        OwnerId = t.OwnerId
                    );
                    if(mapAccountProfiles.containsKey(i)){
                    	for(Account_Profile__c a : mapAccountProfiles.get(i)){
	                    	if(t.Business_Segment__c == a.Business_Segment__c){
	                   			objAccountProfile.Id = a.Id;
	                    		break;
	                    	}
                    	}
                    }
                    //Set Price Book Currency
	                if(
	                	t.Pricebook_Currency__c == null
	                	&& mapAccounts.get(i).Sub_Region__c != null
	                ){
	                    objAccountProfile.Pricebook_Currency__c = mapCurrencies.get(mapAccounts.get(i).Sub_Region__c).Currency__c;
	                }
                    lstAccountProfilesUpsert.add(objAccountProfile);
                }
            }
        }
        upsert lstAccountProfilesUpsert;
    }
}