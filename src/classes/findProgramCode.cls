public class findProgramCode {
    public String pcode;
    public String plevel;
    public String purl;
    public String myId;
    public String myType;
    
    public void setMyId(String str){
        myId = str;
    }
    public String getMyId(){
        return myId;
    }
    public void setMyType(String str){
        if(str == 'Genuine HID Technology'){
            myType = PartnerProductConversion.genHIDRt;
        }else if(str == 'Advantage Partner'){
            myType = PartnerProductConversion.advPrgRt;
        }else if(str == 'Advantage Connect Partner'){
            myType = PartnerProductConversion.advPrCRt;
        }
        /*
        else if(str == 'Identity Assurance Partner'){
            myType = PartnerProductConversion.ideAssRt;
        }
        */
    }
    public String getMyType(){
        return myType;
    }
    public String getPcode(){
        try{
            Partner_Program__c p = [SELECT Participation_Code__c FROM Partner_Program__c WHERE Account__c = :myId AND RecordTypeId = :myType];
            pcode = p.Participation_Code__c;
        }catch (Exception e){
            pcode = '';
        }
        return pcode;
    }
    public String getPlevel(){
        try{
            Partner_Program__c p = [SELECT Membership_Level__c FROM Partner_Program__c WHERE Account__c = :myId AND RecordTypeId = :myType];
            plevel = p.Membership_Level__c;
        }catch (Exception e){
            plevel = '';
        }
        return plevel;
    }
    public String getPurl(){
        try{
            Partner_Program__c p = [SELECT Partner_Directory_URL__c FROM Partner_Program__c WHERE Account__c = :myId AND RecordTypeId = :myType];
            purl = p.Partner_Directory_URL__c;
        }catch (Exception e){
            purl = '';
        }
        return purl;
    }
}