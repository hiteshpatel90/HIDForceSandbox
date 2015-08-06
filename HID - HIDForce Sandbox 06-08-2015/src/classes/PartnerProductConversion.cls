public class PartnerProductConversion {
    // all classes related to the Lead/Partner Product conversion process should contain
    // an instance of this class

    public static final String APPROVED_STATUS = 'Approved';
    public static final String QUALIFIED_STATUS = 'Qualified';
    public static final String GENUINE_HID_TYPE = 'Genuine HID Technology';
    public static final String ADVANTAGE_PARTNER_TYPE = 'Advantage Partner';

    public static final Id genHIDRt = [SELECT Id FROM RecordType WHERE SobjectType = 'Partner_Program__c' AND Name = :GENUINE_HID_TYPE].Id;
    public static final Id advPrgRt = [SELECT Id FROM RecordType WHERE SobjectType = 'Partner_Program__c' AND Name = :ADVANTAGE_PARTNER_TYPE].Id;
    public static final Id advPrCRt = [SELECT Id FROM RecordType WHERE SobjectType = 'Partner_Program__c' AND DeveloperName = 'Advantage_Connect_Partner_Legacy'].Id;
    //public static final Id ideAssRt = [SELECT Id FROM RecordType WHERE SobjectType = 'Partner_Program__c' AND Name = 'Identity Assurance Partner'].Id;
    
    private static User guestSiteUser {get; set;}
    public static User getGuestSiteUser() {
        if (guestSiteUser == null)
            guestSiteUser = [SELECT Id FROM User WHERE IsActive=true AND Profile.Name='HIDTechnology Profile' LIMIT 1];
            
        return guestSiteUser;
    }
}