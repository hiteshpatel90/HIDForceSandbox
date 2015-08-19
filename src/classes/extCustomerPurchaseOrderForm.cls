////////////////////////////////////////////////////////////////////
//Type                    :  Apex Class
//Name                    :  extCustomerPurchaseOrderForm
//Company                 :  Jade Global
//Created By              :  Hitesh Patel
//Created Date            :  07/10/2014
//Last Modified By        :  
//Last Modified Date      :  
/////////////////////////////////////////////////////////////////////
public class extCustomerPurchaseOrderForm{
    public order objOrder {get; set;}
    public Account objAccount {get; set;}
    //For Sales Quote selection page
    public BigMachines__Quote_Product__c objBigMachinesQuoteProduct {get; set;}
    public string strselQuote {get; set;}
    public string strselQuoteOpp {get; set;}
    public List<SelectOption> SalesQuoteOpportunity {get; set;}
    final static String BMISTATUSAPPROVED = 'Approved'; 
    final static String BMISTATUSCREATINGORDER = 'Creating Order'; 
    Public set<string> statusSet = new set<string>();
    private ApexPages.StandardController stdController;
    public string existingOrderId {get; set;}
      
    public string strselShipToAddress {get; set;}
    //For second page
    public List<wrapCustomerPurchaseOrderLI> lstwrapCustomerPurchaseOrderLI{get; set;}
    //For preview page
    public List<wrapCustomerPurchaseOrderLI> lstwrapCustomerPurchaseOrderLIPreview{get; set;}
    public boolean isMakeorderdisable {get; set;}
    //Constructor
    public extCustomerPurchaseOrderForm(apexpages.standardController stdCon){
        statusSet = new set<String>();
        existingOrderId =System.currentPageReference().getParameters().get('id');

        this.stdController = stdCon;
        objOrder = (Order)stdCon.getRecord();
        
        if(objOrder.AccountId != null){
            id actId = objOrder.AccountId;
            objAccount = [Select id, Name from Account WHERE id =: actId  LIMIT 1];
        }else{
            //objOrder = new order();
            objAccount = new Account();
        }
        
        if(objOrder.Ship_To_Addresses__c != null){
            id shiptoAddId= objOrder.Ship_To_Addresses__c ;
            strselShipToAddress = [Select id, Name from Bill_To_Addresses__c WHERE id =: shiptoAddId LIMIT 1].Name;
        }

        objBigMachinesQuoteProduct = new BigMachines__Quote_Product__c();
        if(objOrder.Quote__c != null){
            objBigMachinesQuoteProduct.BigMachines__Quote__c = objOrder.Quote__c;
        }
        lstwrapCustomerPurchaseOrderLI = new List<wrapCustomerPurchaseOrderLI>();
        strselQuote = null;
        strselQuoteOpp = null;
        isMakeorderdisable = false;
        statusSet.add(BMISTATUSAPPROVED );
        statusSet.add(BMISTATUSCREATINGORDER );
        
        List<BigMachines__Quote__c> lstBigMachinesQuote = [select id from BigMachines__Quote__c where id =: objBigMachinesQuoteProduct.BigMachines__Quote__c AND BigMachines__Status__c IN: statusSet AND Expiration_Date__c >= TODAY];
        if(lstBigMachinesQuote.size() == 0 && objOrder.Quote__c != null){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Selected Sales Quote has been expired.');
            ApexPages.addMessage(myMsg);
        }
    }    
    
