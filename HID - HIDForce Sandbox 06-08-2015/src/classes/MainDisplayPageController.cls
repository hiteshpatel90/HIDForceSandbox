/*
    This controller operates the main display page for the partner portal access page.
    It branches off to a Lead display and converter page and also an Opportunity display page.
*/

public class MainDisplayPageController {
    
    public string defaultTab 
    {
        get
        {
            string tab=ApexPages.currentPage().getParameters().get('tab');
            if(tab!='Opps')
            {
                tab='Leads';
            }
            return tab;
        }set;
    }
    
    public String sortByFilter {get;set;} // addition by Gaurav
    public string query ;                 // addition by Gaurav
    //public List<string> leadStatusList = new List<string>();  // addition by Gaurav
    public String leadStatus = '';
    
    public final Integer PAGE_SIZE {get; set;} // Addition by gaurav for pagination.
    public Integer pageNum         {get; set;} // Addition by gaurav for pagination.
    public Integer totalNumberOfResults {get;set;} // Addition by gaurav for pagination.
    public Decimal lastPage {get;set;}  // Addition by gaurav for pagination.
    
    
    //Leads List
    Public List<Lead> leads = new List<Lead>();
    Public transient List<Lead> deadLeads = new List<Lead>(); // addition by Gaurav
    
    //Opportunities List
    Public Opportunity[] opps;
          
    //Call the portal authentication controller
    HidPortalAuthenticationController pController = new HidPortalAuthenticationController();
    
    
    //True of False Authentication
    Public Boolean Authenticated{get; set;}
    
    //Token for Authentication
    private string Token;
    
    //Variable to store ID passed in via Encryption.
    public string tempId{get; set;}
    
    //Constructor for MainDisplayPageController       
    public MainDisplayPageController(ApexPages.StandardController controller) {
        
        if(ApexPages.currentPage().getParameters().get('test') == '1')
        {
            tempId = 'test';
        }
        else
        {
        //Checks for string containing Partner_Name__c
        if(ApexPages.currentPage().getParameters().get('u') != null){
            tempId = pController.DecryptData(pController.FetchKey(),ApexPages.currentPage().getParameters().get('u'));
            system.debug(tempId);  
        }else{
            tempId = 'None';
        }
        system.debug('value of u>>>>>>' + tempId);
        //Checks for Token
        if(ApexPages.currentPage().getParameters().get('token') != null){
            token = ApexPages.currentPage().getParameters().get('token');
        }else{
            token = 'None';
        }
       
        //Authentication
        string temp = pController.urlCallout(token);
      
       if(temp == '1'){
            Authenticated = true;
        }else
        {
            //If unauthenticaed : return error
            Authenticated = false;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, 'Authentication timed out');
            ApexPages.addMessage(myMsg);
        }
}

         // Addition By Gaurav for Header based Sorting
        sortByFilter = apexpages.currentpage().getparameters().get('sortByFilter') != null?apexpages.currentpage().getparameters().get('sortByFilter'):'CurrentAssignmentDate__c desc'; 
        system.debug('value of sorting filter' + sortByFilter);
        
