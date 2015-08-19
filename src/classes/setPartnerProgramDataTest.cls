@isTest(seeAllData=true)
private class setPartnerProgramDataTest {
    static User u;

    static{
        Profile up = [
            SELECT
                Id
            FROM
                Profile
            WHERE
                Name = 'HID Sales User - IAM'
        ];
        u = new User(
            Alias = 'u1',
            Email = 'u1@hidglobal.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = up.Id,
            Country = 'United States',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'u1@hidglobal.com'
        );
        insert u;
    }
    
    static testMethod void testAll(){
        list<Account> lstAccounts = new list<Account>();
        for(Integer i = 0; i <= 9; i++){
            Account a = new Account(
                Name = 'Don Bilbo Inc. ' + i,
                BillingCountry = 'United States',
                BillingState = 'California',
                Sub_Region__c = 'N. America',
                Region__c = 'NAM'
            );
            if(i == 0){
            	a.Oracle_Customer_Number__c = '34234';
            }
            lstAccounts.add(a);
        }
        Database.SaveResult[] lstAccountResult = Database.insert(lstAccounts);
        
        Account_Profile__c ap = new Account_Profile__c(
        	Account__c = lstAccountResult[0].getId(),
        	Business_Segment__c = 'PACS',
        	Partner_Type__c = 'OEM',
        	Tier__c = 'Silver',
        	Market_Size__c = 'AME-Large'
        );
        insert ap;
        
		Assessment__c asm = new Assessment__c(
			Account__c = lstAccountResult[0].getId(),
			Business_Segment__c = 'PACS',
			Partner_Type__c = 'OEM',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
        
        list<Partner_Program__c> lstPartnerPrograms = new list<Partner_Program__c>();
        Partner_Program__c p = new Partner_Program__c(
            RecordTypeId = utilController.idAdvantagePartnerRecordType,
            Account__c = lstAccountResult[0].getId(),
            Partner_Program_Status__c = 'In Progress',
            Partner_Program_Status_Modifier__c = 'N/A',
            Expiration_Date__c = date.today().addDays(180)
        );
        lstPartnerPrograms.add(p);
        p = new Partner_Program__c(
            RecordTypeId = utilController.idAdvantagePartnerRecordType,
            Account__c = lstAccountResult[1].getId(),
            Partner_Program_Status__c = 'Enrolled',
            Partner_Program_Status_Modifier__c = 'N/A'
        );
        lstPartnerPrograms.add(p);
        p = new Partner_Program__c(
            RecordTypeId = utilController.idAdvantagePartnerRecordType,
            Account__c = lstAccountResult[2].getId(),
            Partner_Program_Status__c = 'Opted Out',
            Partner_Program_Status_Modifier__c = 'Indirect'
        );
        lstPartnerPrograms.add(p);
        p = new Partner_Program__c(
            RecordTypeId = utilController.idAdvantagePartnerRecordType,
            Account__c = lstAccountResult[3].getId(),
            Partner_Program_Status__c = 'Opted Out',
            Partner_Program_Status_Modifier__c = 'Standard Pricing'
        );
        lstPartnerPrograms.add(p);
        Database.SaveResult[] lstPartnerProgramResult = Database.insert(lstPartnerPrograms);
        
        list<Partner_Program__c> lstPartnerProgramUpdate = new list<Partner_Program__c>();
        p = new Partner_Program__c(
            Id = lstPartnerProgramResult[0].getId(),
            Partner_Program_Status__c = 'Enrolled',
            Expiration_Date__c = null
        );
        lstPartnerProgramUpdate.add(p);
        p = new Partner_Program__c(
            Id = lstPartnerProgramResult[1].getId(),
            Partner_Program_Status__c = 'Opted Out',
            Partner_Program_Status_Modifier__c = 'Indirect'
        );
        lstPartnerProgramUpdate.add(p);
        p = new Partner_Program__c(
            Id = lstPartnerProgramResult[2].getId(),
            Partner_Program_Status__c = 'Opted Out',
            Partner_Program_Status_Modifier__c = 'Standard Pricing'
        );
        lstPartnerProgramUpdate.add(p);
        p = new Partner_Program__c(
            Id = lstPartnerProgramResult[3].getId(),
            Partner_Program_Status__c = 'Enrolled',
            Partner_Program_Status_Modifier__c = 'N/A'
        );
        lstPartnerProgramUpdate.add(p);
        Database.SaveResult[] lstPartnerProgramUpdateResult = Database.update(lstPartnerProgramUpdate);
        
        Partner_Program_Category__c pc = new Partner_Program_Category__c(
        	Partner_Program__c = lstPartnerProgramResult[0].getId(),
        	Partner_Program_Category__c = 'PACS'
        );
        insert pc;
        
		pc = new Partner_Program_Category__c(
        	Partner_Program__c = lstPartnerProgramResult[0].getId(),
        	Partner_Program_Category__c = 'PACS'
        );
        
        try{
            insert pc;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        
        p = new Partner_Program__c(
            Id = lstPartnerProgramResult[0].getId(),
            Partner_Program_Status__c = 'Opted Out',
            Partner_Program_Status_Modifier__c = 'Standard Pricing'
        );
        update p;
    }
    
    static testMethod void testBrazil(){
		Account a = new Account(
            Name = 'Don Bilbo Inc. 999',
            BillingCountry = 'Brazil',
            BillingState = 'Acre',
            Sub_Region__c = 'Brazil',
            Region__c = 'LAM'
        );
        insert a;
        
        Account_Profile__c ap = new Account_Profile__c(
        	Account__c = a.Id,
        	Business_Segment__c = 'PACS',
        	Partner_Type__c = 'OEM',
        	Tier__c = 'Silver'
        );
        insert ap;
        
		Assessment__c asm = new Assessment__c(
			Account__c = a.Id,
			Business_Segment__c = 'PACS',
			Partner_Type__c = 'OEM',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
        
        Partner_Program__c p = new Partner_Program__c(
            RecordTypeId = utilController.idAdvantagePartnerRecordType,
            Account__c = a.Id,
            Partner_Program_Status__c = 'In Progress',
            Partner_Program_Status_Modifier__c = 'N/A',
            Expiration_Date__c = date.today().addDays(180)
        );
        insert p;
        
        p = new Partner_Program__c(
        	Id = p.Id,
            Partner_Program_Status__c = 'Opted Out',
            Partner_Program_Status_Modifier__c = 'Standard Pricing'
        );
        update p;

    }
}