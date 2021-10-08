const pdfMultiple = async data => {
  const pdfDoc = await PDFLib.PDFDocument.create();
  const timesRomanFont = await pdfDoc.embedFont(PDFLib.StandardFonts.TimesRoman);
  const fontSize = 8;
  data.forEach(item => {
    const page = pdfDoc.addPage([350, 400]);
    const { width, height } = page.getSize();
    page.drawText(JSON.stringify(item), {
      x: 0,
      y: height - 4 * fontSize,
      size: fontSize,
      font: timesRomanFont,
      color: PDFLib.rgb(0, 0.53, 0.71)
    })
  });
  const pdfBytes = await pdfDoc.save();
  let file = new File([pdfBytes], "prueba.pdf", {
    type: "application/pdf;charset=utf-8",
  });
  saveAs(file);
}

const pdfUnitario = async data => {
  let i = 0;
  while (i < data.length) {
    const pdfDoc = await PDFLib.PDFDocument.create();
    const timesRomanFont = await pdfDoc.embedFont(PDFLib.StandardFonts.TimesRoman);
    const fontSize = 8;
    const page = pdfDoc.addPage([350, 400]);
    const { width, height } = page.getSize();
    page.drawText(JSON.stringify(data[i]), {
      x: 0,
      y: height - 4 * fontSize,
      size: fontSize,
      font: timesRomanFont,
      color: PDFLib.rgb(0, 0.53, 0.71),
    })
    const pdfBytes = await pdfDoc.save();
    let file = new File([pdfBytes], "prueba.pdf", {
      type: "application/pdf;charset=utf-8",
    });
    saveAs(file);
    i++;
  }
}

const pdfUnitarioZip = async (data, imprimirZip = false) => {
  let i = 0;
  let zip = new JSZip();
  while (i < data.length) {
    const pdfDoc = await PDFLib.PDFDocument.create();
    const timesRomanFont = await pdfDoc.embedFont(PDFLib.StandardFonts.TimesRoman);
    const fontSize = 8;
    const page = pdfDoc.addPage([350, 400]);
    const { width, height } = page.getSize();
    page.drawText(JSON.stringify(data[i]), {
      x: 0,
      y: height - 4 * fontSize,
      size: fontSize,
      font: timesRomanFont,
      color: PDFLib.rgb(0, 0.53, 0.71),
    })
    const pdfBytes = await pdfDoc.save();
    let file = new File([pdfBytes], "prueba.pdf", {
      type: "application/pdf;charset=utf-8",
    });
    if (imprimirZip) {
      zip.file(`Documento ${(i + 1)}.pdf`, file);
    } else {
      saveAs(file);
    }
    i++;
  }
  if (imprimirZip) {
    zip.generateAsync({ type: "blob" }).then(function (array) {
      saveAs(array, "Archivos.zip");
    });
  }
}

const crearPdf = async (datos, imprimir) => {
  if (imprimir === 1) {
    pdfMultiple(datos)
  } else if (imprimir === 2) {
    pdfUnitario(datos)
  } else {
    pdfUnitarioZip(datos, true)
  }
}


function readFileAsync(file) {
  return new Promise((resolve, reject) => {
    let reader = new FileReader();
    reader.onload = () => {
      resolve(reader.result);
    };
    reader.onerror = reject;
    reader.readAsArrayBuffer(file);
  })
}

function download(file, filename, type) {
  const link = document.getElementById('link');
  link.download = filename;
  let binaryData = [];
  binaryData.push(file);
  link.href = URL.createObjectURL(new Blob(binaryData, { type: type }))
}

const merge = async () => {
  let PDFDocument = PDFLib.PDFDocument;
  let i = 0;
  let respData = [];
  let num = 1000;
  while (i <= num) {
    const { data } = await peticionServerProcess('getDocument', { x01: i, x02: (i + 4) });
    respData = respData.concat(data)
    console.log('peticion => ', (i + 1))
    i = i + 5;
  }
  console.log('Final peticion')

  let file = [];
  i = 0;
  while (i < respData.length) {
    let tem = await convertBase64ToFile('data:application/pdf;base64,' + respData[i].fileBlob, 'hola.pdf');
    const document = await readFileAsync(tem);
    file.push(document);
    i++;
  }

  let pdf = [];
  i = 0;
  while (i < file.length) {
    const document = await PDFDocument.load(file[i]);
    pdf.push(document);
    i++;
  }

  const mergedPdf = await PDFDocument.create();
  let copiedPages = [];
  i = 0;
  while (i < pdf.length) {
    copiedPages = await mergedPdf.copyPages(pdf[i], pdf[i].getPageIndices());
    copiedPages.forEach((page) => mergedPdf.addPage(page));
    i++;
  }

  const mergedPdfFile = await mergedPdf.save();
  download(mergedPdfFile, 'pdf-lib_page_copying_example.pdf', 'application/pdf')
}

const merge = async () => {
  let PDFDocument = PDFLib.PDFDocument;
  const mergedPdf = await PDFDocument.create();

  let i = 0;
  let respData = [];
  let num = 1000;
  while (i <= num) {
    const { data } = await peticionServerProcess('getDocument', { x01: i, x02: (i + 4) });
    let j = 0
    while (j < data.length) {
      let tem = await convertBase64ToFile('data:application/pdf;base64,' + data[j].fileBlob, 'hola.pdf');
      const document = await readFileAsync(tem);
      const document2 = await PDFDocument.load(document);
      let copiedPages = await mergedPdf.copyPages(document2, document2.getPageIndices());
      copiedPages.forEach((page) => mergedPdf.addPage(page));
      j++;
    }
    respData = respData.concat(data)
    console.log('peticion => ', (i + 1))
    i = i + 5;
  }
  console.log('Final peticion')

  const mergedPdfFile = await mergedPdf.save();
  download(mergedPdfFile, 'pdf-lib_page_copying_example.pdf', 'application/pdf')
}