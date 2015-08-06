trigger setERPUpdateOracle on Account (after update) {
	
	set<Id> setAccounts = new set<Id>();
	//Added by Atul on 8/6/2014 for updating Lead partner name if name changes
	map<id, string> mpAccname = new map<id, string>();
	//Addition ends
	for(Account a : trigger.new){
		//Use set of Accounts with new Oracle Customer Number for PAF ERP Update 
		if(
			String.isBlank(trigger.oldMap.get(a.Id).Oracle_Customer_Number__c)
			&& String.isNotBlank(a.Oracle_Customer_Number__c)
		){
			setAccounts.add(a.Id);
		}
		//Added by Atul on 8/6/2014 for updating Lead partner name if name changes
		if(a.name != null && a.name != Trigger.oldmap.get(a.id).name)
		{
			mpAccname.put(a.id, a.name);
		}
	}

	if(mpAccname != null && mpAccname.keyset().size() > 0)
	{
		List<Lead> lstLeads = new List<Lead>();
		lstLeads = [select id, PartnerAssignment__c, Partner_Name__c from lead where PartnerAssignment__c in :mpAccname.keyset()];
		for(lead l: lstLeads)
		{
			l.Partner_Name__c = mpAccname.get(l.PartnerAssignment__c);
		}
		if(lstLeads != null && lstLeads.size() > 0)
		{
			database.update(lstLeads, false);
		}
	}
	//Addition ends
	
	if(!setAccounts.isEmpty()){
		String strQry = 'SELECT Id, Account__c, ERP_Update__c';
		//Add Tyco fieldset members to query; required for excluding Tyco PAFs from ERP Update
	    list<Schema.FieldSetMember> lstFields = Schema.SObjectType.Price_Authorization_Form__c.fieldSets.Fields_with_Tyco.getFields();
	    for(Schema.FieldSetMember f : lstFields) {
	    	strQry += ', ' + f.getFieldPath();
	    }
		strQry += ' FROM Price_Authorization_Form__c WHERE Status__c = \'Approved\' AND ERP_Update__c = false AND ERP_Update_Date__c = null'; // AND Other__c = null';
		strQry += ' AND Account__c IN (';
		for(Id i : setAccounts){
			strQry += '\'' + i + '\', ';
		}
		strQry = strQry.left(strQry.length()-2);
		strQry += ')';
		//Don't set ERP_Update__c = true for pre-CE records
		strQry += ' AND RecordTypeId != \'' + utilController.idRecordInApprovalProcessRecordType + '\'';
		list<Price_Authorization_Form__c> lstPriceAuthorizationForms = Database.query(strQry);
		
		for(Price_Authorization_Form__c p : lstPriceAuthorizationForms){
			Boolean bolHasTyco = false;
			//Exclude Tyco PAFs from ERP Update
		    for(Schema.FieldSetMember f : lstFields){
		    	if(p.get(f.getFieldPath())=='Tyco'){
	               	bolHasTyco = true;
		    	}
		    }
		    if(bolHasTyco){
		    	continue;
		    }else{
		    	p.ERP_Update__c = true;
		    }
		}
		update lstPriceAuthorizationForms;
	}
}