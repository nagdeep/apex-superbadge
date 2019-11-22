@isTest
public with sharing class WareHouseSyncScheduleTest {
    @isTest
    public static void syncTest(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        Test.startTest();
            String testRes = System.schedule('scheduler','0 0 1 * * ?', new WarehouseSyncSchedule());   
        Test.stopTest();
    }
}
