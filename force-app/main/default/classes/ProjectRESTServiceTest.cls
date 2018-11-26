@isTest
public class ProjectRESTServiceTest {
  
  //Implement Apex REST service tests here
  public static Account a;
  public static Opportunity o;
  
  static testMethod void  ProjectRESTServiceTest(){

   setData();
     Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock ());
   Test.startTest();
   
      //o.stagename = 'Closed Won';
      //update o;
              
      RestRequest req = new RestRequest(); 
      RestResponse res = new RestResponse();

    req.requestURI = '/services/apexrest/ProjectRESTService';  //Request URL
    req.httpMethod = 'POST';//HTTP Request Type
    //req.requestBody = Blob.valueof(JsonMsg);
    req.addParameter('ProjectRef', 'ProjectRef001');
    req.addParameter('ProjectName', 'ProjectName001');
    req.addParameter('OpportunityId', o.id);
    req.addParameter('StartDate',  String.valueOf(Date.today()) );
    req.addParameter('EndDate', String.valueOf(Date.today().addDays(100)));
    req.addParameter('Status', 'Running');
    req.addParameter('Amount', String.valueOf(10000.00));    
    
        
    RestContext.request = req;
    RestContext.response= res;
    string sRetVal = ProjectRESTService.postProjectData('ProjectRef001','ProjectName001', (String)o.id,Date.today() ,Date.today().addDays(100), (Double) 10000.00,'Running' );
    Test.stopTest();

   }
   
    static testMethod void  ProjectRESTServiceTest2(){

   setData();
     Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock ());
   Test.startTest();
   
      //o.stagename = 'Closed Won';
      //update o;
              
      RestRequest req = new RestRequest(); 
      RestResponse res = new RestResponse();

    req.requestURI = '/services/apexrest/ProjectRESTService';  //Request URL
    req.httpMethod = 'POST';//HTTP Request Type
    //req.requestBody = Blob.valueof(JsonMsg);
    req.addParameter('ProjectRef', 'ProjectRef001');
    req.addParameter('ProjectName', 'ProjectName001');
    req.addParameter('OpportunityId', o.id);
    req.addParameter('StartDate',  String.valueOf(Date.today()) );
    req.addParameter('EndDate', String.valueOf(Date.today().addDays(100)));
    req.addParameter('Status', 'Running1');
    req.addParameter('Amount', String.valueOf(10000.00));    
    
        
    RestContext.request = req;
    RestContext.response= res;
    string sRetVal = ProjectRESTService.postProjectData('ProjectRef001','ProjectName001', (String)o.id,Date.today() ,Date.today().addDays(100), (Double) 10000.00,'Running1' );
    Test.stopTest();

   }//ProjectRESTServiceTest2
   
  
   private static void setData(){
      
     ServiceTokens__c oSetting = new ServiceTokens__c();
      oSetting.Name = 'ProjectServiceToken';
      oSetting.Token__c = 'Token__c';
      insert oSetting;
      
      Date closeDate = Date.today().addDays(15);
      a = new Account(Name='Test Account');
      insert a;
      
      o = new Opportunity(Type='New Project', closeDate =closeDate , StageName='Submitted Project', name='Opportunity 1');
      o.AccountId = a.id;
      o.Amount = 10000;
      insert o;
      
  
  }
}