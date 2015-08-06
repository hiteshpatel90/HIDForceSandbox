/**
* Custom controller for the report_summary visual force page.
* The visual force page renders a PDF for a Visit_Report__c record
* when the user clicks the "Export to PDF" button.  The PDF also
* lists out the record's related lists.
*/
public class ReportSummaryController 
{
    public Visit_Report__c report { get;set; }
    public List<Contact_Junction__c> contacts { get;set; }
    public List<Opportunity_Junction__c> opportunities { get;set; }
    public List<User_Junction_Object__c> employees { get;set; }
    
    public List<Visit_Report__c> openActivities {get;set; }
    public List<Note> notes { get;set; }
    public List<Attachment> attachments { get;set; }
    public List<Visit_Report__c> activityHistory { get;set; }
    public List<NotesAndAttachmentWrapper> notesAndAttachmentsWrapperList {get; set;}
    
    public ReportSummaryController()
    {
        Id reportId;
        Map<String, String> params = ApexPages.currentPage().getParameters();   
        
        if( params.containsKey('Id') ) {
            reportId = params.get('Id');
        } else {
            //throw exception
        }
        
        notesAndAttachmentsWrapperList = new List<NotesAndAttachmentWrapper>();
        
        
        this.report = [Select Meeting_Purpose__c,  CreatedById, Visit_Location__c, Visit_Date__c, SystemModstamp, Report_Distribution__c, Related_Account__c, OwnerId, Name, 
                              LastModifiedDate, LastModifiedById, LastActivityDate, Key_Meeting_Notes__c, 
                              Internal_Use_Only__c, Id, Confidential__c, Confidence_Level__c 
                       From Visit_Report__c 
                       Where id = :reportId];
        
        
        contacts = [Select Phone_Number__c,Contact__r.Name, Name, Email__c, Contact_Account__c 
                    From Contact_Junction__c c 
                    Where Visit_Report__c = :reportId];
        
        employees = [Select Name, user__r.Name, Job_Title__c, Email__c, Department__c 
                     From User_Junction_Object__c 
                     Where Visit_Report__c = :reportId];
        
        opportunities = [Select Id, opportunity__r.name, Probability__c, Name, Opportunity_Amount__c, Location_Country__c, Location_City__c 
                         From Opportunity_Junction__c 
                         Where Visit_Report__c = :reportId];
        
        notes = [Select Title, ParentId, LastModifiedDate, Id, Note.CreatedBy.Name, Body 
                 From Note 
                 Where ParentId = :reportId];
        
        attachments = [Select Name, ParentId, LastModifiedDate, Id, Attachment.CreatedBy.Name, Body 
                       From Attachment 
                       Where ParentId = :reportId];
        
        activityHistory = [SELECT id, 
                                  (SELECT WhoId, Subject, OwnerId, LastModifiedDate, IsTask, ActivityDate From ActivityHistories) 
                           FROM Visit_Report__c 
                           WHERE  id = :reportId];
        
        openActivities = [SELECT id, 
                                 (Select WhoId, Subject, IsTask,  Status, Priority, OwnerId, IsClosed, ActivityDate From OpenActivities) 
                          FROM  Visit_Report__c 
                          Where Id = :reportId];
        
        System.debug(openActivities);
        System.debug(activityHistory);
        
        // Add the notes to the wrapper
        addNotes();
        
        // Add attachments to the wrapper
        addAttachments();
    }
    
    /**
    * Loop through the list of Note records and 
    * create a new NotesAndAttachmentWrapper object
    * passing in fields on the Note
    */
    private void addNotes() {
        for (Note note : notes) {
            notesAndAttachmentsWrapperList.add( new NotesAndAttachmentWrapper('Note', 
                                                                               note.Title, 
                                                                               note.Body,
                                                                               note.LastModifiedDate, 
                                                                               note.CreatedBy.Name) );
        }
    }
    
    /**
    * Loop through the list of Attachment records and 
    * create a new NotesAndAttachmentWrapper object
    * passing in fields on the Attachment
    */    
    private void addAttachments() {
        for (Attachment attachment : attachments) {
            
            Blob body = attachment.Body;
            
            notesAndAttachmentsWrapperList.add( new NotesAndAttachmentWrapper('Attachment', 
                                                                               attachment.Name, 
                                                                               body.toString(),
                                                                               attachment.LastModifiedDate, 
                                                                               attachment.CreatedBy.Name) );
        }
    }
    
