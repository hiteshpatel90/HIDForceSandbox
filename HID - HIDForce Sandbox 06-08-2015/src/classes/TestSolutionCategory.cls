@isTest
private class TestSolutionCategory
{
	static testMethod void testSolutionCategory()
	{
       PageReference pageRef = Page.SolutionCategory;
       Test.setCurrentPage(pageRef);
       Test.startTest();
       		SolutionCategoryController categoryController = new SolutionCategoryController();
	   Test.stopTest();
		
       System.assertNotEquals(null, categoryController.categories);	
    }
}