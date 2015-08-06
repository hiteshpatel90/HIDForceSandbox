trigger setBigMachinesQuoteProductCost on BigMachines__Quote_Product__c (after insert) {
	
	map<String,Decimal> mapProductCostConversionRates = new map<String,Decimal>();
	
	for(Product_Cost_Conversion_Rates__c c : [
		SELECT
			To_Currency__c,
			Conversion_Rate__c
		FROM Product_Cost_Conversion_Rates__c
		WHERE From_Currency__c = 'USD'
	]){
			mapProductCostConversionRates.put(c.To_Currency__c,c.Conversion_Rate__c);
	}
	
	map<Id,Decimal> mapProductCost = new map<Id,Decimal>();
	
	for(BigMachines__Quote_Product__c p : [
		SELECT
			BigMachines__Product__c,
			Cost__c
		FROM
			BigMachines__Quote_Product__c
		WHERE Id IN : trigger.newMap.keySet()
	]){
		mapProductCost.put(p.BigMachines__Product__c, p.Cost__c);
	}

	for(Product_Cost__c p : [
		SELECT
			Product__c,
			Cost__c
		FROM
			Product_Cost__c
		WHERE
			Org__c = 'MAX'
			AND Product__c IN : mapProductCost.keySet()
	]){
		mapProductCost.put(p.Product__c, p.Cost__c);
	}
	
	list<BigMachines__Quote_Product__c> lstProduct = new list<BigMachines__Quote_Product__c>([
		SELECT
			BigMachines__Product__c,
			Cost__c,
			CurrencyIsoCode
		FROM
			BigMachines__Quote_Product__c
		WHERE Id IN : trigger.newMap.keySet()
	]);
	
	for(BigMachines__Quote_Product__c p : lstProduct){
		try{
			p.Cost__c = mapProductCost.get(p.BigMachines__Product__c);
			if(p.CurrencyIsoCode != 'USD'){
				p.Cost_Quote_Currency__c = mapProductCost.get(p.BigMachines__Product__c) * mapProductCostConversionRates.get(p.CurrencyIsoCode);
			}else{
				p.Cost_Quote_Currency__c = mapProductCost.get(p.BigMachines__Product__c);
			}
		}catch(Exception e){
			
		}
	}
	
	try{
		update lstProduct;
	}catch(Exception e){
		
	}
}