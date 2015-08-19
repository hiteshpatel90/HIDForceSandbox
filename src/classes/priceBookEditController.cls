public with sharing class priceBookEditController {
    private final Pricebook_Request__c objPriceBook;
    
    public priceBookEditController(ApexPages.StandardController s){
        if(!Test.isRunningTest()){
            s.addFields(new list<String>{
                'Id',
                'Name',
                'Owner',
                'Contact_Name__c',
                'Send_To__c',
                'Customer_Price_Book_Type__c',
                'Customer_Price_Book__c'
            });
        }
        objPriceBook = (Pricebook_Request__c)s.getRecord();
    }
    public Pricebook_Request__c getObjPriceBook(){
        return objPriceBook;
    }
    
    public PageReference updatePriceBook(){
        return null;
    }
    public PageReference customSave(){
        Boolean bolRequiredError = false;
        if(ApexPages.currentPage().getParameters().containsKey('clone')){
        	objPriceBook.Id = null;
        }
        if(objPriceBook.Contact_Name__c == null){
            bolRequiredError = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contact Name is required.'));
        }
        if(objPriceBook.Send_To__c == null){
            bolRequiredError = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Send To is required.'));
        }
        if(objPriceBook.Customer_Price_Book_Type__c == null){
            bolRequiredError = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Customer Price Book Type is required.'));
        }
        if(objPriceBook.Customer_Price_Book__c == null){
            bolRequiredError = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Customer Price Book is required.'));
        }
        if(!bolRequiredError){
            try{
                upsert objPriceBook;
                PageReference p = new PageReference('/' + objPriceBook.Id);
                return p;
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Query Error: ' + e.getMessage()));
                return null;
            }
        }else{
            return null;
        }
    }
    
    public list<SelectOption> getLstCustomerPriceBook(){
        map<String,list<String>> ap = new map<String,list<String>>();
        if(objPriceBook.Contact_Name__c != null){
            Id c = [
                SELECT
                    AccountId
                FROM
                    Contact
                WHERE
                    Id =: objPriceBook.Contact_Name__c
            ].AccountId;
            for(Account_Profile__c a : [
                SELECT
                    Business_Segment__c,
                    Pricebook_Currency__c,
                    Account__r.Region__c,
                    Account__r.BillingCountry
                FROM
                    Account_Profile__c
                WHERE
                    Account__c =: c
            ]){
                ap.put(a.Business_Segment__c,new list<String>{a.Pricebook_Currency__c, a.Account__r.Region__c, a.Account__r.BillingCountry});
            }
        }
        list<String> l = new list<String>();
        if(objPriceBook.Customer_Price_Book_Type__c == 'IAM Standard Customer Price Books'){
       	    if(ap.containsKey('Identity Assurance')){
            	if(ap.get('Identity Assurance')[0] == 'AUD'){
            		l.add('IAM IA Customer Price Book AUD');
            	}else if(ap.get('Identity Assurance')[2] == 'Brazil'){
            		l.add('IAM IA Customer Price Book USD Brazil');
            	}else if(ap.get('Identity Assurance')[0] == 'CNY'){
            		l.add('IAM IA Customer Price Book CNY');
            	}else if(ap.get('Identity Assurance')[0] == 'EUR'){
            		l.add('IAM IA Customer Price Book Euro');
            	}else if(ap.get('Identity Assurance')[0] == 'GBP'){
            		l.add('IAM IA Customer Price Book GBP');
            	}else if(ap.get('Identity Assurance')[0] == 'USD'){
            		if(ap.get('Identity Assurance')[1] == 'EMEA'){
            			l.add('IAM IA Customer Price Book USD EMEA');
            		}else{
            			l.add('IAM IA Customer Price Book USD');
            		}
            	}else if(ap.get('Identity Assurance')[0] == 'INR'){
            		l.add('IAM IA Customer Price Book INR');
            	}
            }else{
				l.add('IAM IA Customer Price Book AUD');
	            l.add('IAM IA Customer Price Book CNY');
	            l.add('IAM IA Customer Price Book Euro');
	            l.add('IAM IA Customer Price Book GBP');
	            l.add('IAM IA Customer Price Book INR');
	            l.add('IAM IA Customer Price Book USD');
	            l.add('IAM IA Customer Price Book USD Brazil');
	            l.add('IAM IA Customer Price Book USD EMEA');
            }
            if(ap.containsKey('PACS')){
                if(ap.get('PACS')[2] == 'Brazil'){
                	l.add('IAM EasyLobby Customer Price Book USD Brazil');
                	l.add('IAM Managed Services Customer Price Book USD Brazil');
                    l.add('IAM PACS Customer Price Book USD Brazil');
                }else if(ap.get('PACS')[0] == 'CNY'){
                	l.add('IAM EasyLobby Customer Price Book CNY');
                	l.add('IAM Managed Services Customer Price Book CNY');
                    l.add('IAM PACS Customer Price Book CNY');
                }else if(ap.get('PACS')[0] == 'EUR'){
                	l.add('IAM EasyLobby Customer Price Book Euro');
                	l.add('IAM Managed Services Customer Price Book Euro');
                    l.add('IAM PACS Customer Price Book Euro');
                    l.add('IAM pivCLASS Customer Price Book Euro');
                }else if(ap.get('PACS')[0] == 'GBP'){
                	l.add('IAM EasyLobby Customer Price Book GBP');
                	l.add('IAM Managed Services Customer Price Book GBP');
                    l.add('IAM PACS Customer Price Book GBP');
                    l.add('IAM pivCLASS Customer Price Book GBP');
                }else if(ap.get('PACS')[0] == 'USD'){
                	l.add('IAM EasyLobby Customer Price Book USD');
                    if(ap.get('PACS')[1] == 'EMEA'){
                    	l.add('IAM Managed Services Customer Price Book USD EMEA');
                        l.add('IAM PACS Customer Price Book USD EMEA');
                        l.add('IAM pivCLASS Customer Price Book USD');
                    }else{
                    	l.add('IAM Managed Services Customer Price Book USD');
                        l.add('IAM PACS Customer Price Book USD');
                        l.add('IAM pivCLASS Customer Price Book USD');
                    }
                }else if(ap.get('PACS')[0] == 'INR'){
                	l.add('IAM EasyLobby Customer Price Book INR');
                	l.add('IAM Managed Services Customer Price Book INR');
                    l.add('IAM PACS Customer Price Book INR');
                }
            }else{
	            l.add('IAM EasyLobby Customer Price Book CNY');
	            l.add('IAM EasyLobby Customer Price Book Euro');
	            l.add('IAM EasyLobby Customer Price Book GBP');
	            l.add('IAM EasyLobby Customer Price Book INR');
	            l.add('IAM EasyLobby Customer Price Book USD');
	            l.add('IAM EasyLobby Customer Price Book USD Brazil');
	            
	            l.add('IAM Managed Services Customer Price Book CNY');
	            l.add('IAM Managed Services Customer Price Book Euro');
	            l.add('IAM Managed Services Customer Price Book GBP');
	            l.add('IAM Managed Services Customer Price Book INR');
	            l.add('IAM Managed Services Customer Price Book USD');
	            l.add('IAM Managed Services Customer Price Book USD Brazil');
	            l.add('IAM Managed Services Customer Price Book USD EMEA');
	            
                l.add('IAM PACS Customer Price Book CNY');
                l.add('IAM PACS Customer Price Book Euro');
                l.add('IAM PACS Customer Price Book GBP');
                l.add('IAM PACS Customer Price Book INR');
                l.add('IAM PACS Customer Price Book USD');
                l.add('IAM PACS Customer Price Book USD Brazil');
                l.add('IAM PACS Customer Price Book USD EMEA');
                l.add('IAM pivCLASS Customer Price Book Euro');
                l.add('IAM pivCLASS Customer Price Book GBP');
                l.add('IAM pivCLASS Customer Price Book USD');
        	}
            if(ap.containsKey('Secure Issuance')){
                if(ap.get('Secure Issuance')[2] == 'Brazil'){
                    l.add('IAM Secure Issuance Customer Price Book USD Brazil');
                }else if(ap.get('Secure Issuance')[0] == 'CNY'){
                    l.add('IAM Secure Issuance Customer Price Book CNY');
                }else if(ap.get('Secure Issuance')[0] == 'EUR'){
                    l.add('IAM Secure Issuance Customer Price Book Euro');
                }else if(ap.get('Secure Issuance')[0] == 'GBP'){
                    l.add('IAM Secure Issuance Customer Price Book GBP');
                }else if(ap.get('Secure Issuance')[0] == 'USD'){
                    if(ap.get('Secure Issuance')[1] == 'EMEA'){
                        l.add('IAM Secure Issuance Customer Price Book USD EMEA');
                    }else{
                        l.add('IAM Secure Issuance Customer Price Book USD');
                    }
                }
            }else{
                l.add('IAM Secure Issuance Customer Price Book CNY');
                l.add('IAM Secure Issuance Customer Price Book Euro');
                l.add('IAM Secure Issuance Customer Price Book GBP');
                l.add('IAM Secure Issuance Customer Price Book USD');
                l.add('IAM Secure Issuance Customer Price Book USD EMEA');
                l.add('IAM Secure Issuance Customer Price Book USD Brazil');
            }
        }else if(objPriceBook.Customer_Price_Book_Type__c == 'IAM NAS Customer Price Books (Requires NAS NDA Contract)'){
        	if(ap.containsKey('PACS')){
        		if(ap.get('PACS')[2] == 'Brazil'){
        			l.add('IAM NAS Customer Price Book USD Brazil');
        		}else if(ap.get('PACS')[0] == 'CNY'){
        			l.add('IAM NAS Customer Price Book CNY');
        		}else if(ap.get('PACS')[0] == 'EUR'){
        			l.add('IAM NAS Customer Price Book Euro');
        		}else if(ap.get('PACS')[0] == 'GBP'){
        			l.add('IAM NAS Customer Price Book GBP');
        		}else if(ap.get('PACS')[0] == 'INR'){
        			l.add('IAM NAS Customer Price Book INR');
        		}else if(ap.get('PACS')[0] == 'USD'){
        			if(ap.get('PACS')[1] == 'EMEA'){
        				l.add('IAM NAS Customer Price Book USD EMEA');
        			}else{
        				l.add('IAM NAS Customer Price Book USD');
        			}
        		} 
        	}else{
	            l.add('IAM NAS Customer Price Book CNY');
	            l.add('IAM NAS Customer Price Book Euro');
	            l.add('IAM NAS Customer Price Book GBP');
	            l.add('IAM NAS Customer Price Book INR');
	            l.add('IAM NAS Customer Price Book USD');
	            l.add('IAM NAS Customer Price Book USD Brazil');
	            l.add('IAM NAS Customer Price Book USD EMEA');
        	}
        }else if(objPriceBook.Customer_Price_Book_Type__c == 'IAM E21 Customer Price Books (Approved Accounts ONLY)'){
        	if(ap.containsKey('PACS')){
        		if(ap.get('PACS')[0] == 'CNY'){
        			l.add('Tyco IAM PACS Customer Price Book CNY');
        		}else if(ap.get('PACS')[0] == 'EUR'){
        			l.add('Tyco IAM PACS Customer Price Book Euro');
        		}else if(ap.get('PACS')[0] == 'GBP'){
        			l.add('Tyco IAM PACS Customer Price Book GBP');
        		}else if(ap.get('PACS')[0] == 'INR'){
        			l.add('Tyco IAM PACS Customer Price Book INR');
        		}else if(ap.get('PACS')[0] == 'USD'){
        			if(ap.get('PACS')[1] == 'EMEA'){
        				l.add('Tyco IAM PACS Customer Price Book USD EMEA');
        			}else{
        				l.add('Tyco IAM PACS Customer Price Book USD');
        			}
        		}
        	}else{
	            l.add('Tyco IAM PACS Customer Price Book CNY');
	            l.add('Tyco IAM PACS Customer Price Book Euro');
	            l.add('Tyco IAM PACS Customer Price Book GBP');
	            l.add('Tyco IAM PACS Customer Price Book INR');
	            l.add('Tyco IAM PACS Customer Price Book USD');
	            l.add('Tyco IAM PACS Customer Price Book USD EMEA');
        	}
        }
        return getStrOptions(l);
    }
    
    private list<SelectOption> getStrOptions(list<String> lstOptions){
        list<SelectOption> o = new list<SelectOption>();
        for(String s : lstOptions){
            o.add(new SelectOption(s,s));
        }
        return o;
    }
}