    //For Sales Quote selection page
    public opportunity objOpp {get; set;}
    public void  SalesQuoteaccandoppset(){
        List<BigMachines__Quote__c> lstBigMachinesQuote = [select id from BigMachines__Quote__c where id =: objBigMachinesQuoteProduct.BigMachines__Quote__c AND BigMachines__Status__c IN: statusSet AND Expiration_Date__c >= TODAY];
       
        if(lstBigMachinesQuote.size() == 0){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Selected Sales Quote has been expired.');
            ApexPages.addMessage(myMsg);
        }
        List<BigMachines__Quote__c> lstBigMachinesQuoteSel = [select id, Quote_To_Account__c,BigMachines__Account__c,  BigMachines__Opportunity__c, BigMachines__Opportunity__r.Name, BigMachines__Opportunity__r.AccountId, BigMachines__Opportunity__r.Account.Name from BigMachines__Quote__c where id =: objBigMachinesQuoteProduct.BigMachines__Quote__c];
        
        if(lstBigMachinesQuoteSel.size() > 0){
            BigMachines__Quote__c objBigMachinesQuote = lstBigMachinesQuoteSel[0];
            //objAccount = objBigMachinesQuote.BigMachines__Opportunity__r.Account;
            objAccount = new Account(id=objBigMachinesQuote.BigMachines__Opportunity__r.AccountId,name = objBigMachinesQuote.BigMachines__Opportunity__r.Account.Name);
            objOpp = objBigMachinesQuote.BigMachines__Opportunity__r;
            if(objOrder.AccountId == null){
                objOrder.AccountId = objBigMachinesQuote.BigMachines__Account__c;
            }
            objOrder.Bill_to_Account__c = objBigMachinesQuote.Quote_To_Account__c;
            fillSalesQuote();
        }
        
       
    }
    
    public List<SelectOption> SalesQuote {get; set;}    
    public void fillSalesQuote() {
        SalesQuoteOpportunity = new List<SelectOption>();
        SalesQuote = new List<SelectOption>();
        if(objOrder.Bill_to_Account__c != null){            
            List<BigMachines__Quote__c> lstBigMachinesQuote = [select id, BigMachines__Account__r.Name, name,BigMachines__Opportunity__c , BigMachines__Opportunity__r.name from BigMachines__Quote__c where Quote_To_Account__c =: objOrder.Bill_to_Account__c AND BigMachines__Account__c =: objAccount.id AND BigMachines__Status__c IN: statusSet AND Expiration_Date__c >= TODAY];
            for(BigMachines__Quote__c bq: lstBigMachinesQuote){
                SalesQuote.add(new SelectOption(bq.Name, bq.Name + ',' + bq.BigMachines__Account__r.Name));
                SalesQuoteOpportunity.add(new SelectOption(bq.BigMachines__Opportunity__c, bq.BigMachines__Opportunity__r.Name));
            }
        }
    }
    
    /*public void fillSalesQuoteOpp() {
        
        SalesQuoteOpportunity = new List<SelectOption>();
        if(objOrder.Customer__c != null){            
            List<BigMachines__Quote__c> lstBigMachinesQuote = [select id, BigMachines__Opportunity__c, BigMachines__Opportunity__r.Name from BigMachines__Quote__c ];
            set<Id> sOppId = new set<Id>();
            for(BigMachines__Quote__c bq: lstBigMachinesQuote){
                if(sOppId.contains(bq.BigMachines__Opportunity__c) == false){
                    sOppId.add(bq.BigMachines__Opportunity__c);
                    //SalesQuoteOpportunity.add(new SelectOption(bq.BigMachines__Opportunity__c, bq.BigMachines__Opportunity__r.Name));
                }
            }
        }
    }*/
    
