public with sharing class TestingUtils {

	public static User SITE_USER = createUser('TestAd', 'HIDTechnology Profile', false);
	
	public static User ADMIN_USER = createUser('TestAd', 'System Administrator', false);
			
	public static User createUser(String userName, String profileName, Boolean insertUser)
    {    	   
    	   return createUsers(userName, profileName, 1, insertUser)[0];    	   	
    }
        
    public static List<User> createUsers(String userName, String profileName, Integer size, Boolean insertUsers)
    {    	       	       	   
    	   
    	   List<User>allUsers = new List<User>();
    	   
    	   String profileId;
	        try
	        {
	            profileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id;
	        }
	        catch(Exception ex)
	        {
	            System.debug(ex);
	            System.assert(false, 'No profile exists with name'+ profileName);
	        }
	        
	        for(Integer i = 0; i < size; i++)
	        {
		        User testUser = new User();
		        testUser.LastName = 'test ' + UserName + 'i';
		        testUser.Alias = UserName+i;  
		        testUser.Email = UserName+i+'@hidglobal.com';
		        testUser.Username = UserName+i+UserName+i+'@hidglobal.com';
		        testUser.CommunityNickname = 'a'+UserName+i;
		        testUser.TimeZoneSidKey = 'America/New_York';
		        testUser.LocaleSidKey = 'en_US';
		        testUser.EmailEncodingKey = 'ISO-8859-1';
		        testUser.ProfileId = profileId;
		        testUser.LanguageLocaleKey = 'en_US';
		        testUser.IsActive = true;
		        
		        allUsers.add(testUser);	        
	        }
	        
	        if(insertUsers)
	        {
		        System.RunAs(ADMIN_USER)
				{
					insert allUsers;
				}	
	        }
	        
	        return allUsers;
    	   	
    }
    
    public static List<Attachment> createAttachments(Blob body, String fileName, Id parentId , Integer size, Boolean willInsert)
	{
        List<Attachment> attachments = new List<Attachment>();
        
        for(Integer i = 0; i < size; i++)
        {
        	attachments.add(new Attachment(name = fileName,Body = body, parentId = parentId));
        }
        
        if(willInsert)
        	insert attachments;
        return attachments;
						
	}
	public static List<Case> createCases(Integer size, Boolean willInsert)
	{
        List<Case> cases = new List<Case>();
        
        for(Integer i = 0; i < size; i++)
        {
        	cases.add(new Case());
        }
        
        if(willInsert)
        	insert cases;
        
        return cases;
						
	}
	
	public static List<CategoryData> createCategoryData(List<Id> solutionIds, List<Id> categoryNodeIds , Boolean willInsert)
	{
        List<CategoryData> categoryData = new List<CategoryData>();
        
        for(Integer i = 0; i < solutionIds.size(); i++)
        {
        	CategoryData cData = new CategoryData();
        	cData.CategoryNodeId = categoryNodeIds[i];
        	cData.RelatedSobjectId = solutionIds[i];
        	categoryData.add(cData);
        }
        
        if(willInsert)
        	insert categoryData;
        
        return categoryData;
						
	}
	
	public static List<Solution> createSolutions(String name, Integer size , Boolean willInsert)
	{
        
        List<Solution> solutions = new List<Solution>();
        for(Integer i = 0; i < size; i++)
        {
        	Solution theSolution = new Solution();
        	theSolution.SolutionName = name+i;
        	theSolution.IsPublishedInPublicKb = true;
        	theSolution.IsPublished = true;
        	solutions.add(theSolution);
        }
        
                       
        if(willInsert)
        	insert solutions;
        
        return solutions;
						
	}
	
	public static List<Solution> createSolutions(String name, Integer size, Id solutionRecordTypeId, Boolean willInsert)
	{
        
        List<Solution> solutions = new List<Solution>();
        for(Integer i = 0; i < size; i++)
        {
        	Solution theSolution = new Solution();
        	theSolution.SolutionName = name+i;
        	theSolution.IsPublishedInPublicKb = true;
        	theSolution.IsPublished = true;
        	theSolution.RecordTypeId = solutionRecordTypeId;
        	solutions.add(theSolution);
        }
        
                       
        if(willInsert)
        	insert solutions;
        
        return solutions;
						
	}

}