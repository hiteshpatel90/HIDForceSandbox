@isTest(seeAllData=true)
private class setOrderDetailToQuoteProductTest {
	static Account a;
	static Opportunity o;
	static Product2 p;
	static Pricebook2 pb;
	static PricebookEntry pbe;  
	static BigMachines__Quote__c q;
	// static BigMachines__Quote_Product__c qp;
	static Order_History__c oh;
	
	static {
        a = new Account(
            Name = 'Don Bilbo Inc.',
            BillingCountry = 'United States',
            Billingstate = 'California',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Oracle_Customer_Number__c = '12345',
            Region__c = 'NAM'
        );
        insert a;
        
        /* pb = new Pricebook2(
        	Name = 'Crapachino'
        );
        insert pb; */
        
        Id idStandardPricebook = test.getStandardPricebookId();
        p = [
        	SELECT
        		Id,
        		Name
        	FROM
        		Product2
        	WHERE
        		IsActive = true
        	LIMIT 1
        ];
        
        /* p = new Product2(
        	Name = 'Crapachino'
        );
        insert p;
        
        Id idStandardPricebook = test.getStandardPricebookId(); 
        pbe = new PricebookEntry(
        	Product2Id = p.Id,
        	Pricebook2Id = idStandardPricebook,
        	CurrencyISOCode = 'EUR'
        ); */
        
		o = [
			SELECT
				Id
			FROM
				Opportunity
			WHERE
				StageName != null
				AND Quote_Type__c != null
			LIMIT 1
		];

		q = [
			SELECT
				Id,
				Name
			FROM
				BigMachines__Quote__c
			WHERE
				BigMachines__Opportunity__r.StageName = 'Discovery'
				AND BigMachines__Opportunity__r.Business_Segment__c = 'PACS'
				AND BigMachines__Status__c = 'Pending'
			LIMIT 1
		];
		
		oh = new Order_History__c(
			Account__c = a.Id
		);
		insert oh;

	}
	
    static testMethod void setOrderDetailToQuoteProductTest() {
		BigMachines__Quote_Product__c qp = new BigMachines__Quote_Product__c(
			BigMachines__Quote__c = q.Id,
			Name = q.Name,
			BigMachines__Product__c = p.Id,
			BigMachines__Quantity__c = 1,
			BigMachines__Sales_Price__c = 1.0
		);
		insert qp;
    	
    	test.startTest();
        Order_Detail__c od = new Order_Detail__c(
        	Name = 'Crapachino',
        	Quote_Number__c = 'Crapachino',
        	Order_History_Number__c = oh.Id,
        	Ordered_Item__c = 'Crapachino',
        	Quanity__c = 1
        );
        insert od;
        
		od = new Order_Detail__c(
        	Name = 'Crapachino',
        	Quote_Number__c = 'Crapachino',
        	Order_History_Number__c = oh.Id,
        	Ordered_Item__c = 'Crapachino',
        	Quanity__c = 1
        );
        insert od;
        test.stopTest();
    }
    
    static testMethod void setQuoteProductToOrderDetail() {
        Order_Detail__c od = new Order_Detail__c(
        	Name = 'Crapachino',
        	Quote_Number__c = 'Crapachino',
        	Order_History_Number__c = oh.Id,
        	Ordered_Item__c = 'Crapachino',
        	Quanity__c = 1
        );
        insert od;
        
        test.startTest();
		BigMachines__Quote_Product__c qp = new BigMachines__Quote_Product__c(
			BigMachines__Quote__c = q.Id,
			Name = q.Name,
			BigMachines__Product__c = p.Id,
			BigMachines__Quantity__c = 1,
			BigMachines__Sales_Price__c = 1.0
		);
		insert qp;
		test.stopTest();
    }

    static testMethod void setOrderDetailToQuoteProductUpdateTest() {
    	BigMachines__Quote__c qq = q.clone();
    	qq.Name = 'Cornholio';
    	insert qq;
    	
		BigMachines__Quote_Product__c qp = new BigMachines__Quote_Product__c(
			BigMachines__Quote__c = q.Id,
			Name = q.Name,
			BigMachines__Product__c = p.Id,
			BigMachines__Quantity__c = 1,
			BigMachines__Sales_Price__c = 1.0
		);
		insert qp;
    	
    	test.startTest();
        Order_Detail__c od = new Order_Detail__c(
        	Name = 'Crapachino',
        	Quote_Number__c = 'Crapachino',
        	Order_History_Number__c = oh.Id,
        	Ordered_Item__c = 'Crapachino',
        	Quanity__c = 1
        );
        insert od;
        
        od.Quote_Number__c = 'Cornholio';
        update od;
        
        test.stopTest();
    }
}