-- Se puede hacer consultas sin especificar el path
SELECT jt.*
  FROM j_purchaseorder po,
       json_table(po.po_document
         COLUMNS (Requestor,
                  NESTED ShippingInstructions.Phone[*]
                              COLUMNS (type, "number"))) AS "JT";

-- Con el path
SELECT jt.*
  FROM j_purchaseorder po,
       json_table(po.po_document, '$'
         COLUMNS (Requestor VARCHAR2(4000) PATH '$.Requestor',
                  NESTED                   PATH '$.ShippingInstructions.Phone[*]'
                    COLUMNS (type     VARCHAR2(4000) PATH '$.type',
                             "number" VARCHAR2(4000) PATH '$.number'))) AS "JT";
