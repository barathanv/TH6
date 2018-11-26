trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here
    List<ID> lProjectID = new List<ID>();
    if (Trigger.isUpdate && Trigger.isAfter){
    
        for (Project__c p : Trigger.New){
            if (p.status__c == 'Billable') {// && Trigger.oldMap.get(p.Id).status__c != 'Billable'){
                lProjectID.add(p.Id);
            }
        }//for
    }//if
    
    if (lProjectID.size() > 0){
        BillingCalloutService.callBillingService(lProjectID); 
    }//call WebSvc
    
}