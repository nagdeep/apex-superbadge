// This class can be safely deleted from your org. 
// It was only used to ensure 100% test coverage 
// for the managed package installation 

@IsTest
public class InstallationTests {
    @IsTest
    public static void testMaintenanceRequest(){
    //    MaintenanceRequestHelper.updateWorkOrders();
    }
    
    @IsTest
    public static void testWarehouseSync(){
    //    WarehouseCalloutService.runWarehouseEquipmentSync();
    }

    @IsTest
    public static void testMaintenancePositive(){
        Vehicle__c newV= new Vehicle__c(name='100Kv Battery');
        insert newV;

        Product2 newProd = new Product2(Name='Test',Maintenance_Cycle__c=20,Replacement_Part__c=true);
        insert newProd;

        Case c= new Case(Type='Routine Maintenance',Subject='RM',Vehicle__c=newV.Id,Equipment__c=newProd.Id,Status='New');
        insert c;

        Test.startTest();
            c.Status='Closed';
            update c;
        Test.stopTest();
    }

    @IsTest
    public static void testMaintenanceBulk(){
         Vehicle__c newV= new Vehicle__c(name='100Kv Battery');
        insert newV;

        Product2 newProd = new Product2(Name='Test',Maintenance_Cycle__c=20,Replacement_Part__c=true);
        insert newProd;
        List<Case> insertList = new List<Case>();
        for(Integer i=0;i<300;i++){
        Case c= new Case(Type='Routine Maintenance',Subject='RM'+i,Vehicle__c=newV.Id,Equipment__c=newProd.Id,Status='New');
        insertList.add(c);
        }
        insert insertList;

        //List<Case> updateList = new List<Case>();
        Test.startTest();
            for(Integer i=0;i<300;i++){
                insertList[i].Status='Closed';
            }
            update insertList;
        Test.stopTest();
    }
}