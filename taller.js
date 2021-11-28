// Ejerccio 1
const ejerccio1 = () => {
  // Metodo burbuja
  const Burbuja = (arreglo) => {
    let lista = [...arreglo];
    let n, i, k, aux;
    n = lista.length;

    console.log('Array sin ordenar: ', lista); // Mostramos, por consola, la lista desordenada
    // Algoritmo de burbuja
    for (k = 1; k < n; k++) {
      for (i = 0; i < (n - k); i++) {
        if (lista[i] > lista[i + 1]) {
          aux = lista[i];
          lista[i] = lista[i + 1];
          lista[i + 1] = aux;
        }
      }
    }
    console.log('Array ordenado: ', lista); // Mostramos, por consola, la lista ya ordenada
  }

  // Genera 20 numeros random
  let miarray = Array.from({ length: 20 }, () => Math.floor(Math.random() * 1000));

  Burbuja(miarray);
}

// Ejercicio 2
const ejercicio2 = () => {
  // Metodo para intercalar dos vectores
  const intercalacionVector = (vector1, vector2) => {
    let n = vector1.length;
    let array3 = [];
    for (let i = 0; i < n; i++) {
      array3.push(vector1[i]);
      array3.push(vector2[i]);
    }
    console.log('Array resultante: ', array3);
  }

  let tamanoVector = 5;
  let array1 = Array.from({ length: tamanoVector }, () => Math.floor(Math.random() * 1000));
  let array2 = Array.from({ length: tamanoVector }, () => Math.floor(Math.random() * 1000));

  console.log('Array 1: ', array1);

  console.log('array 2: ', array2);

  intercalacionVector(array1, array2);
}

// Ejercicio 3
const ejercicio3 = () => {
  let temperatura = Array.from({ length: 12 }, () => Math.floor(Math.random() * (40 - 18) + 18));
  let meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto",
    "Septiembre", "Octubre", "Noviembre", "Diciembre"];
  let mesMayor = 0, indiceMayor;
  let mesMenor = 1000, indiceMenor;
  console.log(`Temperatura por mes`);
  temperatura.forEach((data, i) => console.log(`${meses[i]} ${data}°`));
  temperatura.forEach((data, i) => {
    if (mesMenor > data) {
      mesMenor = data;
      indiceMenor = i;
    }
    if (mesMayor < data) {
      mesMayor = data;
      indiceMayor = i;
    }
  })
  console.log(`Mes con menor temperatura: ${meses[indiceMenor]} ${temperatura[indiceMenor]}°`);
  console.log(`Mes con mayor temperatura: ${meses[indiceMayor]} ${temperatura[indiceMayor]}°`);
}

// Ejercicio 4
const ejercicio4 = () => {
  let matriz2 = [Array.from({ length: 2 }, () => Math.floor(Math.random() * 10)),
  Array.from({ length: 2 }, () => Math.floor(Math.random() * 10)),
  Array.from({ length: 2 }, () => Math.floor(Math.random() * 10))];
  let matriz1 = [Array.from({ length: 3 }, () => Math.floor(Math.random() * 10)),
  Array.from({ length: 3 }, () => Math.floor(Math.random() * 10))];
  let matrizResultante = [];
  for (let i = 0; i < 3; i++) {
    let temporal = [];
    let resultado;
    for (let j = 0; j < 3; j++) {
      resultado = matriz1[0][i] * matriz2[j][0] + matriz1[1][i] * matriz2[j][1];
      temporal.push(resultado)
    }
    matrizResultante.push(temporal)
  }
  console.log('Matriz uno: ', matriz1);
  console.log('Matriz dos: ', matriz2);
  console.log('Matriz Resultante', matrizResultante)
}

// Ejercicio 5
const ejercicio5 = () => {
  let n, aux;
  let matriz = [Array.from({ length: 5 }, () => Math.floor(Math.random() * 10)),
  Array.from({ length: 5 }, () => Math.floor(Math.random() * 10)),
  Array.from({ length: 5 }, () => Math.floor(Math.random() * 10)),
  Array.from({ length: 5 }, () => Math.floor(Math.random() * 10)),
  Array.from({ length: 5 }, () => Math.floor(Math.random() * 10))];
  console.log('Matriz de entrada', matriz);
  let fila1 = 2;
  let fila2 = 5;

  for (let i = 0; i < matriz.length; i++) {
    aux = matriz[fila2 - 1][i];
    matriz[fila1 - 1][i] = matriz[fila2 - 1][i];
    matriz[fila2 - 1][i] = aux;
  }
  console.log('MAtriz Resultante', matriz);
}
