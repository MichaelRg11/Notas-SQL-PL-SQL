const ocultar = () => {
  let value = apex.item("P1_NEW").getValue();
  console.log('value2 => ', value);
  let region = document.getElementById('contenedor');
  if (value === 'true') {
    region.setAttribute("hidden", "");
    region.style.display = 'block';
  } else {
    region.style.display = 'none';
  }
}

ocultar();

const peticionServerProcess = (proc, json = {}) => {
  return apex.server.process(proc, json);
}

const notificarActos = async () => {
  obtenerActos()
  let $await;
  if (v_json) {
    var count = JSON.parse(v_json).length;  
    apex.message.confirm('¿Está seguro de enviar a notificar ' + count + ' acto(s)?', async function (d) {
      if (d) {
        try {
          $await = apex.widget.waitPopup('NotificarActos', {f01: v_json});
          await peticionServerProcess()
          await apex.server.process('NotificarActos', {
            f01: v_json
          }).then(async (resp) => {
            if (resp.tipo =='ERROR') {
              apex.message.clearErrors();
              apex.message.showErrors([
                {
                  type: "error",
                  location: ["page"],
                  message: resp.mensaje,
                  unsafe: false
                }]);
            } else {
              apex.message.showPageSuccess(resp.mensaje);
              apex.region("fiscalizacion").refresh();
            }
          }) 
        } catch (e) {
          console.log(e);
        } finally {
          $await.remove();
        }
        await peticionServerProcess('callback')
      }
    })
  } else {
    apex.message.clearErrors();
    apex.message.showErrors([
      {
        type: "error",
        location: ["page"],
        message: "Ningún acto seleccionado, por favor verifique!",
        unsafe: false
      }]);
  }
}