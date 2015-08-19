public with sharing class CaseFileAttachService
{
	public static List<Case>  getCasesToAttachFile(List<Case> cases)
	{
		List<Case> casesToFindAttachment = new List<Case>();
		for(Case c : cases)
		{
			if(c.webToCaseUniqueTimeStamp__c != '' && c.webToCaseUniqueTimeStamp__c != null)
			{
				casesToFindAttachment.add(c);
			}	
		}
		return casesToFindAttachment;
	}
	
	public static void attachFile(List<Case> cases)
	{
		Map<String,Id> uniqueIdToCaseId = new Map<String,Id>();
		 
		if(!cases.isEmpty())
		{
			for(Case c: cases)
			{
				uniqueIdToCaseId.put(c.webToCaseUniqueTimeStamp__c,c.Id);
			}
			
			Map<Id,Case> idToBlankCases = new Map<Id,Case>([SELECT Id,UniqueTimeStampId__c FROM Case WHERE UniqueTimeStampId__c IN :uniqueIdToCaseId.keySet() AND CreatedDate = LAST_90_DAYS]);
			List<Attachment> attachments = [SELECT Id,parentId,body,Name FROM Attachment WHERE parentId IN :idToBlankCases.keySet()];
			
			List<Attachment> newAttachments = new List<Attachment>();
			for(Attachment attach: attachments)
			{
				Attachment tempAttach = new Attachment();
				tempAttach.Body = attach.body;
				tempAttach.Name = attach.Name;
				tempAttach.ParentId = uniqueIdToCaseId.get((idToBlankCases.get(attach.parentId)).UniqueTimeStampId__c);
				newAttachments.add(tempAttach); 
			}
			Map<Id,Case> idToCase = new Map<Id,Case>(cases);	
		
			try
			{
				insert newAttachments;
			}
			catch (System.DmlException ex)
			{
				for (Integer i = 0; i < ex.getNumDml(); i++)
				{
					Integer objectIndex = ex.getDmlIndex(i);
					idToCase.get(newAttachments[objectIndex].ParentId).addError(ex.getDmlMessage(i)); 
				}
			}
			try
			{
				delete idToBlankCases.values(); 
			}
			catch(System.DmlException ex)
			{
				
			}
		}
		
	}
	
}