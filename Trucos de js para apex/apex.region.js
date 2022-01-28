/* Refrescar Region o item */
let region = apex.region('myRegion'); // Estatic id de la region
region.refresh();

/* Refrescar interactive grid */
let model = apex.region("myRegion").widget().interactiveGrid("getViews").grid.model;
model.fetchRecords(model._data);

/* Funcion para hacer peticiones y que estas esperen */
const peticionServerProcess = (proc, json) => {
  return apex.server.process(proc, json);
}
