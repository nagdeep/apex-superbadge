public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        Http h = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-superbadge-apex.herokuapp.com/equipment');
        req.setMethod('GET');

        HttpResponse res = h.send(req);
        JSONParser parser = JSON.createParser(res.getBody());
        List<Product2> updateList=new List<Product2>();
            while (parser.nextToken() != null) {
                // Start at the array of invoices.
                if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                    while (parser.nextToken() != null) {
                        // Advance to the start object marker to
                        //  find next invoice statement object.
                        if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                            EquipClass inv = (EquipClass)parser.readValueAs(EquipClass.class);
                            System.debug(inv);
                            Product2 equipRec = new Product2();
                            equipRec.Name=inv.Name;
                            equipRec.Replacement_Part__c=true;
                            equipRec.Warehouse_SKU__c=inv.sku;
                            equipRec.Cost__c=inv.cost;
                            equipRec.Current_Inventory__c=inv.quantity;
                            equipRec.Lifespan_Months__c=inv.lifespan;
                            equipRec.Maintenance_Cycle__c = inv.maintenanceperiod;
                            updateList.add(equipRec);
                            
                        }
                    }
                }
            }
        upsert updateList Warehouse_SKU__c;

        System.debug(updateList);

    
    }

    public class EquipClass {
        public String Name;
        public Boolean replacement;
        public Integer quantity;
        public Integer maintenanceperiod;
        public Integer lifespan;
        public Integer cost;
        public String sku;
    } 
}
