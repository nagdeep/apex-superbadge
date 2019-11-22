public with sharing class WarehouseSyncSchedule implements Schedulable {
   public void execute(SchedulableContext sc) {
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}