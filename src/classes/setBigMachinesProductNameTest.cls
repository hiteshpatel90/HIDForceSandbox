@isTest
private class setBigMachinesProductNameTest {
    static testMethod void myUnitTest() {
    	Product2 product = new Product2(Name='New Product', CurrencyIsoCode='USD');
    	insert product;
    	product = [SELECT Name, BigMachines__Part_Number__c FROM Product2 WHERE Name = 'New Product'];
    	system.assertEquals(product.Name, product.BigMachines__Part_Number__c);
    	product.Name = 'Not So New Product';
    	update product;
    	product = [SELECT Name, BigMachines__Part_Number__c FROM Product2 WHERE Name = 'Not So New Product'];
    	system.assertEquals(product.Name, product.BigMachines__Part_Number__c);
    }
}