    public pagereference goTonextpage(){
        //BigMachines__Quote__c
        List<BigMachines__Quote__c> lstBigMachinesQuote = [select id from BigMachines__Quote__c where id =: objBigMachinesQuoteProduct.BigMachines__Quote__c AND BigMachines__Status__c IN: statusSet AND Expiration_Date__c >= TODAY];
        if(lstBigMachinesQuote.size() == 0){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Selected Sales Quote has been expired.');
            ApexPages.addMessage(myMsg);
        }
        SalesQuoteaccandoppset();
        pagereference pr = new pagereference('/apex/OrderForm');
        return pr;
    }
    public pagereference goTopreviouspage(){
        lstwrapCustomerPurchaseOrderLI = new List<wrapCustomerPurchaseOrderLI>();
        pagereference pr = new pagereference('/apex/CustomerPurchaseOrderForm');
        return pr;
    }
    //Go To Order Prototype page
    public pagereference gotoOrderProtoType(){
        pagereference pr = new pagereference('/apex/orderPrototype');
        return pr;
    }
    //Preview page display
    public pagereference goTopreviewpage(){
        lstwrapCustomerPurchaseOrderLIPreview = new List<wrapCustomerPurchaseOrderLI>();
         
        for(wrapCustomerPurchaseOrderLI wCPOLI:  lstwrapCustomerPurchaseOrderLI){
            if(wCPOLI.isCPOLIselected == true){
               
                lstwrapCustomerPurchaseOrderLIPreview.add(wCPOLI);
            }
        }      
        wrapCustomerPurchaseOrderLI objwrapCustomerPurchaseOrderLItemp = lstwrapCustomerPurchaseOrderLIPreview[0];
        for(integer i=0;i<lstwrapCustomerPurchaseOrderLIPreview.size();i++){
            for(integer j=i;j<lstwrapCustomerPurchaseOrderLIPreview.size();j++){
                if(lstwrapCustomerPurchaseOrderLIPreview[i].objCustPurchaseOLI.Line_Number__c > lstwrapCustomerPurchaseOrderLIPreview[j].objCustPurchaseOLI.Line_Number__c){
                    
                    //objwrapCustomerPurchaseOrderLITemp = new wrapCustomerPurchaseOrderLI();
                    objwrapCustomerPurchaseOrderLITemp = lstwrapCustomerPurchaseOrderLIPreview[i];
                    lstwrapCustomerPurchaseOrderLIPreview[i] = lstwrapCustomerPurchaseOrderLIPreview[j];
                    lstwrapCustomerPurchaseOrderLIPreview[j] = objwrapCustomerPurchaseOrderLITemp;
                }
            }
            //lstwrapCustomerPurchaseOrderLIPreview.add(objwrapCustomerPurchaseOrderLI);
        }
        
        pagereference pr = new pagereference('/apex/OrderFormPreview');
        return pr;
    }
    
