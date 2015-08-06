public class xmlTools {
    private static String strSessionId = '';
    private static final String STR_BM_INSTANCE = 'testhid';
    private static final String STR_XMLNS_SOAPENV = 'http://schemas.xmlsoap.org/soap/envelope/';
    private static final String STR_XMLNS_BM = 'urn:soap.bigmachines.com';
    private static final String STR_SCHEMA_LOCATION_SECURITY = 'https://' + STR_BM_INSTANCE + '.bigmachines.com/bmfsweb/' + STR_BM_INSTANCE + '/schema/v1_0/security/Security.xsd';
    private static final String STR_SCHEMA_LOCATION_COMMERCE = 'https://' + STR_BM_INSTANCE + '.bigmachines.com/bmfsweb/' + STR_BM_INSTANCE + '/schema/v1_0/commerce/quickstart_commerce_process.xsd';
    private static final String STR_SOAP_SERVER = 'https://' + STR_BM_INSTANCE + '.bigmachines.com/v1_0/receiver';
    
    @future(callout=true)
    public static void createOrders(set<String> setTransactionIds){
        if(strSessionId == ''){
            XmlStreamReader r = new XmlStreamReader(getHTTP(getLoginXml()).getBody());
            while(r.hasNext()){
                if ((r.getEventType() == XmlTag.START_ELEMENT) && (r.getLocalName() == 'sessionId')){
                    r.next();
                    if(r.getEventType() == XmlTag.CHARACTERS){
                        strSessionId = r.getText();
                        break;
                    }
                }
                r.next();
            }
        }
        for(String s : setTransactionIds){
        	XmlStreamReader t = new XmlStreamReader(getHTTP(getCreateOrderXml(s)).getBody());
        }
    }
    public static HttpResponse getHTTP(String body){
        Http h = new Http();
        HttpRequest rq = new HttpRequest();
        rq.setEndpoint(STR_SOAP_SERVER);
        rq.setMethod('GET');
        rq.setBody(body);
        HttpResponse re = h.send(rq);
        return re;
    }
    
    public static String getLoginXml(){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument('UTF-8','1.0');
        w.writeStartElement('soapenv','Envelope',STR_XMLNS_SOAPENV);
        w.writeNamespace('soapenv',STR_XMLNS_SOAPENV);
        w.writeStartElement('soapenv','Header','');
        w.writeStartElement('bm','category',STR_XMLNS_BM);
       	w.writeNamespace('bm',STR_XMLNS_BM);
        w.writeCharacters('Security');
        w.writeEndElement();
        w.writeStartElement('bm','xsdInfo',STR_XMLNS_BM);
        w.writeNamespace('bm',STR_XMLNS_BM);
        w.writeStartElement('bm','schemaLocation','');
        w.writeCharacters(STR_SCHEMA_LOCATION_SECURITY);
        w.writeEndElement();
        w.writeEndElement();
        w.writeEndElement();
        w.writeStartElement('soapenv','Body','');
        w.writeStartElement('bm','login',STR_XMLNS_BM);
        w.writeNamespace('bm',STR_XMLNS_BM);
        w.writeStartElement('bm','userInfo','');
        w.writeStartElement('bm','username','');
        w.writeCharacters('superuser');
        w.writeEndElement();
        w.writeStartElement('bm','password','');
        w.writeCharacters('h^J2^12y^3');
        w.writeEndDocument();
        String s = w.getXmlString();
        w.close();
        return s;
    }
    
    public static String getCreateOrderXml(String strTransactionId){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument('UTF-8','1.0');
        w.writeStartElement('soapenv','Envelope',STR_XMLNS_SOAPENV);
        w.writeNamespace('soapenv',STR_XMLNS_SOAPENV);
        w.writeStartElement('soapenv','Header','');
        w.writeStartElement('bm','userInfo',STR_XMLNS_BM);
        w.writeNameSpace('bm',STR_XMLNS_BM);
        w.writeStartElement('bm','sessionId','');
        w.writeCharacters(strSessionId);
        w.writeEndElement();
        w.writeEndElement();
        w.writeStartElement('bm','category',STR_XMLNS_BM);
        w.writeNameSpace('bm',STR_XMLNS_BM);
        w.writeCharacters('Commerce');
        w.writeEndElement();
        w.writeStartElement('bm','xsdInfo',STR_XMLNS_BM);
        w.writeNamespace('bm',STR_XMLNS_BM);
        w.writeStartElement('bm','schemaLocation','');
        w.writeCharacters(STR_SCHEMA_LOCATION_COMMERCE);
        w.writeEndElement();
        w.writeEndElement();
        w.writeEndElement();
        w.writeStartElement('soapenv','Body','');
        w.writeStartElement('bm','updateTransaction',STR_XMLNS_BM);
        w.writeNamespace('bm', STR_XMLNS_BM);
        w.writeStartElement('bm','transaction','');
        w.writeStartElement('bm','id','');
        w.writeCharacters(strTransactionId);
        w.writeEndElement();
        w.writeStartElement('bm','process_var_name','');
        w.writeCharacters('quickstart_commerce_process');
        w.writeEndElement();
        w.writeStartElement('bm','action_data','');
        w.writeStartElement('bm','action_var_name','');
        w.writeCharacters('createOrder_quote');
        w.writeEndDocument();
        String s = w.getXmlString();
        w.close();
        return s;
    }
}