        leadStatus = apexpages.currentpage().getparameters().get('leadStatus') != null?apexpages.currentpage().getparameters().get('leadStatus'):'All Leads'; 
         /*if(leadStatus == null || leadStatus == '') {
             leadStatus = 'All Leads';
         }
         */
         PAGE_SIZE = 50;
          pageNum = apexpages.currentpage().getparameters().get('pageNum') != null?Integer.ValueOf(apexpages.currentpage().getparameters().get('pageNum')):1; 
          System.debug('page Num---'+pageNum );
         query = '';
          //upto here   
         // query = query + sortByFilter + ' NULLS LAST limit 500'; //Added by Gaurav
         
          
          
    }
    
    public void FilterData()
    {
        pageNum = 1;
        GetData();
    }

    //Queries the Data for the lists
    public PageReference GetData()
    {
     system.debug('@@@' + apexpages.currentpage().getparameters().get('sortByFilter'));
     apexpages.currentpage().getparameters().put('leadStatus',leadStatus);
        sortByFilter = (apexpages.currentpage().getparameters().get('sortByFilter') != null && apexpages.currentpage().getparameters().get('sortByFilter') != '')?apexpages.currentpage().getparameters().get('sortByFilter'):'CurrentAssignmentDate__c desc'; 
         system.debug('@@@' + sortByFilter );
        leads = new List<Lead>();
        List<Lead> tmpleads = new List<Lead>();
        deadLeads = new List<Lead>();
        Integer offset = (pageNum-1) * PAGE_SIZE; 
         system.debug('@@@Entered');
        List<Lead> tmpList = new List<Lead>();
        string tmpQuery = 'SELECT LeadReviewed__c,PartnerAccountId, firstname, lastname, company, Postal_Code__c, status, lastactivitydate,email, CurrentAssignmentDate__c , Country, State, City from Lead where Partner_Name__c = :tempId and isconverted = false ';
        if(leadStatus == 'Open Leads')  {
              tmpQuery = tmpQuery + ' AND (status = \'New\' or status = \'In Progress\')  ';
          }
        else if(leadStatus == 'Qualified Leads')  {
              tmpQuery = tmpQuery + ' AND status = \'Qualified\' '; //Added by Gaurav
          }
        
        tmpQuery = tmpQuery + 'ORDER BY ' + sortByFilter +' NULLS LAST  limit 20000';
        
       system.debug('My Query >>>>' + apexpages.currentpage().getparameters().get('sortByFilter') +'   ' + tmpQuery );
        
        
        
        for(Lead l : Database.query(tmpQuery)) {
                 system.debug('@@@' + apexpages.currentpage().getparameters().get('sortByFilter'));
                 if (apexpages.currentpage().getparameters().get('sortByFilter') == null || apexpages.currentpage().getparameters().get('sortByFilter') == ''){
                 
                     if(l.status != 'Dead'){
                         tmpleads.add(l);
                     }
                     else {
                         deadLeads.add(l);
                     }
                 }
                 else
                 {
                    tmpleads.add(l);
                 }
            }   
            if (deadLeads != null && deadLeads.size() > 0)
            {
                tmpleads.addAll(deadLeads); // upto here
            }           
            
            
       // tmpList = database.query(tmpQuery );
       // system.debug('@@@' + 'SELECT LeadReviewed__c,PartnerAccountId, firstname, lastname, company, Postal_Code__c, status, lastactivitydate,email, CurrentAssignmentDate__c ,Country ,State ,City from Lead ORDER BY ' + sortByFilter +' NULLS LAST  limit ' + offset+PAGE_SIZE);
     system.debug('@@Offset' + tmpleads.size() + '  ' + offset);
        Set<id> LeadIds = new Set<id>();
        if(tmpleads != null)
        {
        if(tmpleads.size()>=offset+PAGE_SIZE)
        {
            for (Integer i=offset;i<=offset+PAGE_SIZE-1;i++) {
                LeadIds.add(tmpleads[i].Id);
            }
        }
        else
        {
           for (Integer i=offset;i<tmpleads.size();i++) {
                LeadIds.add(tmpleads[i].Id);
            } 
        }
        }
      tmpleads = null;
         system.debug('My Set' + LeadIds.size());
         string str = '';
         
        query = 'SELECT LeadReviewed__c,PartnerAccountId, firstname, lastname, company, Postal_Code__c, status, lastactivitydate,email, CurrentAssignmentDate__c , Country, State, City from Lead where id in :LeadIds ORDER BY ' + sortByFilter +' NULLS LAST ' ;
        
       
        /*system.debug('status here is>>>>>>>>>>>>>' + leadStatus);
          if(leadStatus == 'All Leads')  {
              //query = query + ' ORDER BY  ' + sortByFilter + ' NULLS LAST limit ' + PAGE_SIZE + ' offset '+offset; //Added by Gaurav
          }
          
          if(leadStatus == 'Open Leads')  {
              //query = query + ' AND (status = \'New\' or status = \'In Progress\')  ORDER BY  ' + sortByFilter + ' NULLS LAST limit ' + PAGE_SIZE  + ' offset '+offset; //Added by Gaurav
              query = query + ' AND (status = \'New\' or status = \'In Progress\')  ';
          }
          
          if(leadStatus == 'Qualified Leads')  {
              //query = query + ' AND status = \'Qualified\'  ORDER BY  ' + sortByFilter + ' NULLS LAST limit ' + PAGE_SIZE + ' offset '+offset; //Added by Gaurav
              query = query + ' AND status = \'Qualified\' '; //Added by Gaurav
          }
          
          system.debug('Query is >>>>>' + query);*/
        //Checks for Authentication
        if(Authenticated == true){
            //Populates the Lead list via the string Partner_Name__c 
            //leads = [SELECT PartnerAccountId, firstname, lastname, phone, company, Address_State__c, Postal_Code__c, status, lastactivitydate,
             //email from Lead where Partner_Name__c = :tempId and isconverted = false]; 
             
             system.debug('our Query is ' + query );
             //leads = Database.query(query);
             deadLeads = new List<Lead>();
            for(Lead l : Database.query(query)) {
                 
                 if (apexpages.currentpage().getparameters().get('sortByFilter') == null || apexpages.currentpage().getparameters().get('sortByFilter') == ''){
                 
                     if(l.status != 'Dead'){
                         leads.add(l);
                     }
                     else {
                         deadLeads.add(l);
                     }
                 }
                 else
                 {
                    leads.add(l);
                 }
            }   
            if (deadLeads != null && deadLeads.size() > 0)
            {
                leads.addAll(deadLeads); // upto here
            }                
            //Populates the Opportunity list via the string Partner_Name__c 
            opps = [SELECT id, name, type, stagename from Opportunity where Partner_Name__c = :tempId];
            
            return null; 
        }else{
            //return Page.Unauthorized;    //Unauthenticated redirect.
            return Null; 
        }
    }
    
    
    //-----------------Used to Populate the Tabs----------------
    //Sends Leads to Page.
    Public List<Lead> getLeadResults()
    {      
        return leads;
    }
    // Returns Opportunities to Page.
    Public List<Opportunity> getOppsResults()
    {     
        return opps;
    }
    
    //----------------Redirect to Lead and Opps Page------------
    //Goes to the lead display page
    Public PageReference OpenLeadPage()
    {     
        string data = pController.EncryptData(pController.FetchKey(),ApexPages.currentPage().getParameters().get('u'));
        PageReference leadPage = Page.LeadDisplayPage;
        leadPage.getParameters().put('o',data);
        leadPage.getParameters().put('id', ApexPages.currentPage().getParameters().get('lid'));
        leadPage.getParameters().put('leadStatus', ApexPages.currentPage().getParameters().get('leadStatus'));// Addition by gaurav on 8 july 2014
        //Token
        data = token;
        leadPage.getParameters().put('token',data);          
        return leadPage;
    }
    
    //Goes to the opportunity display page.
    Public PageReference OpenOppsPage()
    {     
        //Encrypt Partner Name
        string data = pController.EncryptData(pController.FetchKey() ,ApexPages.currentPage().getParameters().get('u'));
        PageReference oppPage = Page.OppsDisplayPage;
        //Encrypted Partner Name 
        oppPage.getParameters().put('o',data);
        //Opportunity ID
        oppPage.getParameters().put('id', ApexPages.currentPage().getParameters().get('oid')); 
        //Token
        string data2 = token;
        oppPage.getParameters().put('token',data2);      
        return oppPage;
    }
    
    
    //To be removed in production: Creates a Search for Partner Name: 'Test' and grabs a token.
    public PageReference LoadPage()
    {
        //Refresh Page Reference
            PageReference newPage = Page.MainDisplayPage;
            string data = pController.EncryptData(pController.FetchKey() ,'Test');
            newPage.getParameters().put('u',data); 
            data = pController.urlTokenTest();
            newPage.getParameters().put('token',data);
            newPage.setRedirect(true); 

        return newPage;
    }
    
    
    public String getString() {
        return leadStatus;
    }
            
    public void setString(String s) {
        this.leadStatus = s;
        ApexPages.currentPage().getParameters().put('leadStatus', leadStatus);
        system.debug('Lead status is ' + this.leadStatus);
    }
    
    
    public List<Integer> getPaginationList() {
        List<Integer> paginationList = new List<Integer>();
        
        if (leadStatus == 'All Leads') {
            totalNumberOfResults = Database.CountQuery('Select count() from Lead where  Partner_Name__c = :tempId and isconverted = false limit 20000');
        } else if (leadStatus == 'Open Leads') {
            totalNumberOfResults = Database.CountQuery('Select count() from Lead where Partner_Name__c = :tempId and isconverted = false AND (status = \'New\' or status = \'In Progress\') limit 20000');
        } else if (leadStatus == 'Qualified Leads') {
            totalNumberOfResults = Database.CountQuery('Select count() from Lead where Partner_Name__c = :tempId and isconverted = false AND status = \'Qualified\' limit 20000');
        }  
        system.debug('totalNumberOfResults'+totalNumberOfResults);   
        
        if(totalNumberOfResults != null && totalNumberOfResults > 0 ){
            paginationList = CommUtils.getPaginationList(pageNum, totalNumberOfResults, PAGE_SIZE);
            lastpage = Math.ceil(Decimal.ValueOf(totalNumberOfResults)/Decimal.ValueOf(PAGE_SIZE));
            
        }
        else
        {
            paginationList = new List<integer>(1);
            lastpage = 1;
        }
        return paginationList;
    }
    
}