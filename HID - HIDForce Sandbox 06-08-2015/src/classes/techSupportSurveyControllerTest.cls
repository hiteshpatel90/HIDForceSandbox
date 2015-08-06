@isTest
private class techSupportSurveyControllerTest {
	static testMethod void testFailures(){
		techSupportSurveyController s = new techSupportSurveyController();
		surveyClass surveyClass = new surveyClass();
		
		String strTooLong = 'This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! This text is too long! ';
		
		Boolean bolEmptyList = surveyClass.bolRequired(new list<String>());
		system.assert(!bolEmptyList);
		
		s.setIntCurrentPage(3);
		
		String strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey21');
		
		s.strSatisfied = null;
		s.strSuggestionsImprovementHIDWebsite = strTooLong;
		s.strDocumentationNotAccurate = strTooLong;
		
		strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey21');
		
		s.setIntCurrentPage(2);
		s.strOtherFactors = strTooLong;
		strNextPage = s.page3().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey22');
		
		s.setIntCurrentPage(2);
		s.strOtherFactors = '';
		s.strSatisfied = 'No';
		strNextPage = s.page3().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey22');
		
		s.setIntCurrentPage(3);
		s.strName = strTooLong;
		strNextPage = s.submit().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey23');
	}
    static testMethod void surveyControllerTest() {
	    String strFourValues = 'Excellent';
	    String strSixValues = 'Excellent';
	    String strTwoValues = 'Yes';
	    list<String> lstFiveValues = new list<String>{'My original problem is still present'};
	    String strFreeText = 'The evil is always and everywhere!';

	    Integer intCurrentPage = 1;
	    
    	Case c = new Case();
		insert(c);
		
		techSupportSurveyController s = new techSupportSurveyController();
		
		PageReference p = Page.TechSupportSurvey21;
		system.assertEquals(s.getStrCaseId(),null);
		system.assertEquals(s.strLanguage,'en');
		
		ApexPages.currentPage().getParameters().put('caseId', c.Id);
		ApexPages.currentPage().getParameters().put('lang', 'de');
		
		system.assertEquals(s.getStrCaseId(),c.Id);
		system.assertEquals(s.strLanguage,'de');

		s.setIntCurrentPage(intCurrentPage);
		s.setStrCaseId(c.Id);
		ApexPages.currentPage().getParameters().put('lang', 'en');
		
		system.assertEquals(s.getIntCurrentPage(),intCurrentPage);
		system.assertEquals(s.getStrCaseId(),c.Id);
		system.assertEquals(s.strLanguage,'en');
		
		s.getFourValues();
		s.getSixValues();
		s.getTwoValues();
		
		s.strOverallImpression = strFourValues;
		s.strEaseContacting = strSixValues;
		s.strQualityAdvice = strSixValues;		
		s.strProfessionalism = strSixValues;
		s.strPriority = strSixValues;
		s.strKeptUpdated = strSixValues;
		s.strProductQuality = strSixValues;
		s.strDocumentationQuality = strSixValues;
		s.strOpeningCase = strSixValues;
		s.strSearchingKnowledgebaseSolutions = strSixValues;
		s.strDownloads = strSixValues;
		s.strFindingPhoneNumber = strSixValues;
		s.strSuggestionsImprovementHIDWebsite = strFreeText;
		s.strDocumentationAccurate = strTwoValues;
		s.strDocumentationNotAccurate = strFreeText;
		s.strSatisfied = strTwoValues;
		
		system.assertEquals(s.strOverallImpression,strFourValues);
		system.assertEquals(s.strEaseContacting,strSixValues);
		system.assertEquals(s.strQualityAdvice,strSixValues);
		system.assertEquals(s.strProfessionalism,strSixValues);
		system.assertEquals(s.strPriority,strSixValues);
		system.assertEquals(s.strKeptUpdated,strSixValues);
		system.assertEquals(s.strProductQuality,strSixValues);
		system.assertEquals(s.strDocumentationQuality,strSixValues);
		system.assertEquals(s.strOpeningCase,strSixValues);
		system.assertEquals(s.strSearchingKnowledgebaseSolutions,strSixValues);
		system.assertEquals(s.strDownloads,strSixValues);
		system.assertEquals(s.strFindingPhoneNumber,strSixValues);
		system.assertEquals(s.strSuggestionsImprovementHIDWebsite,strFreeText);
		system.assertEquals(s.strDocumentationAccurate,strTwoValues);
		system.assertEquals(s.strDocumentationNotAccurate,strFreeText);
		system.assertEquals(s.strSatisfied,strTwoValues);
		
		String strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey23');

		strNextPage = s.page1().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey21');
		
		strTwoValues = 'No';
		s.strSatisfied = strTwoValues;
		
		strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey22');
		
		s.getFiveValues();
		
		s.setStrWhyNotSatisfied(lstFiveValues);
		s.strOtherFactors = strFreeText;
		
		system.assertEquals(s.getStrWhyNotSatisfied(),lstFiveValues);
		system.assertEquals(s.strOtherFactors,strFreeText);
		
		strNextPage = s.page3().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey23');
		
		s.strPublicComments = strTwoValues;
		s.strName = strFreeText;
		s.strAdditionalComments = strFreeText;
		
		system.assertEquals(s.strAdditionalComments,strFreeText);
		system.assertEquals(s.strPublicComments,strTwoValues);
		system.assertEquals(s.strName,strFreeText);
		
		strNextPage = s.submit().getUrl();
		system.assertEquals(strNextPage, 'http://www.hidglobal.com/main/exit-survey.html');
    }
}