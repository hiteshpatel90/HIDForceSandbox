public class surveyController {
	surveyClass surveyClass = new surveyClass();
	
	Integer intCurrentPage = 1;
	public String strLanguage{
		get{return surveyClass.strLanguage(ApexPages.currentPage().getParameters().get('lang'));}
	    set;	
    }

	Id strCaseId = null;
	
    public String strOverallImpression{get;set;}
    public String strEaseContacting{get;set;}
    public String strHelpfulness{get;set;}
    public String strQualityAdvice{get;set;}
    public String strProfessionalism{get;set;}
    public String strOverallQuality{get;set;}
    public String strSatisfied{get;set;}
    
    list<String> strWhyNotSatisfied = new list<String>();
    public String strOtherFactors{get;set;}
    
    public String strRepUnderstandingProblem{get;set;}
    public String strAdditionalComments{get;set;}

    public Integer getIntCurrentPage(){
    	return intCurrentPage;
    }
    public void setIntCurrentPage(Integer intCurrentPage){
    	this.intCurrentPage = intCurrentPage;
    }

    public Id getStrCaseId(){
    	if(strCaseId == null){
    		return ApexPages.currentPage().getParameters().get('caseId');
    	}else{
    		return strCaseId;
    	}
    }
    public void setStrCaseId(Id strCaseId){
    	this.strCaseId = strCaseId;
    }
    
    public list<String> getStrWhyNotSatisfied(){
    	return strWhyNotSatisfied;
    }
    public void setStrWhyNotSatisfied(list<String> strWhyNotSatisfied){
    	this.strWhyNotSatisfied = strWhyNotSatisfied;
    }
           
    public PageReference page1(){
    	intCurrentPage = 1;
    	return Page.TechSupportSurvey1;
    }
    public PageReference page2(){
    	list<String> lstRequired = new list<String>{strOverallImpression,strEaseContacting,strHelpfulness,strQualityAdvice,strProfessionalism,strOverallQuality,strSatisfied};
    	if(intCurrentPage == 1){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
    	}
    	if(!ApexPages.hasMessages()){
	    	if(strSatisfied == 'No'){
	    		intCurrentPage = 2;
				return Page.TechSupportSurvey2;
	    	}else if(intCurrentPage == 1){
	    		intCurrentPage = 3;
	    		return Page.TechSupportSurvey3;
	    	}else{
	    		intCurrentPage = 1;
	    		return Page.TechSupportSurvey1;
	    	}
    	}else{
    		intCurrentPage = 1;
    		return Page.TechSupportSurvey1;
    	}
    }
    public PageReference page3(){
    	list<String> lstRequired = !strWhyNotSatisfied.isEmpty() ? strWhyNotSatisfied.clone() : new list<String>{strOtherFactors};
    	if(intCurrentPage == 2){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
    	}
    	if(!ApexPages.hasMessages()){
    		intCurrentPage = 3;
    		return Page.TechSupportSurvey3;
    	}else{
    		intCurrentPage = 2;
    		return Page.TechSupportSurvey2;
    	}
    }

    public PageReference submit(){
    	list<String> lstRequired = new list<String>{strRepUnderstandingProblem};
    	if(intCurrentPage == 3){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
    	}
    	if(!ApexPages.hasMessages()){
    		Surveys__c oldSurvey = new Surveys__c();
    		
    		try{
	    		oldSurvey = [SELECT Id FROM Surveys__c WHERE Related_Case_ID__c =: strCaseId LIMIT 1];
		    	
    		}catch(exception e){
				oldSurvey = new Surveys__c();
    		}
    		
    		Surveys__c s = new Surveys__c(Id = oldSurvey.Id);
    		s.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Surveys__c' AND Name = 'Tech Support Survey'].Id;
	    	s.Related_Case_ID__c = strCaseId;
	    	s.Overall_Impression_of_Technical_Support__c = strOverallImpression;
	    	s.Ease_of_Contacting_Tech_Suppot__c = strEaseContacting;
	    	s.Helpfulness_of_Tech_Support_Rep__c = strHelpfulness;
	    	s.Quality_of_Advice__c = strQualityAdvice;
	    	s.Professionalism_of_Tech_Support_Rep__c = strProfessionalism;
	    	s.Overall_Quality_of_Handling_the_Issue__c = strOverallQuality;
	    	s.Case_Closed_to_Customer_Satisfaction__c = strSatisfied;
	    	s.Why_Were_you__c = '';
	    	for(String w:strWhyNotSatisfied){
	    		s.Why_Were_you__c += w + ';';
	    	}
	    	s.Other_Reason_for_Dissatisfaction__c = strOtherFactors;
	    	s.Tech_Support_Rep_Understanding_of_Proble__c = strRepUnderstandingProblem;
	    	s.Additional_Comments__c = strAdditionalComments;
	    	
	    	upsert(s);
	    	   	
	    	return new PageReference('http://www.hidglobal.com/main/exit-survey.html');
    	}else{
    		intCurrentPage = 3;
    		return Page.TechSupportSurvey3;
    	}
    }
    
    public list<SelectOption> getTwoValues(){
    	return surveyClass.lstOptions(
    		new list<list<String>>{
    			new list<String>{'Yes',system.label.SurveyYes},
    			new list<String>{'No',system.label.SurveyNo}
    		}
    	);
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
    public list<SelectOption> getFiveValues(){
    	return surveyClass.lstOptions(
    		new list<list<String>>{
    			new list<String>{'My original problem is still present',system.label.SurveyProblemStillPresent},
    			new list<String>{'Only part of the problem was resolved',system.label.SurveyProblemPartResolved},
    			new list<String>{'I am waiting for a solution',system.label.SurveyWaitingForSolution},
    			new list<String>{'The solution required a work-around',system.label.SurveyWorkAround},
    			new list<String>{'I did not like the solution I was given',system.label.SurveySolutionNotLiked}
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
    public list<SelectOption> getRepUnderstandingProblemValues(){
    	return surveyClass.lstOptions(
    		new list<list<String>>{
    			new list<String>{'The representative fully understood my issue',system.label.SurveyRepFullyUnderstoodIssue},
    			new list<String>{'The representative might not have fully understood the issue',system.label.SurveyRepNotFullyUnderstoodIssue},
    			new list<String>{'The representative did not understand my issue',system.label.SurveyRepNotUnderstoodIssue},
    			new list<String>{'Not applicable - I contacted Technical Support with an inquiry, not with a problem',system.label.SurveyNotApplicableLong}
    		}
    	);
    }
}