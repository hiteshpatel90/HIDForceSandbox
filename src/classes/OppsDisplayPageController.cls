/*
    This controller is for the opps display page and is just a simple data display for the partner portal.
*/

public without sharing class OppsDisplayPageController{
      
    /*------------------- Public Variables -------------------*/
    public Opportunity opp {get; set;}
    //Boolean to handle Authentication.
    public boolean Authenticated {get; set;}
    
    private string token;
    
    /*------------------- Local Variables -------------------*/
    ApexPages.StandardController stdCtrl;     
    string newId = 'none';
    string encryptedId = '';
    /*------------------- Encryption/Decryption -------------------*/
    HidPortalAuthenticationController pController = new HidPortalAuthenticationController();
    
    
    /*------------------- Call to Save Record -------------------*/
    public PageReference saveopp()
    {
        if (null==opp)
        {
            return null;
        }else
        {
            try
            {
            update opp;
            return GoBack();
            }catch (exception e)
            {
                ApexPages.addMessages(e);
            }
            return null;
        }
    }
   
    /*------------------- Dynamic Update of Probability -------------------*/
    public transient Map<String, Decimal> probabilityStageNameMap;
    public PageReference changeStageName() 
    {        
        if (probabilityStageNameMap == null) {
            probabilityStageNameMap = new Map<String, Decimal>();
            for (OpportunityStage oppStage : [Select MasterLabel, DefaultProbability
                                           From OpportunityStage]) {
            probabilityStageNameMap.put(oppStage.MasterLabel, oppStage.DefaultProbability);
            }
        }
        if (probabilityStageNameMap.containsKey(opp.StageName)) {    
            opp.Probability = probabilityStageNameMap.get(opp.StageName);
        }
    return null;
    }

    /*------------------- Constructor -------------------*/
    public OppsDisplayPageController(ApexPages.StandardController controller) 
    {
        stdCtrl = controller;
        
        if(opp == null)
        {
              opp = [Select Partner_Name__c, name, Region__c, amount, stagename, probability, Lost_On_Hold_Reason__c, Dominant_Technology__c,
                Vertical_Markets__c, Reference__c,Opportunity_Type__c, Type, Multisite__c, Description, LeadSource, Lead_Qualified_Date__c FROM Opportunity
         where id = :ApexPages.currentPage().getParameters().get('id')];
        }
        
        //Collect ID
        encryptedId=ApexPages.currentPage().getParameters().get('o');
        
        newId = null;
        
        try{
        	newId = pController.DecryptData(pController.FetchKey(), ApexPages.currentPage().getParameters().get('o'));
        }catch(Exception e){}
        //Collect Token
        if(ApexPages.currentPage().getParameters().get('token') != null){
            token = ApexPages.currentPage().getParameters().get('token');
        }else{
            token = 'None';
        }
        
        //Authenticate
        string temp = pController.urlCallout(token);
        if(temp == '1'){
           Authenticated = true; 
        }else
        {
            //If unauthenticaed : Return error
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, 'Authentication timed out' + token + temp);
            ApexPages.addMessage(myMsg);
        }     
    } 
    
    /*------------------- Authentication -------------------*/
    Public PageReference Authenticate()
    {
        system.debug('Authenticate Result: '+Authenticated);
        if(this.Authenticated == true){
            system.debug('Authentication is Real');
            return Null; 
        }else{
//            return Page.Unauthorized;
              return null;
        }
    }
  
    /*------------------- Return to Listing Page -------------------*/  
    public PageReference GoBack(){       
        PageReference newPage = page.MainDisplayPage;
        string data = newId;
        newPage.getParameters().put('u',newId);
        newPage.getParameters().put('token',token);
        newPage.getParameters().put('tab','Opps');
        newPage.setRedirect(true);  
        return newPage; 
    }     
}//END OF FILE