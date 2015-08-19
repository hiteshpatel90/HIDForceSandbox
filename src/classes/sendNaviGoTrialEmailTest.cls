@isTest
private class sendNaviGoTrialEmailTest {
    
    // static String strTimestamp = String.valueOf(DateTime.now().getTime());
    
    // static String strExportControlQueueId = [
        // SELECT
            // QueueId
        // FROM
            // QueueSobject
        // WHERE
            // SobjectType = 'Lead'
            // AND Queue.DeveloperName = 'ExportCheckQueue'
            // LIMIT 1
    // ].QueueId;
    
    // static testMethod void sendNaviGoTrialEmailTestPass() {
        // Lead l = new Lead(
            // FirstName = 'Don',
            // LastName = 'Bilbo',
            // Company = 'Don Bilbo',
            // Email = 'dbilbo@bilbo.com',
            // Export_Check_Required__c = true,
            // Download_Product__c = 'naviGO',
            // Download_Link_Parameters__c = strTimestamp,
            // OwnerId = strExportControlQueueId
        // );
        
        // insert l;
        
        // l = [SELECT Id, Export_Status__c FROM Lead WHERE Id =: l.Id];
        // l.Export_Status__c = 'Software Encryption Allowed';
        // update l;
        
        // Integer i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the trial version of naviGO'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);
        
        // l.Business_Segment__c = 'PACS';
        // update l;
        
        // i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the trial version of naviGO'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);
    // }
    
    // static testMethod void sendNaviGoTrialEmailTestFail() {
        // Lead l = new Lead(
            // FirstName = 'Don',
            // LastName = 'Bilbo',
            // Company = 'Don Bilbo',
            // Email = 'dbilbo@bilbo.com',
            // Export_Check_Required__c = true,
            // Download_Product__c = 'naviGO',
            // Download_Link_Parameters__c = strTimestamp,
            // OwnerId = strExportControlQueueId
        // );
        
        // insert l;
        
        // l = [SELECT Id, Export_Status__c FROM Lead WHERE Id =: l.Id];
        // l.Export_Status__c = 'Software Encryption Declined';
        // update l;
        
        // Integer i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the trial version of naviGO'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);
        
        // l.Business_Segment__c = 'PACS';
        // update l;
        
        // i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the trial version of naviGO'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);      
    // }
    
    // static testMethod void sendCrescendoEmailTestPass() {
        // Lead l = new Lead(
            // FirstName = 'Don',
            // LastName = 'Bilbo',
            // Company = 'Don Bilbo',
            // Email = 'dbilbo@bilbo.com',
            // Export_Check_Required__c = true,
            // Download_Product__c = 'Crescendo C700',
            // Download_Link_Parameters__c = strTimestamp,
            // OwnerId = strExportControlQueueId
        // );
        // insert l;
        
        // l = [SELECT Id, Export_Status__c FROM Lead WHERE Id =: l.Id];
        // l.Export_Status__c = 'Software Encryption Allowed';
        // update l;
        
        // Integer i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the Crescendo Middleware'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);
        
        // l.Business_Segment__c = 'PACS';
        // update l;
        
        // i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the Crescendo Middleware'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);      
    // }
    
    // static testMethod void sendCrescendoEmailTestFail() {
        // Lead l = new Lead(
            // FirstName = 'Don',
            // LastName = 'Bilbo',
            // Company = 'Don Bilbo',
            // Email = 'dbilbo@bilbo.com',
            // Export_Check_Required__c = true,
            // Download_Product__c = 'Crescendo C700',
            // Download_Link_Parameters__c = strTimestamp,
            // OwnerId = strExportControlQueueId
        // );
        // insert l;
        
        // l = [SELECT Id, Export_Status__c FROM Lead WHERE Id =: l.Id];
        // l.Export_Status__c = 'Software Encryption Declined';
        // update l;
        
        // Integer i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the Crescendo Middleware'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);
        
        // l.Business_Segment__c = 'PACS';
        // update l;
        
        // i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // Subject = 'Email: Your request for the Crescendo Middleware'
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(1, i);      
    // }
    
       // static testMethod void sendNoEmailTest() {
        // Lead l = new Lead(
            // FirstName = 'Don',
            // LastName = 'Bilbo',
            // Company = 'Don Bilbo',
            // Email = 'dbilbo@bilbo.com',
            // Export_Check_Required__c = true,
            // Download_Product__c = 'MumboJambo',
            // Download_Link_Parameters__c = strTimestamp,
            // OwnerId = strExportControlQueueId
        // );
        // insert l;
        
        // l = [SELECT Id, Export_Status__c FROM Lead WHERE Id =: l.Id];
        // l.Export_Status__c = 'Software Encryption Declined';
        // update l;
        
        // Integer i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // (
                // Subject = 'Email: Your request for the Crescendo Middleware'
                // OR Subject  = 'Email: Your request for the trial version of naviGO'
            // )
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(0, i);
        
        // l.Business_Segment__c = 'PACS';
        // update l;
        
        // i = [
        // SELECT
            // Count()
        // FROM
            // Task
        // WHERE
            // (
                // Subject = 'Email: Your request for the Crescendo Middleware'
                // OR Subject  = 'Email: Your request for the trial version of naviGO'
            // )
            // AND WhoId =: l.Id
        // ];
        // system.assertEquals(0, i);      
    // }
}