@isTest
private class priceBookEditControllerTest {
    static Account a;
    static Contact k;
    static Account_Profile__c p;
    
    static { 
        a = new Account(
            Name = 'Don Bilbo Inc.',
            BillingCountry = 'United States',
            BillingState = 'California',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Oracle_Customer_Number__c = '12345'
        );
        insert a;

        k = new Contact(
            AccountId = a.Id,
            FirstName = 'Don',
            LastName = 'Bilbo',
            Email = 'dbilbo@hidglobal.com',
            Pricing_Notifications__c = 'Yes'
        );
        insert k;

        p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert p;
    }
    
    static testMethod void testSuccess(){
        Pricebook_Request__c r = new Pricebook_Request__c(
            Contact_Name__c = k.Id,
            Send_To__c = 'Requester only',
            Customer_Price_Book_Type__c = 'IAM Standard Customer Price Books',
            Customer_Price_Book__c = 'IAM Secure Issuance Customer Price Book USD'
        );
        
        PageReference ref = Page.PriceBookEdit;
        Test.setCurrentPage(ref);
        
        priceBookEditController c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getObjPriceBook();
        c.getLstCustomerPriceBook();
        c.updatePriceBook();
        ApexPages.PageReference returnPage = c.customSave();
        ApexPages.currentPage().getParameters().put('retURL', k.Id);
        returnPage = c.customSave();
        
    }
    static testMethod void testFail(){
        Pricebook_Request__c r = new Pricebook_Request__c();
        
        priceBookEditController c = new priceBookEditController(new ApexPages.StandardController(r));
        ApexPages.PageReference returnPage = c.customSave();
    }
    
    static testMethod void testPriceBookCurrency(){
        Account_Profile__c pp = [
            SELECT
                Pricebook_Currency__c
            FROM
                Account_Profile__c
            WHERE
                Id =: p.Id
        ];
        pp.Pricebook_Currency__c = 'EUR';
        update pp;
        
        Pricebook_Request__c r = new Pricebook_Request__c(
            Contact_Name__c = k.Id,
            Send_To__c = 'Requester only',
            Customer_Price_Book_Type__c = 'IAM Standard Customer Price Books'
        );
        
        priceBookEditController c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getLstCustomerPriceBook();
        
        pp.Pricebook_Currency__c = 'CNY';
        update pp;

        c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getLstCustomerPriceBook();
        
        pp.Pricebook_Currency__c = 'GBP';
        update pp;

        c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getLstCustomerPriceBook();
        
        
        pp.Pricebook_Currency__c = 'INR';
        update pp;

        c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getLstCustomerPriceBook();
        
        Account aa = new Account(
            Name = 'Don Bilbo Co.',
            BillingCountry = 'Germany',
            Channel__c = 'IAM - Distribution',
            Region__c = 'EMEA',
            Sub_Region__c = 'W. Europe & Nordics',
            Oracle_Customer_Number__c = '54321'
        );
        insert aa;
        
        Contact kk = new Contact(
            AccountId = aa.Id,
            FirstName = 'Don',
            LastName = 'Bilbo',
            Email = 'dbilbo@hidglobal.com',
            Pricing_Notifications__c = 'Yes'
        );
        insert kk;
        
        pp = new Account_Profile__c(
            Account__c = aa.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert pp;
        
        r = new Pricebook_Request__c(
            Contact_Name__c = kk.Id,
            Send_To__c = 'Requester only',
            Customer_Price_Book_Type__c = 'IAM Standard Customer Price Books'
        );
        
        c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getLstCustomerPriceBook();
        
        aa.BillingCountry = 'Brazil';
        aa.Sub_Region__c = 'Brazil';
        aa.Region__c = 'LAM';
        update aa;
        
        r = new Pricebook_Request__c(
            Contact_Name__c = kk.Id,
            Send_To__c = 'Requester only',
            Customer_Price_Book_Type__c = 'IAM Standard Customer Price Books'
        );
        
        c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getLstCustomerPriceBook();
    }
    
    static testMethod void testNoAccountProfile(){
        Account aa = new Account(
            Name = 'Don Bilbo Co.',
            BillingCountry = 'Germany',
            Channel__c = 'IAM - Distribution',
            Region__c = 'EMEA',
            Sub_Region__c = 'W. Europe & Nordics',
            Oracle_Customer_Number__c = '54321'
        );
        insert aa;
        
        Contact kk = new Contact(
            AccountId = aa.Id,
            FirstName = 'Don',
            LastName = 'Bilbo',
            Email = 'dbilbo@hidglobal.com',
            Pricing_Notifications__c = 'Yes'
        );
        insert kk;
        
        Pricebook_Request__c r = new Pricebook_Request__c(
            Contact_Name__c = kk.Id,
            Send_To__c = 'Requester only',
            Customer_Price_Book_Type__c = 'IAM Standard Customer Price Books',
            Customer_Price_Book__c = 'IAM Secure Issuance Customer Price Book USD'
        );
        
        PageReference ref = Page.PriceBookEdit;
        Test.setCurrentPage(ref);
        
        priceBookEditController c = new priceBookEditController(new ApexPages.StandardController(r));
        c.getLstCustomerPriceBook();
        
        r.Customer_Price_Book_Type__c = 'IAM NAS Customer Price Books (Requires NAS NDA Contract)';
        c.getLstCustomerPriceBook();
        
        /*r.Customer_Price_Book_Type__c = 'IAM VertX Customer Price Books';
        c.getLstCustomerPriceBook();*/
        
        r.Customer_Price_Book_Type__c = 'IAM E21 Customer Price Books (Approved Accounts ONLY)';
        c.getLstCustomerPriceBook();
    }
}