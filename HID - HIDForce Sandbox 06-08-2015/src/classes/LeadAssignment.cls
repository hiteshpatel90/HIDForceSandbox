public class LeadAssignment {
   public  Set<String> nullParamsSet;
   public LeadAssignment(){  
       nullParamsSet = new Set<String>();
       for (NullParameters__c np : NullParameters__c.getall().values()){
           nullParamsSet.add(np.values__c);
       }
   }
   
   //nullParamsSet.addAll(nullparams);
   public void AssignLeads(List<Lead> LeadsNew, Boolean IsInsert) {       
       set<id> LeadIds = new set<id>();
       for(lead ld : LeadsNew){
           if(ld.id != null)
           LeadIds.add(ld.id);
       }
       system.debug('LeadIds===>'+LeadIds + LeadIds.size());
       set<id> ignoreLeadIds = new set<id>();   
       List<Lead> newLeadsFinalList = new List<Lead>();        
       if(LeadIds != null && LeadIds.size() > 0)
       {
           List<campaignmember> cms = [Select leadid, status from campaignmember where leadId in :LeadIds and  status = 'Sent'];
           system.debug('campainmembers===>'+cms);
           


           for(campaignmember cm : cms){
               ignoreLeadIds.add(cm.leadid);
           }
       }
       
       for (Lead lead: LeadsNew) {
           boolean isInIgnoreIdList;
           isInIgnoreIdList = false;
           for(id ignoreLeadId : ignoreLeadIds){
               if(ignoreLeadId == lead.id){
                  isInIgnoreIdList = true;
                  break;
               }
           }
           if(isInIgnoreIdList == false){
               newLeadsFinalList.add(lead);
           }
       }
       system.debug('newLeadsFinalList===>'+newLeadsFinalList);
           
       if (IsInsert)
       {
           // we want to limit the LeadRouting records that we bring back and cache
           Set<String> Countries = new Set<String>();
           Set<String> States    = new Set<String>();
           Set<String> Cities    = new Set<String>();
           System.debug('Null Values==='+nullParamsSet );
           Map<String, String> mapcountries = new Map<String, string>();
           List<Countries__c> lstCountries = [select id, name, Country__c from Countries__c];
           for(Countries__c co: lstCountries){
               mapcountries.put(co.Name, co.Country__c);
           }
           
           for (Lead lead: newLeadsFinalList) {
                     
               if (!nullParamsSet.contains(lead.CountryCode) && lead.CountryCode != null ) { Countries.add(mapcountries.get(lead.CountryCode)); }
               
           }
           system.debug('#############'+mapcountries);
           system.debug('#############'+mapcountries.values());
           Map<String, String> mapstates = new Map<String, string>();
           List<States__c> lstStates = [select id, name, State__c from States__c where country__c IN: Countries];
           for(States__c co: lstStates){
               mapstates.put(co.State__c, co.Name);
           }
           for (Lead lead: newLeadsFinalList) {
               System.Debug('----------------->' + lead); 
               System.debug('====>'+lead.Country + '__' +  lead.State +'__'+lead.City);   
               System.debug('====>'+lead.CountryCode + '__' +  lead.StateCode +'__'+lead.City);        
               //if (!nullParamsSet.contains(lead.CountryCode) && lead.CountryCode != null ) { Countries.add(mapcountries.get(lead.CountryCode)); }
               if (!nullParamsSet.contains(lead.StateCode) && lead.StateCode != null )   {
                       States.add(mapstates.get(lead.StateCode));                   
               }
               if (!nullParamsSet.contains(lead.City) && lead.City != null)    { Cities.add(lead.City.toLowercase()); }
           }           
          System.debug('Countries ' + Countries );
          System.debug('States    ' + States    );
          System.debug('Cities    ' + Cities    );
          System.debug('nullParamsSet===' + nullParamsSet);
          
           Map<String, LeadRouting__c> LeadRoutingCache = new Map<String, LeadRouting__c>();          
          for (LeadRouting__c record : [
               Select 
                   Id, NAME,Country__c, State__c, City__c, DefaultOwner__c, NextRank__c,
                   Partner1__c, Partner2__c, Partner3__c, Partner4__c, 
                   Partner5__c, Partner6__c, Partner7__c, Partner8__c
               From 
                   LeadRouting__c
               Where 
                   ( 
                   (Country__c in :Countries      and State__c in :States         and City__c in :Cities)          OR
                   (Country__c in :Countries      and State__c in :States         and (City__c in :nullParamsSet OR City__c = null))   OR
                   (Country__c in :Countries      and (State__c in :nullParamsSet OR State__c = null)   and City__c in :Cities)          OR
                   (Country__c in :Countries      and (State__c in :nullParamsSet OR State__c = null)   and (City__c in :nullParamsSet OR City__c = null)) OR
                   ((Country__c in : nullParamsSet OR Country__c = null) and (State__c in :nullParamsSet OR State__c = null)   and (City__c in :nullParamsSet OR City__c = null))
                   ) AND ( Status__c != 'Inactive')
               ])
           {
               System.debug(''+record);
               // rather than using id build a complex key based on what is populated
               LeadRoutingCache.put(GetLeadRoutingMapKey(record.Country__c, record.State__c, record.City__c), record);
           }
        
           System.Debug('----------------->' + LeadRoutingCache);
           System.Debug('----------------->' + LeadRoutingCache.keyset());    

           LeadRouting__c LeadRouting = null;
           
           // Loop through leads and assign accordingly - also make change to LeadRouting table 
           for (Lead lead: newLeadsFinalList) { 
                          
               if (lead.Business_Segment__c != 'Secure Issuance') { continue; }      
               string str = (lead.Other_Role__c != null) ? lead.Other_Role__c.toLowerCase() : '';  
               if(lead.Role__c == 'Partner' || lead.Role__c == 'Consultant' || (lead.Role__c == 'Other' && (str == 'partner' || str == 'consultant' )))
                   { continue; }
                              
              //LeadRouting = LeadRoutingCache.get(GetLeadRoutingMapKey(lead.Country, lead.State, lead.City));
              LeadRouting = LeadRoutingCache.get(GetLeadRoutingMapKey(mapcountries.get(lead.CountryCode), mapstates.get(lead.StateCode), lead.City));
              
             
              if (LeadRouting == null){
                   LeadRouting = LeadRoutingCache.get(GetLeadRoutingMapKey(lead.Country, null, lead.City));
                  
                   if(LeadRouting == null){
                       LeadRouting = LeadRoutingCache.get(GetLeadRoutingMapKey(lead.Country, lead.State, null));
                      
                       if(LeadRouting == null){                            
                            LeadRouting = LeadRoutingCache.get(GetLeadRoutingMapKey(lead.Country, null , null));                            
                            
                            if(LeadRouting == null){
                                LeadRouting = LeadRoutingCache.get('DefaultRule');
                            }       
                       }
                   }
              }
              //ckeck for all null partners.......
               System.debug('Lead Routing Final===>'+LeadRouting );
               if (LeadRouting != null) { 
                   System.Debug('----------------->' + LeadRouting.ID);  
                   System.Debug('----------------->' + LeadRouting.Name);         
                   decimal NextRank = GetNextRankForLeadRouting(LeadRouting, LeadRouting.NextRank__c);
                   System.Debug('----------------->' + NextRank ); 
                   /* Assigning default owner if no partner is assigned any value */
                   if (LeadRouting.Partner1__c == null && LeadRouting.Partner1__c == null && LeadRouting.Partner3__c == null && LeadRouting.Partner4__c == null && LeadRouting.Partner5__c == null && LeadRouting.Partner6__c == null && LeadRouting.Partner7__c == null && LeadRouting.Partner8__c == null){
                           
                           lead.LeadRouting__c            = LeadRouting.Id;
                           lead.CurrentRank__c            = null;
                           lead.PartnerAssignment__c      = null;
                           lead.OriginalAssignmentDate__c = System.now();
                           lead.CurrentAssignmentDate__c  = System.now(); 
                           if (LeadRouting.DefaultOwner__c != null) { lead.OwnerId = LeadRouting.DefaultOwner__c; }
                           continue;
                   }
                   if (NextRank > 0 && NextRank < 9)
                   {
                   System.Debug('----------------->' + Lead.Name); 
                       lead.LeadRouting__c            = LeadRouting.Id;
                       lead.OriginalRank__c           = NextRank;
                       lead.CurrentRank__c            = NextRank;
                       lead.PartnerAssignment__c      = GetPartnerByRank(LeadRouting, NextRank);
                       lead.OriginalAssignmentDate__c = System.now();
                       lead.CurrentAssignmentDate__c  = System.now();
                       
                       if (NextRank == 8) { 
                           LeadRouting.NextRank__c = 1; 
                       } else {
                           LeadRouting.NextRank__c = NextRank + 1;
                       }
                   }
                   
                                     
               }
               else {
                   // no default rule?
               } 
           }
           
           update LeadRoutingCache.Values();
       }
       else
       {     
           system.debug('Check>>>');
           // Updates
           Set<String> LeadRoutingIds = new Set<String>();
           for (Lead lead: newLeadsFinalList) {
               if (lead.LeadRouting__c != null) { LeadRoutingIds.add(lead.LeadRouting__c); }    
           }
           
           // get matching LeadRouting records
           Map<String, LeadRouting__c> LeadRoutingCache = new Map<String, LeadRouting__c>();
           for (LeadRouting__c record : [
               Select
                   Id, Country__c, State__c, City__c, DefaultOwner__c, NextRank__c,
                   Partner1__c, Partner2__c, Partner3__c, Partner4__c, 
                   Partner5__c, Partner6__c, Partner7__c, Partner8__c
               From
                   LeadRouting__c
               Where
                   Id in :LeadRoutingIds
                   AND Status__c != 'Inactive'
               ])
           {
               LeadRoutingCache.put(record.Id, record);
           }
           
           LeadRouting__c LeadRouting = null;
           
           // Loop through leads and assign accordingly 
           for (Lead lead: newLeadsFinalList) {
               // Change Request 04/03/2013 - A Business Segment of 'Secure Issuance' indicates that this lead should be assigned by this feature. 
               if (lead.Business_Segment__c != 'Secure Issuance') { continue; }
               // End Change Request 04/03/2013
               
               LeadRouting = LeadRoutingCache.get(lead.LeadRouting__c);
                          
               if (LeadRouting != null) {
                   decimal LeadNextRank = lead.CurrentRank__c + 1; 
                   if (LeadNextRank == 9) { LeadNextRank = 1; }
                   decimal NextRank = GetNextRankForLeadRouting(LeadRouting, LeadNextRank); 
                   if (NextRank > 0 && NextRank < 9)
                   {
                       // if the Lead is going to assigned to its original Partner, assign it to the user
                       if (lead.OriginalRank__c == NextRank) {
                           lead.CurrentRank__c            = null;
                           lead.PartnerAssignment__c      = null;
                           lead.CurrentAssignmentDate__c  = System.now(); 
                           if (LeadRouting.DefaultOwner__c != null) { lead.OwnerId = LeadRouting.DefaultOwner__c; }
                       }
                       else {
                           lead.CurrentRank__c            = NextRank;
                           lead.PartnerAssignment__c      = GetPartnerByRank(LeadRouting, NextRank);
                           lead.CurrentAssignmentDate__c  = System.now();
                       }
                       
                       if (NextRank == 8) { 
                           LeadRouting.NextRank__c = 1; 
                       } else {
                           LeadRouting.NextRank__c = NextRank + 1;
                       }
                   }
               }
               else {
                   // do nothing?
               }
               
           }
           update newLeadsFinalList;
           update LeadRoutingCache.Values();
           
       }
   }
   
    public void ReassignLeads() {
        // Purpose: called by the Scheduled job to reassign all Leads that
        //            have not been reviewed by the current assignee within 48 hours
        //            this retrieves the data and passes it to AssignLeads in 200 record batches
        DateTime startDate = System.now().addHours(-48);
        List<Lead> Leads = new List<Lead>();
       
        for (Lead record : [
           Select
               Id, OriginalRank__c, CurrentRank__c, PartnerAssignment__c, CurrentAssignmentDate__c, LeadRouting__c, Business_Segment__c
           From
               Lead
           Where
               Business_Segment__c = 'Secure Issuance' AND
               CurrentAssignmentDate__c < :startDate AND
               ( LeadReviewed__c = null or LeadReviewed__c = false ) AND
               LeadRouting__c != null AND IsConverted = false
           ])
        {
            // create a list of objects to process.  once it reaches 200, submit it and reset the list
           if(record.CurrentRank__c != null && record.OriginalRank__c != null)
            Leads.add(record);
            if (Leads.size() == 200) {
                AssignLeads(Leads, false);
                Leads = new List<Lead>();
            }
        }
        
        System.Debug('-----------------> Lead Count: ' + Leads.size());
        
        // for anything less than an even 200 objects
        if (Leads.size() > 0) {
            AssignLeads(Leads, false);
        }             
    }
   
    public string GetLeadRoutingMapKey(String Country, String State, String City) {
        
        // Purpose: Concenate LeadRouting Data for Map Key.  This enables us to match Lead Data without looping
        if ((!nullParamsSet.contains(Country) && Country != null) && (!nullParamsSet.contains(State) && State != null) && (!nullParamsSet.contains(City) && City != null)) {
            return Country + '_' + State + '_' + City.toLowerCase();
        }
        else {
            if ((!nullParamsSet.contains(Country) && Country != null)&& (!nullParamsSet.contains(State) && State != null)) {
                return Country + '_' + State;
            } 
            else if ((!nullParamsSet.contains(Country) && Country != null) && (!nullParamsSet.contains(City) && City != null)){
                return Country + '_' + '_' + City.toLowerCase();
            }
            else {
                if ((!nullParamsSet.contains(Country) && Country != null)) {
                    return Country;
                }
                else {
                    return 'DefaultRule';
                }
            }           
        }
    }
   
    public Decimal GetNextRankForLeadRouting(LeadRouting__c LeadRouting, Decimal RequestedRank) {
    System.Debug('----------------->' + RequestedRank );    
    System.Debug('----------------->' + LeadRouting.ID );
        
        // Purpose: Each LeadRouting record acts as an assignment round robin.  Return the next rank that has a value assigned
        
        // appears the LeadRouting record is invalid
        if (RequestedRank == null) { return -1; }

        // there are 6 partner rankings - loop through the list until a non-null value is found
        Decimal NewRank = RequestedRank;
        for (Decimal i = 1; i < 9; i++) {
            //Decimal NextRank = LeadRouting.NextRank__c;
            // once we get to -1 its time to start back at 5
            if (NewRank > 8) { NewRank = 1; }
            
            if (NewRank == 1 && LeadRouting.Partner1__c != null) { break; }
            if (NewRank == 2 && LeadRouting.Partner2__c != null) { break; }
            if (NewRank == 3 && LeadRouting.Partner3__c != null) { break; }
            if (NewRank == 4 && LeadRouting.Partner4__c != null) { break; }
            if (NewRank == 5 && LeadRouting.Partner5__c != null) { break; }
            if (NewRank == 6 && LeadRouting.Partner6__c != null) { break; }
            if (NewRank == 7 && LeadRouting.Partner7__c != null) { break; }
            if (NewRank == 8 && LeadRouting.Partner8__c != null) { break; }
            
            // No match found.  Go to the next in the list
            NewRank++;        
        }
        System.Debug('----------------->' + NewRank);
        return NewRank;
    }
  
    public String GetPartnerByRank(LeadRouting__c LeadRouting, Decimal Rank) {
        
        // Purpose: Return the Account for the Ranking Number
        if (Rank == 1) { return LeadRouting.Partner1__c; }
        if (Rank == 2) { return LeadRouting.Partner2__c; }
        if (Rank == 3) { return LeadRouting.Partner3__c; }
        if (Rank == 4) { return LeadRouting.Partner4__c; }
        if (Rank == 5) { return LeadRouting.Partner5__c; }
        if (Rank == 6) { return LeadRouting.Partner6__c; }
        if (Rank == 7) { return LeadRouting.Partner7__c; }
        if (Rank == 8) { return LeadRouting.Partner8__c; }
        
        // invalid parameters or invalid LeadRouting record
        return null;
    }
}