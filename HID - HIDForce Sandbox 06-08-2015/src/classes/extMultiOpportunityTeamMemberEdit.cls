/****************************************************************************
* Type               : Apex Class
* Name               : extMultiOpportunityTeamMemberEdit
* Modified by        : Hitesh Patel
* Modified Date      : 24th July 2015
* Last Modified By   : Hitesh Patel 24th July 2015
* Purpose            : This is Extension class for "MultiOpportunityTeamMemberEdit" visualforce page
                       This class is used to enter Opportunity Team under particular Opportunity with Notification to user            
****************************************************************************/
public class extMultiOpportunityTeamMemberEdit{
    public string strInfoMsg {get; set;}
    public OpportunityTeamMember objOppMem {get; set;}
    public List<OpportunityTeamMember> lstOpportunityTeamMember {get; set;}
    public string strOppId {get; set;}
    public Opportunity objOpp;
    public boolean isSendNotification {get; set;}
    // Constructor
    public extMultiOpportunityTeamMemberEdit(apexpages.standardcontroller stdOpp){
        isSendNotification = false;
        strOppId = apexpages.currentpage().getparameters().get('Id');
        objOpp = new Opportunity(id=strOppId);
        lstOpportunityTeamMember = new List<OpportunityTeamMember>();
        for(Integer i = 0; i < 5; i ++){
            
            objOppMem = new OpportunityTeamMember();
            objOppMem.OpportunityId = strOppId;
            lstOpportunityTeamMember.add(objOppMem);
        }
        strInfoMsg = 'Team members\' access level for this opportunity may be greater than your organization\'s default opportunity access settings.<a href="javascript:openPopupFocusEscapePounds(%27https://help.salesforce.com/apex/htdoor?loc=help&target=salesteam_add.htm&section=Team_Selling&language=en_US&release=196.15&instance=CS30%27, %27Help%27, 1024, 768, %27width=1024,height=768,resizable=yes,toolbar=yes,status=yes,scrollbars=yes,menubar=yes,directories=no,location=yes,dependant=no%27, false, false);">Learn More</a>';
 
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,strInfoMsg );
        ApexPages.addMessage(myMsg);
    }
    
    // Method to insert Opportunity Team member
    public pagereference addOpportunityTeamMember(){
        List<OpportunityTeamMember> lstOpportunityTeamMemberInsert = new List<OpportunityTeamMember>();
        for(OpportunityTeamMember otm: lstOpportunityTeamMember){
            if(otm.UserId != null){
                lstOpportunityTeamMemberInsert.add(otm);
            }
        }
        // condition to check email need to send or not
        if(isSendNotification == true){
            
            // Create a master list to hold the emails we'll send
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            for(OpportunityTeamMember otm: lstOpportunityTeamMemberInsert){
                // Create a new Email
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setTargetObjectId(otm.userid);
                // Set email contents - you can use variables!
                mail.setSubject('You have been successfully added in the Opportunity Team');
                //mail.setTemplateId(templateList[0].Id);
                mail.setplaintextBody('You have been successfully added in the Opportunity Team');
                mail.setsaveAsActivity(false);
                mails.add(mail);
            }
            Messaging.sendEmail(mails);
            system.debug('############'+mails);
        }
        if(!lstOpportunityTeamMemberInsert.isEmpty()){
            insert lstOpportunityTeamMemberInsert;
        }
        pagereference pr = new ApexPages.StandardController(objOpp).view();
        pr.setRedirect(true);
        return pr;
    
    }
    // Method to insert Opportunity Team member
    public pagereference addOpportunityTeamMemberAddMore(){
        List<OpportunityTeamMember> lstOpportunityTeamMemberInsert = new List<OpportunityTeamMember>();
        for(OpportunityTeamMember otm: lstOpportunityTeamMember){
            if(otm.UserId != null){
                lstOpportunityTeamMemberInsert.add(otm);
            }
        }
        // condition to check email need to send or not
        if(isSendNotification == true){
            
            // Create a master list to hold the emails we'll send
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            for(OpportunityTeamMember otm: lstOpportunityTeamMemberInsert){
                // Create a new Email
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setTargetObjectId(otm.userid);
                // Set email contents - you can use variables!
                mail.setSubject('You have been successfully added in the Opportunity Team');
                //mail.setTemplateId(templateList[0].Id);
                mail.setplaintextBody('You have been successfully added in the Opportunity Team');
                mail.setsaveAsActivity(false);
                mails.add(mail);
            }
            Messaging.sendEmail(mails);
        }
        if(!lstOpportunityTeamMemberInsert.isEmpty()){
            insert lstOpportunityTeamMemberInsert;
        }
        pagereference pr = new pagereference('/apex/MultiOpportunityTeamMemberEdit?oppId=' + strOppId);
        pr.setRedirect(true);
        return pr;
    
    }
    // Go back to Opportunity detail page
    public pagereference cancelTeamMember(){
        pagereference pr = new ApexPages.StandardController(objOpp).view();
        pr.setRedirect(true);
        return pr;
    
    }
}