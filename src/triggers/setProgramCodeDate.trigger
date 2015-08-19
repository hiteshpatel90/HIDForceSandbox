trigger setProgramCodeDate on Partner_Program__c (before insert) {
    datetime myDT = Datetime.now();
    String myDate = myDT.format('ddMMyyhhmmss');
    for (Partner_Program__c p : Trigger.new){
    	if(p.Account__c != null && p.Account_Cluster__c != null){
    		p.addError('Please select either an Account, or an Account Cluster, not both!');
    	}else if(p.Account__c != null){
        	Integer i = [
        		SELECT
        			COUNT()
        		FROM
        			Partner_Program__c
        		WHERE
        			Account__c =: p.Account__c 
        			AND RecordTypeId =: p.RecordTypeId
        	];
        	if(i>0){
            	p.addError('A program of this type already exists!');
        	}
    	}else if(p.Account_Cluster__c != null){
        	Integer i = [
        		SELECT
        			COUNT()
        		FROM
        			Partner_Program__c
        		WHERE
        			Account__c =: p.Account_Cluster__c 
        			AND RecordTypeId =: p.RecordTypeId
        	];
        	if(i>0){
            	p.addError('A program of this type already exists!');
        	}
    	}else{
    		p.addError('Please select an Account or Account Cluster!');
    	}
        if(p.RecordTypeId == PartnerProductConversion.advPrgRt){
            p.Participation_Code__c = 'AP-' + myDate;
        }else if(p.RecordTypeId == PartnerProductConversion.advPrCRt){
            p.Participation_Code__c = 'HC-' + myDate;
        }else if(p.RecordTypeId == PartnerProductConversion.genHIDRt){
            p.Participation_Code__c = 'GT-' + myDate;
        }
        /*else if(p.RecordTypeId == PartnerProductConversion.ideAssRt){
            p.Participation_Code__c = 'IA-' + myDate;
        }
        */
    }
}