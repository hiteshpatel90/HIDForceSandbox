public class retrieveLastLoginGroup{
    datetime tDate = datetime.now();
    datetime lDate = tDate.addDays(-30);
    public list<User> getSales(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true 
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c = 'Sales'
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
    public list<User> getSalesEmea(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c = 'Sales'
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            AND Region__c = 'EMEA'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
    public list<User> getCustomerService(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c = 'Customer Service'
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
    public list<User> getCustomerServiceEmea(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c = 'Customer Service'
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            AND Region__c = 'EMEA'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
    public list<User> getTechSupport(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c = 'Tech Support'
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
    public list<User> getTechSupportEmea(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c = 'Tech Support'
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            AND Region__c = 'EMEA'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
    public list<User> getMarketing(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c = 'Marketing'
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
    public list<User> getOthers(){
        return [SELECT firstname, lastname, lastlogindate
            FROM user
            WHERE isactive = true
            AND (lastlogindate < :lDate OR lastlogindate = null)
            AND Functional_Group__c NOT IN ('Admin','Customer Service','Marketing','Sales','Tech Support')
            AND (NOT lastname LIKE '%User%')
            AND (NOT lastname LIKE '%Integration%')
            AND (NOT lastname LIKE '%Test%')
            AND UserType = 'Standard'
            ORDER BY lastlogindate ASC, firstname ASC, lastname ASC];
    }
}