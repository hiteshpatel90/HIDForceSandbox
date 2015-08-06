////////////////////////////////////////////////////////////////////
//Type                    :  Apex Class
//Name                    :  ShiptoAddressOLILookupController
//Company                 :  Jade Global
//Created By              :  Hitesh Patel
//Created Date            :  07/21/2014
//Last Modified By        :  
//Last Modified Date      :   
// Description            : Custom controller for Ship to Address OLI lookup page
/////////////////////////////////////////////////////////////////////

public with sharing class ShipToAddressLookupController
{
    public String query {get; set;}
    public List<Bill_To_Addresses__c> lstshipToAddress {get; set;}
    string strSelshipToAcc;
    string BilltoAddress;
    
    public ShipToAddressLookupController(){

        strSelshipToAcc = apexpages.currentpage().getparameters().get('selShipacc');
        string strSelBillToAdd = apexpages.currentpage().getparameters().get('billtoAdd');
        BilltoAddress = [SELECT id,Oracle_Organization_Active__c FROM Bill_To_Addresses__c WHERE id =: strSelBillToAdd LIMIT 1].Oracle_Organization_Active__c;
            
        if(strSelshipToAcc != null && strSelBillToAdd != null){            
                        
            string strSearch = apexpages.currentpage().getparameters().get('namevalue');
            if(strSearch != '' ){
                query = strSearch;
                string strSearchTemp = '%' + strSearch + '%';
                //lstshipToAddress = [select id,name, Account__c, Address_1__c, City__c, State_Province__c, Country__c,Oracle_Organization_Active__c from Bill_To_Addresses__c where Name Like: strSearchTemp and Account__c =: strSelshipToAcc AND Oracle_Organization_Active__c =: BilltoAddress and ship_To__c = true Limit 10000];
                lstshipToAddress = [select id,name, Account__c, Address_1__c, City__c, State_Province__c, Country__c,Oracle_Organization_Active__c from Bill_To_Addresses__c where Name Like: strSearchTemp and Account__c =: strSelshipToAcc AND Oracle_Organization_Active__c =: BilltoAddress Limit 10000];
            }else{
                //lstshipToAddress = [select id,name, Account__c, Address_1__c, City__c, State_Province__c, Country__c  from Bill_To_Addresses__c where Account__c =: strSelshipToAcc AND Oracle_Organization_Active__c =: BilltoAddress and ship_To__c = true Limit 10000];
                lstshipToAddress = [select id,name, Account__c, Address_1__c, City__c, State_Province__c, Country__c  from Bill_To_Addresses__c where Account__c =: strSelshipToAcc AND Oracle_Organization_Active__c =: BilltoAddress Limit 10000];
            }
        }
    }
    public PageReference runQuery(){
        string strSearchTemp = '%' + query + '%';        
        //lstshipToAddress = [select id,name, Account__c, Address_1__c, City__c, State_Province__c, Country__c  from Bill_To_Addresses__c where Name Like: strSearchTemp and Account__c =: strSelshipToAcc AND Oracle_Organization_Active__c =: BilltoAddress and ship_To__c = true Limit 10000];
        lstshipToAddress = [select id,name, Account__c, Address_1__c, City__c, State_Province__c, Country__c  from Bill_To_Addresses__c where Name Like: strSearchTemp and Account__c =: strSelshipToAcc AND Oracle_Organization_Active__c =: BilltoAddress Limit 10000];
        return null;
    }
}