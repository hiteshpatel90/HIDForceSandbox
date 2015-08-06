@isTest
private class setContactCardirisCountryTest {
    static testMethod void setContactCardirisCountryTest() {
        Contact c = new Contact(FirstName = 'Hans', LastName = 'Wurst', Cardiris_Country__c = 'Germany');
        Database.Saveresult d = Database.insert(c);
        system.assert(d.isSuccess());
    }
}