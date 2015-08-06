/****************************************************************************
* Type               : Apex Class
* Name               : PafPicklistsController
* Modified by        : Hitesh Patel
* Modified Date      : 5th June 2015
* Last Modified By   : Hitesh Patel 5th June 2015
* Purpose            : This controller is used to get submit value of PAF price code based on display value of price code.                
****************************************************************************/
public class PafPicklistsController{
    transient Map<String, List<Price_Authorization_Form_Code__c>> pafFieldValuesMap;
    transient Set<String> pafFieldNames;
    transient List<Price_Authorization_Form_Code__c> priceCodeList;
    transient Map<String, String> mapPafPriceCodeValues;
    transient Map<String, String> mapPafPriceCodeDisplayValues;
    public PafPicklistsController(String accCountry, String strPAFRecType){
        pafFieldNames = new Set<String>();
        mapPafPriceCodeValues = new Map<String, String>();
        mapPafPriceCodeDisplayValues = new Map<String, String>();
        
        pafFieldValuesMap = new Map<String, List<Price_Authorization_Form_Code__c>>();
        String queryString='select Price_Code__c, Display_Value__c, Submit_Value__c from Price_Authorization_Form_Code__c ';
        String ExceptionCountries=System.Label.ExceptionCountries;
        String[] arrCountries = ExceptionCountries.split(',');
        String ExceptionCountry;
        //priceCodeList = new List<Price_Authorization_Form_Code__c>();
        //priceCodeList = [select Price_Code__c, Display_Value__c, Submit_Value__c from Price_Authorization_Form_Code__c where Country__c=:accCountry ORDER BY Display_Order__c];
        
        //Generate query to exclude brazil from PAF
        
        for(integer i=0;i<arrCountries.size();i++){
            if(accCountry != null && accCountry.toLowercase().trim()==arrCountries[i]){
                ExceptionCountry=arrCountries[i];
            }
        }
        if(ExceptionCountry!=null){
            queryString = queryString +' where Country__c=:accCountry ';
        }else{
            queryString = queryString +' where Country__c=\'\'';
        }
        
        system.debug('@@@@@@'+strPAFRecType);
        if(strPAFRecType != null && strPAFRecType == 'Standard_PAF'){
            
            queryString = queryString +' AND Is_In_vPAF__c = false ';
        }
        system.debug('@@@@@@'+queryString);
        queryString += ' ORDER BY Display_Order__c';
        
        priceCodeList=Database.query(queryString);
        for(Price_Authorization_Form_Code__c pafc :priceCodeList){
            pafFieldNames.add(pafc.Price_Code__c);            
            mapPafPriceCodeValues.Put(pafc.Display_Value__c, pafc.Submit_Value__c);
            if(mapPafPriceCodeDisplayValues.containskey(pafc.Submit_Value__c) == false){
                mapPafPriceCodeDisplayValues.Put(pafc.Submit_Value__c, pafc.Display_Value__c);
            }
        } 
        
        for(String pafFieldName :pafFieldNames){
            List<Price_Authorization_Form_Code__c> relatedPafCodes = new List<Price_Authorization_Form_Code__c>();
            for(Price_Authorization_Form_Code__c pafc :priceCodeList){
                if(pafFieldName == pafc.Price_Code__c){
                    relatedPafCodes.add(pafc);
                }
            }
            pafFieldValuesMap.put(pafFieldName, relatedPafCodes);
        }
    }
    
    public List<SelectOption> getFieldValues(String PriceCodeName){
        List<SelectOption> accessoriesValues = new List<SelectOption>();
        selectOption opNone = new selectOption('', '--None--');
        accessoriesValues.add(opNone);
        if(pafFieldValuesMap.get(PriceCodeName) != null){
            for(Price_Authorization_Form_Code__c pafc :pafFieldValuesMap.get(PriceCodeName)){
            
                
                //selectOption op = new selectOption(pafc.Submit_Value__c, pafc.Display_Value__c);
                selectOption op = new selectOption(pafc.Display_Value__c, pafc.Display_Value__c);
                accessoriesValues.add(op);
            }
        }    
        return accessoriesValues;
    }
    
    public string getPAFPriceCodeSubmitValue(string priceCodedisplayValue){
        string returnString = '';
        if(!mapPafPriceCodeValues.isEmpty() && mapPafPriceCodeValues.get(priceCodedisplayValue) != null){
            returnString = mapPafPriceCodeValues.get(priceCodedisplayValue);
        }
        return returnString;
    }
    
    public string getPAFPriceCodeDisplayValue(string priceCodeSubmitValue){
        string returnString = '';
        if(!mapPafPriceCodeDisplayValues.isEmpty() && mapPafPriceCodeDisplayValues.get(priceCodeSubmitValue) != null ){
            returnString = mapPafPriceCodeDisplayValues.get(priceCodeSubmitValue);
        }
        return returnString;
    }
}