    //fill Part Detail on "Make Order Match Quote" checkbox check
    public void fillPartDetail(){
        lstwrapCustomerPurchaseOrderLI = new List<wrapCustomerPurchaseOrderLI>();
        system.debug('#########'+strselQuote);
        set<String> sQuoteName = new set<String>();
        strselQuote = strselQuote.replace('[','');
        strselQuote = strselQuote.replace(']','');
        string[] arrselQuote = strselQuote.split(',');
        for(String str: arrselQuote){
            str = str.trim();
            sQuoteName.add(str); 
        }
        system.debug('#########'+sQuoteName);
        List<BigMachines__Quote_Product__c> lstBMQP = [select id, Name, convertCurrency(BigMachines__Sales_Price__c), BigMachines__Product__c, BigMachines__Product__r.Name, BigMachines__Quantity__c,  BigMachines__Quote__r.BigMachines__Opportunity__c, BigMachines__Quote__r.BigMachines__Opportunity__r.Name, BigMachines__Quote__r.Name from BigMachines__Quote_Product__c where BigMachines__Quote__r.Name in: sQuoteName];
        for(BigMachines__Quote_Product__c bq: lstBMQP){
            wrapCustomerPurchaseOrderLI objwrapCustomerPurchaseOrderLI = new wrapCustomerPurchaseOrderLI();
            objwrapCustomerPurchaseOrderLI.isCPOLIselected = false;
            objwrapCustomerPurchaseOrderLI.isQLIEditmode = false;
            objwrapCustomerPurchaseOrderLI.objCustPurchaseOLI.PricebookEntryId = bq.BigMachines__Product__c;
            //objwrapCustomerPurchaseOrderLI.isPOQuantityEdit = true;            
            //objwrapCustomerPurchaseOrderLI.isShiptoEdit = true;
            
            objwrapCustomerPurchaseOrderLI.objCustPurchaseOLI.Quote_Product__r = bq;
            objwrapCustomerPurchaseOrderLI.objCustPurchaseOLI.Quote_Product__c = bq.id;
            //objwrapCustomerPurchaseOrderLI.objCustPurchaseOLI.Ship_to_Addresses__c = objOrder.Ship_To_Addresses__c;
            lstwrapCustomerPurchaseOrderLI.add(objwrapCustomerPurchaseOrderLI);
        }
    }
    //Fill Shipping method values from custom setting
    public List<Selectoption> getShippingMethods(){
        List<Selectoption> lstSelectoption = new List<Selectoption>();
        List<ShippingMethodCodes__c> sMCodes = ShippingMethodCodes__c.getall().values();
        lstSelectoption.add(new SelectOption('',' -- None -- '));
        for(ShippingMethodCodes__c smc: sMCodes){
            lstSelectoption.add(new SelectOption(smc.Name,smc.SHIP_METHOD_MEANING__c));
        }
        return lstSelectoption;
    }
    public pagereference saveOrder(){
        
        PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
        Id standardPriceBookId = pb2Standard.Id;     
        objOrder.Pricebook2Id = standardPriceBookId;
        objOrder.EffectiveDate = system.today();
        //objOrder.accountid = objAccount.id;
        objOrder.Status = 'Draft';      
        if(objOrder.Quote__c == null){
            objOrder.Quote__c = objBigMachinesQuoteProduct.BigMachines__Quote__c;
        }
        database.upsert(objOrder);
      
        
        set<Id> sProdId = new set<Id>();
        set<id>  sBMQProd = new set<id>();
        //set<id>  missingPBEProds = new set<id>();
        for(wrapCustomerPurchaseOrderLI wrapLI: lstwrapCustomerPurchaseOrderLI){
            
            if(wrapLI.isCPOLIselected){
                system.debug('###########'+wrapLI.objCustPurchaseOLI.Quote_Product__c);
                
                
                system.debug('@@@@@@@@@@'+wrapLI.objCustPurchaseOLI.Quote_Product__r.BigMachines__Product__c);
                if(wrapLI.objCustPurchaseOLI.PricebookEntryId != null){
                    sProdId.add(wrapLI.objCustPurchaseOLI.PricebookEntryId);
                }else if(wrapLI.strOrderProdId != null){                
                    sProdId.add(wrapLI.strOrderProdId);
                }else if(wrapLI.objCustPurchaseOLI.Quote_Product__r.BigMachines__Product__c != null){
                    sProdId.add(wrapLI.objCustPurchaseOLI.Quote_Product__r.BigMachines__Product__c);
                }
            }
        }
       
        system.debug('###########'+sProdId);
        
        List<PricebookEntry> lstPricebookEntry  = [select id, Product2Id, UnitPrice from PricebookEntry  where Pricebook2Id =: standardPriceBookId and Product2id IN: sProdId and IsActive = true];
        Map<Id, Id> mapProPricebook = new Map<Id, Id>();
        for(PricebookEntry pe: lstPricebookEntry){
            mapProPricebook.Put(pe.Product2Id, pe.id);
        }
        system.debug('@@@@@@@@@@@@@@@@@'+mapProPricebook);
        List<orderItem> lstorderItem = new List<orderItem>();
        for(wrapCustomerPurchaseOrderLI wrapLI: lstwrapCustomerPurchaseOrderLI){
            if(wrapLI.isCPOLIselected){
                orderItem objOLI = new orderItem();
                objOLI.Orderid = objOrder.id;
                // OriginalOrderItem
               // system.debug('@@@@@@@@@@@@@@@@@'+wrapLI.objCustPurchaseOLI.PO_Quantity__c);
                objOLI.Quantity = wrapLI.objCustPurchaseOLI.Quantity;
                //objOLI.PO_Quantity__c = wrapLI.objCustPurchaseOLI.PO_Quantity__c;
                
                if(wrapLI.objCustPurchaseOLI.PricebookEntryId != null){                    
                    objOLI.PricebookEntryId = mapProPricebook.get(wrapLI.objCustPurchaseOLI.Quote_Product__r.BigMachines__Product__c);
                }else{
                    if(!mapProPricebook.isEmpty() && mapProPricebook != null ){
                        if(mapProPricebook.containskey(wrapLI.strOrderProdId)){
                            objOLI.PricebookEntryId = mapProPricebook.get(wrapLI.strOrderProdId);
                            
                        }
                    }
                }
                if(wrapLI.objCustPurchaseOLI.Quote_Product__c != null){
                    objOLI.UnitPrice = wrapLI.objCustPurchaseOLI.Quote_Product__r.BigMachines__Sales_Price__c;
                    objOLI.Quote_Product__c = wrapLI.objCustPurchaseOLI.Quote_Product__c;
                }else{
                    if(!lstPricebookEntry.isEmpty() && lstPricebookEntry != null){
                        objOLI.UnitPrice = lstPricebookEntry[0].UnitPrice;
                    }
                }
                objOLI.Ship_to_Addresses__c = wrapLI.objCustPurchaseOLI.Ship_to_Addresses__c;
                //objOLI.SQ_Number__c = wrapLI.objCustPurchaseOLI.Quote_Product__r.BigMachines__Quote__r.Name;
                objOLI.BigMachines_Quote__c = wrapLI.objCustPurchaseOLI.Quote_Product__r.BigMachines__Quote__c;
                //objOLI.BigMachines_Document_Number__c = wrapLI.objCustPurchaseOLI.Quote_Product__r.Document_Number__c;
                
                objOLI.Line_Number__c = wrapLI.objCustPurchaseOLI.Line_Number__c;
                objOLI.Request_Date__c = wrapLI.objCustPurchaseOLI.Request_Date__c;
                objOLI.Line_Number__c = wrapLI.objCustPurchaseOLI.Line_Number__c;
                objOLI.Shipping_Method_Code__c = objOrder.Shipping_Method_Code__c;
                lstorderItem.add(objOLI);
            }
        }
        if(lstorderItem.size() > 0){
            insert lstorderItem;
        }      
        if(objOrder.id != null){
            pagereference pr = new pagereference('/'+objOrder.id);
            //pr.setRedirect(true);
            return pr;
        }else{
            return null;
        }
    }
    
