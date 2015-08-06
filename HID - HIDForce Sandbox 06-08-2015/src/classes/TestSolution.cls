@isTest
private class TestSolution 
{
	private  static Solution oneSolution;
	private static String SOLUTION_NAME = 'My Test Solutions';
	private static String SOLUTION_ID = 'solution_id';
	
	static void setup()
	{
       oneSolution = TestingUtils.createSolutions(SOLUTION_NAME, 1, true)[0];
	}
	
	static testMethod void testSolution()
	{
       setup();
       PageReference solutionPage = Page.Solution;
       solutionPage.getParameters().put(SOLUTION_ID, oneSolution.Id);
       Test.setCurrentPage(solutionPage);
       Test.startTest();       
       		SolutionController controller = new SolutionController();
	   Test.stopTest();
	   System.assertNotEquals(null, controller.oneSolution);
	   System.assertEquals(SOLUTION_NAME+'0', controller.oneSolution.SolutionName);
	   
    }
}