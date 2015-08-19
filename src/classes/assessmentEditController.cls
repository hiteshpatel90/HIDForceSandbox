public with sharing class assessmentEditController {
    private final utilController uCtrl = new utilController();
    
    private final Assessment__c objAssessment;
    private Assessment__c objAssessmentApproved;
    
    private final set<String> setAccountClusterAccess = new set<String>{
        'System Administrator',
        'HID Business Administrator'
    };
    
    private String strAccountClusterOwner;
    private final String strUserId = UserInfo.getUserId();
    private final String strUserProfileId = UserInfo.getProfileId();
    private final String strUserProfileName = [
        SELECT
            Name
        FROM
            Profile
        WHERE
            Id =: strUserProfileId
    ].Name;
    
    private final static list<String> lstScore = new list<String>{
        'SI_Spend_Asmt__c',
        'SI_Software_Spend_Asmt__c',
        'SI_Hardware_Spend_Asmt__c',
        'IA_Spend_Asmt__c',
        'IA_Rev_from_Strong_Authentication_Asmt__c',
        'IA_Revenue_from_Software_Hardware_Asmt__c',
        'PACS_Spend_Asmt__c',
        'iCLASS_Spend_Asmt__c',
        'Stocks_All_SKUs_Cert_Prod_Lines_Asmt__c',
        'HID_Solutions_Integr_U_HID_API_Asmt__c',
        'SI_Product_Certifications_Asmt__c',
        'SI_Certified_Employees_Asmt__c',
        'IA_Product_Certifications_Asmt__c',
        'IA_Certified_Employees_Asmt__c',
        'HID_Academy_Courses_Completed_Asmt__c',
        'Employees_w_pivCLASS_Cert_Asmt__c',
        'Days_of_Inventory_on_Hand_Asmt__c',
        'HID_Logo_and_Link_on_Homepage_Asmt__c',
        'HID_Brand_Featured_in_Promotions_Asmt__c',
        'HID_Products_in_St_OEM_Price_Book_Asmt__c',
        'HID_Prod_Inc_in_OEM_Spec_Doc_Asmt__c',
        'Sales_Effectiveness_Asmt__c',
        'New_IA_Cust_Brought_on_by_Partner_Asmt__c',
        'Customer_Service_Quality_Asmt__c',
        'Monthly_POS_Report_Provided_to_HID_Asmt__c',
        'Business_Plan_Provided_to_HID_Asmt__c',
        'Joint_Integrator_Training_Asmt__c',
        'Monthly_Forecast_Accuracy_Asmt__c',
        'EDI_Implemented_with_HID_Asmt__c',
        'Blanket_Ordering_Frequently_Used_Asmt__c',
        'Bulk_Ordering_Frequently_Used_Asmt__c'
    };
    private final static list<String> lstDbl = new list<String>{
        'SI_Spend__c',
        'SI_Software_Spend__c',
        'SI_Hardware_Spend__c',
        'SI_Hardware_Spend_as_Percent_of_SI_Spend__c',
        'IA_Spend__c',
        'IA_Revenue_from_Strong_Authentication__c',
        'IA_Revenue_from_Strong_Auth_Perc__c',
        'IA_Revenue_from_Software_Hardware__c',
        'IA_Revenue_from_SW_HW_Percent__c',
        'PACS_Spend__c',
        'iCLASS_Spend__c',
        'iCLASS_Spend_as_Percent_of_PACS_Spend__c'
    };
    private final static list<String> lstInt = new list<String>{
        'HID_Solutions_Integrated_Using_HID_API__c',
        'SI_Product_Certifications__c',
        'SI_Certified_Employees__c',
        'IA_Product_Certifications__c',
        'IA_Certified_Employees__c',
        'HID_Academy_Courses_Completed__c',
        'Employees_w_pivCLASS_Certification__c',
        'Days_of_Inventory_on_Hand__c',
        'HID_Products_Included_in_OEM_Spec_Doc__c',
        'New_IA_Customers_Brought_on_by_Partner__c'
    };
    private final static list<String> lstStr = new list<String>{
        'Stocks_All_SKUs_Certified_Product_Lines__c',
        'HID_Logo_and_Link_on_Homepage__c',
        'HID_Brand_Featured_in_Promotions__c',
        'HID_Products_in_Standard_OEM_Price_Book__c',
        'Sales_Effectiveness__c',
        'Customer_Service_Quality__c',
        'Monthly_POS_Report_Provided_to_HID__c',
        'Business_Plan_Provided_to_HID__c',
        'Joint_Integrator_Training__c',
        'Monthly_Forecast_Accuracy__c',
        'EDI_Implemented_with_HID__c',
        'Blanket_Ordering_Frequently_Used__c',
        'Bulk_Ordering_Frequently_Used__c'
    };
    private final static list<String> lstFields = new list<String>{
        'Id',
        'Name',
        'Account__c',
        'Account_Cluster__c',
        'Account__r.Region__c',
        'Account__r.BillingCountryCode',
        'Account__r.BillingState',
        'Business_Segment__c',
        'Partner_Type__c',
        'Market_Size__c',
        'Approval_Status__c',
        'Approval_Date__c',
        'Total_Asmt__c',
        'Recommended_Tier__c',
        'Requested_Tier__c',
        'Effective_Date_for_Benefits__c',
        'Requested_Effective_Date_for_Pricing__c',
        'Comments__c'
    };

    public assessmentEditController(ApexPages.StandardController s){
        serverURL = System.URL.getSalesforceBaseUrl().getHost();
        returnURL = ApexPages.currentPage().getParameters().get('retURL');
        bolAccountClusterOwnerEditorMatch = true;
        
        if(!Test.isRunningTest()){
            s.addFields(
                uCtrl.getFieldList(
                    new list<list<String>>{
                        lstFields,
                        lstDbl,
                        lstInt,
                        lstStr,
                        lstScore
                    }
                )
            );
        }
        objAssessment = (Assessment__c)s.getRecord();
        if(
            objAssessment.Account__c == null
            && objAssessment.Account_Cluster__c == null
        ){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'No Account/Account Cluster selected. Please open an Account/Account Cluster and create the Assessment there.'
                )
            );
        }else if(objAssessment.Account__c != null){
        	Account objAccount = [
        		SELECT
        			BillingCountryCode,
        			BillingState
        		FROM
        			Account
        		WHERE
        			Id =: objAssessment.Account__c
        	];
        	if(objAccount.BillingCountryCode == null){
        		ApexPages.addMessage(
        			new ApexPages.Message(
        				ApexPages.Severity.ERROR,
        				'Billing Country missing for the selected Account! Please return to the Account page and fill in the Country (and State, where required)!'
        			)
        		);
        	}else{
        		if(
					utilController.setBillingCountryCodes.contains(objAccount.BillingCountryCode)
					&& objAccount.BillingState == null
        		){
        			ApexPages.addMessage(
        				new ApexPages.Message(
        					ApexPages.Severity.ERROR,
        					'Billing State missing for the selected Account! Please return to the Account page and fill in the State!'
        				)
        			);
        		}
        	}
            if(getAccountProfileData('Business_Segment__c', new list<String>{'Account__c'}, true).size() == 1){
                ApexPages.addMessage(
                    new ApexPages.Message(
                        ApexPages.Severity.ERROR,
                        'No Business Segment available. Please return to the account page and create a new Account Profile first.'
                    )
                );
            }
        }else if(objAssessment.Account_Cluster__c != null){
            Account_Cluster__c c = [
                SELECT
                    OwnerId
                FROM
                    Account_Cluster__c
                WHERE
                    Id =: objAssessment.Account_Cluster__c
                LIMIT 1
            ];
            strAccountClusterOwner = c.OwnerId;
            if(
                strAccountClusterOwner != strUserId
                && !setAccountClusterAccess.contains(strUserProfileName)
            ){
                bolAccountClusterOwnerEditorMatch = false;
            }else if(getAccountProfileData('Business_Segment__c', new list<String>{'Account_Cluster__c'}, true).size() == 1){
                ApexPages.addMessage(
                    new ApexPages.Message(
                        ApexPages.Severity.ERROR,
                        'No Business Segment available. Please return to the account page and create a new Account Profile first.'
                    )
                );
            }
        }
        if(!ApexPages.hasMessages()){
            if(objAssessment.Approval_Status__c == null){
                objAssessment.Approval_Status__c = 'Draft';
            }
        	if(objAssessment.Approval_Status__c == 'Draft'){
            	getMapScoreValues();
        	}
            getAssessmentApprovedValues();
        }
    }

    public PageReference step1(){
        if(
            objAssessment.Account_Cluster__c != null
            && strAccountClusterOwner != strUserId
            && !setAccountClusterAccess.contains(strUserProfileName)
       
        ){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Only Account Cluster Owner can create/edit Account Cluster Assessments.'
                )
            );
        }
        if(bolAccountClusterCheck()){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'This Account is member of an Account Cluster. The Assessment cannot be created/edited.'
                )
            );
        }
        return Page.AssessmentEditPage1;
    }
    public PageReference step2(){
        if(
            objAssessment.Account_Cluster__c != null
            && strAccountClusterOwner != strUserId
            && !setAccountClusterAccess.contains(strUserProfileName)
        ){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Only Account Cluster Owner can create/edit Account Cluster Assessments.'
                )
            );
        }
        if(bolAccountClusterCheck()){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'This Account is member of an Account Cluster. The Assessment cannot be created/edited.'
                )
            );
        }
        if(objAssessment.Business_Segment__c == null){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Business Segment is required.'
                )
            );
        }
        if(objAssessment.Partner_Type__c == null){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Partner Type is required.'
                )
            );
        }
        if(objAssessment.Market_Size__c == null){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Market Size is required on the Account Profile for this Business Segment.'
                )
            );
        }
        if(!ApexPages.hasMessages()){
        	if(objAssessment.Approval_Status__c == 'Draft'){
	            getAccountSpending();
	            getMapScoreValues();
	            resetTotalScore();
	            resetRecommendedTier();
        	}
            getAssessmentApprovedValues();
            if(objAssessment.Recommended_Tier__c == null){
                ApexPages.addMessage(
                    new ApexPages.Message(
                        ApexPages.Severity.ERROR,
                        'No Assessment Criteria available because selected Partner Type does not qualify for the Partner Program and is not eligible to be assessed. Please cancel out of this screen.'
                    )
                );
                return null;
            }else{
                return Page.AssessmentEditPage2;
            }
        }else{
            return null;
        }
    }
    public PageReference customSave(){
        if(
            objAssessment.Account_Cluster__c != null
            && strAccountClusterOwner != strUserId
            && !setAccountClusterAccess.contains(strUserProfileName)
       
        ){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Only Account Cluster Owner can create/edit Account Cluster Assessments.'
                )
            );
        }
        if(bolAccountClusterCheck()){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'This Account is member of an Account Cluster. The Assessment cannot be created/edited.'
                )
            );
        }
        if(objAssessment.Requested_Tier__c == null){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Requested Tier is required.'
                )
            );
        }
        if(objAssessment.Requested_Effective_Date_for_Pricing__c == null){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Pricing Effective Date is required.'
                )
            );
        }
        if(
            objAssessment.Requested_Effective_Date_for_Pricing__c < date.today()
            && (
                objAssessment.Approval_Status__c == null
                || objAssessment.Approval_Status__c == 'Draft'
            )
        ){
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Pricing Effective Date cannot be in the past.'
                )
            );
        }
        if(!ApexPages.hasMessages()){
			if(objAssessment.Approval_Status__c == 'Draft'){
				getMapScoreValues();
            	resetTotalScore();
			}
            try{
                PageReference p;
                upsert objAssessment;
                p = new PageReference('/' + objAssessment.Id);
                return p;
            }catch(Exception e){
                ApexPages.addMessage(
                    new ApexPages.Message(
                        ApexPages.Severity.ERROR,
                        'Save failed - DML Error: ' + e.getMessage()
                    )
                );
                return Page.AssessmentEditPage2;
            }
        }else{
            return null;
        }
    }
    public PageReference customDelete(){
        delete objAssessment;
        if(objAssessment.Account__c != null){
            return new PageReference('/' + objAssessment.Account__c);
        }else if(objAssessment.Account_Cluster__c != null){
            return new PageReference('/' + objAssessment.Account_Cluster__c);
        }else{
            return new PageReference('home');
        }
    }
    public PageReference customCancel(){
        PageReference p = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
        return p;
    }
    public PageReference updateAssessment(){
        getMapScoreValues();
        resetTotalScore();
        resetRecommendedTier();
        return null;
    }
    public PageReference updateAccount(){
        return null;
    }
    
    public Assessment__c getObjAssessment(){
        return objAssessment;
    }
    public Assessment__c getObjAssessmentApproved(){
        return objAssessmentApproved;
    }
    
    public String serverURL {get;set;}
    public String returnURL {get;set;}
    public Boolean bolAccountClusterOwnerEditorMatch {get;set;} 
    
    public String strRegion {
        get{
            if(strRegion == null){
                String strQry;
                strQry = 'SELECT Region__c FROM';
                if(objAssessment.Account__c != null){
                    strQry += ' Account WHERE Id = \'' + objAssessment.Account__c;
                }else{
                    strQry += ' Account_Cluster__c WHERE Id = \'' + objAssessment.Account_Cluster__c;
                }
                strQry += '\' LIMIT 1';
                list<sObject> lstRegion = Database.query(strQry);
                return String.valueOf(lstRegion[0].get('Region__c'));
            }else{
                return strRegion;
            }
        }set;
    }
    public String getStrTE1(){
        if(objAssessment.Business_Segment__c == 'Secure Issuance'){
            return 'SI_Product_Certifications__c';
        }else{
            return 'IA_Products_Certifications__c';
        }
    }
    
    public Boolean getBolSI(){
        if(objAssessment.Business_Segment__c == 'Secure Issuance'){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolIA(){
        if(objAssessment.Business_Segment__c == 'Identity Assurance'){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolPACS(){
        if(objAssessment.Business_Segment__c == 'PACS'){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolEdit(){
        if(
            objAssessment.Approval_Status__c == 'Draft'
            || objAssessment.Approval_Status__c == 'Rejected'
        ){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolCustomDelete(){
        if(setAccountClusterAccess.contains(strUserProfileName)){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolAccount(){
        if(objAssessment.Account__c != null){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getBolJointIntegratorTraining(){
        if(objAssessment.Partner_Type__c != 'Integrator'){
            return true;
        }else{
            objAssessment.Joint_Integrator_Training__c = null;
            return false;
        }
    }
    public Boolean getBolSIDistributor(){
        if(
            objAssessment.Business_Segment__c == 'Secure Issuance'
            && objAssessment.Partner_Type__c == 'Distributor'
        ){
            return true;
        }else{
            objAssessment.put('Stocks_All_SKUs_Certified_Product_Lines__c','No');
            return false;
        }
    }
    public Boolean getBolSIPACSIntegrator(){
        if(
            (
                objAssessment.Business_Segment__c == 'Secure Issuance'
                || objAssessment.Business_Segment__c == 'PACS'
            )
            && objAssessment.Partner_Type__c == 'Integrator'
        ){
            return true;
        }else{
            objAssessment.put('Sales_Effectiveness__c','Below Average');
            return false;
        }
    }
    public Boolean getBolPACSIntegrator(){
        if(
            objAssessment.Business_Segment__c == 'PACS'
            && objAssessment.Partner_Type__c == 'Integrator'
        ){
            return true;
        }else{
            objAssessment.put('HID_Academy_Courses_Completed__c',0);
            return false;
        }
    }
    public Boolean getBolOEM(){
        if(objAssessment.Partner_Type__c == 'OEM'){
            return true;
        }else{
            objAssessment.put('HID_Solutions_Integrated_Using_HID_API__c',0);
            objAssessment.put('HID_Products_Included_in_OEM_Spec_Doc__c',0);
            return false;
        }
    }
    public Boolean getBolSIPACSOEM(){
        if(
            (
                objAssessment.Business_Segment__c == 'Secure Issuance'
                || objAssessment.Business_Segment__c == 'PACS'
            )
            && objAssessment.Partner_Type__c == 'OEM'
        ){
            return true;
        }else{
            objAssessment.put('HID_Products_in_Standard_OEM_Price_Book__c','No');
            return false;
        }
    }
    public Boolean getBolIAOEM(){
        if(
            objAssessment.Business_Segment__c == 'Identity Assurance'
            && objAssessment.Partner_Type__c == 'OEM'
        ){
            return true;
        }else{
            objAssessment.put('HID_Products_in_Standard_OEM_Spec_Doc__c',0);
            return false;
        }
    }
    public Boolean getBolDistributorOEM(){
        if(
            objAssessment.Partner_Type__c == 'Distributor'
            || objAssessment.Partner_Type__c == 'OEM'
        ){
            return true;
        }else{
            objAssessment.put('Days_of_Inventory_on_Hand__c',0);
            return false;
        }
    }
    public Boolean getBolIADistributorIntegrator(){
        if(
            objAssessment.Business_Segment__c == 'Identity Assurance'
            && (
                objAssessment.Partner_Type__c == 'Distributor'
                || objAssessment.Partner_Type__c == 'Integrator'
            )
        ){
            return true;
        }else{
            objAssessment.put('IA_Revenue_from_Software_Hardware__c',0);
            objAssessment.put('New_IA_Customers_Brought_on_by_Partner__c',0);
            return false;
        }
    }
    
    public list<SelectOption> getLstBusinessSegment(){
        if(objAssessment.Account__c != null){
            return getAccountProfileData('Business_Segment__c', new list<String>{'Account__c'}, true);
        }else{
            return getAccountProfileData('Business_Segment__c', new list<String>{'Account_Cluster__c'}, true);
        }
    }
    public list<SelectOption> getLstPartnerType(){
        if(objAssessment.Account__c != null){
            return getAccountProfileData('Partner_Type__c', new list<String>{'Account__c', 'Business_Segment__c'}, false);
        }else{
            return getAccountProfileData('Partner_Type__c', new list<String>{'Account_Cluster__c', 'Business_Segment__c'}, false);
        }
    }
    public list<SelectOption> getLstMarketSize(){
        if(objAssessment.Account__c != null){
            return getAccountProfileData('Market_Size__c', new list<String>{'Account__c', 'Business_Segment__c'}, false);
        }else{
            return getAccountProfileData('Market_Size__c', new list<String>{'Account_Cluster__c','Business_Segment__c'}, false);
        }
    }
    public list<SelectOption> getLstDaysInventory(){
        if(objAssessment.Partner_Type__c == 'Distributor'){
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '15' => '15',
                    '30' => '30',
                    '45' => '45+'
                }
            );
        }else{
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '15' => '15',
                    '30' => '30+'
                }
            );
        }
    }
    public list<SelectOption> getLstHIDAPISolutions(){
        if(objAssessment.Business_Segment__c == 'Secure Issuance'){
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '1' => '1+'
                }
            );
        }else{
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '1' => '1',
                    '2' => '2',
                    '3' => '3',
                    '4' => '4+'
                }
            );
        }
    }
    public list<SelectOption> getLstSIProductCertifications(){
        if(objAssessment.Partner_Type__c == 'OEM'){
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '1' => '1+'
                }
            );
        }else{
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '1' => '1',
                    '2' => '2',
                    '3' => '3+'
                }
            );
        }
    }    
    public list<SelectOption> getLstIAProductCertifications(){
        return uCtrl.getVarOptions(
            new map<String,String>{
                '0' => '0',
                '1' => '1',
                '2' => '2 - 3',
                '4' => '4 - 5',
                '6' => '6+'
            }
        );
    }
    public list<SelectOption> getLstHIDAcademyCoursesCompleted(){
        return uCtrl.getVarOptions(
            new map<String,String>{
                '0' => '0',
                '50' => '1 - 50',
                '51' => '51+'
            }
        );
    }
    public list<SelectOption> getLstSICertifiedEmployees(){
        if(objAssessment.Partner_Type__c == 'Integrator'){
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0 - 1',
                    '02' => '2',
                    '03' => '3 - 5',
                    '06' => '6 - 10',
                    '11' => '11+'
                }
            );
        }else if(objAssessment.Partner_Type__c == 'Distributor'){
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '1' => '1',
                    '2' => '2 - 5',
                    '6' => '6+'
                }
            );
        }else{
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0',
                    '1' => '1 - 5',
                    '6' => '6+'
                }
            );
        }
    }
    public list<SelectOption> getLstIACertifiedEmployees(){
        if(objAssessment.Partner_Type__c == 'OEM'){
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0 - 1',
                    '02' => '2 - 5',
                    '06' => '6 - 10',
                    '11' => '11 - 15',
                    '16' => '16+'
                }
            );
        }else{
            return uCtrl.getVarOptions(
                new map<String,String>{
                    '0' => '0 - 1',
                    '02' => '2 - 3',
                    '04' => '4 - 5',
                    '06' => '6 - 10',
                    '11' => '11+'
                }
            );
        }
    }
    public list<SelectOption> getLstEmployeesWpivCLASSCert(){
        return uCtrl.getVarOptions(
            new map<String,String>{
                '0' => '0',
                '01' => '1 - 5',
                '06' => '6 - 10',
                '11' => '11 - 15',
                '16' => '16+'
            }
        );
    }
    public list<SelectOption> getLstOEMSpecDoc(){
        return uCtrl.getVarOptions(
            new map<String,String>{
                '0' => '0',
                '1' => '1',
                '2' => '2',
                '3' => '3',
                '4' => '4+'
            }
        );
    }
    public list<SelectOption> getLstIANewCustomers(){
        return uCtrl.getVarOptions(
            new map<String,String>{
                '0' => '0',
                '1' => '1 - 2',
                '3' => '3 - 5',
                '6' => '6+'
            }
        );
    }
    
    private void getMapScoreValues(){
        String strQry;
        for(String s : lstScore){
            objAssessment.put(s,0);
        }
        try{
            if(
                objAssessment.SI_Spend__c <> 0
                && objAssessment.SI_Spend__c != null
                && objAssessment.SI_Hardware_Spend__c <> 0
                && objAssessment.SI_Hardware_Spend__c != null
            ){
                objAssessment.SI_Hardware_Spend_as_Percent_of_SI_Spend__c = objAssessment.SI_Hardware_Spend__c * 100 / objAssessment.SI_Spend__c;
            }else if(
                objAssessment.IA_Spend__c <> 0
                && objAssessment.IA_Spend__c != null
            ){
                if(
                    objAssessment.IA_Revenue_from_Strong_Authentication__c <> 0
                    && objAssessment.IA_Revenue_from_Strong_Authentication__c != null
                ){
                    objAssessment.IA_Revenue_from_Strong_Auth_Perc__c = objAssessment.IA_Revenue_from_Strong_Authentication__c * 100 / objAssessment.IA_Spend__c;
                }else{
                    objAssessment.IA_Revenue_from_Strong_Auth_Perc__c = 0.0;
                }
                if(
                    objAssessment.IA_Revenue_from_Software_Hardware__c <> 0
                    && objAssessment.IA_Revenue_from_Software_Hardware__c != null
                ){
                    objAssessment.IA_Revenue_from_SW_HW_Percent__c = objAssessment.IA_Revenue_from_Software_Hardware__c * 100 / objAssessment.IA_Spend__c;
                }
            }else if(
                objAssessment.PACS_Spend__c <> 0
                && objAssessment.PACS_Spend__c != null
                && objAssessment.iCLASS_Spend__c <> 0
                && objAssessment.iCLASS_Spend__c != null
            ){
                objAssessment.iCLASS_Spend_as_Percent_of_PACS_Spend__c = objAssessment.iCLASS_Spend__c * 100 / objAssessment.PACS_Spend__c;
            }
            strQry = 'SELECT Criterion_Score_Name__c, MAX(Score__c) Score__c, Criterion_Name__c, Business_Segment__c, Partner_Type__c, Market_Size__c, MAX(Numeric_Value__c) Numeric_Value__c, MAX(Alphanumeric_Value__c) Alphanumeric_Value__c';
            strQry += ' FROM Scoring_Criterion__c';
            strQry += ' WHERE Business_Segment__c = \'' + objAssessment.Business_Segment__c + '\'';
            strQry += ' AND Partner_Type__c = \'' + objAssessment.Partner_Type__c + '\' AND (';
            for(String s : lstDbl){
                if(objAssessment.get(s) != null && objAssessment.get(s) <> 0){
                    strQry += '(Numeric_Value__c <= ';
                    if(s == 'SI_Hardware_Spend__c'){
                        strQry += objAssessment.SI_Hardware_Spend_as_Percent_of_SI_Spend__c;
                    }else if(s == 'IA_Revenue_from_Strong_Authentication__c'){
                        strQry += objAssessment.IA_Revenue_from_Strong_Auth_Perc__c;
                    }else if(s == 'IA_Revenue_from_Software_Hardware__c'){
                        strQry += objAssessment.IA_Revenue_from_SW_HW_Percent__c;
                    }else if(s == 'iCLASS_Spend__c'){
                        strQry += objAssessment.iCLASS_Spend_as_Percent_of_PACS_Spend__c;
                    }else{
                        strQry += objAssessment.get(s);
                    }
                    if(
                        s == 'SI_Spend__c'
                        || s == 'IA_Spend__c'
                        || s == 'PACS_Spend__c'
                    ){
                        strQry += ' AND Market_Size__c = \'' + objAssessment.Market_Size__c + '\'';
                    }
                    strQry += ' AND Criterion_Name__c = \'' + s + '\') OR';
                }
            }
            for(String s : lstInt){
                if(objAssessment.get(s) != null && objAssessment.get(s) <> 0){
                    strQry += ' (Numeric_Value__c <= ' + objAssessment.get(s);
                    strQry += ' AND Criterion_Name__c = \'' + s + '\') OR';
                }
            }
            for(String s : lstStr){
                if(objAssessment.get(s) != null){
                    strQry += '(Alphanumeric_Value__c = \'' + objAssessment.get(s) + '\'';
                    strQry += ' AND Criterion_Name__c = \'' + s + '\') OR';
                }
            }
            strQry = strQry.left(strQry.length()-3);
            strQry += ') GROUP BY Criterion_Score_Name__c, Business_Segment__c, Partner_Type__c, Market_Size__c, Criterion_Name__c';
            list<AggregateResult> l = Database.query(strQry);
            for(AggregateResult s : l){
                objAssessment.put(String.valueOf(s.get('Criterion_Score_Name__c')),Integer.valueOf(s.get('Score__c')));
            }
        }catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Update Assessment failed - Query Error: ' + e.getMessage() + ' ' + strQry));
        }
    }
    
    private void getAssessmentApprovedValues(){
        String strQry;
        try{
            strQry = 'SELECT ';
            for(String s : uCtrl.getFieldList(new list<list<String>>{lstFields,lstDbl,lstInt,lstStr,lstScore})){
                strQry += s + ', ';
            }
            strQry = strQry.left(strQry.length()-2);
            strQry += ' FROM Assessment__c';
            if(objAssessment.Account__c != null){
                strQry += ' WHERE Account__c = \'' + objAssessment.Account__c + '\'';
            }else if(objAssessment.Account_Cluster__c != null){
                strQry += ' WHERE Account_Cluster__c = \'' + objAssessment.Account_Cluster__c + '\'';
            }
            strQry += ' AND Business_Segment__c = \'' + objAssessment.Business_Segment__c + '\'';
            strQry += ' AND Partner_Type__c = \'' + objAssessment.Partner_Type__c + '\'';
            strQry += ' AND Approval_Status__c = \'Approved\'';
            strQry += ' ORDER BY Requested_Effective_Date_for_Pricing__c DESC LIMIT 1';
            objAssessmentApproved = Database.query(strQry);
        }catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Query Error: ' + e.getMessage() + ' ' + strQry));
        }
    }
    
    private void getAccountSpending(){
        set<Id> setAccountIds = new set<Id>();
        if(objAssessment.Account__c != null){
            setAccountIds.add(objAssessment.Account__c);
        }
        if(objAssessment.Account_Cluster__c != null){
            for(Account_Cluster_Member__c m : [
                SELECT
                    Account__c
                FROM
                    Account_Cluster_Member__c
                WHERE
                    Account_Cluster__c =: objAssessment.Account_Cluster__c
            ]){
                setAccountIds.add(m.Account__c);
            }
        }
        Double dblIASpend = 0.0;
        Double dblIARevSWHW = 0.0;
        Double dblIARevStrongAuth = 0.0;
        
        Double dblPACSSpend = 0.0;
        Double dbliCLASSSpend = 0.0;
        
        Double dblSISpend = 0.0;
        Double dblSIHardwareSpend = 0.0;
        Double dblSISoftwareSpend = 0.0;
        try{
            for(AggregateResult a : [
                SELECT
                    SUM(IA_Revenue_from_Software_Hardware__c) IA_Rev_SW_HW__c,
                    SUM(IA_Revenue_from_Strong_Authentication__c) IA_Rev_Strong_Auth__c,
                    SUM(IA_Spend__c) IA_Spend__c,
                    SUM(iCLASS_Spend__c) iCLASS_Spend__c,
                    SUM(PACS_Spend__c) PACS_Spend__c,
                    SUM(SI_Hardware_Spend__c) SI_Hardware_Spend__c,
                    SUM(SI_Software_Spend__c) SI_Software_Spend__c,
                    SUM(SI_Spend__c) SI_Spend__c
                FROM
                    Account_Spending__c
                WHERE
                    Account__c IN : setAccountIds
            ]){
                if(objAssessment.Business_Segment__c == 'Identity Assurance'){
                    if(a.get('IA_Spend__c') != null) dblIASpend += (Double)a.get('IA_Spend__c');
                    if(a.get('IA_Rev_SW_HW__c') != null) dblIARevSWHW += (Double)a.get('IA_Rev_SW_HW__c');
                    if(a.get('IA_Rev_Strong_Auth__c') != null) dblIARevStrongAuth += (Double)a.get('IA_Rev_Strong_Auth__c');
                }else if(objAssessment.Business_Segment__c == 'PACS'){
                    if(a.get('PACS_Spend__c') != null) dblPACSSpend += (Double)a.get('PACS_Spend__c');
                    if(a.get('iCLASS_Spend__c') != null) dbliCLASSSpend += (Double)a.get('iCLASS_Spend__c');
                }else if(objAssessment.Business_Segment__c == 'Secure Issuance'){
                    if(a.get('SI_Spend__c') != null) dblSISpend += (Double)a.get('SI_Spend__c');
                    if(a.get('SI_Hardware_Spend__c') != null) dblSIHardwareSpend += (Double)a.get('SI_Hardware_Spend__c');
                    if(a.get('SI_Software_Spend__c') != null) dblSISoftwareSpend += (Double)a.get('SI_Software_Spend__c');
                }
            }
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Spend Query Error: ' + e + '; Line: ' + e.getLineNumber()));
        }
        if(objAssessment.Business_Segment__c == 'Identity Assurance'){
            if(objAssessment.IA_Spend__c == null) objAssessment.IA_Spend__c = dblIASpend;
            if(objAssessment.IA_Revenue_from_Software_Hardware__c == null) objAssessment.IA_Revenue_from_Software_Hardware__c = dblIARevSWHW;
            if(objAssessment.IA_Revenue_from_Strong_Authentication__c == null) objAssessment.IA_Revenue_from_Strong_Authentication__c = dblIARevStrongAuth;
        }else if(objAssessment.Business_Segment__c == 'PACS'){
            if(objAssessment.PACS_Spend__c == null) objAssessment.PACS_Spend__c = dblPACSSpend;
            if(objAssessment.iCLASS_Spend__c == null) objAssessment.iCLASS_Spend__c = dbliCLASSSpend;
        }else if(objAssessment.Business_Segment__c == 'Secure Issuance'){
            if(objAssessment.SI_Spend__c == null) objAssessment.SI_Spend__c = dblSISpend;
            if(objAssessment.SI_Hardware_Spend__c == null) objAssessment.SI_Hardware_Spend__c = dblSIHardwareSpend;
            if(objAssessment.SI_Software_Spend__c == null) objAssessment.SI_Software_Spend__c = dblSISoftwareSpend;
        }
    }
    
    private void resetRecommendedTier(){
        try{
            objAssessment.Recommended_Tier__c = (String)[
                SELECT
                    Alphanumeric_Value__c
                FROM
                    Scoring_Criterion__c
                WHERE
                    Region__c =: strRegion
                    AND Business_Segment__c =: objAssessment.Business_Segment__c
                    AND Partner_Type__c =: objAssessment.Partner_Type__c
                    AND Criterion_Name__c = 'Recommended_Tier__c'
                    AND Score__c <=: objAssessment.Total_Asmt__c
                ORDER BY
                    Score__c DESC
                LIMIT 1
            ].Alphanumeric_Value__c;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Tier Discount available for the selected Business Segment and/or Partner Type.'));
        }
    }
    
    private void resetTotalScore(){
        objAssessment.Total_Asmt__c = 0;
        for(String s : lstScore){
            objAssessment.Total_Asmt__c += Integer.valueOf(objAssessment.get(s));
        }
    }
    
    private Boolean bolAccountClusterCheck(){
        if(objAssessment.Account__c != null){
            list<Account_Cluster_Member__c> idAccountClusterMember = [
                SELECT
                    Id
                FROM
                    Account_Cluster_Member__c
                WHERE
                    Account__c =: objAssessment.Account__c
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
    
    private list<SelectOption> getAccountProfileData(String strWhat, list<String> lstWhere, Boolean bolNone){
        list<SelectOption> o = new list<SelectOption>();
        if(bolNone){
            o.add(new SelectOption('','--None--'));
        }
        String strQry = 'SELECT ' + strWhat + ' FROM Account_Profile__c WHERE ';
        for(String s : lstWhere){
            strQry += s + ' = \'' + objAssessment.get(s) + '\' AND ';
        }
        strQry = strQry.left(strQry.length()-5);
        if(strWhat == 'Business_Segment__c'){
            strQry += ' AND Business_Segment__c IN (\'Identity Assurance\', \'PACS\', \'Secure Issuance\')';
        }
        
        try{
            list<Account_Profile__c> l = Database.query(strQry);
            for(Account_Profile__c a : l){
                o.add(new SelectOption(String.valueOf(a.get(strWhat)),String.valueOf(a.get(strWhat))));
            }
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Account Profile incomplete: ' + e.getMessage()));
        }
        return o;
    }
}