trigger setLeadRegion on Lead (before insert, before update) {
	
	if(!utilController.bolSetLeadRegion){
		utilController.bolSetLeadRegion = true;

	    set<String> setCountryCodes = new set<String>();
	    set<String> setCountryNames = new set<String>();
	    set<String> setStateCodes = new set<String>();
	    set<String> setStateNames = new set<String>();
	    map<String, Countries__c> mapLeadCountryCodes = new map<String, Countries__c>();
	    map<String, Countries__c> mapLeadCountryNames = new map<String, Countries__c>();
	    map<String, States__c> mapLeadStateCodes = new map<String, States__c>();
	    map<String, States__c> mapLeadStateNames = new map<String, States__c>();
	    
	    for(Lead l : trigger.new){
	        if(
	            trigger.isInsert
	            && l.Cardiris_Country__c != ''
	            && l.Cardiris_Country__c != null
	        ){
	            l.Country = l.Cardiris_Country__c;
	            l.Cardiris_Country__c = null;
	        }
	        system.debug('JAN - Lead Country after: ' + l.Country);
	        system.debug('JAN - Lead Country Code after: ' + l.CountryCode);
	        
	        if(l.CountryCode != null){
	            if(
	            	l.CountryCode != 'US'
	            	&& l.CountryCode != 'CA'
		        ){
	    	        setCountryCodes.add(l.CountryCode);
	        	}else{
	            	setStateCodes.add(l.StateCode);
	        	}
	        }else if(l.Country != null){
	            if(
	            	l.Country != 'United States'
	                && l.Country != 'Canada'
	            ){
	                setCountryNames.add(l.Country);
	            }else{
	                setStateNames.add(l.State);
	            }
	        }
	    }
	    for(Countries__c c:[
	        SELECT
	            Name,
	            Country__c,
	            Region__c,
	            Territory__c,
	            Sales_Territory__c
	        FROM
	            Countries__c
	        WHERE
	            Name IN : setCountryCodes
	        	OR Country__c IN : setCountryNames
	    ]){
	        mapLeadCountryCodes.put(c.Name, c);
	        mapLeadCountryNames.put(c.Country__c, c);
	    }
	    
	    for(States__c c:[
	        SELECT
	            Name,
	            State__c,
	            Region__c,
	            Territory__c,
	            Sales_Territory__c
	        FROM
	            States__c
	        WHERE
	            (
	                State__c IN : setStateCodes
	        		OR Name IN : setStateNames
	            )
	            AND Country__c IN ('United States', 'Canada')
	    ]){
	        mapLeadStateCodes.put(c.State__c, c);
	        mapLeadStateNames.put(c.Name, c);
	    }
	    for(Lead l : trigger.new){
	        if(l.CountryCode != null){
	            if(l.CountryCode != 'US' && l.CountryCode != 'CA' && mapLeadCountryCodes.containsKey(l.CountryCode)){
	                l.Region__c = mapLeadCountryCodes.get(l.CountryCode).Region__c;
	                l.Territory__c = mapLeadCountryCodes.get(l.CountryCode).Territory__c;
	                l.Sales_Territory__c = mapLeadCountryCodes.get(l.CountryCode).Sales_Territory__c;
	            }else if((l.CountryCode  == 'US' || l.CountryCode == 'CA') && mapLeadStateCodes.containsKey(l.StateCode)){
	                l.Region__c = mapLeadStateCodes.get(l.StateCode).Region__c;
	                l.Territory__c = mapLeadStateCodes.get(l.StateCode).Territory__c;
	                l.Sales_Territory__c = mapLeadStateCodes.get(l.StateCode).Sales_Territory__c;
	            }else if((l.CountryCode == 'US' || l.CountryCode == 'CA') && !mapLeadStateCodes.containsKey(l.StateCode)){
	                l.Region__c = 'NAM';
	                l.Sales_Territory__c = 'NAM';
	            }
	        }else if(l.Country != null){
	            if(l.Country != 'United States' && l.Country != 'Canada' && mapLeadCountryNames.containsKey(l.Country)){
	                l.Region__c = mapLeadCountryNames.get(l.Country).Region__c;
	                l.Territory__c = mapLeadCountryNames.get(l.Country).Territory__c;
	                l.Sales_Territory__c = mapLeadCountryNames.get(l.Country).Sales_Territory__c;
	            }else if((l.Country  == 'United States' || l.Country == 'Canada') && mapLeadStateNames.containsKey(l.State)){
	                l.Region__c = mapLeadStateNames.get(l.State).Region__c;
	                l.Territory__c = mapLeadStateNames.get(l.State).Territory__c;
	                l.Sales_Territory__c = mapLeadStateNames.get(l.State).Sales_Territory__c;
	            }else if((l.Country == 'United States' || l.Country == 'Canada') && !mapLeadStateNames.containsKey(l.State)){
	                l.Region__c = 'NAM';
	                l.Sales_Territory__c = 'NAM';
	            }
	        }
	    }
	}
}