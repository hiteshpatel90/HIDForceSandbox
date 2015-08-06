public class TierDiscountController{
    Map<String, Price_Authorization_Form_Code__c> tierDiscountMap = new Map<String, Price_Authorization_Form_Code__c>();
    public TierDiscountController(){
        for(Price_Authorization_Form_Code__c PAFCode:[SELECT In_Program__c,HID_Connect__c,Restricted__c, Price_code__c FROM Price_Authorization_Form_Code__c]){
            tierDiscountMap.put(PAFCode.Price_code__c, PAFCode);
        }
    }
    
    public string getTierDiscountDetails(string priceCode){
        string returnString;
        Price_Authorization_Form_Code__c pfCode = tierDiscountMap.get(priceCode);
         if(pfCode != null){
            if(pfCode.HID_Connect__c == null)
                pfCode.HID_Connect__c = '-';
            if(pfCode.In_Program__c == null)
                pfCode.In_Program__c  = '-';
            if(pfCode.Restricted__c == null)
                pfCode.Restricted__c = '-';              
        returnString = pfCode.In_Program__c + ' ' + pfCode.Restricted__c + ' ' + pfCode.HID_Connect__c;
         }  
        return returnString;
    }
}