/*
    This controller class is for the LeadDisplayPage.
    It is designed to work with the MainDisplayPage / Oppsdisplay Page for the partner portal.
*/

public class LeadDisplayPageController {
    
 
    /*--------------------- Public Variables ---------------------*/
    public string newId {get; set;}
    public string tempid {get; set;}
    //Authentication
    public boolean Authenticated {get; set;}
    private string Token;
    //public List<Campaign> camps{get; set;} // commented by Gaurav
    public List<CampaignMember> cms {get; set;}
    
    public string lStatus;

    /*--------------------- Local Variables ---------------------*/
    ApexPages.StandardController stdCtrl;
    //Decrpt/Encrypt call
    HidPortalAuthenticationController pController = new HidPortalAuthenticationController();
    
    
    /*--------------------- Refresh Call ---------------------*/
    public PageReference refresh()
    {
        return null;
    }

    /*--------------------- Constructor ---------------------*/
    public LeadDisplayPageController(ApexPages.StandardController controller) {
        stdCtrl = controller;
        
        newId = null;
        try{
          newId = pController.DecryptData(pController.FetchKey(),ApexPages.currentPage().getParameters().get('o'));
        }catch(Exception e){}

        if(newId == null)
            newId = 'none';

        tempId = ApexPages.currentPage().getParameters().get('id');
        
        //Check for Token
        if(ApexPages.currentPage().getParameters().get('token') != null){
            token = ApexPages.currentPage().getParameters().get('token');
        }else{
            token = 'None';
        }
        String temp ;
        
        //Authentication
        IF(Test.isRunningTest() != true){
           temp = pController.urlCallout(token);
        } else {
           temp = '1';
        }
        if(temp == '1'){
           Authenticated = true; 
        }else
        {
            Authenticated = false;
            //If unauthenticaed : Return error
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, 'Authentication timed out');
            ApexPages.addMessage(myMsg);
        }
        //Changes by gaurav
         cms = new List<CampaignMember>();
        cms = [SELECT Campaign.Id, Campaign.name, Campaign.type , Campaign.description, Campaign.Region__c, createddate, CampaignID, LeadID, Status ,FirstRespondedDate FROM CampaignMember WHERE LeadID = : tempId ORDER BY FirstRespondedDate DESC];
        
        // upto here
        /*
        Set<Id> campIds= new Set<Id>();
        
        for(CampaignMember  cm : cms){
            if(campIds.contains(cm.CampaignID)== false){
                campIds.add(cm.CampaignID);
            }
        }
        camps = [Select Id, name, type , description, Region__c from campaign where Id in: campIds];
          System.debug('Campaigns == ' + camps);  
          */
          lStatus = ApexPages.currentPage().getParameters().get('leadStatus');
          system.debug('Previous page value' + ApexPages.currentPage().getParameters().get('leadStatus'));
    }  
    
    /*--------------------- Convert Lead ---------------------*/
    public static void doConvert(Id leadId){
        
        //Query Lead
        Lead leads = [select id, region__c, qualified_date__c, partner_name__c from Lead where id = :leadId LIMIT 1];
        //Update the Lead
//        update leads;

        //Convert
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(leadId);
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);      
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        system.debug(lcr);      
        
        //Update Opportunity with Parter Name
        Opportunity editOpp = [select id from Opportunity where id = :lcr.GetOpportunityId()];
        editOpp.Created_By_Lead_Conversion__c = 'Yes'; 
        editOpp.Partner_Name__c = leads.Partner_name__c;
        editOpp.Region__c = leads.Region__c;
        editOpp.Lead_Qualified_Date__c = leads.Qualified_Date__c;
        update editOpp;
        
        Account editAcc = [Select id From Account where id = :lcr.GetAccountId()];
        editAcc.Type='End-User';
        update editAcc;
    }

    /*--------------------- Authentication ---------------------*/
    Public PageReference Authenticate()
    {
        if(Authenticated == true){
            return Null; 
        }else{
            return Page.Unauthorized;
        }
    }
    

    /*--------------------- PageReference to call Convert ---------------------*/
    Public PageReference convert()
    {
        //Needs lead id
        try
        {
            doConvert(tempid);    
            
        } catch (Exception e)
        {
            system.debug(e.getMessage());
            ApexPages.addmessages(e);
        }
        PageReference newPage = page.MainDisplayPage;   
        string data = newId;
        newPage.getParameters().put('u',data);
        newPage.getParameters().put('token', token);
        newpage.getParameters().put('tab','Leads');
        newPage.setRedirect(true);  
        return newPage;
    }
    
    /*--------------------- Return to Listing Page ---------------------*/
    public PageReference GoBack(){
       PageReference newPage = page.MainDisplayPage;
       string data = newId;
       newPage.getParameters().put('u',data);
       newPage.getParameters().put('token',token);
       newpage.getParameters().put('tab','Leads');
       newpage.getParameters().put('leadStatus',lStatus);
       newPage.setRedirect(true);  
       return newPage;
    }
   /*--------------------- Save Lead ---------------------*/
   public PageReference save()
   {
      //update Lead Reviewed checkbox to remove from Lead Routing
        Lead l3ad = (Lead)stdCtrl.getRecord();
        l3ad.LeadReviewed__c = true;              
      stdCtrl.save();
      return GoBack();
   }
   
    public PageReference SaveLead()
    {   
        
        //prep_lead_record(this.lead_data_proxy ,(ID)tempid);
        return null;
    }
}//END OF FILE