    //set Purchase Order Quantity on "Make Order Match Quote" checkbox check
    public void fillPOQuantity(){
        if(objOrder.Make_Order_Match_Quote__c == true){        
            for(wrapCustomerPurchaseOrderLI cpoli: lstwrapCustomerPurchaseOrderLI){
                cpoli.objCustPurchaseOLI.Quantity = cpoli.objCustPurchaseOLI.Quote_Product__r.BigMachines__Quantity__c;
                cpoli.objCustPurchaseOLI.Ship_to_Addresses__c = objOrder.Ship_To_Addresses__c;
                cpoli.isPOQuantityEdit = false;
                cpoli.isCPOLIselected = true;
            }
        }else{
            for(wrapCustomerPurchaseOrderLI cpoli: lstwrapCustomerPurchaseOrderLI){
                cpoli.objCustPurchaseOLI.Quantity = null;
                //cpoli.isPOQuantityEdit = true;
                cpoli.objCustPurchaseOLI.Ship_to_Addresses__c = null;
                cpoli.isCPOLIselected = false;
            }
        }    
    }
    public Integer intselectedRow {get; set;}
    //Edit selected Line Item row
    public void EditselectedRow(){
        integer intRowno = 0;
        intselectedRow = 0;
        string strRowno = apexpages.currentpage().getparameters().get('rowid');
        system.debug('########'+strRowno);
        if(strRowno != null && lstwrapCustomerPurchaseOrderLI.size() > 0){
            intRowno = integer.valueOf(strRowno);            
            lstwrapCustomerPurchaseOrderLI[intRowno-1].isQLIEditmode = lstwrapCustomerPurchaseOrderLI[intRowno-1].isCPOLIselected;
            if(lstwrapCustomerPurchaseOrderLI[intRowno-1].isCPOLIselected == true){
                intselectedRow += 1;
                lstwrapCustomerPurchaseOrderLI[intRowno-1].objCustPurchaseOLI.Ship_to_Addresses__c = objOrder.Ship_To_Addresses__c;
                lstwrapCustomerPurchaseOrderLI[intRowno-1].strShipToAddress = strselShipToAddress;
            }else{
                lstwrapCustomerPurchaseOrderLI[intRowno-1].objCustPurchaseOLI.Ship_to_Addresses__c = null;
                lstwrapCustomerPurchaseOrderLI[intRowno-1].objCustPurchaseOLI.Quantity = null;
                lstwrapCustomerPurchaseOrderLI[intRowno-1].objCustPurchaseOLI.Request_Date__c = null;
                lstwrapCustomerPurchaseOrderLI[intRowno-1].isShiptoEdit = false;
            }
            //lstwrapCustomerPurchaseOrderLI[intRowno-1].isQLIEditmode = true;
            
        }
    }
    
    
    public void addNewRowLI(){
        isMakeorderdisable = true;
        if(lstwrapCustomerPurchaseOrderLI.size() > 0){
            for(wrapCustomerPurchaseOrderLI wrCPOLI: lstwrapCustomerPurchaseOrderLI){
                if(wrCPOLI.isCPOLIselected == false){
                    wrCPOLI.isQLIEditmode = false;
                    wrCPOLI.isShiptoEdit = false;
                }
            }
            /*if(lstwrapCustomerPurchaseOrderLI[lstwrapCustomerPurchaseOrderLI.size() -1].isPartSelect != null && lstwrapCustomerPurchaseOrderLI[lstwrapCustomerPurchaseOrderLI.size() -1].isPartSelect){
                lstwrapCustomerPurchaseOrderLI[lstwrapCustomerPurchaseOrderLI.size() -1].isCPOLIselected = true;
            }*/
        }
        
        wrapCustomerPurchaseOrderLI objwrapCustomerPurchaseOrderLI = new wrapCustomerPurchaseOrderLI();
        objwrapCustomerPurchaseOrderLI.isCPOLIselected = true;
        objwrapCustomerPurchaseOrderLI.isQLIEditmode = true;
        objwrapCustomerPurchaseOrderLI.isShiptoEdit = true;
        objwrapCustomerPurchaseOrderLI.isPartSelect = true;
        objwrapCustomerPurchaseOrderLI.objCustPurchaseOLI.Ship_to_Addresses__c = objOrder.Ship_To_Addresses__c;
        objwrapCustomerPurchaseOrderLI.strShipToAddress = strselShipToAddress;
        lstwrapCustomerPurchaseOrderLI.add(objwrapCustomerPurchaseOrderLI);
        
    }
    
    //Order Products
    public class wrapCustomerPurchaseOrderLI {
        public orderitem objCustPurchaseOLI {get; set;}
        public string strPartNumber {get; set;}
        public string strShipToAddress {get; set;}
        public boolean isCPOLIselected {get; set;}
        public boolean isQLIEditmode {get; set;}
        public boolean isShiptoEdit {get; set;}
        public boolean isPOQuantityEdit {get; set;}
        public boolean isReqDateEdit {get; set;}
        public boolean isPartSelect{get; set;}
        public boolean isGeneralSQsel {get; set;}
        public string strOrderProdId {get; set;}
        public wrapCustomerPurchaseOrderLI(){
            objCustPurchaseOLI = new orderitem();
        }
    }
}