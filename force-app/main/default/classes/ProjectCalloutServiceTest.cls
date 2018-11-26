@isTest(SeeAllData=false)
private class ProjectCalloutServiceTest {
  //Implement mock callout tests here
  private static Account a;
  private static Opportunity o;
  
  private testMethod  static void  ProjectServiceCalloutTest1(){
  
      
      setData();
      Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock ());
      Test.startTest();
          o.stagename = 'Closed Won';
          update o;
      Test.stopTest();
  
  }//ProjectServiceCalloutTest1
  
  private testMethod static void ProjectServiceCalloutTest2(){
  
      
      setData();
      Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
      Test.startTest();
          o.stagename = 'Closed Won';
          update o;
      Test.stopTest();
  
  }//ProjectServiceCalloutTest2
  
  private static void setData(){
      
      ServiceTokens__c oSetting = new ServiceTokens__c();
      oSetting.Name = 'ProjectServiceToken';
      oSetting.Token__c = 'Token__c';
      insert oSetting;
      
      Date closeDate = Date.today().addDays(15);
      a = new Account(Name='Test Account');
      insert a;
      
      o = new Opportunity(Type='New Project', closeDate =closeDate , StageName='Prospecting', name='Opportunity 1');
      o.AccountId = a.id;
      o.Amount = 10000;
      insert o;
      
  
  }
  
}