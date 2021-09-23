async function prueba(p_this) {
  //Obtenemos el modelo de la región del InteractiveGrid de Liquidación
  var item_vlor = p_this.triggeringElement.value.replaceAll('.', '');
  let conceptos_ajustes = apex.region("conceptos_ajustes").widget().interactiveGrid("getViews", "grid").model;
  let table = apex.region("conceptos_ajustes").widget().interactiveGrid("getViews").grid.getSelectedRecords();
  let value = table[0];

  try {
    apex.server.process('Calcular_Interes_Mora', {
      x01: item_vlor,
      x02: value[conceptos_ajustes.getFieldKey("VGNCIA")],
      x03: value[conceptos_ajustes.getFieldKey("ID_PRDO")],
      x04: value[conceptos_ajustes.getFieldKey("ID_CNCPTO")],
      x05: value[conceptos_ajustes.getFieldKey("ID_ORGEN")],
      x06: value.item("P106_FCHA_INTRES").getValue(),
      x07: value[conceptos_ajustes.getFieldKey("CDGO_MVMNTO_ORGN")]
    }).then((resp) => {
      console.log('Respuesta: ', resp);
      conceptos_ajustes.setValue(value, "VLOR_AJSTE_INTRES", `$${new Intl.NumberFormat('de-DE').format(resp.v_vlor_intres)}`);
      var capital_interes = value[conceptos_ajustes.getFieldKey("VLOR_INTRES")].trim().replaceAll('.', '').replace('$', '');
      var ajuste_interes = value[conceptos_ajustes.getFieldKey("VLOR_AJSTE_INTRES")].trim().replaceAll('.', '').replace('$', '');
      var total_interes = capital_interes - ajuste_interes;
      conceptos_ajustes.setValue(value, "TTAL_INTRES", `$${new Intl.NumberFormat('de-DE').format(total_interes)}`);
    });
  } catch (e) {
    console.log(e);
  };
}