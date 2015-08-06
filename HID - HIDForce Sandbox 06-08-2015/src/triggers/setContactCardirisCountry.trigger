trigger setContactCardirisCountry on Contact (before insert) {
    for(Contact C : trigger.new){
        if(c.Cardiris_Country__c != '' && c.Cardiris_Country__c != null){
            c.MailingCountry = c.Cardiris_Country__c;
            c.Cardiris_Country__c = null;
        }
    }
}