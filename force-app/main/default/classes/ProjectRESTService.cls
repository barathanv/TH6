@RestResource(urlMapping='/ProjectRESTService/*')
global class ProjectRESTService {
    //Implement service logic here
    
    @HttpPost
    global static String postProjectData(String ProjectRef, String ProjectName, String OpportunityId, Date StartDate,
                                         Date EndDate, Double Amount, String Status){ 
                                         
           
           Savepoint sp = Database.setSavepoint();
           try{
           
               Opportunity o = [select id, name from Opportunity where id = :OpportunityId  limit 1];
               
               Project__c oP = new Project__c();
               oP.Opportunity__c = o.Id;
               oP.ProjectRef__c = ProjectRef;
               oP.Start_Date__c = StartDate;
               oP.End_Date__c = EndDate;   
               op.Status__c = Status;
               op.Name = ProjectName;
               op.Billable_Amount__c = Amount;
                        
               system.debug(oP);
               
               upsert oP Project__c.ProjectRef__c;
               
               system.debug('oP ' + oP);
               
               o.DeliveryInstallationStatus__c = 'In Progress';
               update o;

                                         
               return 'OK' ;
               
            }catch(Exception ex){
                // Rollback to the previous null value
                Database.rollback(sp);
                return 'ERROR :' + 'ProjectRef ' + ProjectRef + ' Message: ' + ex.getMessage();
            }   
    
    }//postProjectData
    
    
}//ProjectRESTService