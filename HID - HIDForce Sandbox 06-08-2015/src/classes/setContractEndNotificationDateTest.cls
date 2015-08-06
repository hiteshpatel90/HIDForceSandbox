@isTest
private class setContractEndNotificationDateTest {
    static testMethod void setContractEndNotificationDateTest() {
        Date datToday = date.today();
        Date datNextYear = datToday.addYears(1);
        Date datAfterNextYear = datNextYear.addYears(1);

        set<Id> setContract = new set<Id>();
        list<Contract> lstContract = new list<Contract>();
        list<Database.SaveResult> lstDsrInsertContract = new list<Database.SaveResult>();
        
    	Id idContractRecordType = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Business Rep Due Diligence').getRecordTypeId(); 
    	
        Account a = new Account(Name = 'Crazy Achmed');
        insert a;
        
        for(Integer i = 1; i < 68; i++){
	        Contract c = new Contract(
	        	RecordTypeId = idContractRecordType,
	        	AccountId = a.Id,
	        	Status = 'Draft',
	        	Agreement_Type__c = 'Agency',
	        	StartDate = datToday
	        );
	        lstContract.add(c);
	        
	        c = new Contract(
	        	RecordTypeId = idContractRecordType,
	        	AccountId = a.Id,
	        	Status = 'Draft',
	        	Agreement_Type__c = 'Agency',
	        	StartDate = datToday,
	        	EndDate = datNextYear,
	        	OwnerExpirationNotice = '15'
	        );
	        lstContract.add(c);
	        
	        c = new Contract(
	        	RecordTypeId = idContractRecordType,
	        	AccountId = a.Id,
	        	Status = 'Draft',
	        	Agreement_Type__c = 'Agency',
	        	StartDate = datToday,
	        	EndDate = datAfterNextYear,
	        	OwnerExpirationNotice = '15'
	        );
	        lstContract.add(c);	        
        }
        
        Contract c = new Contract(
	        RecordTypeId = idContractRecordType,
	        AccountId = a.Id
	    );
        
        Test.startTest();
        
        lstDsrInsertContract = Database.insert(lstContract);
        
        try{
        	insert c;
        }catch(Exception e){
        	system.assert(e.getMessage().contains('Start Date is required!'));
        }
        
        Test.stopTest();
        
		for(Database.Saveresult d : lstDsrInsertContract){
			setContract.add(d.getId());
		}
        
        for(Contract cs : [
        	SELECT
        		StartDate,
        		EndDate,
        		Contract_End_Notification_Date__c,
        		Contract_End_Warning_Date__c,
        		Anti_Bribery_Recertification_Date__c
        	FROM
        		Contract
        	WHERE
        		Id IN : setContract
        ]){
	        if(cs.EndDate != null){
	        	system.assertNotEquals(cs.Contract_End_Notification_Date__c,null);
	        	system.assertEquals(cs.Contract_End_Warning_Date__c,cs.Contract_End_Notification_Date__c.addDays(-15));
	        	Decimal decNotificationYears = Decimal.valueOf((cs.StartDate.daysBetween(date.today()) / 365)).round(system.roundingmode.DOWN) + 1;
				if(
					cs.StartDate.daysBetween(cs.EndDate) > 365
					&& cs.StartDate.addYears(Integer.valueOf(decNotificationYears)) < cs.EndDate
				){
	        		system.assertEquals(cs.Anti_Bribery_Recertification_Date__c,cs.StartDate.addYears(Integer.valueOf(decNotificationYears)));
	        	}else{
	        		system.assertEquals(cs.Anti_Bribery_Recertification_Date__c,null);
	        	}
	        }
        }
    }
}