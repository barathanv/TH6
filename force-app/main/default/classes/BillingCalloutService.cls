public class BillingCalloutService {
    
    public class ProjectStatus implements Queueable{
    
        Public List<Project__C> m_lProject; 
        public ProjectStatus(List<Project__C> lP){
            m_lProject = lP;
        }
        
        public void execute(QueueableContext context){
        
            upsert m_lProject ;
        
        }
    
    }
    
    //Implement business and callout logic methods here
    
    @Future(callout=true)        
    public static void callBillingService(List<ID> lID ){
    
        ServiceCredentials__c objSvcParams = ServiceCredentials__c.getValues('BillingServiceCredential');
        
        try{
        
            List<Project__c> lProject = [select id , Status__c, Billable_Amount__c , ProjectRef__c from Project__C where status__C = 'Billable' and id in :lID ];
        
            BillingServiceProxy.InvoicesPortSoap11  bsvcClient = new BillingServiceProxy.InvoicesPortSoap11(); 
            List<Project__c> lPUpdate = new List<Project__c>();
            for (Project__c oP : lProject ){
                BillingServiceProxy.project objProject = new BillingServiceProxy.project();
                objProject.projectid = oP.ProjectRef__c ;
                objProject.projectRef = oP.ProjectRef__c ; 
                objProject.billAmount = oP.Billable_Amount__c ;
                objProject.username = objSvcParams.Username__c; 
                objProject.password = objSvcParams.Password__c;
                
                string sRetVal = bsvcClient.billProject(objProject);
                
                if (sRetVal.equalsIgnoreCase('OK')){
                    Project__c o = new Project__c();
                    o.Id = oP.Id;
                    o.status__c = 'Billed';
                    lPUpdate.add(o); 
                }
                
                System.debug(sRetVal);
              }//for
                  if (lPUpdate.size() > 0){
                       ProjectStatus objPS = new ProjectStatus(lPUpdate);
                       System.enqueueJob(objPS);
                  }
              }catch(Exception ex){
                  system.debug(ex.getMessage());
              }
    }//callBillingService
    
    
    
    
}//BillingCalloutService