public class PopulateApprovalCheckboxesController{
    
    public static boolean isPAFFirstExcecution = FALSE;
    private Map<Id, ACCOUNT> accountsMap = new Map<Id, ACCOUNT>();
    private Account_Profile__c[] accountProfiles;
    public void retrieveRelatedInfo(List<Price_Authorization_Form__c> pafList){
              retrieveAccountInfo(pafList);
              retrieveAccountProfileInfo(pafList);
    }
    private void retrieveAccountInfo(List<Price_Authorization_Form__c> pafList){
            List<Id> accountIds = new List<Id>();
            for(Price_Authorization_Form__c paf:pafList){
                   accountIds.add(paf.Account__c);
            }
            ACCOUNT[] accounts = [SELECT Id, Oracle_Customer_Number__c, Sub_Region__c FROM ACCOUNT Where Id IN :accountIds];
            
            for(ACCOUNT account:accounts){
                     accountsMap.put(account.Id, account);
            }
    }
    private void retrieveAccountProfileInfo(List<Price_Authorization_Form__c> pafList){
            List<Id> accountIds = new List<Id>();
            for(Price_Authorization_Form__c paf:pafList){
                   accountIds.add(paf.Account__c);
            }
            accountProfiles = [SELECT Account__c FROM Account_Profile__c Where Account__c IN :accountIds AND Tier__c <> null];
    }
    private boolean isOracleCustDefined(Price_Authorization_Form__c paf){
             Account accnt = accountsMap.get(paf.Account__c);
             if(accnt!=null && accnt.Oracle_Customer_Number__c!=null 
                                     && String.isNotEmpty(accnt.Oracle_Customer_Number__c)
                                     && String.isNotBlank(accnt.Oracle_Customer_Number__c))
                    return true;
             return false;
    }
    private boolean isSubRegionDefined(Price_Authorization_Form__c paf){
             Account accnt = accountsMap.get(paf.Account__c);
             if(accnt!=null && accnt.Sub_Region__c!=null 
                                     && String.isNotEmpty(accnt.Sub_Region__c)
                                     && String.isNotBlank(accnt.Sub_Region__c))
                    return true;
             return false;
    }
    private boolean isTierAccountProfileAttached(Price_Authorization_Form__c paf){
             for(Account_Profile__c accntProfile:accountProfiles){
                          if(accntProfile.Account__c == paf.Account__c)
                                   return true;
             }
             return false;
    }
    // Set L1, E21, L2, E21VP Approval Needed Checkboxes for all given input PAFs
    public void setApprovalNeededCheckboxes(List<Price_Authorization_Form__c> pafList){
        retrieveRelatedInfo(pafList);
        setL1ApprovalNeededCheckbox(pafList);
        setE21ApprovalNeededCheckbox(pafList);
        setL2E21ApprovalNeededCheckbox(pafList);
        setPricingApprovalNeededCheckbox(pafList);
    }
    // Set is L1 Approval Needed Checkbox for all given input PAFs
    private void setL1ApprovalNeededCheckbox(List<Price_Authorization_Form__c> pafList){
        for(Price_Authorization_Form__c paf:pafList){
             // L1 Approval
            if(paf.L1_Approver__c!=null && String.isNotEmpty(paf.L1_Approver__c) 
                && String.isNotBlank(paf.L1_Approver__c)){
                paf.Is_L1_Approval_Needed__c = true;
            }else{
                paf.Is_L1_Approval_Needed__c = false;
            }
        }
    }
    // Set is E21 Approval Needed Checkbox for all given input PAFs
    private void setE21ApprovalNeededCheckbox(List<Price_Authorization_Form__c> pafList){
        for(Price_Authorization_Form__c paf:pafList){
             // E21 Approval
             System.debug('aaaaaaaaaaaaaaa befor '+paf.Is_E21_Approval_Needed__c +'aaaaaaaaaaaa' +paf.e_21_Account__c);
            if(paf.E21_Approver__c!=null && String.isNotEmpty(paf.E21_Approver__c) 
                && String.isNotBlank(paf.E21_Approver__c) && paf.e_21_Account__c=='Yes'){
                paf.Is_E21_Approval_Needed__c = true;
            }else{
                paf.Is_E21_Approval_Needed__c = false;
            }
            // System.debug('aaaaaaaaaaaaaaa after'+paf.Is_E21_Approval_Needed__c +'aaaaaaaaaaaa');
        }
    }
    // Set is L2 Approval Needed Checkbox for all given input PAFs
   private void setL2E21ApprovalNeededCheckbox(List<Price_Authorization_Form__c> pafList){
        for(Price_Authorization_Form__c paf:pafList){
            if(paf.L2_Approver__c!=null && String.isNotEmpty(paf.L2_Approver__c) 
                && String.isNotBlank(paf.L2_Approver__c)){
                
                boolean isL2ApprovalNeeded = isL2ApprovalNeeded(paf);
                boolean isConnectSalesTeam = isConnectSalesTeam(paf);
                boolean isConnectCustomer = isConnectCustomer(paf);
                                 
                if(isL2ApprovalNeeded || (isConnectSalesTeam && isConnectCustomer)){
                    paf.Is_L2_Approval_Needed__c = true;
                    //E21 VP Approval
                    if(paf.e_21_Account__c=='Yes' && paf.E21VP_Approver__c!=null
                    && String.isNotEmpty(paf.E21VP_Approver__c) && String.isNotBlank(paf.E21VP_Approver__c)){
                        paf.Is_E21VP_Approval_Needed__c = true;
                    }else{
                        paf.Is_E21VP_Approval_Needed__c = false;
                    }
                }else{
     System.Debug('************************before '+ paf.Is_L2_Approval_Needed__c +'************************');
                paf.Is_L2_Approval_Needed__c = false;
                paf.Is_E21VP_Approval_Needed__c = false;

  System.Debug('************************ After '+ paf.Is_L2_Approval_Needed__c+'************************');
               }
            }
        }
    }
    // Set is Pricing Approval Needed Checkbox for all given input PAFs
    private void setPricingApprovalNeededCheckbox(List<Price_Authorization_Form__c> pafList){
        for(Price_Authorization_Form__c paf:pafList){
             // L1 Approval
            if(paf.Pricing_Approver__c!=null && String.isNotEmpty(paf.Pricing_Approver__c) 
                && String.isNotBlank(paf.Pricing_Approver__c)){
                paf.Is_Pricing_Approval_Needed__c = true;
            }else{
                paf.Is_Pricing_Approval_Needed__c = false;
            }
        }
    }
    // Returns true if L2 Approval is needed for given input PAF
    public boolean isL2ApprovalNeeded(Price_Authorization_Form__c paf){
        //getAccountProfileValues(paf);
        if(isPartnerProgram(paf)==false)
            return false;
        return (!isProgramDiscountRight(paf));
    }
    // Returns True is PAF Account is a Partner Program
    // i.e. Oracle_Customer_Number__c!=null && Sub_Region__c!=null &&
    // At least 1 Account profile has Tier specified
    private boolean isPartnerProgram(Price_Authorization_Form__c paf){
        if(isOracleCustDefined(paf) && isSubRegionDefined(paf) && isAnyProfileTierAttached(paf))
             return true;
         else
             return false;
        /*List<Account> accounts = [SELECT Oracle_Customer_Number__c, Sub_Region__c FROM ACCOUNT Where Id=:paf.Account__c];
        string oracleCustNo = '';
        string subRegion = '';
        if(accounts.size()>0){
            oracleCustNo = accounts[0].Oracle_Customer_Number__c;
            subRegion = accounts[0].Sub_Region__c;
        }
        //System.Debug('************************ Oracle_Customer_Number__c ' + oracleCustNo + '************************ ');
        //System.Debug('************************ Sub_Region__c ' + subRegion + '************************ ');        
        if(oracleCustNo != null && String.isNotBlank(oracleCustNo) && String.isNotEmpty(oracleCustNo) &&
            subRegion != null && String.isNotBlank(subRegion) && String.isNotEmpty(subRegion) &&
            isAnyProfileTierAttached(paf.Account__c)){
            return true;
        }
        //System.Debug('************************ Not A Partner Program ************************ ');
        return false;*/
    }
    // Returns True if - At least 1 Account profile(associated with given input Account - Id) has Tier specified
    private boolean isAnyProfileTierAttached(Price_Authorization_Form__c paf){
         if(isTierAccountProfileAttached(paf))
             return true;
         else
             return false;
        //System.Debug('************************ IN isAnyProfileTierAttached');
        // Get Account Profiles
        /*Account_Profile__c[] profiles = [SELECT Tier__c from Account_Profile__c Where Account__c=:accountId];
        for(Account_Profile__c profile: profiles){
            string tierValue = profile.Tier__c;
            if(tierValue!=null && String.isNotBlank(tierValue) && String.isNotEmpty(tierValue)){
                //System.Debug('************************ isAnyProfileTierAttached : YES ************************ '); 
                return true;
            }
        }
        //System.Debug('************************ isAnyProfileTierAttached : NO ************************ ');
        return false;*/
    }
    // Return true if
    // For each associated Account profiles(with specified Tier),
    // For Business Segment, Partner Type, Tier combination,
    // Tier Discount value matches with PAF field value FA, FB...FW
    // Depending on Price code in Account_Tier_Discount__c
    private boolean isProgramDiscountRight(Price_Authorization_Form__c paf){
       Price_Authorization_Form__c pafform;
       Account_Tier_Discount__c[] tierDiscounts = getTierDiscount(paf);
       if (tierDiscounts != null && tierDiscounts.size()> 0){
       String pafID=paf.ID;
       string soqlString = 'select '; 
        for(Account_Tier_Discount__c tierDiscount:tierDiscounts){
              soqlString = soqlString +tierDiscount.Tier_Discount__r.Price_Code__c+ ', ';                      
          }        
          soqlString = soqlString.subString(0, soqlString.length()-2);
          system.debug('QQQQQ: '+ soqlString);        
          soqlString = soqlString + ' from Price_Authorization_Form__c where ID=:pafID';   
          
       pafform = dataBase.query(soqlString);
   }
        for(Account_Tier_Discount__c tierDiscount:tierDiscounts){
                    // Price code
                    string priceCode = tierDiscount.Tier_Discount__r.Price_Code__c;
                    // Tier Discount Integer Value
                    Integer i =0;
                    if(tierDiscount.Tier_Discount__r.Discount__c!=null)
                        i = Integer.valueOf(tierDiscount.Tier_Discount__r.Discount__c);
                    
                    // Concatenated Price code and Tier discount
                    string priceCodeDiscount = (priceCode.length()>2?priceCode.subString(0, 2):priceCode) + String.valueOf(i);
                                           
                    Object o = pafform.get(priceCode);
                    System.Debug('************************'+pafform.get(priceCode)+'************************');
                    string fieldValue = String.valueOf(o);
                   //To get splited field value
                   // fieldValue=getPAFPriceCodeValue(fieldValue);
                    
                   // System.Debug('************************ priceCode = ' + priceCode + ', fieldValue = ' + fieldValue + ', priceCodeDiscount = ' + priceCodeDiscount + '************************');
                    if(fieldValue!=null) {
                    if(!priceCodeDiscount.equals(fieldValue )){
                    //    System.Debug('************************ Nonmatching ************************ ');
                             return false;
                          }else{
                     //      System.Debug('************************ Matching ************************ ');
                     }
                 }  
             }
         return true;
    }
     
