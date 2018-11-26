public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
     
    
     public class  APIResult{
        
        public Integer m_ReponseStatusCode {get; set;}
        public string m_ReponseStatusDesc {get; set;}        
        public string m_ResponseMessage {get; set;}
        
       
        public APIResult(){
            m_ReponseStatusCode  = 0; 
            m_ReponseStatusDesc  = 'N/A';
            m_ResponseMessage  = 'N/A';            
        }
    
    } //APIResultclass
    
    
    @InvocableMethod(label='Post Project Info to ProjectService' description='Post New Project type Opportunity to ProjectService')
    public static void PostOpportunityToPMS(List<ID> pOpportunityID){
        
        QueueablePMSCall objQCall = new QueueablePMSCall (pOpportunityID[0]);
        System.enqueueJob(objQCall );
    
    }//postOpportunityToPMS
    
    public class QueueablePMSCall implements Queueable , Database.AllowsCallouts {

         public String m_OpportunityID ;
         
         public QueueablePMSCall(string p_ID ){
             
             m_OpportunityID = p_ID;
         }
         
         public void execute(QueueableContext context) {    
         
            Opportunity obj = [select id, name, account.name, closedate, amount, StageName from opportunity where id = :m_OpportunityID];
            String strProjectJSON = generateSFCCJSON(obj);
            ProjectCalloutService.APIResult oResult = postWS(strProjectJSON );
            if (oResult.m_ReponseStatusCode  == 201){
                obj.StageName = 'Submitted Project';
            }
            else{
                obj.StageName = 'Resubmit Project' ;
            }
            update obj;
            
        }//execute
    
    }// class QueueablePMSCall 
    
     private static string generateSFCCJSON(Opportunity pObj){
    
        JSONGenerator gen = JSON.createGenerator(false);
    
        gen.writeStartObject(); //{ json start

/*"opportunityId": "00641000004EKmFAAW",
  "opportunityName": "Super-Duper Big Deal",
  "accountName": "ACME Corp, Inc.",
  "closeDate": "2016-10-30",
  "amount": 150000 */

        gen.writeStringField('opportunityId', pObj.Id);
        gen.writeStringField('opportunityName', pObj.Name);
        gen.writeStringField('accountName', pObj.Account.name);
        string strDate = String.valueOf(pObj.closedate) ;
        gen.writeStringField('closeDate', strDate );
        gen.writeNumberField('amount', pObj.amount);
 
                       
        gen.writeEndObject(); //} json end                     
        
        string strJSONVal = gen.getAsString();   
        return strJSONVal;
    }//generateSFCCJSON
    
    public static ProjectCalloutService.APIResult postWS(string strJSONBody ) {
      
          ProjectCalloutService.APIResult oResult;
        try {
          
         
          String body = strJSONBody ; 
  
          HttpRequest req = new HttpRequest();  
          ServiceTokens__c objSettings = ServiceTokens__c.getValues('ProjectServiceToken');
          req.setMethod('POST');
          req.setEndpoint('callout:ProjectService');
          req.setHeader('Content-Type','application/json');
          req.setHeader('token',objSettings.Token__c);          
          
          req.setBody(body);
          
          System.Debug('Body:' + body);
  
          Http http = new Http();
    
          HTTPResponse response = http.send(req);
      
          if (response.getStatusCode() >= 300 ) {
            // there was a problem and server responded with something other than success
            system.debug('Exception : ' + response.getStatusCode() );
              throw new MyException ('Exception : ' + response.getStatusCode() );
          }
          if (response.getStatusCode() == 201 ) {
            // there was a problem and server responded with something other than success
            system.debug('Success : ' + response.getStatusCode() );
          }
      
            System.debug('BODY: '+response.getBody());
            System.debug('STATUS:'+response.getStatus());
            System.debug('STATUS_CODE:'+response.getStatusCode());
          
            oResult = new ProjectCalloutService.APIResult();
            oResult.m_ReponseStatusCode    = response.getStatusCode(); 
            oResult.m_ReponseStatusDesc  = response.getStatus();
            oResult.m_ResponseMessage    = response.getBody(); 
 
            System.debug('oResult : ' +oResult );  
            return oResult ; //response.getBody();
          
        } catch (Exception ex) {
          System.debug('exception in the call to webservice : '+ ex.getMessage());
            oResult = new ProjectCalloutService.APIResult();
            oResult.m_ReponseStatusCode    = 0; 
            oResult.m_ReponseStatusDesc  = 'ERROR';
            oResult.m_ResponseMessage    =  ex.getMessage();
            return oResult ; 
        }
    } //post
    
}