trigger setMailMergeAddress on Lead (before insert, before update) {
    for(Lead l:trigger.new){
        
        string strAdr1To4 = '';
        
        /*if(l.Address_1__c != null) strAdr1To4 += '\n' + l.Address_1__c;
        if(l.Address_2__c != null) strAdr1To4 += '\n' + l.Address_2__c;
        if(l.Address_3__c != null) strAdr1To4 += '\n' + l.Address_3__c;
        if(l.Address_4__c != null) strAdr1To4 += '\n' + l.Address_4__c;*/
        if(l.Street != null) strAdr1To4 += '\n' + l.Street;
        strAdr1To4 += '\n';
        
        l.Mail_Merge_Address__c = '';
        
        if(l.Country == 'United States'){
            if(l.Salutation != null) l.Mail_Merge_Address__c += l.Salutation + ' ';
            if(l.Title != null) l.Mail_Merge_Address__c += l.Title + ' ';
            if(l.FirstName != null) l.Mail_Merge_Address__c += l.FirstName + ' ';
            if(l.LastName != null) l.Mail_Merge_Address__c += l.LastName;
            if(l.Company != null) l.Mail_Merge_Address__c += '\n' + l.Company;
            if(strAdr1To4 != '') l.Mail_Merge_Address__c += strAdr1To4;
            if(l.City != null) l.Mail_Merge_Address__c += l.City + ', ';
            if(l.State != null && l.State != '' && l.State != 'Outside of North America') l.Mail_Merge_Address__c += l.State + ' ';
            if(l.PostalCode != null) l.Mail_Merge_Address__c += l.PostalCode;
            if(l.Country != null) l.Mail_Merge_Address__c += '\n' + l.Country.toUpperCase();
        }else if(l.Country == 'United Kingdom'){
            if(l.Salutation != null) l.Mail_Merge_Address__c += l.Salutation + ' ';
            if(l.Title != null) l.Mail_Merge_Address__c += l.Title + ' ';
            if(l.FirstName != null) l.Mail_Merge_Address__c += l.FirstName + ' ';
            if(l.LastName != null) l.Mail_Merge_Address__c += l.LastName;
            if(l.Company != null) l.Mail_Merge_Address__c += '\n' + l.Company;
            if(strAdr1To4 != '') l.Mail_Merge_Address__c += strAdr1To4;
            if(l.City != null) l.Mail_Merge_Address__c += l.City.toUpperCase();
            if(l.PostalCode != null) l.Mail_Merge_Address__c += '\n' + l.PostalCode;
            if(l.Country != null) l.Mail_Merge_Address__c += '\n' + l.Country.toUpperCase();
        }else{
            if(l.Company != null) l.Mail_Merge_Address__c += l.Company + '\n';
            if(l.Salutation != null) l.Mail_Merge_Address__c += l.Salutation + ' ';
            if(l.Title != null) l.Mail_Merge_Address__c += l.Title + ' ';
            if(l.FirstName != null) l.Mail_Merge_Address__c += l.FirstName + ' ';
            if(l.LastName != null) l.Mail_Merge_Address__c += l.LastName;
            if(strAdr1To4 != '') l.Mail_Merge_Address__c += strAdr1To4;
            if(l.PostalCode != null) l.Mail_Merge_Address__c += l.PostalCode;
            if(l.City != null) l.Mail_Merge_Address__c += ' ' + l.City;
            if(l.Country != null) l.Mail_Merge_Address__c += '\n' + l.Country.toUpperCase();
        }
    }
}