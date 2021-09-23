CREATE OR REPLACE FUNCTION add_totals(purchaseOrder IN VARCHAR2)
    RETURN VARCHAR2 IS
    
    po_obj JSON_OBJECT_T;
    li_arr JSON_ARRAY_T;
    li_obj JSON_OBJECT_T;
    unitPrice NUMBER;
    quantity NUMBER;
    totalPrice NUMBER := 0;
    totalQuantity NUMBER := 0;

BEGIN
    po_obj := JSON_OBJECT_T.parse(purchaseOrder);
    li_arr := po_obj.get_array('LineItems');
    FOR i IN 0 .. (li_arr.get_size - 1) LOOP
        li_obj := JSON_OBJECT_T(li_arr.get(i));
        quantity := li_obj.get_number('Quantity');
        unitPrice := li_obj.get_object('Part').get_number('UnitPrice');
        totalPrice := totalPrice + (quantity * unitPrice);
        totalQuantity := totalQuantity + totalPrice;
        DBMS_OUTPUT.PUT_LINE('json: ' || li_obj.to_string);
    END LOOP;
    po_obj.put('totalQuantity', totalQuantity);
    po_obj.put('totalPrice', totalPrice);
    RETURN po_obj.to_string;
END;

UPDATE j_purchaseorder SET (po_document) = add_totals(po_document);

select * from  j_purchaseorder 