public class BoatSearchResults {

    @AuraEnabled
    public static List<BoatType__c> getBoatTypes() {
        
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {  'Id', 'Name'     };
        
        Map<String,Schema.SObjectField> fieldDescribeTokens = 
            Schema.SObjectType.BoatType__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        
        // OK, they're cool, let 'em through
        return [SELECT Id, Name FROM BoatType__c];
    }//getBoatTypes 
    
     @AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId ) {
        
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {  'Id', 'Name' , 'BoatType__c', 'Contact__c' , 'Description__c' , 'Geolocation__c' ,
        'Length__c' , 'Picture__c' , 'Price__c' ,'Year_Built__c'    };
        
        /*
        Map<String,Schema.SObjectField> fieldDescribeTokens = 
            Schema.SObjectType.Boat__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }*/
        
        // OK, they're cool, let 'em through
        List<Boat__c> lb = new List<Boat__c>();
        if (boatTypeId == null || boatTypeId == '' || boatTypeId == '0' )
        lb  = [SELECT Id, Name , BoatType__c, Contact__c , Description__c , Contact__r.Name, 
                       Length__c , Picture__c , Price__c ,Year_Built__c ,
                       Geolocation__latitude__s, Geolocation__longitude__s
                       FROM Boat__c ];
        else 
        lb  = [SELECT Id, Name , BoatType__c, Contact__c , Description__c , Contact__r.Name,
                       Length__c , Picture__c , Price__c ,Year_Built__c  ,
                       Geolocation__latitude__s, Geolocation__longitude__s
                       FROM Boat__c where BoatType__c = :boatTypeId  ];
         
                      
         return lb;    
         
         /*
         List<List<Boat__c>> lb2 = new List<List<Boat__c>>();
         List<Boat__c> temp = new List<Boat__c>();
            for (integer i=0;i<lb.size();i++){
                if (Math.mod(i,4) == 0 && i >0){
                    lb2.add(temp);
                    temp = new List<Boat__c>();
                    temp.add(lb[i]);
                }    else{
                        temp.add(lb[i]);
                }
            }
            lb2.add(temp);
            //system.debug(JSON.serialize(lb2));
            return lb2 ;    
            */
               
    }//getBoats 
    
    
}//BoatSearchResults