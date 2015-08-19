public class PartnerProgramServices {
        
    public static void convertProductsToPartnerProgramProducts(Map<Id, Partner_Program__c> idToPartnerProgram) {
        
        Set<Id> accountIds = new Set<Id>();
        for (Partner_Program__c partnerProgram : idToPartnerProgram.values()) {
            if (partnerProgram.Account__c != null) {
                accountIds.add(partnerProgram.Account__c);
            }
        }
        
        List<Lead_Products__c> leadProductsForUpdate = new List<Lead_Products__c>(); 
        if (!accountIds.isEmpty()) {
            for (Account acct : [SELECT Id, 
                                (SELECT Id, RecordType.Name FROM Partner_Programs__r WHERE Partner_Program_Status__c != 'Inactive' AND Id IN :idToPartnerProgram.keySet()),
                                (SELECT Id, RecordType.Name FROM Lead_Products__r WHERE Approval_Status__c=:PartnerProductConversion.APPROVED_STATUS)
                                FROM Account WHERE Id IN :accountIds])
            {
                if (!acct.Partner_Programs__r.isEmpty()) {
                    
                    for (Partner_Program__c partnerProgram : acct.Partner_Programs__r) {
                        
                        List<Lead_Products__c> convertedLeadProducts = convertProducts(acct.Lead_Products__r, partnerProgram);
                        leadProductsForUpdate.addAll(convertedLeadProducts);
                    }
                }
            }
        }
        if (!leadProductsForUpdate.isEmpty()) {
            try {
                update leadProductsForUpdate;
            }
            catch (DMLException dmlEx) {
                System.debug(dmlEx);
                for (Integer i=0; i < dmlEx.getNumDML(); i++)
                {
                    Id partnerProgramId = leadProductsForUpdate[dmlEx.getDmlIndex(i)].Partner_Program__c;
                    idToPartnerProgram.get(partnerProgramId).addError(dmlEx.getDmlMessage(i));
                }
            }
        }
    }
    
    public static List<Lead_Products__c> convertProducts(List<Lead_Products__c> leadProducts, Partner_Program__c partnerProgram) {
        List<Lead_Products__c> convertedLeadProducts = new List<Lead_Products__c>();
        
        for (Lead_Products__c leadProduct : leadProducts) {             
            Boolean programMatchesProduct = (partnerProgram.RecordType.Name == leadProduct.RecordType.Name);
            if (programMatchesProduct) {
                
                leadProduct.Partner_Program__c = partnerProgram.Id;
                leadProduct.Account__c = null;
                convertedLeadProducts.add(leadProduct);
            }
        }
        
        return convertedLeadProducts;
    }
}