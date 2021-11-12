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

const merge = async () => {
  console.time('loop');
  let popup = apex.widget.waitPopup();
  let { cantidad, nmro_lote } = await peticionServerProcess('prc_nmro_documentos', {});
  console.log('cantidad', cantidad)
  if (cantidad > 0) {
    let PDFDocument = PDFLib.PDFDocument;
    const mergedPdf = await PDFDocument.create();
    let i = 1;
    let respData = [];
    while (i <= cantidad) {
      const { data } = await peticionServerProcess('prc_co_documentos', { x01: i, x02: (i + 19 > cantidad ? cantidad : i + 19) });
      console.log(`# de datos => ${data.length}`)
      let j = 0
      while (j < data.length) {
        let tem = await convertBase64ToFile(`data:application/pdf;base64,${data[j].fileBlob}`, data[j].fileName);
        const document = await readFileAsync(tem);
        const document2 = await PDFDocument.load(document);
        let copiedPages = await mergedPdf.copyPages(document2, document2.getPageIndices());
        copiedPages.forEach((page) => mergedPdf.addPage(page));
        j++;
      }
      respData = respData.concat(data)
      i = i + 20;
    }
    const mergedPdfFile = await mergedPdf.save();
    //download(mergedPdfFile, `Detalle lote #${nmro_lote}.pdf`, 'application/pdf');
    let zip = new JSZip();
    zip.file(`Detalle lote #${nmro_lote}.pdf`, mergedPdfFile);
    zip.generateAsync({ type: "blob" }).then(mergedPdfFile => {
      download(mergedPdfFile, `Detalle lote #${nmro_lote}.zip`, 'application/zip');
    });
    console.timeEnd('loop'); // Muestra por consola: "loop: 63ms"
  } else {
    alert('No existen documentos asociados.')
  }
  popup.remove();
}
