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