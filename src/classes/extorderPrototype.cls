public class extorderPrototype{
    public List<Order> lstOrder {get; set;}
    public extorderPrototype(apexpages.standardcontroller stdCon){
        lstOrder = [select id, OrderNumber, Status, EffectiveDate, TotalAmount from order order by createddate desc limit 1000];
    }
}