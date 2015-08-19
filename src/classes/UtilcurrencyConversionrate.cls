Public class UtilcurrencyConversionrate{
    public Map<String, Decimal> currencyISOCodewithConversionrate(){
        List<CurrencyType> lstCurrencyType = [select id,ConversionRate,DecimalPlaces,IsActive,IsCorporate,IsoCode FROM CurrencyType WHERE IsActive = TRUE];
        Map<String, Decimal> mapCurrwithConversionrate = new Map<String, Decimal>();
        for(CurrencyType ct: lstCurrencyType){
            mapCurrwithConversionrate.Put(ct.IsoCode, ct.ConversionRate);
        }
        return mapCurrwithConversionrate;
    }
}