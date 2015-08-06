public class techSupportSurveyController {
	surveyClass surveyClass = new surveyClass();
	
	Integer intCurrentPage = 1;
	public String strLanguage{
		get{return surveyClass.strLanguage(ApexPages.currentPage().getParameters().get('lang'));}
	    set;	
    }

	Id strCaseId = null;
	
    public String strOverallImpression{get;set;}
    public String strEaseContacting{get;set;}
    public String strQualityAdvice{get;set;}
    public String strProfessionalism{get;set;}
    public String strPriority{get;set;}
    public String strKeptUpdated{get;set;}
    public String strProductQuality{get;set;}
    public String strDocumentationQuality{get;set;}
    public String strOpeningCase{get;set;}
    public String strSearchingKnowledgeBaseSolutions{get;set;}
    public String strDownloads{get;set;}
    public String strFindingPhoneNumber{get;set;}
    public String strSuggestionsImprovementHIDWebsite{get;set;}
    public String strDocumentationAccurate{get;set;}
    public String strDocumentationNotAccurate{get;set;}
    public String strSatisfied{get;set;}
    
    list<String> strWhyNotSatisfied = new list<String>();
    public String strOtherFactors{get;set;}
    
    public String strPublicComments{get;set;}
    public String strName{get;set;}
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
    	return Page.TechSupportSurvey21;
    }
    public PageReference page2(){
    	list<String> lstRequired = new list<String>{
    		strOverallImpression,
    		strEaseContacting,
    		strQualityAdvice,
    		strProfessionalism,
    		strPriority,
    		strKeptUpdated,
    		strProductQuality,
    		strDocumentationQuality,
    		strOpeningCase,
    		strSearchingKnowledgeBaseSolutions,
    		strDownloads,
    		strFindingPhoneNumber,
    		strDocumentationAccurate,
    		strSatisfied
    	};
    	if(intCurrentPage == 1){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
	    	if(strSuggestionsImprovementHIDWebsite.length() > 1000){
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveySuggestionsImprovementHIDWebsite + ' ' + system.label.SurveyTextArea1000TooLong));
	    	}
	    	if(strDocumentationNotAccurate.length() > 1000){
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyDocumentationAccurateAndUseful + ' ' + system.label.SurveyTextArea1000TooLong));
	    	}
    	}
    	if(!ApexPages.hasMessages()){
	    	if(strSatisfied == 'No'){
	    		intCurrentPage = 2;
				return Page.TechSupportSurvey22;
	    	}else if(intCurrentPage == 1){
	    		intCurrentPage = 3;
	    		return Page.TechSupportSurvey23;
	    	}else{
	    		intCurrentPage = 1;
	    		return Page.TechSupportSurvey21;
	    	}
    	}else{
    		intCurrentPage = 1;
    		return Page.TechSupportSurvey21;
    	}
    }
    public PageReference page3(){
    	list<String> lstRequired = !strWhyNotSatisfied.isEmpty() ? strWhyNotSatisfied.clone() : new list<String>{strOtherFactors};
    	if(intCurrentPage == 2){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
	    	if(strOtherFactors.length() > 1000){
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyOtherFactors + ' ' + system.label.SurveyTextArea1000TooLong));
	    	}
    	}
    	if(!ApexPages.hasMessages()){
    		intCurrentPage = 3;
    		return Page.TechSupportSurvey23;
    	}else{
    		intCurrentPage = 2;
    		return Page.TechSupportSurvey22;
    	}
    }

    public PageReference submit(){
    	string strErrMsg;
    	list<String> lstRequired = new list<String>{strPublicComments};
    	if(intCurrentPage == 3){
    		if(!surveyClass.bolRequired(lstRequired)){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyFieldRequired));
    		}
	    	if(strName.length() > 255){
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyNameOrAnonymous + ' ' + system.label.SurveyText255TooLong));
	    	}/*
	    	if(strAdditionalComments.length() > 1000){
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,system.label.SurveyAdditionalComments + ' ' + system.label.SurveyTextArea1000TooLong));
	    	}*/
    	}
    	if(!ApexPages.hasMessages()){
    		Surveys__c oldSurvey = new Surveys__c();
    		
    		try{
	    		oldSurvey = [
	    			SELECT
	    				Id
	    			FROM
	    				Surveys__c
	    			WHERE
	    				Related_Case_ID__c =: strCaseId
	    			LIMIT 1
	    		];
    		}catch(exception e){
				oldSurvey = new Surveys__c();
    		}
    		
    		Surveys__c s = new Surveys__c(Id = oldSurvey.Id);
    		s.RecordTypeId = [
    			SELECT
    				Id
    			FROM
    				RecordType
    			WHERE
    				SobjectType = 'Surveys__c'
    				AND DeveloperName = 'Tech_Support_Mk_II'
    		].Id;
    		
	    	s.Related_Case_ID__c = strCaseId;
	    	s.Overall_Impression_of_Technical_Support__c = strOverallImpression;
	    	s.Ease_of_Contacting_Tech_Suppot__c = strEaseContacting;
	    	s.Quality_of_Advice__c = strQualityAdvice;
	    	s.Professionalism_of_Tech_Support_Rep__c = strProfessionalism;
	    	s.Issue_priority_accessed_correctly__c = strPriority;
	    	s.Support_Engineer_kept_me_updated__c = strKeptUpdated;
	    	s.How_would_you_rate_the_product_quality__c = strProductQuality;
	    	s.How_would_your_rate_the_product_doc__c = strDocumentationQuality;
	    	s.Opening_a_Case_Online__c = strOpeningCase;
	    	s.Searching_The_Knowledge_Base_Solutions__c = strSearchingKnowledgeBaseSolutions;
	    	s.Downloads_Drivers_etc__c = strDownloads;
	    	s.Finding_the_correct_phone_number__c = strFindingPhoneNumber;
	    	s.Suggestions_for_Website_Improvement__c = strSuggestionsImprovementHIDWebsite;
	    	s.Did_you_find_the_doc_accurate_and_useful__c = strDocumentationAccurate;
	    	s.Why_didnt_you_find_the_doc_useful__c = strDocumentationNotAccurate;
	    	s.Case_Closed_to_Customer_Satisfaction__c = strSatisfied;
	    	s.Why_Were_you__c = '';
	    	for(String w:strWhyNotSatisfied){
	    		s.Why_Were_you__c += w + ';';
	    	}
	    	s.Other_Reason_for_Dissatisfaction__c = strOtherFactors;
	    	s.I_will_allow_my_comments_to_be_used__c = strPublicComments;
	    	s.Name_or_anonymous__c = strName;
	    	s.Additional_Comments__c = strAdditionalComments;
	    	
	    	try{
	    		upsert(s);
	    	}catch(Exception e){
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An exception has occurred! A System Administrator has been notified.'));
				strErrMsg += 'ERROR: ' + 'An exception has occurred. Please contact your System Administrator quoting the following message -- '+ e.getTypeName() + ':'+e.getMessage() + ':' + e.getLineNumber() + ':' + e.getStackTraceString();
          		Apexpages.Message errorMessage1 = new Apexpages.Message(ApexPages.Severity.ERROR,strErrMsg );
         		//Apexpages.addMessage(errorMessage1);
         		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage() ;
         		String[] toAddresses = new String[] {'jackermann@hidglobal.com'};
         		mail.setToAddresses(toAddresses) ;
         		mail.setSubject('Tech Support Survey - Exception occurred');
        
         		String body = '<html lang="ja"><body>'+
                          '<br><br>'+ strErrMsg+
                          '</body></html>';
         		mail.setHtmlBody(body);
         		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	    	}
    	}
		if(!ApexPages.hasMessages()){
			return new PageReference('http://www.hidglobal.com/main/exit-survey.html');
		}else{
    		intCurrentPage = 3;
    		return Page.TechSupportSurvey23;
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
}