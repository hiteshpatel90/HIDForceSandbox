trigger setContactMailMergeAddress on Contact (before insert, before update) {
    for(Contact c:trigger.new){
        
        string strAdr1To4 = '';
        
        /*if(c.Address_1__c != null) strAdr1To4 += '\n' + c.Address_1__c;
        if(c.Address_2__c != null) strAdr1To4 += '\n' + c.Address_2__c;
        if(c.Address_3__c != null) strAdr1To4 += '\n' + c.Address_3__c;
        if(c.Address_4__c != null) strAdr1To4 += '\n' + c.Address_4__c;*/
        if(c.MailingStreet != null) strAdr1To4 += '\n' + c.MailingStreet;
        strAdr1To4 += '\n';
        
        c.Mail_Merge_Address__c = '';
        
        if(c.MailingCountry == 'United States'){
            if(c.Salutation != null) c.Mail_Merge_Address__c += c.Salutation + ' ';
            if(c.FirstName != null) c.Mail_Merge_Address__c += c.FirstName + ' ';
            if(c.LastName != null) c.Mail_Merge_Address__c += c.LastName;
            if(c.Account.Name != null) c.Mail_Merge_Address__c += '\n' + c.Account.Name;
            if(strAdr1To4 != '') c.Mail_Merge_Address__c += strAdr1To4;
            if(c.MailingCity != null) c.Mail_Merge_Address__c += c.MailingCity + ', ';
            if(c.MailingState != null && c.MailingState != '' && c.MailingState != 'Outside of North America') c.Mail_Merge_Address__c += c.MailingState + ' ';
            if(c.MailingPostalCode != null) c.Mail_Merge_Address__c += c.MailingPostalCode;
            if(c.MailingCountry != null) c.Mail_Merge_Address__c += '\n' + c.MailingCountry.toUpperCase();
        }else if(c.MailingCountry == 'United Kingdom'){
            if(c.Salutation != null) c.Mail_Merge_Address__c += c.Salutation + ' ';
            if(c.FirstName != null) c.Mail_Merge_Address__c += c.FirstName + ' ';
            if(c.LastName != null) c.Mail_Merge_Address__c += c.LastName;
            if(c.Account.Name != null) c.Mail_Merge_Address__c += '\n' + c.Account.Name;
            if(strAdr1To4 != '') c.Mail_Merge_Address__c += strAdr1To4;
            if(c.MailingCity != null) c.Mail_Merge_Address__c += c.MailingCity.toUpperCase();
            if(c.MailingPostalCode != null) c.Mail_Merge_Address__c += '\n' + c.MailingPostalCode;
            if(c.MailingCountry != null) c.Mail_Merge_Address__c += '\n' + c.MailingCountry.toUpperCase();
        }else{
            if(c.Account.Name != null) c.Mail_Merge_Address__c += c.Account.Name + '\n';
            if(c.Salutation != null) c.Mail_Merge_Address__c += c.Salutation + ' ';
            if(c.FirstName != null) c.Mail_Merge_Address__c += c.FirstName + ' ';
            if(c.LastName != null) c.Mail_Merge_Address__c += c.LastName;
            if(strAdr1To4 != '') c.Mail_Merge_Address__c += strAdr1To4;
            if(c.MailingPostalCode != null) c.Mail_Merge_Address__c += c.MailingPostalCode;
            if(c.MailingCity != null) c.Mail_Merge_Address__c += ' ' + c.MailingCity;
            if(c.MailingCountry != null) c.Mail_Merge_Address__c += '\n' + c.MailingCountry.toUpperCase();
        }
    }
}