   /* private String getPAFPriceCodeValue(String fieldValue){
        if (fieldValue == null)
           return null;
        List<String> parts = fieldValue.split(' ');
        if(parts.size()>0)
           fieldValue = parts[0];
                
        return fieldValue;
    } */
    
    // Get Tier discounts for given input PAF Account 
    private Account_Tier_Discount__c[] getTierDiscount(Price_Authorization_Form__c paf){
         Account_Tier_Discount__c[] tierDiscount = [select Tier_Discount__r.Price_Code__c, Tier_Discount__r.Discount__c from Account_Tier_Discount__c 
                                                                        Where Account__c =: paf.Account__c];
         return tierDiscount;
    }

//This method will check whether PAF owner is from APAC HID Connect or EMEA Connect or HID Connect.
    private boolean isConnectSalesTeam(Price_Authorization_Form__c paf){
        String salesTeam = [SELECT Sales_Team__c FROM User WHERE Id =: paf.OwnerId].Sales_Team__c;
       
        if(salesTeam == 'APAC HID Connect' || salesTeam == 'EMEA Connect' || salesTeam == 'HID Connect'){
            return true;
        }else{
        return false;
        }
    }

//This method will check current accounts bussiness segment = Connect from account profile.    
    private boolean isConnectCustomer(Price_Authorization_Form__c paf){
        List <Account_Profile__c> accProfile = new List <Account_Profile__c>();
        
        accProfile = [SELECT Business_Segment__c FROM Account_Profile__c WHERE Account__c =: paf.Account__c AND Business_Segment__c = 'Connect'];
         
        if(accProfile.size() > 0){
            return true;
        }else{
        return false;
        }
}
}