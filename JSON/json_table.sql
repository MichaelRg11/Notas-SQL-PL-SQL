--
SELECT jt.*
  FROM j_purchaseorder po,
       json_table(po.po_document
         COLUMNS ("Special Instructions",
                  NESTED LineItems[*]
                    COLUMNS (ItemNumber NUMBER,
                             Description PATH Part.Description))) AS "JT";

-- Consejo personal, los nombres de la columna poner entre comillas
-- Para evitar futuros erroes
SELECT po.id, jt.*
  FROM j_purchaseorder po,
       json_table(po.po_document, '$'
         COLUMNS (
           "Special Instructions" VARCHAR2(4000) PATH '$."Special Instructions"',
           "CostCenter" VARCHAR2(1000) PATH '$.CostCenter',
           NESTED PATH '$.ShippingInstructions.Phone[*]'
             COLUMNS (
               "type" VARCHAR(100) PATH '$.type',
               "number" VARCHAR(100) PATH '$.number'),
           NESTED PATH '$.LineItems[*]'
             COLUMNS (
               ItemNumber  NUMBER        PATH '$.ItemNumber',
               Description VARCHAR(4000) PATH '$.Part.Description'))) AS "JT";

--
SELECT jt.requestor, jt.phones
  FROM j_purchaseorder,
       json_table(po_document, '$'
         COLUMNS (requestor VARCHAR2(32 CHAR) PATH '$.Requestor',
                  phones    VARCHAR2(100 CHAR) FORMAT JSON
                            PATH '$.ShippingInstructions.Phone',
                  partial   VARCHAR2(5 CHAR) PATH '$.AllowPartialShipment',
                  has_zip   VARCHAR2(5 CHAR) EXISTS
                            PATH '$.ShippingInstructions.Address.zipCode')) jt
  WHERE jt.partial = 'false' AND jt.has_zip = 'true';

  --
  SELECT jt.*
  FROM j_purchaseorder,
       json_table(po_document, '$'
         COLUMNS (requestor VARCHAR2(32 CHAR) PATH '$.Requestor',
                  phones    VARCHAR2(100 CHAR) FORMAT JSON 
                              PATH '$.ShippingInstructions.Phone',
                  partial   VARCHAR2(5 CHAR) PATH '$.AllowPartialShipment',
                  has_zip   VARCHAR2(5 CHAR) EXISTS
                            PATH '$.ShippingInstructions.Address.zipCode')) jt
  WHERE jt.partial = 'false' AND jt.has_zip = 'true';

  --
  SELECT jt.*
  FROM j_purchaseorder,
       json_table(po_document, '$.ShippingInstructions.Phone[*]'
         COLUMNS (phone_type VARCHAR2(10) PATH '$.type',
                  phone_num  VARCHAR2(20) PATH '$.number')) AS "JT";

--
SELECT jt.*
  FROM j_purchaseorder,
       json_table(po_document, '$'
         COLUMNS (
           requestor  VARCHAR2(32 CHAR) PATH '$.Requestor',
           phone_type VARCHAR2(50 CHAR) FORMAT JSON WITH WRAPPER
                      PATH '$.ShippingInstructions.Phone[*].type',
           phone_num  VARCHAR2(50 CHAR) FORMAT JSON WITH WRAPPER
                      PATH '$.ShippingInstructions.Phone[*].number')) AS "JT";

--
SELECT jt.*
  FROM j_purchaseorder po,
       json_table(po.po_document
         COLUMNS (Requestor,
                  NESTED ShippingInstructions.Phone[*]
                              COLUMNS (type, "number"))) AS "JT";