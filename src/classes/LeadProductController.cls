public class LeadProductController {
    public static final String LANG = 'lang';
    public static final String TERMS_LANG = 'termsLang';
    public static final String CAMPAIGN_ID_KEY = 'cmpid';
    public static final String THANKYOU_URL = 'http://www.hidglobal.com/promotionsThankyou.php';
    public static final String THANKYOU_URL_KEY = 'tyUrl';
	static final Integer MAX_PRODUCTS_SIZE = 200;
	public static final String successText = 'Lead Added Successfully ';
	public static final String ERROR_MESSAGE = 'An error occured while saving your information. Please try again later.';
	
    public Lead leadRecord {get; set;}
    public List<LeadProductWrapper> leadProductsList {get; set;}
    public Integer totalNumberOfProductsAdded {get; set;}
    public List<Lead_Products__c> leadProductToAdd;
    
    public String thankyouUrl {get; set;}
    public Boolean leadSaved {get { return (leadRecord != null) && (leadRecord.Id != null); } set;}
    public String redirectUrl {get { return getRedirectUrl();} set;}
    public String language {get; set;}
    public String termsLanguage {get; set;}
    public String campaignId {get; set;}
    
    public List<String> customErrorMessages {get; set;}	
	public Boolean hasErrorMessages
	{
		get {
			return (!customErrorMessages.isEmpty());
		}
	}
         
    public LeadProductController(ApexPages.StandardController stdController) {

    	language = System.currentPageReference().getParameters().get(LANG);
    	campaignId = System.currentPageReference().getParameters().get(CAMPAIGN_ID_KEY);
    	thankyouUrl = System.currentPageReference().getParameters().get(THANKYOU_URL_KEY);

		customErrorMessages = new List<String>();
        leadRecord = new Lead();
        leadProductsList = new List<LeadProductWrapper>();
        addLeadProduct();
        setTotalNumberOfProductsAdded();
        leadProductToAdd = new List<Lead_Products__c> ();
    }
    
    /**
    * Invoked in VF page when user clicks 'Add More' button
    */
    public void handleAddMoreRequest() {
        Boolean isLastProductValid = (leadProductsList.get(leadProductsList.size()-1).leadProduct != new Lead_Products__c());
        Boolean isMaxProductsSize = (totalNumberOfProductsAdded >= MAX_PRODUCTS_SIZE);	
    	if (isLastProductValid && !isMaxProductsSize)
        	addLeadProduct();
    
        setTotalNumberOfProductsAdded();
    }
    
    public void handleRemoveProduct() {
    	leadProductsList.remove(leadProductsList.size()-1);
    	setTotalNumberOfProductsAdded();
    }
    
    /**
    * Make a new instance of LeadProductWrapper
    */
    private void addLeadProduct() {
    	leadProductsList.add( new LeadProductWrapper( leadProductsList.size()+1, new Lead_Products__c() ) );
    }
        
    private void setTotalNumberOfProductsAdded() {
    	totalNumberOfProductsAdded = leadProductsList.size();
    }
    
    /**
    *	Insert the lead record
    *	Attach the lead Id with the Lead Product 
    *	Insert all the Lead Product
    */
    public PageReference insertLead() {
    	customErrorMessages.clear();
    	try 
    	{
    		Database.DMLOptions dmo = new Database.DMLOptions();
			dmo.assignmentRuleHeader.useDefaultRule= true;
    		
    		leadRecord.setOptions(dmo);
    		insert leadRecord;
	    	
    	} catch (DMLException de) {
    		System.debug(de);
    		customErrorMessages.add(ERROR_MESSAGE);
    		return null;
    		//Don't want to show any error messages which are outside of the field specific messages (next to the field on the form)
    	}
    	
    	try 
    	{
	    	for ( LeadProductWrapper leadWrapper : leadProductsList )
	    	{
	    		if (!leadWrapper.isEmpty()){
		    		Lead_Products__c leadProd = leadWrapper.leadProduct;
		    		leadProd.Lead__c = leadRecord.Id;
		    		leadProductToAdd.add( leadProd );
	    		}
	    	}
	    	insert leadProductToAdd;
	    	
    	} catch (DMLException de) {
    		
    		System.debug(de);
    		return null;
    	}
    	
    	try 
    	{
	    	CampaignMember newCampaignMember = new CampaignMember(LeadId=leadRecord.Id, CampaignId=campaignId);
	    	insert newCampaignMember;
	    	
    	} catch (DMLException de) {
    		
    		System.debug(de);
    		return null;
    	}
    	
    	//DO NOT RETURN PAGEREF
    	// because this page is hosted in an iframe, need client side javascript to take care of redirect
    	return null;
    }
    
    /*private Boolean isValidForm() {
    	//want to ensure at least one lead product is submitted
		if (leadProductsList.get(0) != null && !leadProductsList.get(0).isEmpty())
			return true;
		else
			return false;
    }*/
    
    private String getRedirectUrl(){
    	String url;
    	url = (thankyouUrl == null || thankyouUrl == '') ? THANKYOU_URL : thankyouUrl; //use hard coded value or url query parameter
    	PageReference thankYouPageRef = new PageReference(url);
    	thankYouPageRef.getParameters().put(CAMPAIGN_ID_KEY, campaignId);
    	
    	return thankYouPageRef.getUrl();
    }
    
    /**
    * Wrapper that will be used in the VF page to build out 
    * the rows of the lead product table
    **/
    public class LeadProductWrapper {
        public Integer rowIndex {get; set;}
        public Lead_Products__c leadProduct {get; set;}
        	        
        public LeadProductWrapper(Integer rowIndex, Lead_Products__c leadProduct) {
            this.rowIndex = rowIndex;
            this.leadProduct = leadProduct;
        }
        public Boolean isEmpty() {
        	return (leadProduct.Model_of_integrated_HID_Component__c == null || leadProduct.Model_of_integrated_HID_Component__c == '') &&
				 (leadProduct.Part_of_Integrated_HID_Component__c == null || leadProduct.Part_of_Integrated_HID_Component__c == '') &&
				 (leadProduct.Model_Containing_HID_Component__c == null || leadProduct.Model_Containing_HID_Component__c == '');
        }
    }
}