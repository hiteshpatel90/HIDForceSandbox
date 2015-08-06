public class visitSurveyController {
    surveyClass surveyClass = new surveyClass();
    
    Integer intCurrentPage = 1;
    Id strWhoId = null;
    Id strWhatId = null;
    Id strWhoseId = null;
    String strRenderHowBetter = 'false';
    String strRenderFairPoorAreas = 'false';
    
    public String strLanguage{
        get{return surveyClass.strLanguage(ApexPages.currentPage().getParameters().get('lang'));}
        set;    
    }
    
    public Integer getIntCurrentPage(){
        return intCurrentPage;
    }
    public void setIntCurrentPage(Integer intCurrentPage){
        this.intCurrentPage = intCurrentPage;
    }
    
    public Id getStrWhoId(){
      if(strWhoId == null){
        return ApexPages.currentPage().getParameters().get('whoid');
      }else{
        return strWhoId;
      }
    }
    public void setStrWhoId(Id strWhoId){
      this.strWhoId = strWhoId;
    }
    
    public String getStrWhatId(){
    	if(strWhatId == null){
        	return ApexPages.currentPage().getParameters().get('whatid');
      	}else{
       		return strWhatId;
    	}
    }
    public void setStrWhatId(String strWhatId){
      this.strWhatId = strWhatId;
    }
    
    public String getStrWhoseId(){
    	if(strWhoseId == null){
        	return ApexPages.currentPage().getParameters().get('whoseid');
      	}else{
       		return strWhoseId;
    	}
    }
    public void setStrWhoseId(String strWhoseId){
      this.strWhoseId = strWhoseId;
    }
    
    public String getStrRenderHowBetter(){
    	if(strOverallImpression == 'Fair' || strOverallImpression == 'Poor'){
    		return 'true';
    	}else{
    		return 'false';
    	}
    }
    public void setStrRenderHowBetter(String strRenderHowBetter){
    	this.strRenderHowBetter = strRenderHowBetter;
    }
    
    public String getStrRenderFairPoorAreas(){
    	if(strUnderstandableDelivery == 'Fair' || strUnderstandableDelivery == 'Poor'
    	|| strUnderstandingBusiness == 'Fair' || strUnderstandingBusiness == 'Poor'
    	|| strPresentedSolution == 'Fair' || strPresentedSolution == 'Poor'
    	|| strProfessionalism == 'Fair' || strProfessionalism == 'Poor'
    	|| strCompareOther == 'Fair' || strCompareOther == 'Poor'){
    		return 'true';
    	}else{
    		return 'false';
    	}
    }
    public void setStrRenderFairPoorAreas(String strRenderFairPoorAreas){
    	this.strRenderFairPoorAreas = strRenderFairPoorAreas;
    }
    
    public String strOverallImpression{get;set;}
    public String strHowBetter{get;set;}
    
    public String strUnderstandableDelivery{get;set;}
    public String strUnderstandingBusiness{get;set;}
    public String strPresentedSolution{get;set;}
    public String strProfessionalism{get;set;}
    public String strCompareOther{get;set;}
    public String strFairPoorHowBetter{get;set;}
    
    public String strImprovement{get;set;}
    
    public PageReference page1(){
    	intCurrentPage = 1;
    	return Page.VisitSurvey1;
    }
    
    public PageReference page2(){
    	list<String> lstRequired = new list<String>{strOverallImpression};
    	if(intCurrentPage == 1){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
    	}
    	if(!ApexPages.hasMessages()){
    		if((strOverallImpression == 'Excellent' || strOverallImpression == 'Good')
    		|| (strOverallImpression == 'Fair' || strOverallImpression == 'Poor') && strRenderHowBetter == 'true'){
    			intCurrentPage = 2;
    			return Page.VisitSurvey2;    		
    		}else{
	    		intCurrentPage = 1;
    			return Page.VisitSurvey1;
    		}
    	}else{
    		intCurrentPage = 1;
    		return Page.VisitSurvey1;
    	}
    }
    
    public PageReference page3(){
    	list<String> lstRequired = new list<String>{strUnderstandableDelivery,strUnderstandingBusiness,strPresentedSolution,strProfessionalism,strCompareOther};
    	if(intCurrentPage == 2){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
    	}
    	if(!ApexPages.hasMessages()){
	    	if((strUnderstandableDelivery != 'Fair' && strUnderstandableDelivery != 'Poor'
    		&& strUnderstandingBusiness != 'Fair' && strUnderstandingBusiness != 'Poor'
    		&& strPresentedSolution != 'Fair' && strPresentedSolution != 'Poor'
	    	&& strProfessionalism != 'Fair' && strProfessionalism != 'Poor'
    		&& strCompareOther != 'Fair' && strCompareOther != 'Poor')
    		|| ((strUnderstandableDelivery == 'Fair' || strUnderstandableDelivery == 'Poor'
	    	|| strUnderstandingBusiness == 'Fair' || strUnderstandingBusiness == 'Poor'
    		|| strPresentedSolution == 'Fair' || strPresentedSolution == 'Poor'
    		|| strProfessionalism == 'Fair' || strProfessionalism == 'Poor'
	    	|| strCompareOther == 'Fair' || strCompareOther == 'Poor')
    		&& strRenderFairPoorAreas == 'true')
    		){
	    		intCurrentPage = 3;
	    		return Page.VisitSurvey3;    		
	    	}else{
	    		intCurrentPage = 2;
	    		return Page.VisitSurvey2;
	    	}
    	}else{
    		intCurrentPage = 2;
    		return Page.VisitSurvey2;
    	}
    }
    
    public PageReference submit(){
		Surveys__c oldSurvey = new Surveys__c();
		try{
    		oldSurvey = [SELECT Id FROM Surveys__c WHERE Contact__c =: strWhoId AND Visit_Report__c =: strWhatId LIMIT 1];
	    	
		}catch(exception e){
			oldSurvey = new Surveys__c();
		}
		Surveys__c s = new Surveys__c(Id = oldSurvey.Id);
		s.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Surveys__c' AND Name = 'Visit Survey'].Id;
		s.Contact__c = strWhoId;
		s.Visit_Report__c = strWhatId;
		s.HID_Sales_Rep__c = strWhoseId;
		s.VisitOverallImpression__c = strOverallImpression;
		s.VisitHowBetter__c = strHowBetter;
		s.VisitUnderstandableDelivery__c = strUnderstandableDelivery;
		s.VisitUnderstandingBusiness__c = strUnderstandingBusiness;
		s.VisitPresentedSolution__c = strPresentedSolution;
		s.VisitProfessionalism__c = strProfessionalism;
		s.VisitCompareOther__c = strCompareOther;
		s.VisitFairPoorHowBetter__c = strFairPoorHowBetter;
		s.VisitImprovement__c = strImprovement;
		upsert(s);
    	return new PageReference('http://www.hidglobal.com/main/exit-survey.html');
    }
    
    public list<SelectOption> getFourValues(){
    	return surveyClass.lstOptions(
    		new list<list<String>>{
    			new list<String>{'Excellent',system.label.SurveyExcellent},
    			new list<String>{'Good',system.label.SurveyGood},
    			new list<String>{'Fair',system.label.SurveyFair},
    			new list<String>{'Poor',system.label.SurveyPoor}
    		}
    	);
    }
    public list<SelectOption> getSixValues(){
    	return surveyClass.lstOptions(
    		new list<list<String>>{
    			new list<String>{'Excellent',''},
    			new list<String>{'Good',''},
    			new list<String>{'Average',''},
    			new list<String>{'Fair',''},
    			new list<String>{'Poor',''},
    			new list<String>{'N/A',''}
    		}
    	);
    }
}