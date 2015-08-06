trigger setAccountRegion on Account (before insert, before update) {
	if(!utilController.bolSetAccountRegion){
		utilController.bolSetAccountRegion = true;

	    set<String> setCountryCodes = new set<String>();
		set<String> setCountryNames = new set<String>();
	    set<String> setStateCodes = new set<String>();
		set<String> setStateNames = new set<String>();
	    map<String, Countries__c> mapAccountCountryCodes = new map<String, Countries__c>();
		map<String, Countries__c> mapAccountCountryNames = new map<String, Countries__c>();
	    map<String, States__c> mapAccountStateCodes = new map<String, States__c>();
		map<String, States__c> mapAccountStateNames = new map<String, States__c>();
	
	    for(Account a : trigger.new){
	        if(trigger.isInsert && a.Cardiris_Country__c != '' && a.Cardiris_Country__c != null){
	            a.BillingCountry = a.Cardiris_Country__c;
	            a.Cardiris_Country__c = null;
	        }
	        if(
	            trigger.isUpdate
	            && (
	                (
	                    trigger.oldMap.get(a.Id).Sub_Region__c != a.Sub_Region__c
	                    && a.Oracle_Customer_Number__c != null
	                    
	                ) || (
	                    trigger.oldMap.get(a.Id).Oracle_Customer_Number__c == null
	                    && a.Oracle_Customer_Number__c != null
	                )
	            )
	        ){
	            a.ERP_Update__c = true;
	        }
	        if(a.BillingCountryCode != null){
	            if(a.BillingCountryCode != 'US' && a.BillingCountryCode != 'CA'){
	                setCountryCodes.add(a.BillingCountryCode);
	            }else{
	                setStateCodes.add(a.BillingStateCode);
	            }
	        }else if(a.BillingCountry != null){
	            if(a.BillingCountry != 'United States' && a.BillingCountry != 'Canada'){
	                setCountryNames.add(a.BillingCountry);
	            }else{
	                setStateNames.add(a.BillingState);
	            }
	        }
	    }
	    for(Countries__c c:[
	        SELECT
	            Name,
	            Country__c,
	            Region__c,
	            Territory__c,
	            Sub_Region__c
	        FROM
	            Countries__c
	        WHERE
	            Name IN : setCountryCodes
	        	OR Country__c IN :setCountryNames
	    ]){
	        mapAccountCountryCodes.put(c.Name, c);
	        mapAccountCountryNames.put(c.Country__c, c);
	    }
	    for(States__c c:[
	        SELECT
	            Name,
	            State__c,
	            Region__c,
	            Territory__c
	        FROM
	            States__c
	        WHERE
	            (
	                State__c IN : setStateCodes
	                OR Name IN : setStateNames
	            )
	            AND Country__c IN ('United States', 'Canada')
	    ]){
	        mapAccountStateCodes.put(c.State__c, c);
	        mapAccountStateNames.put(c.Name, c);
	    }
	    for(Account a: trigger.new){
	        if(a.BillingCountryCode != null){
	            if((a.BillingCountryCode != 'US' || a.BillingCountryCode != 'CA') && mapAccountCountryCodes.containsKey(a.BillingCountryCode)){
	                if(a.Region__c == null){
	                    a.Region__c = mapAccountCountryCodes.get(a.BillingCountryCode).Region__c;
	                }
	                if(a.Territory__c == null){
	                    a.Territory__c = mapAccountCountryCodes.get(a.BillingCountryCode).Territory__c;
	                }
	                if(a.Sub_Region__c == null){
	                    a.Sub_Region__c = mapAccountCountryCodes.get(a.BillingCountryCode).Sub_Region__c;
	                }
	            }else if((a.BillingCountryCode == 'US' || a.BillingCountryCode == 'CA') && mapAccountStateCodes.containsKey(a.BillingStateCode)){
	                if(a.Region__c == null){
	                    a.Region__c = mapAccountStateCodes.get(a.BillingStateCode).Region__c;
	                }
	                if(a.Territory__c == null){
	                    a.Territory__c = mapAccountStateCodes.get(a.BillingStateCode).Territory__c;
	                }
	                if(a.Sub_Region__c == null){
	                    a.Sub_Region__c = 'N. America';
	                }
	            }else if((a.BillingCountryCode == 'US' || a.BillingCountryCode == 'CA') && !mapAccountStateCodes.containsKey(a.BillingStateCode)){
	                if(a.Region__c == null){
	                    a.Region__c = 'NAM';
	                }
	                if(trigger.isInsert){
	                    a.Sub_Region__c = 'N. America';
	                }
	            }
	        }else if(a.BillingCountry != null){
	            if((a.BillingCountry != 'United States' || a.BillingCountry != 'Canada') && mapAccountCountryNames.containsKey(a.BillingCountry)){
	                if(a.Region__c == null){
	                    a.Region__c = mapAccountCountryNames.get(a.BillingCountry).Region__c;
	                }
	                if(a.Territory__c == null){
	                    a.Territory__c = mapAccountCountryNames.get(a.BillingCountry).Territory__c;
	                }
	                if(a.Sub_Region__c == null){
	                    a.Sub_Region__c = mapAccountCountryNames.get(a.BillingCountry).Sub_Region__c;
	                }
	            }else if((a.BillingCountry == 'United States' || a.BillingCountry == 'Canada') && mapAccountStateNames.containsKey(a.BillingState)){
	                if(a.Region__c == null){
	                    a.Region__c = mapAccountStateNames.get(a.BillingState).Region__c;
	                }
	                if(a.Territory__c == null){
	                    a.Territory__c = mapAccountStateNames.get(a.BillingState).Territory__c;
	                }
	                if(a.Sub_Region__c == null){
	                    a.Sub_Region__c = 'N. America';
	                }
	            }else if((a.BillingCountry == 'United States' || a.BillingCountry == 'Canada') && !mapAccountStateNames.containsKey(a.BillingState)){
	                if(a.Region__c == null){
	                    a.Region__c = 'NAM';
	                }
	                if(trigger.isInsert){
	                    a.Sub_Region__c = 'N. America';
	                }
	            }
	        }
	    }
	}
}