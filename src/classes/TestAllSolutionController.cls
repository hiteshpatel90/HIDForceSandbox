@isTest
private class TestAllSolutionController
{
	private static String SOLUTION_NAME = 'My Test Solutions';
	private static String ID = 'id';
	
	private static Integer SIZE = 2;
	
	private static CategoryNode cNode = [SELECT Id FROM CategoryNode limit 1];
	private static List<Id> solutionIds = new List<Id>();
	private static List<Solution> solutions;
	
	private static Id techSupportRecordTypeId;
	
	static void setup()
	{
       List<Id> categoryNodeIds = new List<Id>();
       categoryNodeIds.add(cNode.Id);
       categoryNodeIds.add(cNode.Id);
       
       techSupportRecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Solution' AND DeveloperName = :AllSolutionsController.TECH_SUPPORT_DEVELOPER_NAME LIMIT 1][0].Id;
       
       solutions = TestingUtils.createSolutions(SOLUTION_NAME, SIZE, techSupportRecordTypeId, true);
       for(Solution theSolution : solutions)
       {
       		solutionIds.add(theSolution.Id);
       }
       
	   List<CategoryData> cData = TestingUtils.createCategoryData(solutionIds, categoryNodeIds, true);
	}
	
	static testMethod void testAllSolution()
	{
       setup();
       PageReference allSolutionPage = Page.AllSolutions;
       allSolutionPage.getParameters().put(ID, cNode.Id);
       Test.setCurrentPage(allSolutionPage);
       
       Test.startTest();       
       		AllSolutionsController controller = new AllSolutionsController();
	   Test.stopTest();
	   
	   System.assert(controller.solutions.size()> 0);
	   Set<Id> retrievedSolutionIds = new Set<Id>();
	   for(Solution s: controller.solutions)
	   {
	   		retrievedSolutionIds.add(s.Id);
	   }
	   System.assert(retrievedSolutionIds.containsAll(solutionIds));
    }
    
    static testMethod void testTechSupportSolutionsOnly() {
       
       setup();
       Solution nonTechSupportSolution = TestingUtils.createSolutions(SOLUTION_NAME, 1, true)[0];
       
       PageReference allSolutionPage = Page.AllSolutions;
       allSolutionPage.getParameters().put(ID, cNode.Id);
       Test.setCurrentPage(allSolutionPage);
       
       Test.startTest();       
       		AllSolutionsController controller = new AllSolutionsController();
	   Test.stopTest();
	   
	   Set<Id> retrievedSolutionIds = new Set<Id>();
	   for(Solution s: controller.solutions)
	   {
	   		retrievedSolutionIds.add(s.Id);
	   }
	   
	   System.assertEquals(SIZE, retrievedSolutionIds.size(), 'Only the solutions with the tech support record type should have been queried back');
	   
	   System.assert(!retrievedSolutionIds.contains(nonTechSupportSolution.Id));
    }
}