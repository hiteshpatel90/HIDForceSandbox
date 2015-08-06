public class utilController {

    public list<SelectOption> getIntOptions(Integer intExit){
        list<SelectOption> o = new list<SelectOption>();
        for(Integer i=0;i<=intExit;i++){
            o.add(new SelectOption(String.valueOf(i),String.valueOf(i)));
        }
        return o;
    }
    public list<SelectOption> getStrOptions(list<String> lstOptions, Boolean bolNone){
        list<SelectOption> o = new list<SelectOption>();
        if(bolNone){
            o.add(new SelectOption('','--None--'));
        }
        for(String s : lstOptions){
            o.add(new SelectOption(s,s));
        }
        return o;
    }
    public list<SelectOption> getVarOptions(map<String,String> mapOptions){
        list<SelectOption> o = new list<SelectOption>();
        for(String s : mapOptions.keySet()){
            o.add(new SelectOption(s,mapOptions.get(s)));
        }
        o.sort();
        return o;
    }
    public list<SelectOption> getOptions(list<Schema.PicklistEntry> lstPicklist, Boolean bolNone){
        list<SelectOption> o = new list<SelectOption>();
        if(bolNone){
            o.add(new SelectOption('','--None--'));
        }
        for(Schema.PicklistEntry p : lstPicklist){
            o.add(new SelectOption(p.getLabel(),p.getValue()));
        }
        return o;
    }
    public list<String> getFieldList(list<list<String>> lstString){
        list<String> r = new list<String>();
        for(list<String> l : lstString){
            r.addAll(l);
        }
        return r;
    }
    
    public void deprecateApprovedAssessments(set<Id> setTrigger, map<Id,Assessment__c> mapAssessments){
        list<Assessment__c> lstUpdateAssessments = new list<Assessment__c>();
        set<Id> setAccounts = new set<Id>();
        set<Id> setAccountClusters = new set<Id>();
        
        for(Id i : mapAssessments.keySet()){
            if(i.getSobjectType() == Schema.Account.SObjectType){
                setAccounts.add(i);
            }else if(i.getSobjectType() == Schema.Account_Cluster__c.SObjectType){
                setAccountClusters.add(i);
            }
        }
        
        for(Assessment__c a : [
            SELECT
                Id,
                Account__c,
                Account_Cluster__c,
                Approval_Status__c,
                Business_Segment__c
            FROM
                Assessment__c
            WHERE
                Id NOT IN : setTrigger
                AND (
                    Account__c IN : setAccounts
                    OR Account_Cluster__c IN : setAccountClusters
                )
                AND Approval_Status__c = 'Approved'
        ]){
            for(Id i : mapAssessments.keySet()){
                if(
                    (
                        a.Account__c == i
                        || a.Account_Cluster__c == i
                    )
                    && a.Business_Segment__c == mapAssessments.get(i).Business_Segment__c
                ){
                    Assessment__c aa = new Assessment__c(
                        Id = a.Id,
                        Approval_Status__c = 'Deprecated'
                    );
                    lstUpdateAssessments.add(aa);
                }
            }
        }
        update lstUpdateAssessments;
    }
    
    public list<Account_Tier_Discount__c> getLstAccountTierDiscounts(set<Id> setAccounts){
        list<Account_Tier_Discount__c> lstAccountTierDiscounts = new list<Account_Tier_Discount__c>([
            SELECT
                Id,
                Account__c,
                Tier_Discount__c,
                Tier_Discount__r.Business_Segment__c,
                Tier_Discount__r.Price_Code__c,
                Tier_Discount__r.Price_Code_Letters__c,
                Tier_Discount__r.Numeric_Discount__c,
                Tier_Discount__r.Discount__c,
                Override_Discount__c,
                Price_Authorization_Form__c,
                Tier_Discount__r.Price_Code_Value__c,
                Tier_Discount__r.Tier__c,
                Tier_Discount__r.Partner_Type__c
            FROM
                Account_Tier_Discount__c
            WHERE
                Account__c IN : setAccounts
        ]);
        return lstAccountTierDiscounts;
    }
    
    public set<Id> getSetAccountPartnerPrograms(set<Id> setAccounts){
        set<Id> setAccountPartnerPrograms = new set<Id>();
        
        for(Partner_Program__c p : [
            SELECT
                Id,
                Account__c,
                Partner_Program_Status__c
            FROM
                Partner_Program__c
            WHERE
                Account__c IN : setAccounts
                AND RecordTypeId =: utilController.idAdvantagePartnerRecordType
                AND (
                    Partner_Program_Status__c = 'In Progress'
                    OR Partner_Program_Status__c = 'Enrolled'
                )
        ]){
            setAccountPartnerPrograms.add(p.Account__c);
        }
        return setAccountPartnerPrograms;
    }
    
    public list<Account_Profile__c> getLstAccountProfiles(set<Id> setObjects){
        list<Account_Profile__c> lstAccountProfiles = new list<Account_Profile__c>([
            SELECT
                Id,
                Account__c,
                Account_Cluster__c,
                Business_Segment__c,
                Partner_Type__c,
                Tier__c,
                Market_Size__c,
                Requested_Tier_Expiration_Date__c,
                Recommended_Tier__c,
                Customer_Service_Rep__c,
                Inside_Sales_Rep__c,
                National_Account__c,
                National_Account_Manager__c,
                Sales_Manager__c,
                CreatedById,
                OwnerId,
                Account__r.Oracle_Customer_Number__c
            FROM
                Account_Profile__c
            WHERE (
                Account__c IN : setObjects
                OR Account_Cluster__c IN : setObjects
            )
        ]);
        return lstAccountProfiles;
    }
    
    public map<String,map<Id,list<Account_Profile__c>>> getMapProfiles(set<Id> setAccounts, set<Id> setAccountClusters){        
        map<String,map<Id,list<Account_Profile__c>>> mapProfiles = new map<String,map<Id,list<Account_Profile__c>>>();
        map<Id,list<Account_Profile__c>> mapAccountProfiles = new map<Id,list<Account_Profile__c>>();
        map<Id,list<Account_Profile__c>> mapAccountClusterProfiles = new map<Id,list<Account_Profile__c>>();
        
        for(Account_Profile__c a : [
            SELECT
                Id,
                Account__c,
                Account_Cluster__c,
                Business_Segment__c,
                Partner_Type__c,
                Tier__c,
                Market_Size__c,
                Requested_Tier_Expiration_Date__c,
                Recommended_Tier__c,
                Customer_Service_Rep__c,
                Inside_Sales_Rep__c,
                National_Account__c,
                National_Account_Manager__c,
                Sales_Manager__c,
                CreatedById,
                OwnerId,
                Account__r.Oracle_Customer_Number__c
            FROM
                Account_Profile__c
            WHERE (
                Account__c IN : setAccounts
                OR Account_Cluster__c IN : setAccountClusters
            )
        ]){
            if(a.Account_Cluster__c != null){
                list<Account_Profile__c> l = mapAccountClusterProfiles.get(a.Account_Cluster__c);
                if(l == null){
                    l = new list<Account_Profile__c>();         
                }
                l.add(a);
                mapAccountClusterProfiles.put(
                    a.Account_Cluster__c,
                    l
                );
            }else if(a.Account__c != null){
                list<Account_Profile__c> l = mapAccountProfiles.get(a.Account__c);
                if(l == null){
                    l = new list<Account_Profile__c>();
                }
                l.add(a);
                mapAccountProfiles.put(
                    a.Account__c,
                    l
                );
            }
        }
        mapProfiles.put(
            'Account',
            mapAccountProfiles
        );
        mapProfiles.put(
            'Cluster',
            mapAccountClusterProfiles
        );
        return mapProfiles;
    }
    
    public map<Id,set<String>> getMapAssessmentAccountTierDiscountsOverride(map<Id,Assessment__c> mapAssessments, list<Account_Tier_Discount__c> lstAccountTierDiscounts, map<Id,set<Id>> mapClusterAccounts, String strTier){
        map<Id,set<String>> mapAccountTierDiscountsOverride = new map<Id,set<String>>();
        map<Id,Account_Tier_Discount__c> mapAccountTierDiscountsDelete = new map<Id,Account_Tier_Discount__c>();
        
        for(Assessment__c a : mapAssessments.values()){
            for(Account_Tier_Discount__c t : lstAccountTierDiscounts){
                if(
                    a.Business_Segment__c == t.Tier_Discount__r.Business_Segment__c
                    || t.Tier_Discount__r.Business_Segment__c == null
                ){
                    Id idAccount;
                    if(mapClusterAccounts != null){
                        if(mapClusterAccounts.get(a.Account_Cluster__c).contains(t.Account__c)){
                            idAccount = t.Account__c;
                        }
                    }else if(a.Account__c == t.Account__c){
                        idAccount = t.Account__c;
                    }
                    if(idAccount != null){
                        if(
                            t.Override_Discount__c != null
                            || (
                                t.Tier_Discount__r.Business_Segment__c == null
                                && t.Tier_Discount__r.Tier__c == strTier
                            )
                        ){
                            set<String> s = mapAccountTierDiscountsOverride.get(t.Account__c);
                            if(s == null){
                                s = new set<String>();
                            }
                            s.add(t.Tier_Discount__r.Price_Code_Letters__c);
                            mapAccountTierDiscountsOverride.put(
                                t.Account__c,
                                s
                            );
                        }else{
                            mapAccountTierDiscountsDelete.put(
                                t.Id,
                                t
                            );
                        }
                    }
                }
            }
        }
        delete mapAccountTierDiscountsDelete.values();
        return mapAccountTierDiscountsOverride;
    }
    
    public map<Id,set<String>> getMapProfileAccountTierDiscountsOverride(list<Account_Profile__c> lstProfiles, list<Account_Tier_Discount__c> lstAccountTierDiscounts, String strTier){
        map<Id,set<String>> mapAccountTierDiscountsOverride = new map<Id,set<String>>();
        map<Id,Account_Tier_Discount__c> mapAccountTierDiscountsDelete = new map<Id,Account_Tier_Discount__c>();
        
        for(Account_Profile__c a : lstProfiles){
            for(Account_Tier_Discount__c t : lstAccountTierDiscounts){
                if(
                    a.Account__c == t.Account__c
                    && (
                        a.Business_Segment__c == t.Tier_Discount__r.Business_Segment__c
                        || t.Tier_Discount__r.Business_Segment__c == null
                    )
                ){
                    if(
                        t.Override_Discount__c != null
                        || (
                            t.Tier_Discount__r.Business_Segment__c == null
                            && t.Tier_Discount__r.Tier__c == strTier
                        )
                    ){
                        set<String> s = mapAccountTierDiscountsOverride.get(a.Account__c);
                        if(s == null){
                            s = new set<String>();
                        }
                        s.add(t.Tier_Discount__r.Price_Code_Letters__c);
                        mapAccountTierDiscountsOverride.put(
                            a.Account__c,
                            s
                        );
                    }else{
                        mapAccountTierDiscountsDelete.put(
                            t.Id,
                            t
                        );
                    }
                }
            }
        }
        delete mapAccountTierDiscountsDelete.values();
        return mapAccountTierDiscountsOverride;
    }
    
    public map<Id,Account_Cluster_Member__c> getMapClusterMembers(set<Id> setIds){
        map<Id,Account_Cluster_Member__c> mapClusterMembers = new map<Id,Account_Cluster_Member__c>();
        for(Account_Cluster_Member__c a : [
            SELECT
                Id,
                Account__c,
                Account_Cluster__c,
                Account__r.BillingCountry,
                Account__r.E_21_Account__c,
                Account__r.Region__c,
                Account__r.Sub_Region__c,
                Account__r.ERP_Update__c,
                Account__r.ERP_Update_Date__c,
                Account__r.Oracle_Customer_Number__c
            FROM
                Account_Cluster_Member__c
            WHERE
                Account__c IN : setIds
                OR Account_Cluster__c IN : setIds
        ]){
            mapClusterMembers.put(
                a.Account__c,
                a
            );
        }
        return mapClusterMembers;
    }
    
    public map<Id,Account> getMapAccounts(set<Id> setAccounts){
        map<Id,Account> mapAccounts = new map<Id,Account>([
            SELECT
                Id,
                BillingCountry,
                E_21_Account__c,
                Region__c,
                Sub_Region__c,
                ERP_Update__c,
                ERP_Update_Date__c,
                Oracle_Customer_Number__c
            FROM
                Account
            WHERE
                Id IN : setAccounts
        ]);
        return mapAccounts;
    }
    
    public map<Id,Account_Cluster__c> getMapClusters(set<Id> setClusters){
        map<Id,Account_Cluster__c> mapClusters = new map<Id,Account_Cluster__c>([
            SELECT
                Id,
                Name,
                Cluster_Type__c,
                Region__c
            FROM
                Account_Cluster__c
            WHERE
                Id IN : setClusters
        ]);
        return mapClusters;
    }
    
    public list<Account_Tier_Discount__c> getLstAccountTierDiscountCommonPriceCodes(map<Id,set<String>> mapCommonDiscountAccounts, String strTier){
        list<Account_Tier_Discount__c> lstAccountTierDiscountCommonDiscounts = new list<Account_Tier_Discount__c>();
        for(Id i : mapCommonDiscountAccounts.keySet()){
            for(String s : mapCommonDiscountAccounts.get(i)){
                for(Tier_Discount__c t : utilController.lstTierDiscountCommonPriceCodes){
                    if(
                        s == t.Price_Code_Letters__c
                        && strTier == t.Tier__c
                    ){
                        Account_Tier_Discount__c a = new Account_Tier_Discount__c(
                            Account__c = i,
                            Tier_Discount__c = t.Id
                        );
                        lstAccountTierDiscountCommonDiscounts.add(a);
                    }
                }
            }
        }
        return lstAccountTierDiscountCommonDiscounts;
    }
    
    public list<Price_Authorization_Form__c> getLstAssessmentPriceAuthorizationFormCommonPriceCodes(map<Id,Assessment__c> mapAssessments, map<Id,set<String>> mapCommonDiscountAccounts, String strTier){
        list<Price_Authorization_Form__c> lstPriceAuthorizationFormCommonPriceCodes = new list<Price_Authorization_Form__c>();
        map<Id,Account> mapAccounts = new map<Id,Account>([
            SELECT
                Id,
                Oracle_Customer_Number__c
            FROM
                Account
            WHERE
                Id IN : mapAssessments.keySet()
        ]);
        for(Id i : mapAssessments.keySet()){
            if(mapCommonDiscountAccounts.containsKey(i)){
                Price_Authorization_Form__c p = new Price_Authorization_Form__c(
                    Account__c = i,
                    Assessment__c = mapAssessments.get(i).Id,
                    Status__c = 'Approved',
                    RecordTypeId = utilController.idVPAFRecordType,
                    Pricing_Effective_Date__c = mapAssessments.get(i).Requested_Effective_Date_for_Pricing__c,
                    OwnerId = mapAssessments.get(i).OwnerId,
                    Integration_Price_Codes__c = ''
                );
                if(mapAccounts.get(i).Oracle_Customer_Number__c != null){
                    p.ERP_Update__c = true;
                }
                for(String s : mapCommonDiscountAccounts.get(i)){
                    for(Tier_Discount__c t : utilController.lstTierDiscountCommonPriceCodes){
                        if(
                            s == t.Price_Code_Letters__c
                            && t.Tier__c == strTier
                        ){
                            String c = p.Integration_Price_Codes__c;
                            c += t.Price_Code_Letters__c;
                            if(t.Numeric_Discount__c == true){
                                c += Integer.valueOf(t.Discount__c);
                            }
                            c  += ',';
                            p.Integration_Price_Codes__c = c;
                            p.put(
                                t.Price_Code__c,
                                t.Price_Code_Value__c
                            );
                        }
                    }
                }
                lstPriceAuthorizationFormCommonPriceCodes.add(p);
            }
        }
        return lstPriceAuthorizationFormCommonPriceCodes;
    }
    public list<Price_Authorization_Form__c> getLstProfilePriceAuthorizationFormCommonPriceCodes(map<Id,Account_Profile__c> mapCommonDiscountProfiles, map<Id,set<String>> mapCommonDiscountAccounts, String strTier){
        list<Price_Authorization_Form__c> lstPriceAuthorizationFormCommonPriceCodes = new list<Price_Authorization_Form__c>();
        for(Id i : mapCommonDiscountProfiles.keySet()){
            if(mapCommonDiscountAccounts.containsKey(i)){
                Price_Authorization_Form__c p = new Price_Authorization_Form__c(
                    Account__c = i,
                    Status__c = 'Approved',
                    RecordTypeId = utilController.idVPAFRecordType,
                    Pricing_Effective_Date__c = date.today(),
                    OwnerId = mapCommonDiscountProfiles.get(i).OwnerId,
                    Integration_Price_Codes__c = ''
                );
                if(mapCommonDiscountProfiles.get(i).Account__r.Oracle_Customer_Number__c != null){
                    p.ERP_Update__c = true;
                }
                for(String s : mapCommonDiscountAccounts.get(i)){
                    for(Tier_Discount__c t : utilController.lstTierDiscountCommonPriceCodes){
                        if(
                            s == t.Price_Code_Letters__c
                            && strTier == t.Tier__c
                        ){
                            String c = p.Integration_Price_Codes__c;
                            c += t.Price_Code_Letters__c;
                            if(t.Numeric_Discount__c == true){
                                c += Integer.valueOf(t.Discount__c);
                            }
                            c  += ',';
                            p.Integration_Price_Codes__c = c;
                            p.put(
                                t.Price_Code__c,
                                t.Price_Code_Value__c
                            );
                        }
                    }
                }
                lstPriceAuthorizationFormCommonPriceCodes.add(p);
            }
        }
        return lstPriceAuthorizationFormCommonPriceCodes;
    }
    
    public void createProfilevPAFs(set<Id> setAccounts, String strTier, map<Id,Assessment__c> mapProfileAssessments){
        map<Id,Account> mapAccounts = this.getMapAccounts(setAccounts);
        map<Id,Account_Profile__c> mapProfiles = new map<Id,Account_Profile__c>(this.getLstAccountProfiles(setAccounts));
        list<Account_Tier_Discount__c> lstAccountTierDiscounts = this.getLstAccountTierDiscounts(setAccounts);
        
        if(mapProfileAssessments != null){
            mapProfiles.keySet().retainAll(mapProfileAssessments.keySet());
        }
        
        if(
            !mapProfiles.isEmpty()
            && !utilController.lstTierDiscounts.isEmpty()
        ){
            map<Id,set<String>> mapAccountTierDiscountsOverride = this.getMapProfileAccountTierDiscountsOverride(mapProfiles.values(), lstAccountTierDiscounts, strTier);
            map<Id,Account_Profile__c> mapCommonDiscountProfiles = new map<Id,Account_Profile__c>();
            map<Id,set<String>> mapCommonDiscountAccounts = new map<Id,set<String>>();
            list<Price_Authorization_Form__c> lstAccountVPAFs = new list<Price_Authorization_Form__c>();
            list<Account_Tier_Discount__c> lstAccountTierDiscountInsert = new list<Account_Tier_Discount__c>();
            
            for(Account_Profile__c a : mapProfiles.values()){
                Boolean bolHasPriceCode = false;
                if(!mapCommonDiscountProfiles.containsKey(a.Account__c)){
                    mapCommonDiscountProfiles.put(
                        a.Account__c,
                        a
                    );
                    if(!mapAccountTierDiscountsOverride.containsKey(a.Account__c)){
                        mapCommonDiscountAccounts.put(
                            a.Account__c,
                            utilController.setCommonPriceCodes
                        );
                    }else{
                        for(String s : utilController.setCommonPriceCodes){
                            if(!mapAccountTierDiscountsOverride.get(a.Account__c).contains(s)){
                                set<String> l = mapCommonDiscountAccounts.get(a.Account__c);
                                if(l == null){
                                    l = new set<String>();
                                }
                                l.add(s);
                                mapCommonDiscountAccounts.put(
                                    a.Account__c,
                                    l
                                );
                            }
                        }
                    }
                }
                Price_Authorization_Form__c p = new Price_Authorization_Form__c(
                    Account__c = a.Account__c,
                    Status__c = 'Approved',
                    RecordTypeId = utilController.idVPAFRecordType,
                    //Pricing_Effective_Date__c = date.today(),
                    OwnerId = a.OwnerId,
                    Integration_Price_Codes__c = ''
                );
                if(mapProfileAssessments != null){
                    if(mapProfileAssessments.containsKey(a.Id)){
                        p.Assessment__c = mapProfileAssessments.get(a.Id).Id;
                        p.Pricing_Effective_Date__c = mapProfileAssessments.get(a.Id).Requested_Effective_Date_for_Pricing__c;
                    }
                }else{
                    p.Pricing_Effective_Date__c = date.today();
                }
                if(mapAccounts.get(a.Account__c).Oracle_Customer_Number__c != null){
                    p.ERP_Update__c = true;
                }
                for(Tier_Discount__c t : utilController.lstTierDiscounts){
                    String strTierDiscountTier = strTier == 'Standard Pricing' ? 'Standard Pricing' : a.Tier__c;
                    if(
                        t.Business_Segment__c == a.Business_Segment__c
                        && a.Partner_Type__c == t.Partner_Type__c
                        && t.Tier__c == strTierDiscountTier
                        && t.Regions__c.contains(mapAccounts.get(a.Account__c).Region__c)
                    ){
                        //Exclude Price Code with Account Tier Discount Override from vPAF
                        if(mapAccountTierDiscountsOverride.get(a.Account__c) != null){
                            if(mapAccountTierDiscountsOverride.get(a.Account__c).contains(t.Price_Code_Letters__c)){
                                continue;
                            }
                        }
                        //Create new Account Tier Discounts
                        bolHasPriceCode = true;
                        lstAccountTierDiscountInsert.add(
                            new Account_Tier_Discount__c(
                                Account__c = a.Account__c,
                                Tier_Discount__c = t.Id
                            )
                        );
                        //Add Price Codes to vPAF
                        String s = p.Integration_Price_Codes__c;
                        s += t.Price_Code_Letters__c;
                        if(t.Numeric_Discount__c == true){
                            s += Integer.valueOf(t.Discount__c);
                        }
                        s += ',';
                        p.Integration_Price_Codes__c = s;
                        p.put(
                            t.Price_Code__c,
                            t.Price_Code_Value__c
                        );
                    }
                }
                if(bolHasPriceCode){
                    lstAccountVPAFs.add(p);
                }
            }
            if(!mapCommonDiscountProfiles.isEmpty()){
                lstAccountTierDiscountInsert.addAll(this.getLstAccountTierDiscountCommonPriceCodes(mapCommonDiscountAccounts, strTier));
                lstAccountVPAFs.addAll(this.getLstProfilePriceAuthorizationFormCommonPriceCodes(mapCommonDiscountProfiles, mapCommonDiscountAccounts, strTier));
            }
            insert lstAccountTierDiscountInsert;
            insert lstAccountVPAFs;
        }
    }
    
    //trigger control
    public static Boolean bolSetBidDeadlineFromQuote = false;
    public static Boolean bolSetOpportunityData = false;
    public static Boolean isQuoteTriggerExecuted = false;
    public static Boolean isSetOppDataTriggerExecuted = false;
    public static Boolean bolSetAccountRegion = false;
    //public static Boolean bolSetERPUpdateOracle = false;
    public static Boolean bolsetAccountProfile = false;
    public static Boolean bolLeadTriggers = false;
    public static Boolean bolSetLeadRegion = false;
    public static Boolean bolSetReferralContactOnLeadConversion = false;
    public static Boolean bolAccountAssessment = false;
    public static Boolean bolClusterAssessment = false;
    
    public static Boolean bolFirstExecution = false;
    public static Boolean bolFirstExecution2 = false;
    public static Boolean bolFirstExecution3 = false;
    public static Boolean bolFirstExecution4 = false;
    public static Boolean bolFirstExecution5 = false;
    public static Boolean bolFirstExecution6 = false;
    public static Boolean bolFirstExecution7 = false;
    public static Boolean bolFirstExecution8 = false;
    public static Boolean bolFirstExecution9 = false;
    public static Boolean bolFirstExecution10 = false;
    public static Boolean bolFirstExecution11 = false;
    public static Integer intTriggerCounter = 0;
    
    //List of Country Codes requiring State
    public static final set<String> setBillingCountryCodes = new set<String>{'US', 'BR', 'CA', 'CN', 'AU', 'IN', 'IE', 'IT', 'MX'};
    public static final set<String> setCommonPriceCodes = new set<String>{'AC', 'CP', 'PS'};
    
    //Get list of Tier Discounts for vPAF creation
    public static final list<Tier_Discount__c> lstTierDiscounts = new list<Tier_Discount__c>([
        SELECT
            Id,
            Business_Segment__c,
            Partner_Type__c,
            Tier__c,
            Price_Code__c,
            Price_Code_Letters__c,
            Numeric_Discount__c,
            Discount__c,
            Regions__c,
            Price_Code_Value__c
        FROM
            Tier_Discount__c
    ]);
    public static final list<Tier_Discount__c> lstTierDiscountCommonPriceCodes = new list<Tier_Discount__c>([
        SELECT
            Id,
            Business_Segment__c,
            Partner_Type__c,
            Tier__c,
            Price_Code__c,
            Price_Code_Letters__c,
            Numeric_Discount__c,
            Discount__c,
            Regions__c,
            Price_Code_Value__c
        FROM
            Tier_Discount__c
        WHERE
            Business_Segment__c = null
            AND Partner_Type__c = null
    ]);
    
    //Get PAF Record Type Ids
    public static final Id idVPAFRecordType = Schema.SObjectType.Price_Authorization_Form__c.getRecordTypeInfosByName().get('vPAF').getRecordTypeId();   
    public static final Id idStandardPAFRecordType = Schema.SObjectType.Price_Authorization_Form__c.getRecordTypeInfosByName().get('Standard PAF').getRecordTypeId();
    public static final Id idRecordInApprovalProcessRecordType = Schema.SObjectType.Price_Authorization_Form__c.getRecordTypeInfosByName().get('Record in Approval Process').getRecordTypeId();

    //Get Advantage Partner Program Record Type for vPAF exclusion
    public static final Id idAdvantagePartnerRecordType = Schema.SObjectType.Partner_Program__c.getRecordTypeInfosByName().get('Advantage Partner').getRecordTypeId();

    // Get IAM Opportunity Record Type
    public static final Id idOpportunityRecordTypeIAM = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('IAM Opportunity').getRecordTypeId();
}