# CadenaCaracteres

-Parte 1

 Idea de implementación:

Se recibe un string y se verifica si está vacío. Este será nuestro caso base.
Cuando el string no está vacío, se toma el primer caracter del string y se hace la llamada recursiva
hasta que el valor de k sea igual a 0. De esta manera, obtendremos las n subcadenas.
Una vez obtenida una cadena, volvemos al string original y repetimos el procedimiento desde el segundo
caracter

atom_chars(S, Lista): Convierte la cadena S en una lista de caracteres Lista.

accumulator(Lista, K, CharLists): Llama al predicado accumulator/3 para encontrar todas las subcadenas de longitud K en Lista.

convert_to_strings(CharLists, Result): Convierte la lista de listas de caracteres CharLists en una lista de cadenas de texto Result.

findall(Sub, sublist_of_length(Lista, K, Sub), Result): Utiliza findall/3 para encontrar todas las sublistas de longitud K en Lista y las almacena en Result.

sublist_of_length(List, K, Sub): La primera definición encuentra una sublista Sub de longitud K en List. Usa append(Sub, _, List) para obtener una sublista Sub al comienzo de List y verifica que la longitud de Sub sea K.

La segunda definición llama recursivamente a sublist_of_length/3 para avanzar en la lista List y seguir buscando sublistas de longitud K en la cola Tail.

-Parte 2

 Idea de implementacion: 
 
Tomamos el primer caracter. Esa sera nuestra primera subcadena. La repetimos
y verificamos si coincide con los siguientes caracteres del string original hasta llegar al final.
En caso de no coincidir, retrocedemos y añadimos el siguiente caracter del string. 
En este punto, repetimos.