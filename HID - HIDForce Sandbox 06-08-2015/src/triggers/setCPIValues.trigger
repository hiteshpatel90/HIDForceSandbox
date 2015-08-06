trigger setCPIValues on Business_Rep_Due_Diligence__c (before insert, before update) {
    set<String> setCountries = new set<String>();
    map<String,Double> mapCountries = new map<String,Double>();
    map<Id,Account> mapAccounts = new map<Id,Account>();
    
    for(Business_Rep_Due_Diligence__c b : trigger.new){
        mapAccounts.put(b.Account__c,null);
    }
    
    mapAccounts = new map<Id,Account>([SELECT Id, BillingCountry FROM Account WHERE Id IN : mapAccounts.keySet()]);
    
    for(Business_Rep_Due_Diligence__c b : trigger.new){
        system.debug('########'+mapAccounts.get(b.Account__c).BillingCountry);
        setCountries.add(mapAccounts.get(b.Account__c).BillingCountry);
        setCountries.add(b.Project_Country__c);
    }
    
    for(Countries__c c : [SELECT Country__c, CPI__c FROM Countries__c WHERE Country__c IN : setCountries]){
        mapCountries.put(c.Country__c,c.CPI__c);
    }
    
    for(Business_Rep_Due_Diligence__c b : trigger.new){
        Double dblAccCPI = mapCountries.get(mapAccounts.get(b.Account__c).BillingCountry);
        Double dblPrjCPI = mapCountries.get(b.Project_Country__c);

        b.Registered_Country_CPI__c = dblAccCPI;
        b.Project_Country_CPI__c = dblPrjCPI;
        
        b.Business_Rep_located_in_low_risk_country__c = dblAccCPI >= 7 ? true : false;
        b.Project_located_in_low_risk_country__c = dblPrjCPI >= 7 ? true : false;

        if(dblAccCPI >= 9){
            b.Registered_Country_CPI_Rating__c = 'Highly Clean';
        }else if(dblAccCPI < 9 && dblAccCPI >= 8){
            b.Registered_Country_CPI_Rating__c = 'Very Clean';
        }else if(dblAccCPI < 8 && dblAccCPI >= 7){
            b.Registered_Country_CPI_Rating__c = 'Moderately Clean';
        }else if(dblAccCPI < 7 && dblAccCPI >= 6){
            b.Registered_Country_CPI_Rating__c = 'Clean';
        }else if(dblAccCPI < 6 && dblAccCPI >= 4){
            b.Registered_Country_CPI_Rating__c = 'Average';
        }else if(dblAccCPI < 4 && dblAccCPI >= 3){
            b.Registered_Country_CPI_Rating__c = 'Corrupt';
        }else if(dblAccCPI < 3 && dblAccCPI >= 2){
            b.Registered_Country_CPI_Rating__c = 'Moderately Corrupt';
        }else if(dblAccCPI < 2 && dblAccCPI >= 1){
            b.Registered_Country_CPI_Rating__c = 'Very Corrupt';
        }else{
            b.Registered_Country_CPI_Rating__c = 'Highly Corrupt';
        }
        
        if(dblPrjCPI >= 9){
            b.Project_Country_CPI_Rating__c = 'Highly Clean';
        }else if(dblPrjCPI < 9 && dblPrjCPI >= 8){
            b.Project_Country_CPI_Rating__c = 'Very Clean';
        }else if(dblPrjCPI < 8 && dblPrjCPI >= 7){
            b.Project_Country_CPI_Rating__c = 'Moderately Clean';
        }else if(dblPrjCPI < 7 && dblPrjCPI >= 6){
            b.Project_Country_CPI_Rating__c = 'Clean';
        }else if(dblPrjCPI < 6 && dblPrjCPI >= 4){
            b.Project_Country_CPI_Rating__c = 'Average';
        }else if(dblPrjCPI < 4 && dblPrjCPI >= 3){
            b.Project_Country_CPI_Rating__c = 'Corrupt';
        }else if(dblPrjCPI < 3 && dblPrjCPI >= 2){
            b.Project_Country_CPI_Rating__c = 'Moderately Corrupt';
        }else if(dblPrjCPI < 2 && dblPrjCPI >= 1){
            b.Project_Country_CPI_Rating__c = 'Very Corrupt';
        }else{
            b.Project_Country_CPI_Rating__c = 'Highly Corrupt';
        }
        
        if(
            b.Accepts_standard_compensation__c &&
            b.Business_Rep_well_qualified__c &&
            b.Commercial_Project__c &&
            b.Compensation_paid_directly__c &&
            b.Contract_Renewal__c &&
            b.Fee_consistent_with_market_rates__c &&
            b.HID_Global_business_partner__c &&
            b.In_business_for_5_years__c &&
            b.No_connections_with_government_officials__c &&
            b.Registered_Corporation__c &&
            b.Sufficient_evidence_of_qualification__c &&
            b.Usual_payments_financial_arrangements__c &&
            dblAccCPI >= 7 &&
            dblPrjCPI >= 7
        ){
            b.Business_Representative_Questionnaire__c = 'Not Required';
        }else if(b.Business_Representative_Questionnaire__c != 'In Process' && b.Business_Representative_Questionnaire__c != 'Complete'){
            b.Business_Representative_Questionnaire__c = 'Required';
        }
    }
}