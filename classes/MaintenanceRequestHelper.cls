public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(Map<Id,Case> tobeCreated) {
        // TODO: Complete the method to update workorders
        Map<Id,Integer> mapProduct = new Map<Id,Integer>();
        for(Product2 p:[select Id, Maintenance_Cycle__c from Product2]){
            if(p.Maintenance_Cycle__c != null){
                    mapProduct.put(p.Id, Integer.valueOf(p.Maintenance_Cycle__c));
            }   
        }
        List<Case> insertList = new List<Case>();
        for (Case c : tobeCreated.values()) {
            Case newCase=new Case();
            newCase.Subject='New MR';
            newCase.Vehicle__c = c.Vehicle__c;
            newCase.Equipment__c = c.Equipment__c;
            newCase.Type = 'Routine Maintenance';
            newCase.Product__c = c.Product__c;
            newCase.Status = 'New';
            newCase.Date_Due__c =  (mapProduct.get(c.Product__c) != null) ? (Date.today().addDays(Integer.valueOf(mapProduct.get(c.Product__c)))) : (Date.today());
            newCase.Date_Reported__c = Date.today();
            insertList.add(newCase);
        }

        insert insertList;
    }        
    
}