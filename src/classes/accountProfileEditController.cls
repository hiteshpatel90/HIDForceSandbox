public with sharing class accountProfileEditController {

    private final utilController uCtrl = new utilController();
    
    private final Account_Profile__c objAccountProfile;
    private final list<Currencies__c> lstCurrencies = Currencies__c.getAll().values();
    private final set<String> setAccountClusterAccess = new set<String>{
        'HID Business Administrator',
        'HID Pricing Admin',
        'System Administrator'
    };
    
    private String u = UserInfo.getProfileId();
    private String strUserProfileName = [
        SELECT
            Name
        FROM
            Profile
        WHERE
            Id =: u
    ].Name;
    
    public string serverURL {get;set;}
    
    public accountProfileEditController(ApexPages.StandardController s){
        serverURL = System.URL.getSalesforceBaseUrl().getHost();
        if(!Test.isRunningTest()){
            s.addFields(new list<String>{
                'Id',
                'Name',
                'OwnerId',
                'Account__c',
                'Account_Cluster__c',
                'Account__r.BillingCountry',
                'Account__r.BillingCountryCode',
                'Account__r.BillingState',
                'Account__r.E_21_Account__c',
                'National_Account__c',
                'Market_Size__c',
                'Pricebook_Currency__c',
                'Purchasing_Method__c',
                'Competitor__c',
                'Business_Segment__c',
                'NAS_Developer__c',
                'Partner_Type__c',
                'Ranking__c',
                'Program_Category__c',
                'Use_Application__c',
                'Tier__c',
                'Recommended_Tier__c',
                'Requested_Tier_Expiration_Date__c',
                'Integrated_Hardware__c',
                'Sales_Manager__c',
                'Inside_Sales_Rep__c',
                'National_Account_Manager__c',
                'Customer_Service_Rep__c',
                'Partner_Directory__c',
                'Contract_Manufacturer__c',
                'pivCLASS_SDK_Partner__c',
                'pivCLASS_Technology_Partner__c'
            });
        }
        objAccountProfile = (Account_Profile__c)s.getRecord();
        
        if(
            objAccountProfile.Account__c == null
            && objAccountProfile.Account_Cluster__c == null
        ){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'No Account/Account Cluster selected. Please open an Account/Account Cluster and create the Profile there.'
                )
            );
        }else if(objAccountProfile.Account__c != null){
            Account a = [
                SELECT
                    OwnerId,
                    E_21_Account__c,
                    Sub_Region__c
                FROM
                    Account
                WHERE
                    Id =: objAccountProfile.Account__c
                LIMIT 1
            ];
            strGlobalAccount = a.E_21_Account__c;
            strSubRegion = a.Sub_Region__c;
            if(objAccountProfile.Sales_Manager__c == null){
                objAccountProfile.Sales_Manager__c = a.OwnerId;
            }
            if(
                bolAccountClusterCheck()
                && objAccountProfile.Id == null
            ){
                ApexPages.addMessage(
                    new ApexPages.Message(
                        ApexPages.Severity.ERROR,
                        'This Account is member of an Account Cluster. The Profile cannot be created.'
                    )
                );
            }
        }else if(objAccountProfile.Account_Cluster__c != null){
            Account_Cluster__c c = [
                SELECT
                    OwnerId,
                    Cluster_Type__c,
                    Region__c
                FROM
                    Account_Cluster__c
                WHERE
                    Id =: objAccountProfile.Account_Cluster__c
                LIMIT 1
            ];
            strClusterType = c.Cluster_Type__c;
            strRegion = c.Region__c;
            if(objAccountProfile.Sales_Manager__c == null){
                objAccountProfile.Sales_Manager__c = c.OwnerId;
            }
            if(!setAccountClusterAccess.contains(strUserProfileName)){
                ApexPages.addMessage(
                    new ApexPages.Message(
                        ApexPages.Severity.ERROR,
                        'You don\'t have sufficient privileges to create/edit Account Cluster Profiles.'
                    )
                );
            }
        }
        if(!ApexPages.hasMessages()){
            bolRenderSave = bolAccountCheck();
        }
    }
    
    public PageReference customSave(){
        if(
            objAccountProfile.Account__c == null
            && objAccountProfile.Account_Cluster__c == null
        ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Account/Cluster is required.'));
        }else if(
            objAccountProfile.Account_Cluster__c != null
            && !setAccountClusterAccess.contains(strUserProfileName)
        ){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'You don\'t have sufficient privileges to create/edit Account Cluster Profiles.'
                )
            );
        }
        if(bolAccountClusterCheck()){
            if(objAccountProfile.Id == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'This Account is member of an Account Cluster. The Profile cannot be created.'));
            }
        }
        if(objAccountProfile.Business_Segment__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Business Segment is required.'));
        }
        if(objAccountProfile.Partner_Type__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Partner Type is required.'));
        }
        if(
            objAccountProfile.Account__c != null
            && objAccountProfile.Business_Segment__c != 'Internal'
            && objAccountProfile.Sales_Manager__c == null
        ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sales Manager is required.'));
        }
        if(
            objAccountProfile.Account__c != null
            && objAccountProfile.Business_Segment__c == 'Connect'
            && objAccountProfile.Use_Application__c == null
        ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Use Application is required.'));
        }
        if(
            objAccountProfile.Account__c != null
            && objAccountProfile.Business_Segment__c == 'Connect'
            && objAccountProfile.Integrated_Hardware__c == null
        ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Integrated Hardware is required.'));
        }
        if(
            objAccountProfile.Account__c != null
            && (
            	objAccountProfile.Account__r.E_21_Account__c == 'No'
            	|| strGlobalAccount == 'No'
            )
            && objAccountProfile.Partner_Type__c == 'Global Account Group'
        ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Partner Type Global Account Group only valid for Global Accounts.'));
        }
        if(!ApexPages.hasMessages()){
            try{
                if(
                    bolTierReset
                    && objAccountProfile.Tier__c == objAccountProfile.Recommended_Tier__c
                    && objAccountProfile.Recommended_Tier__c != null
                ){
                    objAccountProfile.Requested_Tier_Expiration_Date__c = null;
                    String strQry = 'SELECT';
                    for(Schema.SObjectField f : Schema.getGlobalDescribe().get('Assessment__c').getDescribe().Fields.getMap().values()){
                        Schema.DescribeFieldResult fr = f.getDescribe();
                        if(fr.isCreateable()){
                            strQry += ' ' + fr.getName() + ',';
                        }
                    }
                    strQry = strQry.left(strQry.length()-1);
                    strQry += ' FROM Assessment__c WHERE';
                    if(objAccountProfile.Account__c != null){
                        strQry += ' Account__c = \'' + objAccountProfile.Account__c + '\'';
                    }else if(objAccountProfile.Account_Cluster__c != null){
                        strQry += ' Account_Cluster__c = \'' + objAccountProfile.Account_Cluster__c + '\'';
                    }
                    strQry += ' AND Business_Segment__c = \'' + objAccountProfile.Business_Segment__c + '\' AND Approval_Status__c = \'Approved\' LIMIT 1';
                    
                    Assessment__c s = Database.query(strQry);
                    Assessment__c sc = new Assessment__c();
                    if(s != null){
                    	sc = s.clone(false,true,false,false);
                    }
                    
                    DateTime datLocalDateTime = system.now();
                    sc.Requested_Tier__c = objAccountProfile.Tier__c;
                    sc.Approval_Status__c = 'Approved';
                    sc.Approval_Date__c = datLocalDateTime;
                    sc.Requested_Effective_Date_for_Pricing__c = datLocalDateTime.date();
                    sc.Requested_Tier_Expiration_Date__c = null;
                    sc.Effective_Date_for_Benefits__c = datLocalDateTime.date();
                    sc.Comments__c = 'System Generated';
                    insert sc;
                }
                objAccountProfile.OwnerId = objAccountProfile.Sales_Manager__c;
                upsert objAccountProfile;
                PageReference p = new PageReference('/' + objAccountProfile.Id);
                return p;
            }catch(Exception e){
            	system.debug(e);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
                return null;
            }
        }else{
            return null;
        }
    }
    public PageReference customCancel(){
        PageReference p = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
        return p;
    }
    public PageReference bsUpdate(){
        bolRenderSave = bolAccountCheck();
        return null;
    }
    public PageReference tierUpdate(){
        bolRenderSave = bolAccountCheck();
        bolTierReset = true;
        return null;
    }
    
    public Boolean bolTierReset{
        get{return bolTierReset;}
        set;
    }

    public Account_Profile__c getObjAccountProfile(){
        return objAccountProfile;
    }
    
    public Boolean bolRenderSave{
        get{return bolRenderSave;}
        set;
    }
    public Boolean getBolAccount(){
        if(objAccountProfile.Account__c == null){
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolNationalAccount(){
        if(
            objAccountProfile.Business_Segment__c == null
            || objAccountProfile.Business_Segment__c == 'Animal ID'
            || objAccountProfile.Business_Segment__c == 'Cards and Inlays'
            || objAccountProfile.Business_Segment__c == 'Connect'
            || objAccountProfile.Business_Segment__c == 'Industry and Logistics'
            || objAccountProfile.Business_Segment__c == 'Internal'
            || objAccountProfile.Partner_Type__c == null
            || objAccountProfile.Partner_Type__c == 'Competitor'
            || objAccountProfile.Partner_Type__c == 'Global Account Group'
            || objAccountProfile.Partner_Type__c == 'Media'
            || objAccountProfile.Partner_Type__c == 'Prospect'
            || objAccountProfile.Partner_Type__c == 'Technology Partner'
            || (
                objAccountProfile.Business_Segment__c == 'Government ID'
                && objAccountProfile.Partner_Type__c != 'Multi-National Customer'
            )
        ){
            objAccountProfile.National_Account__c = null;
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolBusinessSegment(){
        if(
            objAccountProfile.Id != null
        ){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolMarketSize(){
        Boolean bolReturn = false;
        if(
            objAccountProfile.Account_Cluster__c != null
            && !setAccountClusterAccess.contains(strUserProfileName)
        ){
            bolReturn = true;
        }else if(
            objAccountProfile.Account__c != null
            && (
                bolAccountClusterCheck()
                || !setAccountClusterAccess.contains(strUserProfileName)
            )
        ){
            bolReturn = true;
        }
        return bolReturn;
    }
    public Boolean getBolPartnerType(){
        Boolean bolReturn = false;
        if(
            objAccountProfile.Account_Cluster__c != null
            && !setAccountClusterAccess.contains(strUserProfileName)
        ){
            bolReturn = true;
        }else if(objAccountProfile.Account__c != null){
            if(bolAccountClusterCheck()){
                bolReturn = true;
            }
        }
        return bolReturn;
    }
    public Boolean getBolPricebookCurrency(){
        if(
            objAccountProfile.Account__c == null
            || !setAccountClusterAccess.contains(strUserProfileName)
        ){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolPurchasingMethod(){
        if(
            objAccountProfile.Account__c == null
            || objAccountProfile.Partner_Type__c == null
            || objAccountProfile.Partner_Type__c == '3rd Party Business Representative'
            || objAccountProfile.Partner_Type__c == 'Consultant'
            || objAccountProfile.Partner_Type__c == 'Competitor'
            || objAccountProfile.Partner_Type__c == 'Global Account Group'
            || objAccountProfile.Partner_Type__c == 'Internal'
            || objAccountProfile.Partner_Type__c == 'Media'
            || objAccountProfile.Partner_Type__c == 'Prospect'
            || (
                objAccountProfile.Business_Segment__c == 'Connect'
                && objAccountProfile.Partner_Type__c == 'End-User'
            )
        ){
            objAccountProfile.Purchasing_Method__c = null;
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolCompetitor(){
        if(
            objAccountProfile.Account__c != null
            && (
                objAccountProfile.Partner_Type__c == 'Competitor'
                || (
                    (
                        objAccountProfile.Partner_Type__c == 'Distributor'
                        || objAccountProfile.Partner_Type__c == 'Integrator'
                        || objAccountProfile.Partner_Type__c == 'OEM'
                    ) && (
                        objAccountProfile.Business_Segment__c == 'Identity Assurance'
                        || objAccountProfile.Business_Segment__c == 'PACS'
                        || objAccountProfile.Business_Segment__c == 'Secure Issuance'
                    )
                )
            )
        ){
            return true;
        }else{
            objAccountProfile.Competitor__c = null;
            return false;
        }
    }
    public Boolean getBolPartnerDirectory(){
        if(objAccountProfile.Account__c == null){
            objAccountProfile.Partner_Directory__c = null;
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolRanking(){
        if(
            objAccountProfile.Account__c == null
            || objAccountProfile.Partner_Type__c == null
            || objAccountProfile.Partner_Type__c == '3rd Party Business Representative'
            || objAccountProfile.Partner_Type__c == 'Competitor'
            || objAccountProfile.Partner_Type__c == 'Internal'
            || objAccountProfile.Partner_Type__c == 'Media'
            || (
                (
                    objAccountProfile.Partner_Type__c == 'Prospect'
                    || objAccountProfile.Partner_Type__c == 'End-User'
                ) && (
                    objAccountProfile.Business_Segment__c == 'Connect'
                    || objAccountProfile.Business_Segment__c == 'Identity Assurance'
                    || objAccountProfile.Business_Segment__c == 'PACS'
                    || objAccountProfile.Business_Segment__c == 'Secure Issuance'
                )
            )
        ){
            objAccountProfile.Ranking__c = null;
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolProgramCategory(){
        if(
            objAccountProfile.Business_Segment__c == 'Identity Assurance'
            || objAccountProfile.Business_Segment__c == 'PACS'
            || objAccountProfile.Business_Segment__c == 'Secure Issuance'
        ){
            objAccountProfile.Program_Category__c = objAccountProfile.Business_Segment__c;
            return true;
        }else{
            objAccountProfile.Program_Category__c = null;
            return false;
        }
    }
    public Boolean getBolUseApplication(){
        if(
            objAccountProfile.Account__c == null
            || objAccountProfile.Partner_Type__c == null
            || objAccountProfile.Business_Segment__c == 'Identity Assurance'
            || objAccountProfile.Business_Segment__c == 'Internal'
            || objAccountProfile.Business_Segment__c == 'PACS'
            || objAccountProfile.Business_Segment__c == 'Secure Issuance'
        ){
            objAccountProfile.Use_Application__c = null;
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolIntegratedHardware(){
        if(
            objAccountProfile.Account__c != null
            && objAccountProfile.Business_Segment__c == 'Connect'
        ){
            return true;
        }else{
            objAccountProfile.Integrated_Hardware__c = null;
            return false;
        }
    }
    public Boolean getBolTier(){
        if(
            (
                objAccountProfile.Business_Segment__c == 'Identity Assurance'
                || objAccountProfile.Business_Segment__c == 'PACS'
                || objAccountProfile.Business_Segment__c == 'Secure Issuance'
            ) && (
                objAccountProfile.Partner_Type__c == 'Distributor'
                || objAccountProfile.Partner_Type__c == 'Integrator'
                || objAccountProfile.Partner_Type__c == 'OEM'
            )
        ){
            if(bolAccountClusterCheck()){
                return false;
            }else{
                return true;
            }
        }else{
            objAccountProfile.Tier__c = null;
            return false;
        }
    }
    public Boolean getBolNASDeveloper(){
        if(
            objAccountProfile.Account__c == null
            || objAccountProfile.Business_Segment__c != 'PACS'
            || objAccountProfile.Partner_Type__c == 'Distributor'
            || objAccountProfile.Partner_Type__c == 'Consultant'
            || objAccountProfile.Partner_Type__c == 'Competitor'
            || objAccountProfile.Partner_Type__c == 'Media'
            || objAccountProfile.Partner_Type__c == 'Technology Partner'
            || (
                objAccountProfile.Business_Segment__c == 'PACS'
                && objAccountProfile.Partner_Type__c == 'Global Account Group'
            )
        ){
            objAccountProfile.NAS_Developer__c = null;
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolNationalAccountManager(){
        if(
            objAccountProfile.Account__c != null
            && objAccountProfile.National_Account__c != 'Yes'
        ){
            objAccountProfile.National_Account_Manager__c = null;
            return false;
        }else{
            return true;
        }
    }
    public Boolean getBolContractManufacturer(){
        if(
            objAccountProfile.Business_Segment__c == 'Connect'
            && objAccountProfile.Partner_Type__c == 'OEM'
        ){
            return true;
        }else{
            objAccountProfile.Contract_Manufacturer__c = null;
            return false;
        }
    }
    public Boolean getBolPivCLASS(){
        if(
            objAccountProfile.Business_Segment__c == 'PACS'
            && (
                objAccountProfile.Partner_Type__c == 'End-User'
                || objAccountProfile.Partner_Type__c == 'Integrator'
                || objAccountProfile.Partner_Type__c == 'OEM'
            )
        ){
            return true;
        }else{
            objAccountProfile.pivCLASS_SDK_Partner__c = false;
            objAccountProfile.pivCLASS_Technology_Partner__c = false;
            return false;
        }
    }
    
    public String strSubRegion{get;set;}
    public String strGlobalAccount{get;set;}
    public String strClusterType{get;set;}
    public String strRegion{get;set;}
    
    public list<SelectOption> getLstPricebookCurrency(){
        list<String> lstOptions = new list<String>();
        if(objAccountProfile.Account__c != null){
            for(Currencies__c c : lstCurrencies){
                if(c.Sub_Region__c == strSubRegion){
                    lstOptions.add(c.Currency__c);
                }
            }
        }
        return uCtrl.getStrOptions(lstOptions, true);
    }
    public list<SelectOption> getLstMarketSize(){
        list<String> lstOptions = new list<String>();
        for(Schema.PicklistEntry p : Account_Profile__c.Market_Size__c.getDescribe().getPicklistValues()){
            lstOptions.add(p.getValue());
        }
        return uCtrl.getStrOptions(lstOptions,true);
    }
    public list<SelectOption> getLstBusinessSegment(){
        Boolean bolNone;
        list<String> lstOptions = new list<String>();
        if(objAccountProfile.Id != null){
            bolNone = false;
            lstOptions.add(objAccountProfile.Business_Segment__c);
        }else{
            set<String> setBusinessSegment = new set<String>();
            bolNone = true;
            String strQry;
            strQry = 'SELECT Business_Segment__c FROM Account_Profile__c WHERE';
            if(objAccountProfile.Account__c != null){
                strQry += ' Account__c = \'' + objAccountProfile.Account__c + '\'';
            }else{
                strQry += ' Account_Cluster__c = \'' + objAccountProfile.Account_Cluster__c + '\'';
            }
            try{
                list<Account_Profile__c> lstBusinessSegment = Database.query(strQry);
                for(Account_Profile__c a : lstBusinessSegment){
                    setBusinessSegment.add(a.Business_Segment__c);
                }
                for(Schema.PicklistEntry p : Account_Profile__c.Business_Segment__c.getDescribe().getPicklistValues()){
                    if(!setBusinessSegment.contains(p.getValue())){
                        lstOptions.add(p.getValue());
                    }
                }
            }catch(Exception e){}
        }
        return uCtrl.getStrOptions(lstOptions,bolNone);
    }
    public list<SelectOption> getLstPartnerType(){
        if(
            objAccountProfile.Account__c != null
            || objAccountProfile.Account_Cluster__c != null
        ){
            list<String> lstOptions = new list<String>();
            Boolean bolFirstNone = true;
            if(objAccountProfile.Business_Segment__c == 'Connect'){
                lstOptions.addAll(new list<String>{
                    'Competitor',
                    'Consultant',
                    'Developer',
                    'End-User',
                    'Integrator',
                    'Media',
                    'OEM',
                    'Prospect'
                });
                if(
                    objAccountProfile.Account__c != null
                    && (
                        objAccountProfile.Account__r.E_21_Account__c == 'Yes'
                        || strGlobalAccount == 'Yes'
                    )
                ){
                    lstOptions.add('Global Account Group');
                    lstOptions.sort();
                }
            }else if(objAccountProfile.Business_Segment__c == 'Government ID'){
                lstOptions.addAll(new list<String>{
                    '3rd Party Business Representative',
                    'Consultant',
                    'Government Ministry',
                    'Government Print Office',
                    'Local Customer',
                    'Manufacturer',
                    'Multi-National Customer',
                    'Technology Partner'
                });
            }else if(objAccountProfile.Business_Segment__c == 'Internal'){
                lstOptions.add('Internal');
                bolFirstNone = false;
            }else if(
                objAccountProfile.Business_Segment__c == 'Identity Assurance'
                || objAccountProfile.Business_Segment__c == 'PACS'
                || objAccountProfile.Business_Segment__c == 'Secure Issuance'
            ){
                lstOptions.addAll(new list<String>{
                    'Competitor',
                    'Consultant',
                    'Distributor',
                    'End-User',
                    'Integrator',
                    'Media',
                    'OEM',
                    'Prospect',
                    'Technology Partner'
                });
                if(
                    objAccountProfile.Account__c != null
                    && (
                        objAccountProfile.Account__r.E_21_Account__c == 'Yes'
                        || strGlobalAccount == 'Yes'
                    )
                ){
                    lstOptions.add('Global Account Group');
                    lstOptions.sort();
                }
            }else if(
                objAccountProfile.Business_Segment__c == 'Industry and Logistics'
                || objAccountProfile.Business_Segment__c == 'Animal ID'
            ){
                lstOptions.addAll(new list<String>{
                    'Competitor',
                    'Consultant',
                    'Distributor',
                    'End-User',
                    'Integrator',
                    'Media',
                    'OEM',
                    'Other',
                    'Prospect',
                    'Supplier',
                    'VAR/Reseller'
                });
            }else if(objAccountProfile.Business_Segment__c == 'Cards and Inlays'){
                lstOptions.addAll(new list<String>{
                    'Card Manufacturer',
                    'Competitor',
                    'Consultant',
                    'Distributor',
                    'End-User',
                    'Integrator',
                    'Media',
                    'OEM',
                    'Other',
                    'Prospect',
                    'Supplier',
                    'VAR/Reseller'
                });
            }
            return uCtrl.getStrOptions(
                lstOptions,
                bolFirstNone
            );
        }else{
            return uCtrl.getStrOptions(new list<String>(), true);
        }
    }
    public list<SelectOption> getLstCompetitor(){
        if(objAccountProfile.Account__c != null){
            if(objAccountProfile.Partner_Type__c == 'Competitor'){
                return uCtrl.getStrOptions(new list<String>{'Yes'}, false);
            }else if(
                (
                    objAccountProfile.Partner_Type__c == 'Distributor'
                    || objAccountProfile.Partner_Type__c == 'Integrator'
                    || objAccountProfile.Partner_Type__c == 'OEM'
                ) && (
                    objAccountProfile.Business_Segment__c == 'Identity Assurance'
                    || objAccountProfile.Business_Segment__c == 'PACS'
                    || objAccountProfile.Business_Segment__c == 'Secure Issuance'
                )
            ){
                return uCtrl.getStrOptions(new list<String>{'No','Yes'}, true);
            }else{
                return uCtrl.getStrOptions(new list<String>(), true);
            }
        }else{
            return uCtrl.getStrOptions(new list<String>(), true);
        }
    }
    public list<SelectOption> getLstPurchasingMethod(){
        list<String> lstOptions = new list<String>{
            'Direct',
            'Indirect'
        };
        if(
            objAccountProfile.Account__c == null
            || objAccountProfile.Partner_Type__c == null
            || objAccountProfile.Partner_Type__c == '3rd Party Business Representative'
            || objAccountProfile.Partner_Type__c == 'Consultant'
            || objAccountProfile.Partner_Type__c == 'Competitor'
            || objAccountProfile.Partner_Type__c == 'Global Account Group'
            || objAccountProfile.Partner_Type__c == 'Internal'
            || objAccountProfile.Partner_Type__c == 'Media'
            || objAccountProfile.Partner_Type__c == 'Prospect'
            || (
                objAccountProfile.Business_Segment__c == 'Connect'
                && objAccountProfile.Partner_Type__c == 'End-User'
            )
        ){
            return uCtrl.getStrOptions(
                new list<String>(),
                true
            );
        }else if(
            objAccountProfile.Business_Segment__c != 'Government ID'
            && objAccountProfile.Partner_Type__c == 'Technology Partner'
        ){
            return uCtrl.getStrOptions(
                new list<String>{
                    'Indirect'
                },
                false
            );
        }else{
            if(objAccountProfile.Business_Segment__c == 'Secure Issuance'){
                lstOptions.add('Repair Only');
            }
            return uCtrl.getStrOptions(
                lstOptions,
                true
            );
        }
    }
    public list<SelectOption> getLstUseApplication(){
        if(objAccountProfile.Account__c != null){
            list<String> lstOptions = new list<String>(); 
            if(objAccountProfile.Business_Segment__c == 'Animal ID'){
                lstOptions.addAll(new list<String>{
                    'Birds',
                    'Fish',
                    'General',
                    'Laboratory',
                    'Livestock',
                    'Other',
                    'Pets'
                });
            }else if(objAccountProfile.Business_Segment__c == 'Cards and Inlays'){
                lstOptions.addAll(new list<String>{
                    'Access Control',
                    'AFC / Public Transport',
                    'Card Bureau',
                    'Card Manufacturer',
                    'Loyalty',
                    'Other',
                    'Stadium & Events',
                    'Vending / Closed Payments'
                });
            }else if(objAccountProfile.Business_Segment__c == 'Connect'){
                lstOptions.addAll(new list<String>{
                    'Access Control Locks',
                    'AFC',
                    'Asset Tracking',
                    'ATM',
                    'Automotive, Transportation & Fleet Management',
                    'Banking',
                    'Biometric Solutions',
                    'Building Automation',
                    'Campus Solutions',
                    'Cashless Payment',
                    'Credentials',
                    'Customs/Passport & National Identity',
                    'Database & Data Collection',
                    'EV Charging Stations',
                    'General',
                    'Handheld/Mobile/Wireless Devices',
                    'Healthcare/Medical Devices',
                    'ID Badge Mgmt./Printing/Smart Card Enc.',
                    'Integrated Intercom',
                    'Intrusion Alarm Arm/Disarm',
                    'Logical Access',
                    'Loyalty',
                    'Manufacturing Control',
                    'Other',
                    'Parking and Long Range',
                    'PC and Peripheral Solutions',
                    'POS/ECR',
                    'Secure Print Authentication',
                    'Special Application',
                    'Specialty Access Control Readers',
                    'Time and Attendance',
                    'Tradeshow/Events Management',
                    'Turnstiles',
                    'Vandal Resistant & Rugged Readers',
                    'Vending',
                    'Visitor Management'
                });
            }else if(objAccountProfile.Business_Segment__c == 'Government ID'){
                lstOptions.addAll(new list<String>{
                    'Driver License',
                    'General',
                    'Health',
                    'National ID - ID',
                    'National ID - Reader',
                    'Other',
                    'Passport - ID',
                    'Passport - Reader',
                    'Residence Card',
                    'Vehicle Registration',
                    'Voter ID'
                });
            }else if (objAccountProfile.Business_Segment__c == 'Industry and Logistics'){
                lstOptions.addAll(new list<String>{
                    'Asset Tracking',
                    'Automation',
                    'Brand Protection',
                    'Consumables',
                    'Consumer Int. (DOOH)',
                    'Healthcare',
                    'Laundry',
                    'Other',
                    'RTI',
                    'Waste Management'
                });
            }
            return uCtrl.getStrOptions(
                lstOptions,
                true
            );
        }else{
            return uCtrl.getStrOptions(new list<String>{''}, false);
        }
    }

    private Boolean bolAccountCheck(){
        Boolean b = true;
        if(objAccountProfile.Account__c != null){
            Account a = [
                SELECT
                    BillingCountryCode,
                    BillingState
                FROM
                    Account
                WHERE
                    Id =: objAccountProfile.Account__c
            ];
            if(a.BillingCountryCode == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Account Country must not be empty. Please select a Country on the Account page.'));
                b = false;
            }else{
				if(
					utilController.setBillingCountryCodes.contains(a.BillingCountryCode)
					&& a.BillingState == null
				){
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Account State must not be empty. Please select a State on the Account page.'));
					b = false;
				}
            }
        }
        return b;
    }
    
    private Boolean bolAccountClusterCheck(){
        if(
            objAccountProfile.Account__c != null
            && (
                objAccountProfile.Business_Segment__c == 'Identity Assurance'
                || objAccountProfile.Business_Segment__c == 'PACS'
                || objAccountProfile.Business_Segment__c == 'Secure Issuance'
            )
        ){
            list<Account_Cluster_Member__c> idAccountClusterMember = [
                SELECT
                    Id
                FROM
                    Account_Cluster_Member__c
                WHERE
                    Account__c =: objAccountProfile.Account__c
            ];
            if(!idAccountClusterMember.isEmpty()){
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
}