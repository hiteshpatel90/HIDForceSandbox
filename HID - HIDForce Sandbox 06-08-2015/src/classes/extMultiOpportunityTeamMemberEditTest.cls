/****************************************************************************
* Type               : Test Class
* Name               : extMultiOpportunityTeamMemberEditTest
* Modified by        : Hitesh Patel
* Modified Date      : 27th July 2015
* Last Modified By   : Hitesh Patel 27th July 2015
* Purpose            : This is test class for extMultiOpportunityTeamMemberEdit            
****************************************************************************/
@isTest
public class extMultiOpportunityTeamMemberEditTest{
    static testMethod void testData(){
        List<Account> insertLstAccounts = new List<Account>();
        List<Opportunity> insertLstOpportunity = new List<Opportunity>();
          
        // Insert account record
        insertLstAccounts = TestDataUtility.createAccounts(2);
        insert insertLstAccounts;
        
        // Insert Opportunity record       
        insertLstOpportunity = TestDataUtility.createOpportunity(2,insertLstAccounts);
        insert insertLstOpportunity;
        system.assertEquals(insertLstOpportunity[0].AccountId, insertLstAccounts[0].id);
        
        apexpages.standardcontroller stdOpp = new apexpages.standardcontroller(insertLstOpportunity[0]);
        
        apexpages.currentpage().getparameters().put('Id', insertLstOpportunity[0].id);
        extMultiOpportunityTeamMemberEdit objextMultiOppTeammember = new extMultiOpportunityTeamMemberEdit(stdOpp);
        
        objextMultiOppTeammember.isSendNotification = true;
        
        objextMultiOppTeammember.lstOpportunityTeamMember[0].UserId = system.userinfo.getUserid();
        objextMultiOppTeammember.addOpportunityTeamMember();
        objextMultiOppTeammember.addOpportunityTeamMemberAddMore();
        objextMultiOppTeammember.cancelTeamMember();
        
    }
}