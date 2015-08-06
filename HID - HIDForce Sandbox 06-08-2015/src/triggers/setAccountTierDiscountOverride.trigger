trigger setAccountTierDiscountOverride on Price_Authorization_Form__c (after insert, after update) {

	if(!utilController.bolFirstExecution8){
		utilController.bolFirstExecution8 = true;

	    utilController uCtrl = new utilController();
	    
	    //Get In-Program Price Codes
	    list<String> lstPriceCodes = new list<String>();
	    for(AggregateResult a :[
	        SELECT
	            Price_Code__c
	        FROM
	            Tier_Discount__c
	        GROUP BY
	            Price_Code__c
	    ]){
	        lstPriceCodes.add(String.valueOf(a.get('Price_Code__c')));
	    }
	    
	    //Prepare Account and PAF information for comparison with existing Account Tier Discounts
	    map<Id, map<String, list<String>>> mapAccounts = new map<Id, map<String, list<String>>>();
	    for(Price_Authorization_Form__c p : trigger.new){
	        if(
	            p.RecordTypeId != utilController.idVPAFRecordType
	            && p.Status__c == 'ERP Update'
	        ){
	            map<String, list<String>> m = new map<String, list<String>>();
	            for(String s : lstPriceCodes){
	                if(p.get(s) != null){
	                    m.put(
	                        s,
	                        new list<String>{
	                            (String)p.get(s),
	                            p.Id
	                        }
	                    );
	                }
	            }
	            if(!m.isEmpty()){
	                mapAccounts.put(
	                    p.Account__c,
	                    m
	                );
	            }
	        }
	    }
	    
	    //Get Account Tier Discount rows
	    list<Account_Tier_Discount__c> lstAccountTierDiscounts = uCtrl.getLstAccountTierDiscounts(mapAccounts.keySet());
	    
	    //Update Account Tier Discount rows
	    list<Account_Tier_Discount__c> lstUpdateAccountTierDiscounts = new list<Account_Tier_Discount__c>();
	    for(Account_Tier_Discount__c a : lstAccountTierDiscounts){
	        map<String, list<String>> m = mapAccounts.get(a.Account__c);
	        if(m.containsKey(a.Tier_Discount__r.Price_Code__c)){
	        	/*if(a.Tier_Discount__r.Numeric_Discount__c == false){
	        		if(!m.get(a.Tier_Discount__r.Price_Code__c)[0].equalsIgnoreCase(a.Tier_Discount__r.Price_Code_Letters__c)){
	        			a.Override_Discount__c = m.get(a.Tier_Discount__r.Price_Code__c)[0];
	        		}else{
	        			a.Override_Discount__c = null;
	        		}
	        	}else if(m.get(a.Tier_Discount__r.Price_Code__c)[0].contains('Delete')){
	                a.Override_Discount__c = m.get(a.Tier_Discount__r.Price_Code__c)[0];
	            }else if(Double.valueOf(m.get(a.Tier_Discount__r.Price_Code__c)[0].substring(2)) <> Double.valueOf(a.Tier_Discount__r.Discount__c)){
	                a.Override_Discount__c = m.get(a.Tier_Discount__r.Price_Code__c)[0];
	            }else{
	                a.Override_Discount__c = null;
	            }*/
	            if(m.get(a.Tier_Discount__r.Price_Code__c)[0] <> a.Tier_Discount__r.Price_Code_Value__c){
	            	a.Override_Discount__c = m.get(a.Tier_Discount__r.Price_Code__c)[0];
	            }else{
	            	a.Override_Discount__c = null;
	            }
	            a.Price_Authorization_Form__c = m.get(a.Tier_Discount__r.Price_Code__c)[1];
	            lstUpdateAccountTierDiscounts.add(a);
	        }
	    }
	    update lstUpdateAccountTierDiscounts;
	}
}