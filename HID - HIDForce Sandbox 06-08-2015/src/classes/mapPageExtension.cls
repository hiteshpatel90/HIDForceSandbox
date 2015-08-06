public class mapPageExtension{
    public List<Account> matches{get; set;}
    public map<Id, String> mapProviderDetailPin {get; set;}
    public mapPageExtension(){
        mapProviderDetailPin = new map<Id, String>();
        string strSOQL = 'SELECT ID, Provider__r.Name ';
        for(Schema.FieldSetMember f : this.getFields()) {
            strSOQL += ', ' + f.getFieldPath();
        }
        strSOQL += ' FROM Account LIMIT 10';
        matches = database.query(strSOQL);
        for(Account acc: matches){
            string strProviderDetailPin = '';
            for(Schema.FieldSetMember f : this.getFields()) {
                if(acc.get(f.getFieldPath()) != null){
                    strProviderDetailPin += acc.get(f.getFieldPath()) + '<br/>';
                }             
            }    
            mapProviderDetailPin.Put(acc.id, strProviderDetailPin);        
        }
    }    
    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Account.FieldSets.Provider_Detail_Pin.getFields();
    }
}