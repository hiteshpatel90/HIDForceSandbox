trigger sendNaviGoTrialEmail on Lead (before update) {
    
    String strExportControlQueueId = [
        SELECT
            QueueId
        FROM
            QueueSobject
        WHERE
            SobjectType = 'Lead'
            AND Queue.DeveloperName = 'ExportCheckQueue'
            LIMIT 1
    ].QueueId;

    String strFromId = [
        SELECT
            Id
        FROM
            OrgWideEmailAddress
        WHERE
            Address = 'exportcontrol-hid@hidglobal.com'
        LIMIT 1
    ].Id;
    
    map<String, Id> mapEmailTemplate = new map<String, Id>();
    
    for(EmailTemplate t : [
        SELECT 
            DeveloperName,
            Id
        FROM
            EmailTemplate
        WHERE
            DeveloperName IN (
                'Export_Control_Allowed_naviGO_English',
                'Export_Control_Declined_naviGO_English',
                'Export_Control_Allowed_Crescendo_English',
                'Export_Control_Declined_Crescendo_English'
            )
        ]
    ){
        mapEmailTemplate.put(t.DeveloperName, t.Id);
    }
    
    map<Id,Lead> mapLead = new map<Id,Lead>();
    
    for(Lead l : trigger.new){
        if(
            (
                l.Export_Status__c == 'Software Encryption Allowed'
                || l.Export_Status__c == 'Software Encryption Declined'
            ) && (
                l.Download_Product__c == 'naviGO'
                || l.Download_Product__c == 'Crescendo C700'
            )
            && trigger.oldMap.get(l.Id).OwnerId == strExportControlQueueId
            && l.Email != ''
            && l.Email != null
        ){
            mapLead.put(l.Id,l);
        }
    }

    for(Task t : [
        SELECT
            WhoId
        FROM
            Task
        WHERE
            (
                Subject = 'Email: Your request for the trial version of naviGO'
                OR Subject = 'Email: Your request for the Crescendo Middleware'
            )
            AND WhoId IN : mapLead.keySet()
        ]
    ){
        mapLead.remove(t.WhoId);    
    }

    list<Messaging.SingleEmailMessage> lstEmailMessage = new list<Messaging.SingleEmailMessage>();
    
    for(Lead l : mapLead.values()){
        Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
        
        m.setUseSignature(false);
        m.setTargetObjectId(l.Id);
        m.setOrgWideEmailAddressId(strFromId);
        
        if(l.Export_Status__c == 'Software Encryption Allowed' && l.Download_Product__c == 'naviGO'){
            m.setTemplateId(mapEmailTemplate.get('Export_Control_Allowed_naviGO_English'));
        }else if(l.Export_Status__c == 'Software Encryption Declined' && l.Download_Product__c == 'naviGO'){
            m.setTemplateId(mapEmailTemplate.get('Export_Control_Declined_naviGO_English'));
        }else if(l.Export_Status__c == 'Software Encryption Allowed' && l.Download_Product__c == 'Crescendo C700'){
            m.setTemplateId(mapEmailTemplate.get('Export_Control_Allowed_Crescendo_English'));
        }else if(l.Export_Status__c == 'Software Encryption Declined' && l.Download_Product__c == 'Crescendo C700'){
            m.setTemplateId(mapEmailTemplate.get('Export_Control_Declined_Crescendo_English'));
        }
        
        lstEmailMessage.add(m);
    }

    Messaging.sendEmail(lstEmailMessage);
}