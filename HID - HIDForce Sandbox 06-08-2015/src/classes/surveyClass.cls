public class surveyClass {
    public Boolean bolRequired(list<String> lstRequired){
    	Boolean bolRes = false;
    	if(lstRequired.isEmpty()){
    		bolRes = false;
    	}else{
	    	for(String l : lstRequired){
	    		if(l == null || l == ''){
	    			bolRes = false;
	    			break;
	    		}else{
	    			bolRes = true;
	    		}
	    	}
    	}
    	return bolRes;
    }
    
    public String strLanguage(String strLanguage){
    	if(strLanguage == null || strLanguage == ''){
    		return 'en';
    	}else{
    		return strLanguage;
    	}
    }
    
    public list<SelectOption> lstOptions(list<list<String>> lstOptions){
    	list<SelectOption> options = new list<SelectOption>();
    	for(list<String> l : lstOptions){
    		options.add(new SelectOption(l[0],l[1]));
    	}
    	return options;
    }
}