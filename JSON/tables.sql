CREATE TABLE j_purchaseorder
  (id          VARCHAR2(32) NOT NULL PRIMARY KEY,
   date_loaded TIMESTAMP(6) WITH TIME ZONE,
   po_document VARCHAR2(3800)
   CONSTRAINT ensure_json CHECK (po_document IS JSON));

drop table j_purchaseorder;

INSERT INTO j_purchaseorder
  VALUES 
  (1,
  sysdate + 2,
  '{ "PONumber"          : 1600,
  "Reference"            : "ABULL-20140421",
  "Requestor"            : "Alexis Bull",
  "User"                 : "ABULL",
  "CostCenter"           : "A50",
  "ShippingInstructions" : { "name"   : "Alexis Bull",
                             "Address": { "street"  : "200 Sporting Green",
                                          "city"    : "South San Francisco",
                                          "state"   : "CA",
                                          "zipCode" : 99236,
                                          "country" : "United States of America" },
                             "Phone" : [ { "type" : "Office", "number" : "909-555-7307" },
                                         { "type" : "Mobile", "number" : "415-555-1234" } ] },
  "Special Instructions" : null,
  "AllowPartialShipment" : false,
  "LineItems"            : [ { "ItemNumber" : 1,
                               "Part"       : { "Description" : "One Magic Christmas",
                                                "UnitPrice"   : 19.95,
                                                "UPCCode"     : 13131092899 },
                               "Quantity"   : 9.0 },
                             { "ItemNumber" : 2,
                               "Part"       : { "Description" : "Lethal Weapon",
                                                "UnitPrice"   : 19.95,
                                                "UPCCode"     : 85391628927 },
                               "Quantity"   : 5.0 } ] }');

delete from j_purchaseorder where id = 1;

select * from j_purchaseorder;

SELECT po.po_document."Special Instructions" FROM j_purchaseorder po;