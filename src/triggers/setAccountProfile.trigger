trigger setAccountProfile on Lead(after update){
	if(!utilController.bolSetAccountProfile){
		utilController.bolSetAccountProfile = false;
	
	    Map<Id,String> mapBusSegment = new Map<Id,String>();
	    Map<Id,String> mapUseApplication = new Map<Id,String>();
	    
	    Map<Id,String> mapAccountStreet = new Map<Id,String>();
	    /*Map<Id,String> mapAccountadd1 = new Map<Id,String>();    
	    Map<Id,String> mapAccountadd2 = new Map<Id,String>();
	    Map<Id,String> mapAccountadd3 = new Map<Id,String>();
	    Map<Id,String> mapAccountadd4 = new Map<Id,String>();*/
	    
	    Map<Id,String> mapAccountcity = new Map<Id,String>();
	    Map<Id,String> mapAccountcountry = new Map<Id,String>();
	    Map<Id,String> mapAccountState = new Map<Id,String>();
	    //Map<Id,String> mapAccountProvince = new Map<Id,String>();
	    Map<Id,String> mapAccountPostalCode = new Map<Id,String>();
	    set<Id> sConvContId = new set<Id>();
	    Map<Id,String> mapIndustryRole = new Map<Id,String>();
	    
	    List<Account_Profile__c> lstAccProfile = new List<Account_Profile__c>();
	    for(Lead mylead : trigger.new){
	        if(myLead.status == 'Qualified'){
	            
	            mapIndustryRole.put(mylead.convertedAccountid, mylead.Industry_Role__c);
	            mapAccountStreet.put(mylead.convertedAccountid, mylead.Street);
	            
	            /*mapAccountadd1.put(mylead.convertedAccountid, mylead.Address_1__c);
	            mapAccountadd2.put(mylead.convertedAccountid, mylead.Address_2__c);
	            mapAccountadd3.put(mylead.convertedAccountid, mylead.Address_3__c);
	            mapAccountadd4.put(mylead.convertedAccountid, mylead.Address_4__c);*/
	            
	            mapAccountcity.put(mylead.convertedAccountid, mylead.City);
	            mapAccountcountry.put(mylead.convertedAccountid, mylead.Country);
	            mapAccountState.put(mylead.convertedAccountid, mylead.State);
	            //mapAccountProvince.put(mylead.convertedAccountid, mylead.Province__c);
	            mapAccountPostalCode.put(mylead.convertedAccountid, mylead.PostalCode);          
	            if(myLead.Business_Segment__c == 'Connect' || myLead.Business_Segment__c == 'Government ID' || myLead.Business_Segment__c == 'Cards and Inlays' || myLead.Business_Segment__c == 'Animal ID' || myLead.Business_Segment__c == 'Industry and Logistics'){
	                if(mylead.Industry_Role__c != null && mylead.Business_Segment__c != null && mylead.Use_Application__c != null){
	                    //sAccId.add(mylead.convertedAccountid);
	                    mapBusSegment.put(mylead.convertedAccountid,myLead.Business_Segment__c);
	                    mapUseApplication.put(mylead.convertedAccountid,myLead.Use_Application__c);
	                    sConvContId.add(mylead.convertedContactid);
	                }
	            }
	            if(myLead.Business_Segment__c == 'PACS' || myLead.Business_Segment__c == 'ID Assurance' || myLead.Business_Segment__c == 'Secure Issuance'){
	                if(mylead.Industry_Role__c != null && mylead.Business_Segment__c != null){
	                    //sAccId.add(mylead.convertedAccountid);
	                    mapBusSegment.put(mylead.convertedAccountid,myLead.Business_Segment__c);
	                    mapUseApplication.put(mylead.convertedAccountid,myLead.Use_Application__c);
	                    sConvContId.add(mylead.convertedContactid);
	                }                
	            }
	        }
	    }
	    
	    if(mapIndustryRole.keyset().size() > 0){
	        List<Account> lstAccountall = [select id, BillingStreet,BillingCity , BillingCountry, BillingState, BillingPostalCode from Account where id IN: mapIndustryRole.keyset()];
	        for(Account acc: lstAccountall){      
	            acc.Channel__c = mapIndustryRole.get(acc.id);
	            if(acc.BillingStreet == null || acc.BillingStreet == ''){
	                acc.BillingStreet = mapAccountStreet.get(acc.id);
	            }
	            /*if(acc.Address_1__c == null || acc.Address_1__c == ''){
	                acc.Address_1__c = mapAccountadd1.get(acc.id);
	            }
	            if(acc.Address_2__c == null || acc.Address_2__c == ''){
	                acc.Address_2__c = mapAccountadd2.get(acc.id);
	            }
	            if(acc.Address_3__c == null || acc.Address_3__c == ''){
	                acc.Address_3__c = mapAccountadd3.get(acc.id);
	            }
	            if(acc.Address_4__c == null || acc.Address_4__c == ''){
	                acc.Address_4__c = mapAccountadd4.get(acc.id);
	            }*/
	            if(acc.BillingCity == null || acc.BillingCity == ''){
	                acc.BillingCity = mapAccountcity.get(acc.id);
	            }
	            if(acc.BillingCountry == null || acc.BillingCountry == ''){
	                acc.BillingCountry = mapAccountcountry.get(acc.id);
	            }
	            if(acc.BillingState == null || acc.BillingState == ''){
	                acc.BillingState = mapAccountState.get(acc.id);
	            }
	            /*if(acc.Province__c == null ||  acc.Province__c == ''){
	                acc.Province__c = mapAccountProvince.get(acc.id);
	            }*/
	            if(acc.BillingPostalCode == null || acc.BillingPostalCode == ''){
	                acc.BillingPostalCode = mapAccountPostalCode.get(acc.id);
	            }
	        }
	        if(lstAccountall.size() > 0){
	            update lstAccountall;
	        }
	    }
	    if(mapBusSegment.keyset().size() > 0){
	        Map<string,string> mapCountry = new Map<string,string>();
	        List<Account> lstAccount = [select id, ownerid, BillingStreet,BillingCity , BillingCountry, BillingState, BillingPostalCode , (select id, Business_Segment__c from Channel_Engagements__r) from Account where id IN: mapBusSegment.keyset()];
	        
	        Map<Id,Countries__c> mapCountries = new Map<Id,Countries__c>([SELECT Identity_Assurance_Market_Size__c, Country__c, PACS_Market_Size__c, Secure_Issuance_Market_Size__c FROM Countries__c]);
	        for(Countries__c cn: mapCountries.values()){
	            mapCountry.Put(cn.Country__c,cn.id);        
	        }
	        for(Account acc: lstAccount){
	           if(acc.Channel_Engagements__r.size() == 0){
	                Account_Profile__c objAccProfile = new Account_Profile__c();
	                objAccProfile.Business_Segment__c = mapBusSegment.get(acc.id);
	                objAccProfile.Use_Application__c = mapUseApplication.get(acc.id);
	                objAccProfile.Partner_Type__c = mapIndustryRole.get(acc.id);
	                objAccProfile.Account__c = acc.id;
	                objAccProfile.Program_Category__c = mapBusSegment.get(acc.id);
	                if(mapCountry.containskey(acc.BillingCountry)){
	                    if(mapBusSegment.get(acc.id) == 'Identity Assurance'){
	                        objAccProfile.Market_Size__c = mapCountries.get(mapCountry.get(acc.BillingCountry)).Identity_Assurance_Market_Size__c;
	                    }else if(mapBusSegment.get(acc.id) == 'PACS'){
	                        objAccProfile.Market_Size__c = mapCountries.get(mapCountry.get(acc.BillingCountry)).PACS_Market_Size__c;
	                    }else if(mapBusSegment.get(acc.id) == 'Secure Issuance'){
	                        objAccProfile.Market_Size__c = mapCountries.get(mapCountry.get(acc.BillingCountry)).Secure_Issuance_Market_Size__c;
	                    }
	                }         
	                lstAccProfile.add(objAccProfile);
	            }else{
	                boolean isAccProfileExist = false;
	                for(Account_Profile__c ap: acc.Channel_Engagements__r){
	                    if(mapBusSegment.get(acc.id) == ap.Business_Segment__c){
	                        isAccProfileExist = true;
	                        break;
	                    }
	                }
	                if(isAccProfileExist == false){
	                    Account_Profile__c objAccProfile = new Account_Profile__c();
	                    objAccProfile.Business_Segment__c = mapBusSegment.get(acc.id);
	                    objAccProfile.Use_Application__c = mapUseApplication.get(acc.id);
	                    objAccProfile.Account__c = acc.id;
	                    objAccProfile.Partner_Type__c = mapIndustryRole.get(acc.id);
	                    objAccProfile.Program_Category__c = mapBusSegment.get(acc.id);
	                    if(mapCountry.containskey(acc.BillingCountry)){
	                        if(mapBusSegment.get(acc.id) == 'Identity Assurance'){
	                            objAccProfile.Market_Size__c = mapCountries.get(mapCountry.get(acc.BillingCountry)).Identity_Assurance_Market_Size__c;
	                        }else if(mapBusSegment.get(acc.id) == 'PACS'){
	                            objAccProfile.Market_Size__c = mapCountries.get(mapCountry.get(acc.BillingCountry)).PACS_Market_Size__c;
	                        }else if(mapBusSegment.get(acc.id) == 'Secure Issuance'){
	                            objAccProfile.Market_Size__c = mapCountries.get(mapCountry.get(acc.BillingCountry)).Secure_Issuance_Market_Size__c;
	                        }
	                    }                
	                    lstAccProfile.add(objAccProfile);
	                }
	            }
	        } 
	        if(lstAccount.size() > 0){
	            update lstAccount;
	        }
	        if(lstAccProfile.size() > 0){
	            insert lstAccProfile;
	        }
	        set<ID> sUserID = new set<Id>();
	        List<Account_Profile__c> lstAccProfileAlert = [select id, account__r.Name, Account__r.ownerid, Business_Segment__c,Partner_Type__c  from Account_Profile__c where id IN: lstAccProfile];
	        string strBody = '';       
	        for(Account_Profile__c ap: lstAccProfileAlert){
	            sUserID.add(ap.account__r.ownerid);
	            Messaging.SingleEmailMessage objMEMail = new Messaging.SingleEmailMessage();                  
	            
	            strBody = '<html><body>A new account and/or account profile has been created through the lead conversion process.'; 
	            strBody += 'You are receiving this email alert because you are listed as either the account or contact owner ';
	            strBody += 'for the converted lead. A Sales Manager needs to be added to this account profile. ';
	            strBody += 'Please go into Salesforce and update the necessary records:<BR><BR>';
	            strBody += 'Account Name: ' + ap.account__r.Name + '<BR>';
	            strBody += 'Account Profile Segment: ' + ap.Business_Segment__c + '<BR>';
	            strBody += 'Partner Type: ' + ap.Partner_Type__c + '<BR>';
	            strBody += 'Link to Account Profile: ' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + ap.id + '</body></html>';
	            objMEMail.setSubject('New Account and Profile Alert - Select a Sales Manager');
	            objMEMail.setHtmlBody(strBody);
	            objMEMail.setTargetObjectId(ap.Account__r.ownerid);
	            objMEMail.saveAsActivity = false;
	            Messaging.sendEmail( new Messaging.SingleEmailMessage[] {objMEMail} );
	        }
	    
	        List<Contact> lstContact = [select id,ownerid from contact where id in: sConvContId];
	        for(Contact con: lstContact){
	            if(sUserID.contains(con.ownerid) == false && strBody != ''){
	                sUserID.add(con.ownerid);
	                Messaging.SingleEmailMessage objMEMail = new Messaging.SingleEmailMessage();                   
	                objMEMail.setHtmlBody(strBody);
	                objMEMail.setTargetObjectId(con.ownerid);
	                objMEMail.setSubject('New Account and Profile Alert - Select a Sales Manager');
	                objMEMail.saveAsActivity = false;
	                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { objMEMail } );   
	            }
	        }
	    }
	}
}