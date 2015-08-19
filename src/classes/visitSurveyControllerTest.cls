@isTest
private class visitSurveyControllerTest {
	static testMethod void testFailures(){
		visitSurveyController v = new visitSurveyController();
		
		v.setIntCurrentPage(3);
		
		String strNextPage = v.page2().getUrl();
		system.assertEquals(strNextPage,'/apex/visitsurvey1');
		
		strNextPage = v.page2().getUrl();
		system.assertEquals(strNextPage,'/apex/visitsurvey1');
		
		v.setIntCurrentPage(2);
		strNextPage = v.page3().getUrl();
		system.assertEquals(strNextPage,'/apex/visitsurvey2');
	}
	static testMethod void visitSurveyControllerTest(){
		visitSurveyController vc = new visitSurveyController();
		
		String strFourValues = 'Excellent';
	    String strSixValues = 'Excellent';
	    Integer intCurrentPage = 1;
	    
		Account a = new Account(Name = 'Don Bilbo');
		insert a;
		
		Contact c = new Contact(FirstName = 'Don', LastName = 'Bilbo', Account = a);
		insert c;
		
		Visit_Report__c v = new Visit_Report__c(Related_Account__c = a.Id);
		insert v;
		
		Contact_Junction__c cj = new Contact_Junction__c(Visit_Report__c = v.Id, Contact__c = c.Id);
		insert cj;
		
		cj = [SELECT CreatedBy.Id FROM Contact_Junction__c WHERE Id =: cj.Id LIMIT 1];
		
		PageReference p = Page.VisitSurvey1;
		system.assertEquals(vc.getStrWhoId(),null);
		system.assertEquals(vc.getStrWhatId(),null);
		system.assertEquals(vc.getStrWhoseId(),null);
		system.assertEquals(vc.strLanguage,'en');
		
		ApexPages.currentPage().getParameters().put('whoId',c.Id);
		ApexPages.currentPage().getParameters().put('whatId',v.Id);
		ApexPages.currentPage().getParameters().put('whoseId',cj.CreatedById);
		ApexPages.currentPage().getParameters().put('lang', 'en');
		
		system.assertEquals(vc.getStrWhoId(),c.Id);
		system.assertEquals(vc.getStrWhatId(),v.Id);
		system.assertEquals(vc.getStrWhoseId(),cj.CreatedById);
		system.assertEquals(vc.strLanguage,'en');
		
		vc.setIntCurrentPage(intCurrentPage);
		vc.setStrWhoId(c.Id);
		vc.setStrWhatId(v.Id);
		vc.setStrWhoseId(cj.CreatedById);
		
		system.assertEquals(vc.getIntCurrentPage(),intCurrentPage);
		system.assertEquals(vc.getStrWhoId(),c.Id);
		system.assertEquals(vc.getStrWhatId(),v.Id);
		system.assertEquals(vc.getStrWhoseId(),cj.CreatedById);
		
		vc.getFourValues();
		vc.getSixValues();
		
		vc.strOverallImpression = strFourValues;
		
		String strNextPage = vc.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey2');
		system.assertEquals(vc.getStrRenderHowBetter(),'false');
		
		strNextPage = vc.page1().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey1');
		
		strFourValues = 'Poor';
		vc.strOverallImpression = strFourValues;
		
		strNextPage = vc.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey1');
		
		vc.setStrRenderHowBetter(vc.getStrRenderHowBetter());
		system.assertEquals(vc.getStrRenderHowBetter(),'true');
		
		strNextPage = vc.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey2');
		
		vc.strUnderstandableDelivery = strSixValues;
		vc.strUnderstandingBusiness = strSixValues;
		vc.strPresentedSolution = strSixValues;
		vc.strProfessionalism = strSixValues;
		vc.strCompareOther = strSixValues;
		
		strNextPage = vc.page3().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey3');
		system.assertEquals(vc.getStrRenderFairPoorAreas(),'false');
		
		strNextPage = vc.page2().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey2');
		
		strSixValues = 'Poor';
		vc.strUnderstandableDelivery = strSixValues;
		
		strNextPage = vc.page3().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey2');
		
		vc.setStrRenderFairPoorAreas(vc.getStrRenderFairPoorAreas());
		system.assertEquals(vc.getStrRenderFairPoorAreas(),'true');
		
		strNextPage = vc.page3().getUrl();
		system.assertEquals(strNextPage, '/apex/visitsurvey3');
		
		vc.strImprovement = 'Wuff';
		
		strNextPage = vc.submit().getUrl();
		system.assertEquals(strNextPage, 'http://www.hidglobal.com/main/exit-survey.html');
	}
}