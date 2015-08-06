public with sharing class AllSolutionsController {
	
	public static String HID_CSS_URL {
		get { return SolutionCategoryController.HID_CSS_URL_STRING; }
		private set;
	}
	
	public List<Solution> solutions {get; set;}
	public Solution oneSolution {get; set;}
	
	public List<CategoryNode> categories {get;set;}
	
	private String id;
	public String lang {get; set;}
	
	public Boolean hasSolutions {
		get {
			return !solutions.isEmpty();
		}
	}
	
	public Boolean hasCategories {
		get {
			return !categories.isEmpty();
		}
	}
	
	public static final String TECH_SUPPORT_DEVELOPER_NAME = 'Tech_Support';
	private Id techSupportRecordTypeId;
	
	public AllSolutionsController() {
		
		lang = 'en_US';
		
		Map<String,String> currentParams = Apexpages.currentPage().getParameters();
		
		if ( currentParams.containsKey( 'id' ) )
			id = currentParams.get( 'id' );
        
        if ( currentParams.containsKey( 'lang' ) )
            lang = currentParams.get( 'lang' );
        
        		
		List<CategoryData> categoryData = [SELECT Id,  RelatedSobjectId From CategoryData 
					WHERE CategoryNodeId = :id];
		List<Id> solutionIds = new List<Id>();
		for(CategoryData cData : categoryData)
		{
			solutionIds.add(cData.RelatedSobjectId);
		}
		
		techSupportRecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Solution' AND DeveloperName = :TECH_SUPPORT_DEVELOPER_NAME LIMIT 1][0].Id;
		
		solutions = [SELECT Id, SolutionName From Solution 
					WHERE IsPublished = true 
					AND IsPublishedInPublicKb = true 
					AND SolutionLanguage = :lang 
					AND Id IN : solutionIds 
					AND RecordTypeId = :techSupportRecordTypeId];
	
		categories = [Select c.Id, c.ParentId, c.MasterLabel From CategoryNode c WHERE c.ParentId = :id];	
	}
	
}