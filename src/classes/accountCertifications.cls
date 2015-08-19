public class accountCertifications {
	
	public void setAccountCertifications (set<Id> setAccounts){
		map<Id,Integer> mapAccountPivCLASSPAMs = new map<Id,Integer>();
		map<Id,Integer> mapAccountPivCLASSSoftware = new map<Id,Integer>();
		map<Id,String> mapAccountNewCertifications = new map<Id,String>();
		map<Id,String> mapAccountOldCertifications = new map<Id,String>();

		for(Account a : [
			SELECT
				Id,
				HID__c,
				(
					SELECT
						Attendee__c,
						Course_or_Module__c,
						Course_or_Module__r.Name
					FROM
						Training_History__r
					WHERE
						Attendee__r.Status__c = 'Active'
						AND Course_or_Module__c IN (
							SELECT
								Id
							FROM
								Course__c
							WHERE (
								Name LIKE 'pivCLASS Advanced Training%'
								OR Name LIKE 'pivCLASS PKI @ the Door Training%'
								OR Name LIKE 'pivCLASS Software Training%'
							)
						)
				)
			FROM
				Account
			WHERE
				Id IN : setAccounts
		]){
			String s = a.HID__c;
			if(s == null){
				s = '';
			}
			mapAccountNewCertifications.put(a.Id,s);
			mapAccountOldCertifications.put(a.Id,s);
			
			for(Training__c t : a.Training_History__r){
				if(
					t.Course_or_Module__r.Name.startsWithIgnoreCase('pivCLASS Advanced Training')
					|| t.Course_or_Module__r.Name.startsWithIgnoreCase('pivCLASS PKI @ the Door Training')
				){
					Integer i = mapAccountPivCLASSPAMs.get(a.Id);
					if(i == null){
						i = 0;
					}
					mapAccountPivCLASSPAMs.put(a.Id,++i);
				}else if(
					t.Course_or_Module__r.Name.startsWithIgnoreCase('pivCLASS Software Training')
				){
					Integer i = mapAccountPivCLASSSoftware.get(a.Id);
					if(i == null){
						i = 0;
					}
					mapAccountPivCLASSSoftware.put(a.Id,++i);
				}
			}
			
		}
		system.debug('mapAccountPivCLASSPAMs: ' + mapAccountPivCLASSPAMs);
		system.debug('mapAccountPivCLASSSoftware: ' + mapAccountPivCLASSSoftware);
		
		for(Id i : mapAccountPivCLASSPAMs.keySet()){
			if(
				mapAccountPivCLASSPAMs.get(i) > 1
				&& !mapAccountNewCertifications.get(i).contains('pivCLASS PAMs')
			){
				if(
					mapAccountNewCertifications.get(i) == null
					|| mapAccountNewCertifications.get(i) == ''
				){
					mapAccountNewCertifications.put(i,'pivCLASS PAMs');
				}else{
					mapAccountNewCertifications.put(i,mapAccountNewCertifications.get(i) + ';pivCLASS PAMS');
				}
			}
			if(
				mapAccountPivCLASSPAMs.get(i) < 2
				&& mapAccountNewCertifications.get(i).contains('pivCLASS PAMs')
			){
				String strTmp = '';
				for(String s : mapAccountNewCertifications.get(i).split(';')){
					if(s != 'pivCLASS PAMs'){
						if(strTmp == ''){
							strTmp += s;
						}else{
							strTmp += ';' + s;
						}
					}
				}
				mapAccountNewCertifications.put(i,strTmp);
			}
		}
		system.debug('mapAccountNewCertifications: ' + mapAccountNewCertifications);
		
		for(Id i : mapAccountPivCLASSSoftware.keySet()){
			if(
				mapAccountPivCLASSSoftware.get(i) > 1
				&& !mapAccountNewCertifications.get(i).contains('pivCLASS Software')
			){
				if(
					mapAccountNewCertifications.get(i) == null
					|| mapAccountNewCertifications.get(i) == ''
				){
					mapAccountNewCertifications.put(i,'pivCLASS Software');
				}else{
					mapAccountNewCertifications.put(i,mapAccountNewCertifications.get(i) + ';pivCLASS Software');
				}
			}
			if(
				mapAccountPivCLASSSoftware.get(i) < 2
				&& mapAccountNewCertifications.get(i).contains('pivCLASS Software')
			){
				String strTmp = '';
				for(String s : mapAccountNewCertifications.get(i).split(';')){
					if(s != 'pivCLASS Software'){
						if(strTmp == ''){
							strTmp += s;
						}else{
							strTmp += ';' + s;
						}
					}
				}
				mapAccountNewCertifications.put(i,strTmp);
			}
		}
		system.debug('mapAccountNewCertifications: ' + mapAccountNewCertifications);
		
		list<Account> lstAccounts = new list<Account>();
		for(Id i : mapAccountNewCertifications.keySet()){
			if(mapAccountNewCertifications.get(i) != mapAccountOldCertifications.get(i)){
				Account a = new Account(
					Id = i,
					HID__c = mapAccountNewCertifications.get(i)
				);
				lstAccounts.add(a);
			}
		}
		update lstAccounts;
	}
}