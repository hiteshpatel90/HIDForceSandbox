trigger setAccountClusterData on Account_Cluster__c (after update) {
	
	utilController uCtrl = new utilController();
	
	map<Id,String> mapAccountClusters = new map<Id,String>();
	for(Account_Cluster__c t : trigger.new){
		if(t.Name != trigger.oldMap.get(t.Id).Name){
			mapAccountClusters.put(
				t.Id,
				t.Name
			);
		}
	}
	
	if(!mapAccountClusters.isEmpty()){
		map<Id,set<Id>> mapAccountClusterMembers = new map<Id,set<Id>>();
		map<Id,Account_Cluster_Member__c> mapClusterMembers = uCtrl.getMapClusterMembers(mapAccountClusters.keySet());
        for(Account_Cluster_Member__c a : mapClusterMembers.values()){
			set<Id> s = mapAccountClusterMembers.get(a.Account_Cluster__c);
	        if(s == null){
	            s = new set<Id>();
	        }
	        s.add(a.Account__c);
			mapAccountClusterMembers.put(
				a.Account_Cluster__c,
				s
			);
		}
		if(!mapAccountClusterMembers.isEmpty()){
			list<Account> lstUpdateAccounts = new list<Account>();
			for(Id i : mapAccountClusters.keySet()){
				for(Id j : mapAccountClusterMembers.get(i)){
					Account a = new Account(
						Id = j,
						Account_Cluster__c = mapAccountClusters.get(i)
					);
					lstUpdateAccounts.add(a);
				}
			}
			update lstUpdateAccounts;
		}
	}
}