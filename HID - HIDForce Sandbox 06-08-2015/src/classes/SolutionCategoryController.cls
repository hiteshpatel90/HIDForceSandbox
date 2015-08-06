public with sharing class SolutionCategoryController {
	
	public static final String HID_CSS_URL_STRING = 'http://www.hidglobal.com/css/sales-force.css';
	
	public static String HID_CSS_URL {
		get { return SolutionCategoryController.HID_CSS_URL_STRING; }
		private set;
	}
	
	public List<CategoryNode> categories {get;set;}
	public String lang {get; set;}
	
	public static final String TECH_SUPPORT_NODE_LABEL = 'Tech Support';
	public static Id TECH_SUPPORT_MASTER_NODE_ID = [SELECT Id FROM CategoryNode WHERE MasterLabel = :TECH_SUPPORT_NODE_LABEL][0].Id;
	
	public SolutionCategoryController()
	{
		
	    lang = 'en_US';
	    Map<String,String> currentParams = Apexpages.currentPage().getParameters();
	    
	    if ( currentParams.containsKey( 'lang' ) )
	            lang = currentParams.get( 'lang' );
	    
		categories = [Select c.Id, c.ParentId, c.MasterLabel From CategoryNode c WHERE c.ParentId = :TECH_SUPPORT_MASTER_NODE_ID];	
		
	}
}