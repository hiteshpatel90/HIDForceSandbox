public class UpdatePAFERPController{
 public static boolean isPAFERPUpdateExcecution = FALSE;   
 //Set is ERP Update Checkbox for when all fully approved PAF record with an Oracle Customer Number unless any of the Price_Code contains 'Tyco' 
 public void setPAFERPUpdateCheckbox(Set<id> pafids){
       // String idStandardPAF = [select id from RecordType where Name = 'Standard PAF' and SObjectType = 'Price_Authorization_Form__c'].Id;
       List<Price_Authorization_Form__c> pafList = new List<Price_Authorization_Form__c>();
       string queryString = getqueryString() + ' where id in :pafids';
       pafList = dataBase.query(queryString);
       try{
       //for each PAF
       for(Price_Authorization_Form__c paf:pafList){
       
        //  System.debug('aaaaaaaaaa Status__c'+paf.status__c+'Regoin :'+paf.Account__r.Sub_Region__c+'Account no :'+
        //  paf.Account__r.Oracle_Customer_Number__c+'Othre :'+paf.Other__c+'final status : '+paf.ERP_Update__c);     
        //   system.debug('RecordTypeId---'+paf.RecordTypeId);
          if(paf.RecordTypeId == utilController.idStandardPAFRecordType){
          if(paf.status__c=='Approved'){
               if(isPriceCodeContainsTyco(paf) && paf.Other__c != null && paf.Other__c != ''){
                 paf.ERP_Update__c = false;
               }else{
               
               //Removed the condition to check Account's Sub_Region__c on 19-08-2013
               //if((paf.Account__r.Sub_Region__c!= null && String.isNotBlank(paf.Account__r.Sub_Region__c) 
               //         && String.isNotEmpty(paf.Account__r.Sub_Region__c))&&
                        
               if((paf.Account__r.Oracle_Customer_Number__c != null && String.isNotBlank(paf.Account__r.Oracle_Customer_Number__c) 
                        && String.isNotEmpty(paf.Account__r.Oracle_Customer_Number__c)) && (paf.Integration_Price_Codes__c != null && paf.Integration_Price_Codes__c != '')
                 ){
                     paf.ERP_Update__c =true;
                  }else if(paf.Integration_Price_Codes__c == null || paf.Integration_Price_Codes__c == ''){
                     paf.ERP_Update__c =false;
                  }
               }
            }            
          }//else{paf.ERP_Update__c =false;}
                     
        // System.debug('aaaaaaaaaaaaaaa Status'+paf.ERP_Update__c+' ID : '+paf.ID);         
        }//end for for loop
        
        if(pafList.size()>0){
            UpdatePAFERPController.isPAFERPUpdateExcecution = TRUE;
            update pafList;
        }
           
     } catch(exception e){for(Price_Authorization_Form__c paf :pafList){paf.addError(e.getMessage());}}   
         
     }//end of setERPUpdateCheckbox
   
    //Returns True if - At least 1 Price Code of PAF has value 'Tyco'
    private boolean isPriceCodeContainsTyco(Price_Authorization_Form__c paf){
    List<Schema.FieldSetMember> fields = Schema.SObjectType.Price_Authorization_Form__c.fieldSets.Fields_with_Tyco.getFields();
    boolean flag=FALSE;
  
    for(Schema.FieldSetMember f : fields) {
        if(paf.get(f.getFieldPath())=='Tyco'){
             flag=TRUE;
         }
       }
        if(flag)
          return true;
       else
          return false;   
      }
      
      public string getqueryString(){
          List<Schema.FieldSetMember> fields = Schema.SObjectType.Price_Authorization_Form__c.fieldSets.Fields_with_Tyco.getFields();        
          string soqlString = 'select ';        
          for(Schema.FieldSetMember f :fields){            
              soqlString = soqlString +f.getFieldPath() + ', ';        
          }        
          soqlString = soqlString.subString(0, soqlString.length()-2);        
          soqlString = soqlString + ', Integration_Price_Codes__c, status__c,Account__r.Sub_Region__c,Account__r.Oracle_Customer_Number__c,ERP_Update__c,Other__c, RecordTypeId from Price_Authorization_Form__c';        
          return soqlString;
      }   
  }