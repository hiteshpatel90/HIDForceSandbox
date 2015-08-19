@isTest
private class surveyControllerTest {
	static testMethod void testFailures(){
		surveyController s = new surveyController();
		surveyClass surveyClass = new surveyClass();
		
		Boolean bolEmptyList = surveyClass.bolRequired(new list<String>());
		system.assert(!bolEmptyList);
		
		s.setIntCurrentPage(3);
		
		String strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey1');
		
		s.strSatisfied = null;
		
		strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey1');
		
		s.setIntCurrentPage(2);
		strNextPage = s.page3().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey2');
		
		s.setIntCurrentPage(3);
		strNextPage = s.submit().getUrl();
		system.assertEquals(strNextPage,'/apex/techsupportsurvey3');
	}
    static testMethod void surveyControllerTest() {
	    String strFourValues = 'Excellent';
	    String strSixValues = 'Excellent';
	    String strTwoValues = 'Yes';
	    list<String> lstFiveValues = new list<String>{'My original problem is still present'};
	    String strFreeText = 'The evil is always and everywhere!';
	    String strRepUnderstandingProblem = 'The representative fully understood my issue';
	    String strRepCapability = 'That the representative had the knowledge required to help me with this problem';
	    String strRepUnderstandingSignificance = 'The representative fully understood the importance of the problem';
	    Integer intCurrentPage = 1;
	    
    	Case c = new Case();
		insert(c);
		
		surveyController s = new surveyController();
		
		PageReference p = Page.TechSupportSurvey1;
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
		s.strHelpfulness = strSixValues;
		s.strQualityAdvice = strSixValues;		
		s.strProfessionalism = strSixValues;
		s.strOverallQuality = strSixValues;
		s.strSatisfied = strTwoValues;
		
		system.assertEquals(s.strOverallImpression,strFourValues);
		system.assertEquals(s.strEaseContacting,strSixValues);
		system.assertEquals(s.strHelpfulness,strSixValues);
		system.assertEquals(s.strQualityAdvice,strSixValues);
		system.assertEquals(s.strProfessionalism,strSixValues);
		system.assertEquals(s.strOverallQuality,strSixValues);
		system.assertEquals(s.strSatisfied,strTwoValues);
		
		String strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey3');

		strNextPage = s.page1().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey1');
		
		strTwoValues = 'No';
		s.strSatisfied = strTwoValues;
		
		strNextPage = s.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey2');
		
		s.getFiveValues();
		
		s.setStrWhyNotSatisfied(lstFiveValues);
		s.strOtherFactors = strFreeText;
		
		system.assertEquals(s.getStrWhyNotSatisfied(),lstFiveValues);
		system.assertEquals(s.strOtherFactors,strFreeText);
		
		strNextPage = s.page3().getUrl();
		system.assertEquals(strNextPage, '/apex/techsupportsurvey3');
		
		s.getRepUnderstandingProblemValues();
		s.strRepUnderstandingProblem = strRepUnderstandingProblem;
		
		system.assertEquals(s.strRepUnderstandingProblem,strRepUnderstandingProblem);
		
		s.strAdditionalComments = strFreeText;
		
		system.assertEquals(s.strAdditionalComments,strFreeText);
		
		strNextPage = s.submit().getUrl();
		system.assertEquals(strNextPage, 'http://www.hidglobal.com/main/exit-survey.html');
    }
}