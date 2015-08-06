@isTest
private class TestCaseFileAttach
{
	
	private static String BODYTEXT = 'This is an attachment.';
	private static String ATTACHMENTNAME = 'Secret File';
	private static String UNIQUETIMESTAMP = '98765432873';
	private static integer SIZE = 1;
	private static final String ORIGIN = 'Web Form: Tech Support';
	private static final String JAPLANG = 'jp';
	private static final String ENGLANG = 'en';
	private static FileAttachmentLabels__c japaneseLang;
	private static FileAttachmentLabels__c englishLang;
	
	public static Map<String,FileAttachmentLabels__c> fileAttachmentsLabel;
	
	static void setupLanguageCustomSetting()
	{
	   delete [SELECT Id FROM FileAttachmentLabels__c];
       
       japaneseLang = new FileAttachmentLabels__c();
       japaneseLang.UploadAttachment__c = 'Japanese Upload an Attachment';
       japaneseLang.AttachFile__c = 'Japanese Attach a File'; 
       japaneseLang.UploadSuccess__c = 'Japanese File uploaded successfully.'; 
       japaneseLang.FileSelect__c = 'Japanese Select a file';
       japaneseLang.Name = JAPLANG; 
       
       englishLang = new FileAttachmentLabels__c();
       englishLang.UploadAttachment__c = 'Upload an Attachment';
       englishLang.AttachFile__c = 'Attach a File'; 
       englishLang.UploadSuccess__c = 'File uploaded successfully.'; 
       englishLang.FileSelect__c = 'Select a file';
       englishLang.Name = ENGLANG; 
       
       insert new List<FileAttachmentLabels__c>{japaneseLang , englishLang};
	   
	   
	
	}
	static testMethod void testCreateCase()
	{
		//creating blank case
		Case blankCaseWithAttachment = TestingUtils.createCases(SIZE, false)[0];
		blankCaseWithAttachment.UniqueTimeStampId__c = UNIQUETIMESTAMP;
		insert blankCaseWithAttachment; 
		
		//creating attachment to blank case
		Blob attachmentBody = Blob.valueof(BODYTEXT);
		Attachment attachment = TestingUtils.createAttachments(attachmentBody, ATTACHMENTNAME, blankCaseWithAttachment.Id, SIZE, true)[0];
	    
		//create web2Case
		Case webToCase = TestingUtils.createCases(SIZE, false)[0];
		webToCase.webToCaseUniqueTimeStamp__c = UNIQUETIMESTAMP;
		
		Test.startTest();
			insert webToCase;			
		Test.stopTest();
		
		List<Attachment> attachments = [SELECT Id,Name FROM Attachment WHERE parentId = : webToCase.Id];
		System.assertEquals(1,attachments.size());
		System.assertEquals(ATTACHMENTNAME,attachments[0].Name);
		
		
		List<Case> deletedCase = [SELECT Id FROM Case WHERE Id = : blankCaseWithAttachment.Id];
		System.assertEquals(0,deletedCase.size());//This should be deleted.
		
		List<Attachment> deletedAttachment = [SELECT Id FROM Attachment WHERE parentId = : blankCaseWithAttachment.Id];
		System.assertEquals(0,deletedAttachment.size());//This attachment should be deleted.
	}
	
	static testMethod void testCaseCreationFromUI()
	{
      
       
       PageReference attachmentUploadPage = Page.AttachmentUpload;
       attachmentUploadPage.getParameters().put('uid', UNIQUETIMESTAMP);
       Test.setCurrentPage(attachmentUploadPage);
       String myString = BODYTEXT;
	   Blob attachmentBody = Blob.valueof(myString);
	   
       //Instantiate and construct the controller class.   
       Test.startTest();
       		AttachmentUploadController  controller = new AttachmentUploadController();
       		controller.attachment.Body = attachmentBody;
       		controller.attachment.Name = ATTACHMENTNAME;
       		controller.upload();
       Test.stopTest();
       List<Case> blankInsertedCase = [SELECT Id FROM Case WHERE UniqueTimeStampId__c = :UNIQUETIMESTAMP];
       System.assertEquals(1,blankInsertedCase.size());
       
       List<Attachment> insertedAttachment = [Select Id FROM Attachment WHERE parentId = :blankInsertedCase[0].Id];
       System.assertEquals(1,insertedAttachment.size());
		
	}
	
	static testMethod void testValidLanguageTranslation()
	{
       
       setupLanguageCustomSetting();
       PageReference attachmentUploadPage = Page.AttachmentUpload;
       attachmentUploadPage.getParameters().put('lang', JAPLANG);
       Test.setCurrentPage(attachmentUploadPage);
	   
	   AttachmentUploadController  controller; 
       
       Test.startTest();
       		controller = new AttachmentUploadController();
       Test.stopTest();
       System.assertNotEquals(null,controller.mLabel);
       System.assertEquals(japaneseLang.UploadAttachment__c,controller.mLabel.uploadLabel);
       System.assertEquals(japaneseLang.AttachFile__c,controller.mLabel.attachFileLabel);
       System.assertEquals(japaneseLang.UploadSuccess__c,controller.mLabel.uploadSuccessLabel);
       System.assertEquals(japaneseLang.FileSelect__c,controller.mLabel.fileSelectLabel);
		
	}
	
	static testMethod void testInvalidLanguageTranslation()
	{
       
       
       setupLanguageCustomSetting();
       PageReference attachmentUploadPage = Page.AttachmentUpload;
       attachmentUploadPage.getParameters().put('lang', 'yte'); //No language defined in custom setting.
       Test.setCurrentPage(attachmentUploadPage);
	   
	   AttachmentUploadController  controller; 
       
       Test.startTest();
       		controller = new AttachmentUploadController();
       Test.stopTest();
       System.assertNotEquals(null,controller.mLabel);
       System.assertEquals(englishLang.UploadAttachment__c,controller.mLabel.uploadLabel);
       System.assertEquals(englishLang.AttachFile__c,controller.mLabel.attachFileLabel);
       System.assertEquals(englishLang.UploadSuccess__c,controller.mLabel.uploadSuccessLabel);
       System.assertEquals(englishLang.FileSelect__c,controller.mLabel.fileSelectLabel);
		
	}
}