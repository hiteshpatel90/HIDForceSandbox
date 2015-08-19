@isTest(SeeAllData=true)
private class setCPIValuesTest {
    static final list<Countries__c> COUNTRIES = [SELECT Country__c, CPI__c FROM Countries__c];
    
    static testMethod void setCPIValuesTest() {
        integer i = 0;
        set<Id> setBRDD = new set<Id>();
        set<Id> setAccount = new set<Id>();
        list<Account> lstAccount = new list<Account>();
        list<Business_Rep_Due_Diligence__c> lstBRDD = new list<Business_Rep_Due_Diligence__c>();
        list<Database.SaveResult> lstDsrInsertAccount = new list<Database.SaveResult>();
        list<Database.SaveResult> lstDsrInsertBRDD = new list<Database.SaveResult>();
        
        for(Countries__c c : COUNTRIES){
            Account a = new Account(Name = 'Crazy Achmed', BillingCountry = 'United States');
            lstAccount.add(a);
        }
        
        lstDsrInsertAccount = Database.insert(lstAccount);

        for(Database.Saveresult d : lstDsrInsertAccount){
            setAccount.add(d.getId());
        }
        
        lstAccount = new list<Account>();
        
        for(Account a : [SELECT Id, BillingCountry FROM Account WHERE Id IN : setAccount]){
            lstAccount.add(a);
        }        

        for(Countries__c c : COUNTRIES){
            Business_Rep_Due_Diligence__c b = new Business_Rep_Due_Diligence__c(
                Account__c = lstAccount[i].Id,
                Project_Country__c = c.Country__c,
                Accepts_standard_compensation__c = true,
                Business_Rep_well_qualified__c = true,
                Commercial_Project__c = true,
                Compensation_paid_directly__c = true,
                Contract_Renewal__c = true,
                Fee_consistent_with_market_rates__c = true,
                HID_Global_business_partner__c = true,
                In_business_for_5_years__c = true,
                No_connections_with_government_officials__c = true,
                Registered_Corporation__c = true,
                Sufficient_evidence_of_qualification__c = true,
                Usual_payments_financial_arrangements__c = true,
                Compensation_paid_directly_to_employee__c = 'bla',
                Compensation_reasonable__c = 'bla',
                Criminally_prosecuted__c = 'bla',
                Current_past_connections_with_government__c = 'bla',
                Diligence_conducted__c = 'bla',
                HID_s_need_for_proposed_services__c = 'bla',
                Legal_agreement__c = 'bla',
                Payment_necessary_for_business__c = 'bla',
                Performance_Assessments__c = 'bla',
                Reason_for_unusual_fee__c = 'bla',
                Similar_payments_multiple_Business_Reps__c = 'bla',
                Subcontractors_Retained__c = 'bla',
                Subject_to_allegations__c = 'bla',
                Third_party_engagement__c = 'bla',
                Unusual_payments_financial_agreements__c = 'bla'
            );
            lstBRDD.add(b);
            i++;
        }

        Test.startTest();

        lstDsrInsertBRDD = Database.insert(lstBRDD);
        
        Test.stopTest();
        
        for(Database.Saveresult d : lstDsrInsertBRDD){
            setBRDD.add(d.getId());
        }
        
        for(Business_Rep_Due_Diligence__c b : [SELECT Registered_Country_CPI__c, Registered_Country_CPI_Rating__c, Project_Country_CPI__c, Project_Country_CPI_Rating__c, Business_Rep_located_in_low_risk_country__c, Project_located_in_low_risk_country__c, Business_Representative_Questionnaire__c FROM Business_Rep_Due_Diligence__c WHERE Id IN : setBRDD]){
            system.assertNotEquals(b.Registered_Country_CPI__c,null);
            system.assertNotEquals(b.Registered_Country_CPI_Rating__c,null);
            
            system.assertNotEquals(b.Project_Country_CPI__c,null);
            system.assertNotEquals(b.Project_Country_CPI_Rating__c,null);
            
            system.assertNotEquals(b.Business_Rep_located_in_low_risk_country__c,null);
            system.assertNotEquals(b.Project_located_in_low_risk_country__c,null);
            
            system.assertNotEquals(b.Business_Representative_Questionnaire__c,null);
        }
    }
}