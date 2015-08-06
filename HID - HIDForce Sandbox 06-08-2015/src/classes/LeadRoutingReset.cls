public class LeadRoutingReset
{
    // Author : Timmus Agersea
    // Purpose: Each month the Lead Routing process is reset to start back at rank 1
    public void Reset()
    {
        List<LeadRouting__c> records = new List<LeadRouting__c>();
        for (LeadRouting__c record : [
            Select 
                Id, NextRank__c 
            From 
                LeadRouting__c
            Where 
                NextRank__c <> 1
            ])
        { 
            record.NextRank__c = 1;
            records.add(record);            
        }
        
        update records;
    }
    
@isTest
    static void LeadRoutingReset_Test() {
        LeadRouting__c LeadRouting = new LeadRouting__c(NextRank__c=3);
        insert LeadRouting;
        
        LeadRoutingReset thisClass = new LeadRoutingReset();
        thisClass.Reset();
        
        LeadRouting = [Select Id, NextRank__c From LeadRouting__c Where Id = :LeadRouting.Id];
        
        System.assertEquals(1, LeadRouting.NextRank__c);
        
    
    }
}