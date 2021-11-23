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
const ejerccion2 = () => {
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