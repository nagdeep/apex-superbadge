trigger MaintenanceRequest on Case (before update, after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    if(Trigger.isAfter){
        Map<Id,Case> toBeCreated = new Map<Id,Case>();
        for(Case c: Trigger.new){
            Case oldCase = Trigger.oldMap.get(c.Id);
            if(c.Status!=oldCase.Status && (c.type=='Repair' || c.Type=='Routine Maintenance')){
                toBeCreated.put(c.Id,c);
            }
        }
        MaintenanceRequestHelper.updateWorkOrders(toBeCreated);
    }
}