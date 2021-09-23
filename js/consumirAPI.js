const peticionServerProcess = (proc, json) => {
  return apex.server.process(proc, json);
}

const sumar = async (p_this) => {
  let item_vlor = p_this.triggeringElement.value;
  let grid = apex.region("table").widget().interactiveGrid("getViews", "grid").model;
  let table = apex.region("table").widget().interactiveGrid("getViews").grid.getSelectedRecords();
  let fila = table[0];
  const json_parametros = {
    x01: parseInt(fila[grid.getFieldKey("VLOR")]),
    x02: parseInt(item_vlor)
  }
  const { respuesta, total } = await peticionServerProcess('SUMA_PLSQL', json_parametros);
  grid.setValue(fila, "VALOR", `$${new Intl.NumberFormat('de-DE').format(total)}`);
}

const multiplicar = async () => {
  let grid = apex.region("table").widget().interactiveGrid("getViews", "grid").model;
  let arraytem = grid._data;
  //console.log('array completo => ', arraytem);
  let preTotal = 0;
  let total = 0;
  let i = 0;
  while (i < arraytem.length) {
    let contentTable = arraytem[i]
    //console.log('vlor => ', contentTable[grid.getFieldKey("VLOR")])
    let json_parametros = {
      x01: parseInt(contentTable[grid.getFieldKey("VLOR")]),
      x02: 0
    }
    const resp = await peticionServerProcess('SUMA_PLSQL', json_parametros);
    preTotal = resp.total;

    json_parametros = {
      x01: parseInt(contentTable[grid.getFieldKey("VLOR")]),
      x02: 0
    }
    let resp2 = await peticionServerProcess('SUMA_PLSQL', json_parametros);
    total = preTotal + resp2.total;
    //console.log(i, ' pretotal: ' + preTotal + ' resp total: ' + resp2.total + ' total : ' + total);
    grid.setValue(contentTable, "VALOR", `$${new Intl.NumberFormat('de-DE').format(total)}`);
    i++
  }
}