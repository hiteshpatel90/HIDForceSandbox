public class HidPortalAuthenticationController{
    
    //------------Function to Get Key------------ 
    public string FetchKey(){
        //For future call temporary stores key
        string key = 'L4g612Uk3qWZ227bA1cL47224b72868u';
        return key;
    }
    
    public blob FetchIV()
    {
        return blob.valueOf('271Y784V8sLy31ZR');
    }
    
    //------------Get Token for Testing-----------------------
    public string urlTokenTest(){
    
        //string url = 'http://partnerportal-dev.hidglobal.com/site/token?newtoken=please';
        string url = 'http://partnerportal.hidglobal.com/site/token?newtoken=please';
        // Instantiate a new http object
        Http h = new Http();
    
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
    
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        
        //Return the body 1 or 0 from url.
        return res.getBody();
    }
    
    
    //------------Call out for Authentication Token------------         
    public string urlCallout(string token) {

        //<<<<<< Apply Token to Url >>>>>>
        //string url = 'http://partnerportal-dev.hidglobal.com/site/token?token=' + token;
        string url = 'https://partnerportal.hidglobal.com/site/token?token=' + token;
        // Instantiate a new http object
        Http h = new Http();
    
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
    
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        
        //Return the body 1 or 0 from url.
//        return '1';
        return res.getBody();
    }
    
    //------------Decrypt------------ 
    public String DecryptData(string key, string dataToDecrypt){

        // Decryption Occurs Here
        Blob cryptoKey = Blob.valueOf(key);
        
        // Generate the data to be encrypted.
        blob data = EncodingUtil.base64Decode(dataToDecrypt);
        
        // Decrypt the data
        blob decryptedData = Crypto.decrypt('AES256',cryptoKey,this.FetchIV(),data);//decryptWithManagedIV('AES256', cryptoKey, data);
        
        //Store decrypted data
        string decryptedAccount = decryptedData.tostring();
        return decryptedAccount;
        
    }
    
    //------------Encrypt------------    
    public string EncryptData(string key, string dataToEncrypt){
      
        // Encryption Key
        Blob cryptoKey = Blob.valueOf(key);
        
        // Generate the data to be encrypted.
        Blob data = Blob.valueOf(dataToEncrypt);
        
        // Decrypt the data
        blob encryptedData = Crypto.encrypt('AES256',cryptoKey,this.FetchIV(),data);//encryptWithManagedIV('AES256', cryptoKey, data);
        
        //Store decrypted data
        string encryptedAccount = EncodingUtil.base64Encode(encryptedData);
    
        return encryptedAccount;
    }
}