@isTest
private class BillingCalloutServiceTest {
  //Implement mock callout tests here
    private static Account a;
    private static Opportunity o;
    private static Project__c p  ;
    
    
    private testMethod static void BillingCalloutSvcTest1(){
        
        setData();
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock() );
        Test.startTest();
        p.status__C = 'Billable';
        update p;
        Test.stopTest();
    
    }//BillingCalloutSvcTest1


    private testMethod static void BillingCalloutSvcTest2(){
        
        setData();
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMockFailure() );
        Test.startTest();
        p.status__C = 'Billable';
        update p;
        Test.stopTest();
    
    }//BillingCalloutSvcTest2
    
        
    private static void setData(){
      
      ServiceTokens__c oSetting = new ServiceTokens__c();
      oSetting.Name = 'ProjectServiceToken';
      oSetting.Token__c = 'Token__c';
      insert oSetting;
      
      ServiceCredentials__c objSvcParams  = new ServiceCredentials__c();
      objSvcParams.Name = 'BillingServiceCredential';
      objSvcParams.Username__c = 'testuser';
      objSvcParams.Password__c = 'testpwd';
      insert   objSvcParams  ;
      
      Date closeDate = Date.today().addDays(15);
      a = new Account(Name='Test Account');
      insert a;
      
      o = new Opportunity(Type='New Project', closeDate =closeDate , StageName='Prospecting', name='Opportunity 1');
      o.AccountId = a.id;
      o.Amount = 10000;
      insert o;
      
       p = new Project__c();
       p.Opportunity__c = o.id;
       p.Status__c = 'Running';
       p.Billable_Amount__c = 10000.00;
       p.ProjectRef__c = o.id;
       P.Name = 'Project-12345';
       p.Start_date__c = Date.today();
       p.End_date__c = Date.today().addDays(30);
       
       insert p;
  
  }//setData
  
  
  
  
  
  
}//BillingCalloutServiceTest