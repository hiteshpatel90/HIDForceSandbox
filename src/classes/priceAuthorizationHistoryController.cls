public class priceAuthorizationHistoryController{
    Id pafId = ApexPages.CurrentPage().getParameters().get('id');
    public list<Price_Authorization_Form__History> pafHistory{get;set;}
    
    public priceAuthorizationHistoryController(ApexPages.StandardController con){
        pafHistory = new list<Price_Authorization_Form__History>();
        pafHistory = [SELECT ParentId, OldValue, NewValue, Field, CreatedById, CreatedDate 
            FROM Price_Authorization_Form__History where parentId = :pafId order by CreatedDate desc];
    }
}