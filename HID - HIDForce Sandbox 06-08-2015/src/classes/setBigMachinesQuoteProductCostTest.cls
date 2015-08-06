@isTest
private class setBigMachinesQuoteProductCostTest {

    static testMethod void setBigMachinesQuoteProductCost() {
        
        Product2 p = new Product2(Name = 'Test');
        insert p;
        
        Product_Cost__c c = new Product_Cost__c(
        	Name = 'Test',
        	Product__c = p.Id,
        	Cost__c = 1.23,
        	ISO_Currency__c = 'USD',
        	Org__c = 'MAX'
        );
        insert c;
        
        Product_Cost_Conversion_Rates__c cc = new Product_Cost_Conversion_Rates__c(
        	Name = 'USDEUR',
        	From_Currency__c = 'USD',
        	To_Currency__c = 'EUR',
        	Conversion_Rate__c = 0.75
        );
        insert cc;
        
        BigMachines__Quote__c q = new BigMachines__Quote__c(
        	Name = 'Test'
        );
        insert q;
        
        BigMachines__Quote_Product__c qp = new BigMachines__Quote_Product__c(
        	Name = 'Test',
        	BigMachines__Quote__c = q.Id,
        	BigMachines__Quantity__c = 1,
        	BigMachines__Sales_Price__c = 4.56,
        	BigMachines__Product__c = p.Id,
        	CurrencyIsoCode = 'USD'
        );
        insert qp;
        
        qp = [
        	SELECT
        		Cost__c,
        		Cost_Quote_Currency__c
        	FROM
        		BigMachines__Quote_Product__c
        	WHERE
        		Id =: qp.Id
        ];
        
        system.assertEquals(qp.Cost__c, 1.23);
        system.assertEquals(qp.Cost_Quote_Currency__c, 1.23);
        
        q = new BigMachines__Quote__c(
        	Name = 'Test2'
        );
        insert q;
        
        qp = new BigMachines__Quote_Product__c(
        	Name = 'Test',
        	BigMachines__Quote__c = q.Id,
        	BigMachines__Quantity__c = 1,
        	BigMachines__Sales_Price__c = 4.56,
        	BigMachines__Product__c = p.Id,
        	CurrencyIsoCode = 'EUR'
        );
        insert qp;
        
        qp = [
        	SELECT
        		Cost__c,
        		Cost_Quote_Currency__c
        	FROM
        		BigMachines__Quote_Product__c
        	WHERE
        		Id =: qp.Id
        ];
        
        system.assertEquals(qp.Cost__c, 1.23);
        system.assertEquals(qp.Cost_Quote_Currency__c, 1.23 * 0.75);
        
        p = new Product2(
        	Name = 'Test1'
        );
        insert p;
        
        qp = new BigMachines__Quote_Product__c(
        	Name = 'Test1',
        	BigMachines__Quote__c = q.Id,
        	BigMachines__Quantity__c = 1,
        	BigMachines__Sales_Price__c = 4.56,
        	BigMachines__Product__c = p.Id
        );
        insert qp;
        
        qp = [
        	SELECT
        		Cost__c
        	FROM
        		BigMachines__Quote_Product__c
        	WHERE
        		Id =: qp.Id
        ];
        
        system.assertEquals(qp.Cost__c, null);
    }
}