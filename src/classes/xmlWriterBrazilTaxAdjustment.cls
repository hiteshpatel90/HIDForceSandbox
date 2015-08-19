public class xmlWriterBrazilTaxAdjustment {
    private static string strSessionId = '';
    private static final String STR_URI1 = 'http://schemas.xmlsoap.org/soap/envelope/';
    private static final String STR_URI2 = 'urn:soap.bigmachines.com';
    private static final String STR_URI3 = 'https://testhid.bigmachines.com/bmfsweb/testhid/schema/v1_0/security/Security.xsd';
    private static final String STR_URI4 = 'https://testhid.bigmachines.com/v1_0/receiver';
    private static final String STR_URI5 = 'https://testhid.bigmachines.com/bmfsweb/testhid/schema/v1_0/datatables/BrazilTaxAdjustment.xsd';
    
    @future(callout=true)
    public static void sendXML(String action){
        String s = '';
        if(strSessionId == ''){
            XmlStreamReader r = new XmlStreamReader(getHTTP(getLoginXml()).getBody());
            while(r.hasNext()){
                if ((r.getEventType() == XmlTag.START_ELEMENT) && (r.getLocalName() == 'sessionId')){
                    r.next();
                    if(r.getEventType() == XmlTag.CHARACTERS){
                        strSessionId = r.getText();
                    }
                }
                r.next();
            }
        }
        if(action == 'add'){
            s = s + getHTTP(getDeleteXML()).getBody();
            s = s + getHTTP(getAddXML()).getBody();
            s = s + getHTTP(getDeployXML()).getBody();
        }else if(action == 'delete'){
            s = getHTTP(getDeleteXML()).getBody();
        }
    }
    
    public static HttpResponse getHTTP(String body){
        Http h = new Http();
        HttpRequest rq = new HttpRequest();
        rq.setEndpoint(STR_URI4);
        rq.setMethod('GET');
        rq.setBody(body);
        HttpResponse re = h.send(rq);
        return re;
    }
    
    public static String getLoginXml(){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument('UTF-8', '1.0');
        w.writeStartElement('soapenv','Envelope',STR_URI1);
        w.writeNamespace('soapenv',STR_URI1);
        w.writeStartElement('soapenv','Header','');
        w.writeStartElement('bm','category',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeCharacters('Security');
        w.writeEndElement();
        w.writeStartElement('bm','xsdInfo',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeStartElement('bm','schemaLocation',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeCharacters(STR_URI3);
        w.writeEndElement();
        w.writeEndElement();
        w.writeEndElement();
        w.writeStartElement('soapenv','Body','');
        w.writeStartElement('bm','login',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeStartElement('bm','userInfo','');
        w.writeStartElement('bm','username','');
        w.writeCharacters('superuser');
        w.writeEndElement();
        w.writeStartElement('bm','password','');
        w.writeCharacters('h^J2^12y^3');
        w.writeEndDocument();
        String strXML = w.getXmlString();
        w.close();
        return strXML;
    }
    
    public static String getAddXML(){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument('UTF-8', '1.0');
        w.writeStartElement('soapenv','Envelope',STR_URI1);
        w.writeNamespace('soapenv',STR_URI1);
        
        w.writeCharacters('@@TABLE_HEADER@@');
        
        w.writeStartElement('soapenv','Body','');
        w.writeStartElement('bm','add',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeStartElement('bm','DataTables',STR_URI2);
        w.writeAttribute('bm',STR_URI2,'table_name','BrazilTaxAdjustment');
        
        for(BrazilTaxAdjustment__c b : BrazilTaxAdjustment__c.getAll().values()){
            w.writeStartElement('bm','each_record','');
            w.writeStartElement('bm','PriceCode','');
            w.writeCharacters(b.Price_Code__c);
            w.writeEndElement();
            w.writeStartElement('bm','AdjustmentFactor','');
            w.writeCharacters(String.valueOf(b.Adjustment_Factor__c.setScale(6)));
            w.writeEndElement();
        }
        
        w.writeEndDocument();
        
        String strXML = w.getXmlString().replace('@@TABLE_HEADER@@',getTableHeader());
        w.close();
        return strXML;
    }
    
    public static String getDeleteXML(){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument('UTF-8', '1.0');
        w.writeStartElement('soapenv','Envelope',STR_URI1);
        w.writeNamespace('soapenv',STR_URI1);
        
        w.writeCharacters('@@TABLE_HEADER@@');
        
        w.writeStartElement('soapenv','Body','');
        w.writeStartElement('bm','delete',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeStartElement('bm','DataTables',STR_URI2);
        w.writeAttribute('bm',STR_URI2,'table_name','BrazilTaxAdjustment');
        w.writeStartElement('bm','criteria','');
        w.writeStartElement('bm','field','');
        w.writeCharacters('date_added');
        w.writeEndElement();
        w.writeStartElement('bm','value','');
        w.writeCharacters(datetime.now().format('yyyy-MM-dd kk:mm:ss'));        
        w.writeEndElement();
        w.writeStartElement('bm','comparator','');
        w.writeCharacters('<');
        w.writeEndDocument();
        
        String strXML = w.getXmlString().replace('@@TABLE_HEADER@@',getTableHeader());
        w.close();
        return strXML;
    }
    
    public static String getDeployXML(){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument('UTF-8', '1.0');
        w.writeStartElement('soapenv','Envelope',STR_URI1);
        w.writeNamespace('soapenv',STR_URI1);
        
        w.writeCharacters('@@TABLE_HEADER@@');
        
        w.writeStartElement('soapenv','Body','');
        w.writeStartElement('bm','deploy',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeStartElement('bm','DataTables',STR_URI2);
        w.writeAttribute('bm',STR_URI2,'table_name','BrazilTaxAdjustment');
        w.writeEndDocument();
        
        String strXML = w.getXmlString().replace('@@TABLE_HEADER@@',getTableHeader());
        w.close();
        return strXML;
    }   

    public static String getTableHeader(){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartElement('soapenv','Header','');
        w.writeStartElement('bm','userInfo',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeStartElement('bm','sessionId',STR_URI2);
        w.writeCharacters(strSessionId);
        w.writeEndElement();
        w.writeEndElement();
        w.writeStartElement('bm','category',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeCharacters('Data Tables');
        w.writeEndElement();
        w.writeStartElement('bm','xsdInfo',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeStartElement('bm','schemaLocation',STR_URI2);
        w.writeNamespace('bm',STR_URI2);
        w.writeCharacters(STR_URI5);
        w.writeEndDocument();
        String strXML = w.getXmlString();
        w.close();
        return strXML;
    }
}