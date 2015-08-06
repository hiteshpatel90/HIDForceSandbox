public class opportunityTriggerHandler{
    private static final set<String> setExceptionProfiles = new set<String>{
        'HID Business Administrator',
        'System Administrator',
        'HID Integration User'
    };
    static Id idOpportunityRecordTypeCPO = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('CPO Opportunity').getRecordTypeId();
    private static String strUserProfileName = [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name;
    
    public static void oppAccountProfileValidation(List<Opportunity> lstOpportunityNew){
        set<String> sOppPrimaryBussSeg = new set<String>();
        set<Id> sAccId = new set<Id>();
        for(Opportunity opp: lstOpportunityNew){
             if(opp.AccountId != null && opp.Business_Segment__c != null && opp.RecordTypeId == idOpportunityRecordTypeCPO && !setExceptionProfiles.contains(strUserProfileName)){
                 sOppPrimaryBussSeg.add(opp.Business_Segment__c);
                 sAccId.add(opp.AccountId);
             }
        }
        if(!sOppPrimaryBussSeg.isEmpty() && !sAccId.isEmpty()){
            Map<Id, String> mapAccProfileSeg = new Map<Id, String>();
            List<Account_Profile__c> lstAccountProfile = [select id, Account__c, Business_Segment__c from Account_Profile__c where Business_Segment__c in: sOppPrimaryBussSeg and Account__c IN :sAccId];
            for(Account_Profile__c accProfile: lstAccountProfile){
                mapAccProfileSeg.Put(accProfile.Account__c, accProfile.Business_Segment__c);
            }
            system.debug('@@@@@@@@@@@'+mapAccProfileSeg);

            for(Opportunity opp: lstOpportunityNew){
                system.debug('@@@@@@@@@@@'+opp.RecordTypeId + '&&&&&&'+ idOpportunityRecordTypeCPO );
                system.debug('@@@@@@@@@@@'+setExceptionProfiles);
                if(opp.AccountId != null && opp.RecordTypeId == idOpportunityRecordTypeCPO && !setExceptionProfiles.contains(strUserProfileName)){
                    if(mapAccProfileSeg.size() == 0 || (mapAccProfileSeg.get(opp.Accountid) != null && !mapAccProfileSeg.get(opp.Accountid).contains(opp.Business_Segment__c))){
                        opp.addError('The Account does not have a Profile for the selected Primary Opportunity Business Segment.');
                    }
                }
            }
            
        }
    }
    
    public static void oppCPOLastApprovalValidation(List<Opportunity> lstOpportunityNew){
        for(Opportunity opp: lstOpportunityNew){
            if(opp.CPO_Status__c == 'Converted' && opp.Customer_Signature_Obtained__c == 'No'){
                opp.addError('Please set Customer Signature Obtained for this Opportunity.<br/>' +  '<a style="font-weight:bold; color:#015BA7" href="/' + opp.id + '">' + opp.Name + '</a>');
            }
        }
    
    }
    public static void populateBussandRegSegmentLeader(List<Opportunity> lstOpportunityNew, Map<Id, Opportunity> mapOpportunityOld){
        set<String> sBusinessSegment = new set<String>();
        set<String> sOppRegion = new set<String>();
        List<Product_Team__c> lstProductTeam;
        for(Opportunity opp: lstOpportunityNew){
            if(Trigger.isInsert){
                sBusinessSegment.add(opp.Business_Segment__c);
                sOppRegion.add(opp.Region__c);
            }else if(Trigger.isUpdate){
                if(opp.Business_Segment__c != mapOpportunityOld.get(opp.id).Business_Segment__c || opp.Region__c != mapOpportunityOld.get(opp.id).Region__c){
                    sBusinessSegment.add(opp.Business_Segment__c);
                    sOppRegion.add(opp.Region__c);
                }
            }            
        }
        if(!sBusinessSegment.isEmpty()){
            lstProductTeam = [select id, Business_Segment__c, Business_Segment_Leader__c, Product_Line__c, Region__c, Regional_Segment_Director__c, Product_Marketing_Manager__c, Engineering_Site_Manager__c from Product_Team__c where Business_Segment__c IN: sBusinessSegment or Region__c IN: sOppRegion]; 
            system.debug('@@@@@@@@2'+lstProductTeam );
            if(!lstProductTeam.isEmpty()){
                Map<string, ID> mapBussinessSegLeader = new Map<string, ID>();
                Map<string, ID> mapRegionalSegDirector = new Map<string, ID>();
                for(Product_Team__c pt: lstProductTeam){
                    if(pt.Business_Segment_Leader__c != null){
                        mapBussinessSegLeader.Put(pt.Business_Segment__c, pt.Business_Segment_Leader__c);
                    }
                    if(pt.Regional_Segment_Director__c != null){
                        mapRegionalSegDirector.Put(pt.Business_Segment__c + ' ' + pt.Region__c, pt.Regional_Segment_Director__c);
                    }
                }
                Map<Id, Opportunity> OpportunityMap = new  Map<Id, Opportunity>();
                Opportunity objOpp;
                system.debug('@@@@@@@@mapBussinessSegLeader'+mapBussinessSegLeader);
                for(Opportunity opp: lstOpportunityNew){
                    system.debug('@@@@@@@@mapBussinessSegLeader'+opp.Business_Segment_Leader__c);
                    if(opp.Business_Segment_Leader__c == null){
                        objOpp = new Opportunity(id=opp.id);                    
                        objOpp.Business_Segment_Leader__c = mapBussinessSegLeader.get(opp.Business_Segment__c);
                        OpportunityMap.Put(objOpp.id, objOpp);
                    }
                    if(opp.Regional_Segment_Director__c == null){
                        if(OpportunityMap.containskey(opp.id)){
                            objOpp = OpportunityMap.get(opp.id);
                            objOpp.Regional_Segment_Director__c = mapRegionalSegDirector.get(opp.Business_Segment__c + ' ' + opp.Region__c);
                        }else{
                            objOpp = new Opportunity(id=opp.id);                        
                            objOpp.Regional_Segment_Director__c = mapRegionalSegDirector.get(opp.Business_Segment__c + ' ' + opp.Region__c);
                            OpportunityMap.Put(objOpp.id, objOpp);
                        }
                    }
                    
                }
                system.debug('@@@@@@@@2'+OpportunityMap);
                if(!OpportunityMap.isEmpty()){
                    update OpportunityMap.values();
                }
            }
        }
    }
    public static void insertChatterFollowerofOpp(List<Opportunity> lstOpportunityNew, Map<Id, Opportunity> mapOpportunityOld){
        map<Id, set<Id>> mapFollowers = new map<Id, set<Id>>();
        set<Id> sFollowers = new set<Id>();
        set<Id> sOppId = new set<Id>();
        
        String strCPORecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('CPO Opportunity').getRecordTypeId();
       
        
        List<EntitySubscription> lstEntitySubscriptionInsert = new List<EntitySubscription>();
        for(Opportunity opp: lstOpportunityNew){
            system.debug('@@@@@@@@@'+opp.RecordType.DeveloperName );
            if(opp.RecordTypeId == strCPORecTypeId){
                sFollowers = new set<Id>();
                
                if(Trigger.isInsert){
                    // Owner                
                    sFollowers.add(opp.ownerid);                
                    
                    // Created By
                    sFollowers.add(opp.createdbyId);
                    
                    // Product Marketing Manager
                    if(opp.Product_Marketing_Manager__c != null){
                        sFollowers.add(opp.Product_Marketing_Manager__c);                     
                    }
                    
                    // Engineering Site Manager
                    if(opp.Engineering_Site_Manager__c != null){
                        sFollowers.add(opp.Engineering_Site_Manager__c);                    
                    }
                    
                    // Project Manager
                    if(opp.Project_Manager__c != null){
                        sFollowers.add(opp.Project_Manager__c);
                    }
                    
                    // Business Segment Leader
                    if(opp.Business_Segment_Leader__c != null){
                        sFollowers.add(opp.Business_Segment_Leader__c);
                    }
                    
                    // Regional Segment Director
                    if(opp.Regional_Segment_Director__c != null){
                        sFollowers.add(opp.Regional_Segment_Director__c);
                    }
                    sOppId.add(opp.Id);
                }else if(Trigger.isUpdate){
                    // Owner
                    if(opp.ownerid != null){                   
                        sFollowers.add(opp.ownerid);
                        //if(opp.ownerid != mapOpportunityOld.get(opp.id).ownerid){       
                            sOppId.add(opp.Id);
                       // }
                    }         
                    
                    
                    // Product Marketing Manager
                    if(opp.Product_Marketing_Manager__c != null){
                        sFollowers.add(opp.Product_Marketing_Manager__c);
                        if(opp.Product_Marketing_Manager__c != mapOpportunityOld.get(opp.id).Product_Marketing_Manager__c){
                            sOppId.add(opp.Id);
                        }
                    }
                    
                    // Engineering Site Manager
                    if(opp.Engineering_Site_Manager__c != null){
                        sFollowers.add(opp.Engineering_Site_Manager__c);
                        if(opp.Engineering_Site_Manager__c != mapOpportunityOld.get(opp.id).Engineering_Site_Manager__c){
                            sOppId.add(opp.Id);
                        }
                    }
                    
                    // Project Manager
                    if(opp.Project_Manager__c != null){
                        sFollowers.add(opp.Project_Manager__c);
                        if(opp.Project_Manager__c != mapOpportunityOld.get(opp.id).Project_Manager__c){
                            sOppId.add(opp.Id);
                        }
                    }
                    
                    // Business Segment Leader
                    if(opp.Business_Segment_Leader__c != null){
                        sFollowers.add(opp.Business_Segment_Leader__c);
                        if(opp.Business_Segment_Leader__c != mapOpportunityOld.get(opp.id).Business_Segment_Leader__c){
                            sOppId.add(opp.Id);
                        }
                    }
                    
                    // Regional Segment Director
                    if(opp.Regional_Segment_Director__c != null){
                        sFollowers.add(opp.Regional_Segment_Director__c);
                        if(opp.Regional_Segment_Director__c != mapOpportunityOld.get(opp.id).Regional_Segment_Director__c){
                            sOppId.add(opp.Id);
                        }
                    }
                }
                mapFollowers.Put(opp.id, sFollowers);
            }
        }
        system.debug('@@@@@@@@@@@@@'+mapFollowers);
        if(!mapFollowers.isEmpty()){
            Map<Id, List<EntitySubscription>> mapOppwithFollowers = new Map<Id, List<EntitySubscription>>();
            for(EntitySubscription es: [select id, ParentId, SubscriberId  from EntitySubscription where ParentId IN: sOppId]){
                if(mapOppwithFollowers.containsKey(es.ParentId)){
                    mapOppwithFollowers.get(es.ParentId).add(es);
                }else{
                    mapOppwithFollowers.put(es.ParentId, new List<EntitySubscription>{es});
                }
            }
    
            List<EntitySubscription> lstEntitySubscriptionRemove = new List<EntitySubscription>();     
            for(Opportunity opp: lstOpportunityNew){
                if(opp.RecordTypeId == strCPORecTypeId){
                    List<EntitySubscription> lstEntitySubscription = new List<EntitySubscription>();
                    if(mapOppwithFollowers.containsKey(opp.id)){
                        
                        lstEntitySubscription = mapOppwithFollowers.get(opp.id);
                        for(EntitySubscription es: lstEntitySubscription){
                            Boolean blnIsExistFollower = false;
                            for(Id follower: mapFollowers.get(opp.id)){                                         
                               if(es.ParentId == follower){
                                   blnIsExistFollower = true;
                               }
                           }
                           if(blnIsExistFollower == false){
                               lstEntitySubscriptionRemove.add(es);
                           }
                        }
                    }
                    for(Id follower: mapFollowers.get(opp.id)){                
                        EntitySubscription objEntitySubscription = new EntitySubscription();
                        objEntitySubscription.ParentId = opp.id;
                        objEntitySubscription.SubscriberId = follower;
                        lstEntitySubscriptionInsert.add(objEntitySubscription);                
                    }
                }           
            }
            if(!lstEntitySubscriptionRemove.isempty()){
                delete lstEntitySubscriptionRemove;
            }
            if(!lstEntitySubscriptionInsert.isEmpty()){
                system.debug('@@@@@@@@@@@@@'+lstEntitySubscriptionInsert);
                database.insert(lstEntitySubscriptionInsert, false);
            }
        }
    }
    public static void cpoApprovalFieldUpdates(List<Opportunity> lstOpportunityNew, Map<Id, Opportunity> mapOpportunityOld){
        List<Opportunity> lstOppUpdate = new List<Opportunity>();
        User currentUser = [select id, Skip_CPO_Sales_Approver__c, CPO_Sales_Approver__c from user where id =: system.userinfo.getUserid()];
        
        
        for(Opportunity opp: lstOpportunityNew){
            if(opp.CPO_Status__c == 'Submitted' && mapOpportunityOld.get(opp.id).CPO_Status__c != 'Submitted'){
                Opportunity objOpp = new Opportunity(id=opp.id);
                if(currentUser.Skip_CPO_Sales_Approver__c == false && currentUser.CPO_Sales_Approver__c != null){
                    objOpp.Sales_Manager_Approval__c = 'Awaiting Approval';
                }
                if(objOpp.Regional_Segment_Director_Approval__c != null || objOpp.Regional_Segment_Director_Approval__c != ''){
                    objOpp.Regional_Segment_Director_Approval__c = 'Awaiting Approval';
                }
                if(objOpp.Product_Marketing_Approval__c != null || objOpp.Product_Marketing_Approval__c != ''){
                    objOpp.Product_Marketing_Approval__c = 'Awaiting Approval';
                }
                if(objOpp.Engineering_Input_Approval__c != null || objOpp.Engineering_Input_Approval__c != ''){
                    objOpp.Engineering_Input_Approval__c = 'Awaiting Approval';
                }
                if(objOpp.Product_Post_Engineering_Approval__c != null ||  objOpp.Product_Post_Engineering_Approval__c != ''){
                    objOpp.Product_Post_Engineering_Approval__c = 'Awaiting Approval';
                }
                if(objOpp.Business_Segment_Leader_Approval__c != null || objOpp.Business_Segment_Leader_Approval__c != ''){
                    objOpp.Business_Segment_Leader_Approval__c = 'Awaiting Approval';
                }
                if(objOpp.Opportunity_Owner_Approval__c != null || objOpp.Opportunity_Owner_Approval__c != ''){
                    objOpp.Opportunity_Owner_Approval__c = 'Awaiting Approval';
                }
                lstOppUpdate.add(objOpp);
            }else if(opp.CPO_Status__c == 'Draft' && mapOpportunityOld.get(opp.id).CPO_Status__c != 'Draft'){
                Opportunity objOpp = new Opportunity(id=opp.id);
                objOpp.Sales_Manager_Approval__c = '';
                objOpp.Regional_Segment_Director_Approval__c = '';
                objOpp.Product_Marketing_Approval__c = '';
                objOpp.Engineering_Input_Approval__c = '';
                objOpp.Product_Post_Engineering_Approval__c = '';
                objOpp.Business_Segment_Leader_Approval__c = '';
                objOpp.Opportunity_Owner_Approval__c = '';
                lstOppUpdate.add(objOpp);
            }        
        }
        if(!lstOppUpdate.isEmpty()){
            update lstOppUpdate;
        }
    }    
}