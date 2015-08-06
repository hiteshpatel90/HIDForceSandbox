public with sharing class SolutionController {
	
	public static String HID_CSS_URL {
		get { return SolutionCategoryController.HID_CSS_URL_STRING; }
		private set;
	}
	
	public Solution oneSolution {get; set;}
	
	private String id;
	public SolutionController() {
		
		Map<String,String> currentParams = Apexpages.currentPage().getParameters();
		
		if ( currentParams.containsKey( 'solution_id' ) )
				
			id = currentParams.get( 'solution_id' );
		
		oneSolution = [SELECT Id, Status, SolutionNumber, SolutionNote, SolutionName From Solution 
					WHERE IsPublished = true AND IsPublishedInPublicKb = true AND Id = : id];
	
	}
	
}