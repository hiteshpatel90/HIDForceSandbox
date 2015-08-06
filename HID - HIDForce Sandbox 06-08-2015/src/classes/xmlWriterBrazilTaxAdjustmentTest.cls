@isTest
private class xmlWriterBrazilTaxAdjustmentTest {
    static final String strExpected = '';

    static testMethod void getLoginXMLTest(){
        String strActual = xmlWriterBrazilTaxAdjustment.getLoginXML();
        system.assertNotEquals(strExpected,strActual);
    }   

    static testMethod void getAddXMLTest(){
        BrazilTaxAdjustment__c b = new BrazilTaxAdjustment__c(Name='FE',Price_Code__c='FE',Adjustment_Factor__c=1.23);
        insert b;
        String strActual = xmlWriterBrazilTaxAdjustment.getAddXML();
        system.assertNotEquals(strExpected,strActual);
    }       

    static testMethod void getDeleteXMLTest(){
        String strActual = xmlWriterBrazilTaxAdjustment.getDeleteXML();
        system.assertNotEquals(strExpected,strActual);
    }   
    
    static testMethod void getDeployXMLTest(){
        String strActual = xmlWriterBrazilTaxAdjustment.getDeployXML();
        system.assertNotEquals(strExpected,strActual);
    }
    
    static testMethod void testSchedule(){
        Date datToday = date.today();
        String strMyTomorrow = String.valueOf(datToday.addDays(1)) + ' 01:00:00';
        
        Test.startTest();
        String jobId = System.schedule('Test Brazil Tax Adjustment', '0 0 1 * * ?', new xmlWriterBrazilTaxAdjustmentSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        Test.stopTest();
        
        system.assertEquals('0 0 1 * * ?', ct.CronExpression);
        system.assertEquals(0, ct.TimesTriggered);
        //system.assertEquals(strMyTomorrow, String.valueOf(ct.NextFireTime));
    }
    
     static testMethod void testCallout() {
        Test.setMock(HttpCalloutMock.class, new mockHttpResponseGenerator());

        HttpResponse res = xmlWriterBrazilTaxAdjustment.getHTTP('Hello');

        String contentType = res.getHeader('Content-Type');
        system.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"foo":"bar"}';
        system.assertEquals(actualValue, expectedValue);
        system.assertEquals(200, res.getStatusCode());
    }
    
    static testMethod void sendXMLTest(){
        test.startTest();
        xmlWriterBrazilTaxAdjustment.sendXML('add');
        test.stopTest();
    }
}