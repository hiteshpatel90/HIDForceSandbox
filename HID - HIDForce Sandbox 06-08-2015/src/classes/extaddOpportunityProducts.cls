public class extaddOpportunityProducts{
    public string strSelectedProd {get; set;}
    string strOppId;
    string strOppName;
    Opportunity objCP = new Opportunity();
    public extaddOpportunityProducts(Apexpages.standardController stdCon){
        strOppId = apexpages.currentpage().getparameters().get('id');
        objCP = [Select Id, Name from Opportunity Where Id = :strOppId];
        strOppName = objCP.Name;
    }
    
    public List<SelectOption> getProductMethods() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Stadard','Stadard Product')); 
        options.add(new SelectOption('Custom','Custom Product')); 
        return options; 
    }
    
    public pagereference goToNextPage(){
        if(strSelectedProd == 'Stadard'){
            pagereference pr = new pagereference('/p/opp/SelectSearch?addTo=' + strOppId + '&retURL=/' + strOppId );
            pr.setRedirect(false);
            return pr;
        }else if(strSelectedProd == 'Custom'){
            pagereference pr = new pagereference('/a2h/e?CF00Nn0000000HiWL='+strOppName+'&retURL=/' + strOppId );
            pr.setRedirect(false);
            return pr;
        }else if(strSelectedProd == null){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Please select Product type');
            ApexPages.addMessage(myMsg);
            return null;
        }else{
            return null;
        }
    }
}