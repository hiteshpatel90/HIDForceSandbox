trigger setAccountClusterMemberData on Account_Cluster_Member__c (before insert, after delete) {

	utilController uCtrl = new utilController();

	map<Id,Id> mapAccountClusterIDs = new map<Id,Id>();
		
    if(trigger.isDelete){
	    map<String,Countries__c> mapCountries = new map<String,Countries__c>();
	    for(Countries__c c : Countries__c.getAll().values()){
	        mapCountries.put(
	        	c.Country__c,
	        	c
	        );
	    }
	    
	    for(Account_Cluster_Member__c m : trigger.old){
	        mapAccountClusterIDs.put(
	        	m.Account__c,
	        	m.Account_Cluster__c
	        );
	    }

	    //Update Account.Account_Cluster__c
	    list<Account> lstAccounts = new list<Account>();
		for(Id i : mapAccountClusterIDs.keySet()){
			Account a = new Account(
				Id = i,
				Account_Cluster__c = null
			);
			lstAccounts.add(a);
		}
		update lstAccounts;
		
		//Update Account Cluster Member History
		list<Account_Cluster_Member_History__c> lstAccountClusterMemberHistory = new list<Account_Cluster_Member_History__c>();
		for(Id i : mapAccountClusterIDs.keySet()){
			Account_Cluster_Member_History__c a = new Account_Cluster_Member_History__c(
				Account__c = i,
				Account_Cluster__c = mapAccountClusterIDs.get(i),
				Action__c = 'Remove'
			);
			lstAccountClusterMemberHistory.add(a);
		}
		insert lstAccountClusterMemberHistory;
		
		//Reset Account Profile Market Size
		map<Id,Account> mapAccounts = uCtrl.getMapAccounts(mapAccountClusterIDs.keySet());
		list<Account_Profile__c> lstAccountProfiles = uCtrl.getLstAccountProfiles(mapAccountClusterIDs.keySet());
		list<Account_Profile__c> lstAccountProfilesUpdate = new list<Account_Profile__c>();
		for(Account_Profile__c a : lstAccountProfiles){
			Account_Profile__c ap = new Account_Profile__c(Id = a.Id);
            if(mapAccounts.get(a.Account__c).BillingCountry != null){
                if(a.Business_Segment__c == 'Identity Assurance'){
                    ap.Market_Size__c = mapCountries.get(mapAccounts.get(a.Account__c).BillingCountry).Identity_Assurance_Market_Size__c;
                }else if(a.Business_Segment__c == 'PACS'){
                    ap.Market_Size__c = mapCountries.get(mapAccounts.get(a.Account__c).BillingCountry).PACS_Market_Size__c;
                }else if(a.Business_Segment__c == 'Secure Issuance'){
                    ap.Market_Size__c = mapCountries.get(mapAccounts.get(a.Account__c).BillingCountry).Secure_Issuance_Market_Size__c;
                }
            }
			lstAccountProfilesUpdate.add(ap);
		}
		if(!lstAccountProfilesUpdate.isEmpty()){
			update lstAccountProfilesUpdate;
		}
    }
    
    if(trigger.isInsert){
	    for(Account_Cluster_Member__c m : trigger.new){
	        mapAccountClusterIDs.put(
	        	m.Account__c,
	        	m.Account_Cluster__c
	        );
	    }
	    
	    //Check for duplicate Business Segment (Accounts)
	    map<Id,Account_Cluster_Member__c> mapAccountClusterMembers = uCtrl.getMapClusterMembers(mapAccountClusterIDs.keySet());
        for(Account_Cluster_Member__c a : mapAccountClusterMembers.values()){
	        for(Account_Cluster_Member__c t : trigger.new){
	            if(
	                a.Account__c == t.Account__c
	            ){
	            	mapAccountClusterIDs.remove(a.Account__c);
	                t.addError('This account is already member of another cluster.');
	            }
	        }
	    }
	    
	    if(!mapAccountClusterIDs.isEmpty()){
			map<Id,Account> mapAccounts = uCtrl.getMapAccounts(mapAccountClusterIDs.keySet());
		    map<Id,Account_Cluster__c> mapClusters = uCtrl.getMapClusters(new set<Id>(mapAccountClusterIDs.values()));
			//Check Global Accounts, Account Region
			for(Account_Cluster_Member__c m : trigger.new){
				if(
					mapClusters.get(m.Account_Cluster__c).Cluster_Type__c == 'Global'
					&& mapAccounts.get(m.Account__c).E_21_Account__c != 'Yes'
				){
					mapAccountClusterIDs.remove(m.Account__c);
					m.addError('Account must be a Global Account if the Account Cluster Type is Global.');
				}else if(
					mapClusters.get(m.Account_Cluster__c).Region__c != mapAccounts.get(m.Account__c).Region__c
				){
					mapAccountClusterIDs.remove(m.Account__c);
					m.addError('Account Region must match Account Cluster Region.');
				}
			}
			
			if(!mapAccountClusterIDs.isEmpty()){
			    //Get Account/Account Cluster Profiles
				map<String,map<Id,list<Account_Profile__c>>> mapClusterProfiles = uCtrl.getMapProfiles(mapAccountClusterIDs.keySet(), new set<Id>(mapAccountClusterIDs.values()));
			    map<Id,list<Account_Profile__c>> mapAccountProfiles = mapClusterProfiles.get('Account');
			    map<Id,list<Account_Profile__c>> mapAccountClusterProfiles = mapClusterProfiles.get('Cluster');
		    
			    //Check for Account Clusters without Profiles, Additional Business Segments or Partner Type mismatches on Account Profiles
			    for(Account_Cluster_Member__c m : trigger.new){
					if(mapAccountClusterProfiles.get(m.Account_Cluster__c) == null){
						mapAccountClusterIDs.remove(m.Account__c);
			    		mapAccountClusterProfiles.remove(m.Account_Cluster__c);
			    		m.addError('Account Cluster has no Profile. Please create at least one Profile before assigning an Account to this Account Cluster.');
			    	}else{
			    		if(mapAccountProfiles.get(m.Account__c) != null){
			    			String strError = '';
			    			map<String,Boolean> mapBusinessSegments = new map<String,Boolean>();
			    			for(Account_Profile__c a : mapAccountProfiles.get(m.Account__c)){
			    				mapBusinessSegments.put(a.Business_Segment__c,true);
			    				for(Account_Profile__c c : mapAccountClusterProfiles.get(m.Account_Cluster__c)){
			    					mapBusinessSegments.remove(c.Business_Segment__c);
			    					if(a.Business_Segment__c == c.Business_Segment__c){
			    						if(a.Partner_Type__c != c.Partner_Type__c){
			    							strError += 'Partner Type missmatch for Business Segment ' + c.Business_Segment__c + ': Account Partner Type = ' + a.Partner_Type__c + ', Account Cluster Partner Type = ' + c.Partner_Type__c + '.<br/>';
			    						}
			    					}
			    				}
			    			}
			    			for(String s : mapBusinessSegments.keySet()){
			    				if(
			    					s != 'Identity Assurance'
			    					&& s != 'PACS'
			    					&& s != 'Secure Issuance'
			    				){
			    					mapBusinessSegments.remove(s);
			    				}
			    			}
			    			if(!mapBusinessSegments.isEmpty()){
			    				strError += 'Account has additional Profiles for the following Business Segments: ';
			    				for(String s : mapBusinessSegments.keySet()){
			    					strError += s + ', ';
			    				}
			    				strError = strError.left(strError.length()-2);
			    				strError += '.';
			    			}
			    			if(strError != ''){
			    				m.addError(strError, false);
			    				mapAccountClusterProfiles.remove(m.Account_Cluster__c);
			    			}
			    		}
			    	}
			    }
			    
			    if(!mapAccountClusterIDs.isEmpty()){
				    //Update Account.Account_Cluster__c
				    list<Account> lstAccounts = new list<Account>();
					for(Id i : mapAccountClusterIDs.keySet()){
						Account a = new Account(
							Id = i,
							Account_Cluster__c = mapClusters.get(mapAccountClusterIDs.get(i)).Name
						);
						lstAccounts.add(a);
					}
					update lstAccounts;
					
					//Update Account Cluster Member History
					list<Account_Cluster_Member_History__c> lstAccountClusterMemberHistory = new list<Account_Cluster_Member_History__c>();
					for(Id i : mapAccountClusterIDs.keySet()){
						Account_Cluster_Member_History__c a = new Account_Cluster_Member_History__c(
							Account__c = i,
							Account_Cluster__c = mapAccountClusterIDs.get(i),
							Action__c = 'Add'
						);
						lstAccountClusterMemberHistory.add(a);
					}
					insert lstAccountClusterMemberHistory;
				    
				    //Update Account Profile
				    list<Account_Profile__c> lstAccountProfiles = new list<Account_Profile__c>();
				    if(!mapAccountClusterProfiles.isEmpty()){
					    for(Id i : mapAccountClusterProfiles.keySet()){
					        for(Account_Profile__c c : mapAccountClusterProfiles.get(i)){
					            for(Id j : mapAccountClusterIDs.keySet()){
						            Account_Profile__c p = new Account_Profile__c(
						            	Market_Size__c = c.Market_Size__c,
						                Business_Segment__c = c.Business_Segment__c,
						                Program_Category__c = c.Business_Segment__c,
						                Partner_Type__c = c.Partner_Type__c,
						                Tier__c = c.Tier__c,
						                Requested_Tier_Expiration_Date__c = c.Requested_Tier_Expiration_Date__c,
						                Recommended_Tier__c = c.Recommended_Tier__c,
							            Customer_Service_Rep__c = c.Customer_Service_Rep__c,
							            Inside_Sales_Rep__c = c.Inside_Sales_Rep__c,
							            National_Account__c = c.National_Account__c,
							            National_Account_Manager__c = c.National_Account_Manager__c,
							            Sales_Manager__c = c.Sales_Manager__c,
							            OwnerId = c.OwnerId
						            );
					                p.Account__c = j;
					                if(mapAccountProfiles.containsKey(j)){
					                    for(Account_Profile__c a : mapAccountProfiles.get(j)){
					                        if(a.Business_Segment__c == c.Business_Segment__c){
					                            p.Id = a.Id;
					                            break;
					                        }
					                    }
					                }
					                lstAccountProfiles.add(p);
					            }
					        }
					    }
					    upsert lstAccountProfiles;
				    }
				    
				    //Deprecate Account Cluster Members' Assessments
				    list<Assessment__c> lstAssessments = new list<Assessment__c>();
				    for(Assessment__c a : [
				    	SELECT
				    		Id,
				    		Approval_Status__c
				    	FROM
				    		Assessment__c
				    	WHERE
				    		Approval_Status__c = 'Approved'
				    		AND Account__c IN : mapAccountClusterIDs.keySet()
				    ]){
				    	Assessment__c aa = new Assessment__c(
				    		Id = a.Id,
				    		Approval_Status__c = 'Deprecated'
				    	);
				    	lstAssessments.add(aa);
				    }
				    update lstAssessments;
					
				    //Remove Accounts w. Billing Country = Brazil
				    for(Id i : mapAccounts.keySet()){
				    	if(mapAccounts.get(i).BillingCountry == 'Brazil'){
				    		//mapAccounts.remove(i);
				    		mapAccountClusterIDs.remove(i);
				    		/* Integer j = 0;
				    		while(j < lstAccountProfiles.size()){
								if(lstAccountProfiles[j].Account__c == i){
									lstAccountProfiles.remove(j);
								}
							} */
				    	}
				    }
				    
				    if(!mapAccountClusterIDs.isEmpty()){
				    	//Remove Accounts with Partner Program != In Progress, Enrolled or missing Partner Program
				    	set<Id> setAccountClusterMemberPartnerPrograms = uCtrl.getSetAccountPartnerPrograms(mapAccountClusterIDs.keySet());
						for(Id i : mapAccountClusterIDs.keySet()){
							if(!setAccountClusterMemberPartnerPrograms.contains(i)){
								//mapAccounts.remove(i);
								mapAccountClusterIDs.remove(i);
								/* Integer j = 0;
								while(j < lstAccountProfiles.size()){
									if(lstAccountProfiles[j].Account__c == i){
										lstAccountProfiles.remove(j);
									}
								} */
							}
						}
				    }
						
					if(!mapAccountClusterIDs.isEmpty()){
						uCtrl.createProfilevPAFs(mapAccountClusterIDs.keySet(), null, null);
					}
			    }
			}
	    }
    }
}