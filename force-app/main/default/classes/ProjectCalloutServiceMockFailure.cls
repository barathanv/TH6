@isTest
public class ProjectCalloutServiceMockFailure  implements HttpCalloutMock {
    // implement http mock callout
     public HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        string strURL = req.getEndpoint();
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        
        string strBody = 'ERROR';
        res.setBody(strBody);
        res.setStatusCode(500);
       
        system.debug('HTTPMOCK res ' + res + ' : ' + strURL);
        return res;
    }//respond
    
}//class ProjectCalloutServiceMock