    /**
    * Inner class needed so we can display all Notes and Attachments
    * for a given Visit_Report__c record
    */
    public class NotesAndAttachmentWrapper {
        public String types {get; set;}
        public String title {get; set;}
        public String body {get; set;}
        public Datetime lastModified {get; set;}
        public String createdBy {get; set;}
        
        public NotesAndAttachmentWrapper(String types, 
                                         String title, 
                                         String body,
                                         Datetime lastModified,
                                         String createdBy) {
           this.types = types;
           this.title = title;
           this.body = body;
           this.lastModified = lastModified;
           this.createdBy = createdBy;                                      
        }
    
    }
    
    // Test cases
    /**
    * The pdf generator outputs fields on the Visit_Report__c record along with
    * its related lists. (Open Activities, Notes & Attachments, Activity History, 
    * HID Employees Related To Visit, Opportunities Related to Visit, Contacts Related to Visit) 
    */
    static testMethod void testPdfGenerator()
    {
    	// -------------------- Data setup -----------------------------
        // Fist we need to create an account so we can tie a contact to an account
        Account a = new Account(Name='test account', Type='End-User', Vertical_Markets__c='Unknown');
        insert a;
                
        // Contact
        // Create a contact and tie it to the account record
        Contact c = new Contact(LastName='test contact', 
                                AccountId=a.Id);
        insert c;
        
        // create a visit report record
        Visit_Report__c testReport = new Visit_Report__c(Name='Test Project Record');
        insert testReport;
        
        // Contact Junction
        Contact_Junction__c contactJunction = new Contact_Junction__c(Contact__c=c.Id,
                                                                      Visit_Report__c=testReport.Id);
        insert contactJunction;
        
        // Create some related list records
        // Create an open activity, set the whoId to the contact record
        Task t = new Task(Subject='Test Subject', 
                          Priority='Normal', 
                          Status='Not Started', 
                          WhatId=testReport.Id, 
                          WhoId=c.Id);
        insert t;
        
        // Create a note
        Note n = new Note(Title='Test Note Title', 
                          Body='Test Note Body', 
                          ParentId=testReport.Id);
        insert n;
        
        Id idIDSOpportunity = [select id from recordtype where developername = 'IDS_Opportunity'].Id;
        // Opportunity
        Opportunity opp = new Opportunity(Name='Test Opp', 
                                          AccountId=a.Id, 
                                          recordTypeId = idIDSOpportunity,
                                          Region__c='NAM',
                                          Business_Segment__c='ID Assurance',
                                          CurrencyIsoCode='USD',
                                          Type='Expansion',
                                          StageName='Discovery',
                                          CloseDate=System.today().addDays(3),
                                          Vertical_Markets__c='Unknown');
        insert opp;
        
        // Opporunities Related to Visit related list
        Opportunity_Junction__c oppJunction = new Opportunity_Junction__c(Opportunity__c=opp.Id,
                                                                          Visit_Report__c=testReport.Id);
                                                                          
        insert oppJunction;
        
        // Create a parameter since the controller expects a paramter with the id of the Visit_Report__c record
        ApexPages.currentPage().getParameters().put('Id', testReport.Id);
        
        // -------------------- End Data setup -----------------------------
        
        // --------------- start test ------------------------
    	Test.startTest();
    	ReportSummaryController controller = new ReportSummaryController();
        Test.stopTest();
        // --------------- stop test ------------------------
        
        System.assertNotEquals(null, controller.report);
        System.assertEquals('Test Project Record', controller.report.Name);
        
        System.assertEquals(1, controller.contacts.size());
        System.assertEquals('test contact', controller.contacts.get(0).Contact__r.Name);
        
        // Opportunity Junction                                         
        System.assertEquals(1, controller.opportunities.size());
        System.assertEquals('Test Opp', controller.opportunities.get(0).Opportunity__r.Name);
                                          
        // Note
        System.assertEquals(1, controller.notes.size());
        System.assertEquals('Test Note Title', controller.notes.get(0).Title);
        
        System.assertEquals(1, controller.activityHistory.size());
        System.assertEquals(1, controller.openActivities.size());
        
        Task task = [Select Subject,Priority,Status,WhatId,WhoId
                     From Task
                     Where Id = :t.Id];
                     
        System.assertEquals('Test Subject', task.Subject);                                         
        System.assertEquals('Normal', task.Priority);
        System.assertEquals('Not Started', task.Status);
        System.assertEquals(testReport.Id, task.WhatId);
        System.assertEquals(c.Id, task.WhoId);
    }
}