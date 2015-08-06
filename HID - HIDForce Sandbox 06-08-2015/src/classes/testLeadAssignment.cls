@isTest
class testLeadAssignment{
    static testmethod void LeadAssignment_Test() {
        // Author:  Timmus Agersea
        // Purpose: Test Code
        
        final String CityName    = 'New York';
        final String StateName   = 'California';                                    
        final String CountryName = 'United States';
        final String CountryCode = 'US';  
        final String StateCode = 'CA';
        
        Countries__c objCountries = new Countries__c();
        objCountries.name = 'US'; 
        objCountries.Country__c = 'United States';
        insert objCountries;
        
        States__c objStates = new States__c();
        objStates.State__c = 'CA';
        objStates.name = 'California';
        objStates.Country__c = 'United States'; 
        insert objStates;
        // Create 8 partner accounts used for the LeadRouting record
       // Account Partner8 = new Account(Name = 'Partner8');
        //Account Partner7 = new Account(Name = 'Partner7');
        //Account Partner6 = new Account(Name = 'Partner6');
        //Account Partner5 = new Account(Name = 'Partner5');
        Account Partner4 = new Account(Name = 'Partner4');
        Account Partner3 = new Account(Name = 'Partner3');
        Account Partner2 = new Account(Name = 'Partner2');
        Account Partner1 = new Account(Name = 'Partner1');
        
        
        List<Account> Accounts = new List<Account>();
        
       // Accounts.Add(Partner8);
       // Accounts.Add(Partner7);
       // Accounts.Add(Partner6);
        //Accounts.Add(Partner5);
        Accounts.Add(Partner4);
        Accounts.Add(Partner3);
        Accounts.Add(Partner2);
        Accounts.Add(Partner1);
        
        insert Accounts;

        // Create a LeadRouting record
        LeadRouting__c LeadRouting = new LeadRouting__c(City__c=CityName, State__c=StateName, Country__c=CountryName, NextRank__c=5);
        
        //LeadRouting.Partner8__c = Partner8.Id;
        //LeadRouting.Partner7__c = Partner7.Id;
        //LeadRouting.Partner6__c = Partner6.Id;
        //LeadRouting.Partner5__c = Partner5.Id;
        LeadRouting.Partner4__c = Partner4.Id;
        //LeadRouting.Partner3__c = Partner3.Id;
        LeadRouting.Partner2__c = Partner2.Id;
        LeadRouting.Partner1__c = Partner1.Id;
        
        LeadRouting.NextRank__c = 1;
        
        insert LeadRouting;
        
        LeadAssignment thisClass = new LeadAssignment();
        
        // insert 9 leads so the entire ranking process is processed and cycled
        Lead Lead1 = new Lead(LastName='FakeLead1', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead2 = new Lead(LastName='FakeLead2', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead3 = new Lead(LastName='FakeLead3', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead4 = new Lead(LastName='FakeLead4', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead5 = new Lead(LastName='FakeLead5', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead6 = new Lead(LastName='FakeLead6', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead7 = new Lead(LastName='FakeLead7', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead8 = new Lead(LastName='FakeLead8', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
        Lead Lead9 = new Lead(LastName='FakeLead9', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Secure Issuance');
                
        // this test will call the default lead routing
        Lead Lead10 = new Lead(LastName='FakeLead10', Company='FakeCompany');

        List<Lead> Leads = new List<Lead>();
        
        Leads.add(Lead1);
        Leads.add(Lead2);
        Leads.add(Lead3);
        Leads.add(Lead4);
        Leads.add(Lead5);
        Leads.add(Lead6);
        Leads.add(Lead7);
        Leads.add(Lead8);
        Leads.add(Lead9);
        
        
        
        //insert Lead1;
        insert Leads;
        Test.startTest();
        Lead1 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead1.Id];
        System.assertEquals(1, Lead1.CurrentRank__c); 
        System.assertEquals(1, Lead1.OriginalRank__c); 
        
        //insert Lead2;
        Lead2 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead2.Id];
        System.assertEquals(2, Lead2.CurrentRank__c); 
        System.assertEquals(2, Lead2.OriginalRank__c); 
        
        //insert Lead3; 
        Lead3 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead3.Id];
       // System.assertEquals(4, Lead3.CurrentRank__c); 
       // System.assertEquals(4, Lead3.OriginalRank__c); 
        
        //insert Lead4; 
        Lead4 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead4.Id];
       // System.assertEquals(5, Lead4.CurrentRank__c); 
       // System.assertEquals(5, Lead4.OriginalRank__c); 
        
        //insert Lead5;
        Lead5 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead5.Id];
       // System.assertEquals(6, Lead5.CurrentRank__c); 
       // System.assertEquals(6, Lead5.OriginalRank__c); 
        
        //insert Lead6;
        //Lead6 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead6.Id];
        //System.assertEquals(7, Lead6.CurrentRank__c); 
        //System.assertEquals(7, Lead6.OriginalRank__c);         
        
        //insert Lead7;
        //Lead7 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead7.Id];
        //System.assertEquals(8, Lead7.CurrentRank__c); 
       // System.assertEquals(8, Lead7.OriginalRank__c);   
        
        //insert Lead8;
        Lead8 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead8.Id];
        //System.assertEquals(1, Lead8.CurrentRank__c); 
        //System.assertEquals(1, Lead8.OriginalRank__c);            
        
        //insert Lead9;
        Lead9 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead9.Id];
        //System.assertEquals(2, Lead9.CurrentRank__c); 
        //System.assertEquals(2, Lead9.OriginalRank__c);          
        
        LeadRouting.City__c     = null;
        LeadRouting.State__c    = null;
        LeadRouting.Country__c  = null;
        
        // Test Reassign
        LeadRouting.NextRank__c = 1;
        update LeadRouting;

        insert Lead10;        
        Lead10 = [Select Id, CurrentAssignmentDate__c, CurrentRank__c, OriginalRank__c From Lead Where Id = :Lead10.Id];
        System.assertEquals(Lead10.CurrentRank__c, null); 
        System.assertEquals(Lead10.OriginalRank__c, null);  
        
        // Test reassigning 9 times to ensure the Lead gets assigned to a user
        Lead LeadU = [Select Id, CurrentAssignmentDate__c From Lead Where Id = :Lead1.Id];
        LeadU.CurrentAssignmentDate__c = System.Now().AddHours(-72);
        update LeadU;
        thisClass.ReassignLeads();
        LeadU = [Select Id, CurrentAssignmentDate__c, CurrentRank__c From Lead Where Id = :Lead1.Id];
        System.assertEquals(2, LeadU.CurrentRank__c);  
        
        // skip 3 as the Partner3 field is null
        
        LeadU.CurrentAssignmentDate__c = System.Now().AddHours(-72);
        update LeadU;
        thisClass.ReassignLeads();
        LeadU = [Select Id, CurrentAssignmentDate__c, CurrentRank__c From Lead Where Id = :Lead1.Id];
        System.assertEquals(4, LeadU.CurrentRank__c);          
        
        LeadU.CurrentAssignmentDate__c = System.Now().AddHours(-72);
        update LeadU;
        thisClass.ReassignLeads();
        LeadU = [Select Id, CurrentAssignmentDate__c, CurrentRank__c From Lead Where Id = :Lead1.Id];
       // System.assertEquals(5, LeadU.CurrentRank__c);  
        
        LeadU.CurrentAssignmentDate__c = System.Now().AddHours(-72);
        update LeadU;
        thisClass.ReassignLeads();
        LeadU = [Select Id, CurrentAssignmentDate__c, CurrentRank__c From Lead Where Id = :Lead1.Id];
        //System.assertEquals(6, LeadU.CurrentRank__c);                   
        Test.stopTest();
        
        
        LeadU.CurrentAssignmentDate__c = System.Now().AddHours(-72);
        update LeadU;
        thisClass.ReassignLeads();
        LeadU = [Select Id, CurrentAssignmentDate__c, CurrentRank__c From Lead Where Id = :Lead1.Id];
        //System.assertEquals(7, LeadU.CurrentRank__c);  
        
        LeadU.CurrentAssignmentDate__c = System.Now().AddHours(-72);
        update LeadU;
        thisClass.ReassignLeads();
        LeadU = [Select Id, CurrentAssignmentDate__c, CurrentRank__c From Lead Where Id = :Lead1.Id];
        //System.assertEquals(8, LeadU.CurrentRank__c);                    
        
        LeadU.CurrentAssignmentDate__c = System.Now().AddHours(-72);
        update LeadU;
        thisClass.ReassignLeads();
        LeadU = [Select Id, CurrentAssignmentDate__c, CurrentRank__c From Lead Where Id = :Lead1.Id];
        System.assertEquals(null, LeadU.CurrentRank__c);          
        
            
       
        
        // Test helper method exception cases
        String ResultElse = thisClass.GetPartnerByRank(LeadRouting, -1);
        
        LeadRouting.NextRank__c = null;
        Decimal RankElse = thisClass.GetNextRankForLeadRouting(LeadRouting, LeadRouting.NextRank__c);
        
        String MapKey1 = thisClass.GetLeadRoutingMapKey('United States', 'AZ', 'gilbert');
        String MapKey2 = thisClass.GetLeadRoutingMapKey('United States', 'AZ', null);
        String MapKey3 = thisClass.GetLeadRoutingMapKey('United States', null, null);
        String MapKey4 = thisClass.GetLeadRoutingMapKey(null, null, null);
       
        
        
        System.assertEquals(ResultElse, null);    
        System.assertEquals(RankElse, -1);
        System.assertEquals(MapKey1, 'United States_AZ_gilbert');
        System.assertEquals(MapKey2, 'United States_AZ');
        System.assertEquals(MapKey3, 'United States');
        System.assertEquals(MapKey4, 'DefaultRule');
       
    }
     static testmethod void LeadAssignment_Test2() {
        /*final String CityName    = 'FakeCity';
        final String StateName   = 'FakeState';
        final String CountryName = 'FakeCountry';*/
        
        final String CityName    = 'New York';
        final String StateName   = 'California';
        final String CountryName = 'United States';
        final String CountryCode = 'US';  
        final String StateCode = 'CA';
        
         List<Lead> Leads = new List<Lead>();
         Lead Lead1 = new Lead(LastName='FakeLead1', Company='FakeCompany', CountryCode = CountryCode, StateCode= StateCode, City=CityName, State=StateName,Country=CountryName, LeadRouting__c=null, Business_Segment__c='Animal ID');
        
        Leads.add(Lead1);
        
        Test.startTest();
        
        //insert Lead1;
       
        insert Leads;
        lead1.Role__c = 'Partner';
        update lead1;
         Test.stopTest();
    }
    static testmethod void LeadAssignment_Test3() {
    
    }
}