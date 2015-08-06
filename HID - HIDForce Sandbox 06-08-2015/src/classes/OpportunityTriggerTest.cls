/*  This class will cover all methods of handlerUpdateProdMarketingandEngSitemgr
    Author: JadeGlobal  Date: 
*/
@isTest
public class OpportunityTriggerTest{
    
    static testMethod void dummyData(){
                
        // Insert account record
        List<Account> lstAccounts = new List<Account>();
        lstAccounts =TestDataUtility.createAccounts(2);
        insert lstAccounts;
        
        // Insert Product Team record         
        List<Product_Team__c> lstProducTeam = new List<Product_Team__c>();
        lstProducTeam =TestDataUtility.createProducTeam(2);
        insert lstProducTeam;
        
        // Insert Account Profile record         
        List<Account_Profile__c> lstAccountProfile = new List<Account_Profile__c>();
        lstAccountProfile = TestDataUtility.createAccountProfile(2, lstAccounts);
        insert lstAccountProfile;
        
        // Insert Product Team record
        Product_Team__c objProdTeam = new Product_Team__c();
        objProdTeam.Business_Segment__c = 'Animal Id';
        objProdTeam.Product_Line__c = 'Glass Tubes';
        objProdTeam.Business_Segment_Leader__c = system.userinfo.getuserid();
        objProdTeam.Regional_Segment_Director__c = system.userinfo.getuserid();
        insert objProdTeam;
        
        test.StartTest();
        List<Opportunity> lstOpportunityNew;
        User objUser = TestDataUtility.createUser();
        System.RunAs(objUser) {

            // Insert Opportunity record
            List<Opportunity> lstOpportunity = new List<Opportunity>();
            lstOpportunity = TestDataUtility.createOpportunity(2,lstAccounts);
            insert lstOpportunity;
            
            
        
            // Update Opportunity record
            for(Opportunity opp: lstOpportunity){
                opp.Region__c = 'NAM';
                opp.Business_Segment_Leader__c = system.userinfo.getuserid();           
                opp.Regional_Segment_Director__c = null;
            }
            update lstOpportunity;
            
            // Insert Opportunity record
            lstOpportunityNew = TestDataUtility.createOpportunity(2,lstAccounts);
            // Update Opportunity record
            for(Opportunity opp: lstOpportunityNew){
                opp.Region__c = 'NAM';
                opp.Business_Segment_Leader__c = system.userinfo.getuserid();           
                opp.Regional_Segment_Director__c = system.userinfo.getuserid();
            }
            insert lstOpportunityNew;
            
            
        }
        
        // Update Opportunity record
        for(Opportunity opp: lstOpportunityNew){
            opp.Ownerid = system.userinfo.getuserid();
            opp.Product_Marketing_Manager__c = system.userinfo.getuserid();           
            opp.Engineering_Site_Manager__c = system.userinfo.getuserid(); 
            opp.Project_Manager__c = system.userinfo.getuserid();           
            opp.Regional_Segment_Director__c = system.userinfo.getuserid();     
        }
        update lstOpportunityNew;
        test.StopTest();
     
    }
}