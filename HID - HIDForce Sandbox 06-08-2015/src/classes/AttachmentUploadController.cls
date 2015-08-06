public with sharing class AttachmentUploadController {
 
  public String uniqueTimeStampId {get;set;}
  public Boolean isSuccess {get;set;}
  private final static String UNIQUEID = 'uid';
  private final static String UPLOADED = 'uploaded';
  private final static String LANG = 'lang';
    
  public static Map<String,FileAttachmentLabels__c> fileAttachmentsLabel = FileAttachmentLabels__c.getAll();
  private String language {get; set;}
  public MessageLabel mLabel {get; set;}
  
  public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }
  
  public AttachmentUploadController()
  {
  	this.language = 'en';
  	
  	Map<String,String> currentParams = Apexpages.currentPage().getParameters();
	isSuccess = false;
	if ( currentParams.containsKey( UNIQUEID ) )
	{
		this.uniqueTimeStampId = currentParams.get( UNIQUEID );
	}
	if ( currentParams.containsKey( UPLOADED ) )
	{
		this.isSuccess = (currentParams.get( UPLOADED ) == 'done') ? true:false;
	}
	if ( currentParams.containsKey( LANG ) )
	{
		language = currentParams.get(LANG);
	}
	mLabel = new MessageLabel(this.language);
  }
 
  public PageReference upload() {
 
    Case c = new Case();
    c.UniqueTimeStampId__c = uniqueTimeStampId;
    Savepoint sp = Database.setSavepoint();
    try
    {
    	insert c;
    }
    catch (DMLException e)
    {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error Creating Case'));
      return null;
    }
    attachment.ParentId = c.Id; // the record the file is attached to
 
    try
    {
      insert attachment;
    }
    catch (DMLException e)
    {
      Database.rollback(sp);
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    }
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
	Map<String,String> currentParams = Apexpages.currentPage().getParameters();
	currentParams.put('uploaded' , 'done');	
	PageReference pageRef = Page.AttachmentUpload;
	pageRef.getParameters().putAll(currentParams);
	pageRef.setRedirect(true);
		
	return pageRef;
  }
 
  public class MessageLabel
  {
  	private String language;
  	
  	MessageLabel(String lan)
  	{
  		language = lan;
		if(fileAttachmentsLabel.containsKey(language))
		{
			updateLabelFields(language);
		}
		else
		{
			updateLabelFields('en'); //defaults to english
		}
  	}
  	
  	private void updateLabelFields(String theLang)
  	{
  		uploadLabel = fileAttachmentsLabel.get(theLang).UploadAttachment__c;  
		attachFileLabel = fileAttachmentsLabel.get(theLang).AttachFile__c;
		uploadSuccessLabel = fileAttachmentsLabel.get(theLang).UploadSuccess__c; 
		fileSelectLabel = fileAttachmentsLabel.get(theLang).FileSelect__c;
		maxFileLabel = fileAttachmentsLabel.get(theLang).MaxFile__c;
  	}
  	
  	public String uploadLabel{get ; private set;}
  	public String attachFileLabel{get ; private set;}
  	public String uploadSuccessLabel{get ; private set;}
  	public String fileSelectLabel{get ; private set;}
  	public String maxFileLabel{get ; private set;}
  	
  }
}