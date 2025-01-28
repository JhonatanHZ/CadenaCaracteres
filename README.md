# Cadena de Caracteres

## César Carios & Jhonatan Homsany

### Información general

Este proyecto ha sido desarrollado para la asignatura Lenguajes de Programación en el semestre 2-2024. Para su implementación se usó SWI-Prolog, así que es recomendable cargar la base de conocimiento en dicho entorno.

### Pasos para la ejecución

1. Ya con el código fuente descargado y SWI-Prolog instalado, abrir SWI-Prolog.
2. En SWI-Prolog, hacer click en **File** >> **Consult** y luego cargar el archivo _Proyecto2.pl_.
3. Empezar a consultar.

### Solución de cada parte

#### K_período

El predicado principal hace 3 cosas: Primero, **atom_chars(S, Lista)** convierte el átomo S en una lista de caracteres. Luego, **accumulator(Lista, K, CharLists)** encuentra todas las subcadenas de longitud K en lista de caracteres y las almacena en _CharLists_. Por último, __converter(CharLists, Result)__: Convierte la lista de listas de caracteres _CharLists_ en una lista de átomos Result.

En el caso del predicado _accumulator_, se usa el predicado del preludio de Prolog _findall_ para encontrar todas las subcadenas de longitud K en la lista de caracteres y reunirlas en Result. Es un predicado muy útil pues principalmente sirve para encontrar todas las soluciones posibles de una consulta y almacenarlas en una lista.

Por último tenemos al predicado **sublist(List, K, Sub)**, que está compuesto por dos cláusulas: En la primeraa _append_ une _Sub_ con otra lista para formar _List_. Así que _Sub_ es una sublista continua al inicio de _List_. Con
_length(Sub, K)_ se asegura que _Sub_ tenga exactamente K elementos. Y la segunda cláusula es recursiva: Si la primera cláusula de _sublist_ no encuentra una sublista de longitud K, se descarta el primer elemento de _List_ y llama recursivamente a _sublist_ con la cola de la lista. Y esta es la clave del ejercicio, pues cuando el string no está vacío, se toma el primer caracter del string y se hace la llamada recursiva hasta que el valor de K sea igual a 0. De esta manera obtendremos las n subcadenas y una vez obtenida una cadena, volvemos al string original y repetimos el procedimiento desde el segundo caracter.

#### Ocurrencias

El predicado principal toma una cadena S y devuelve en Result la cantidad máxima de repeticiones de una subcadena dentro de S. Comienza convirtiendo la cadena S en una lista de caracteres _Lista_ utilizando **atom_chars**. Luego llama al predicado **takeSubstrings** con _Lista_, un valor inicial K = 1 y una variable para almacenar el resultado. 

El predicado **takeSubstrings** es el encargado de encontrar las subcadenas en _Lista_ y verificar sus repeticiones. La primera cláusula del predicado calcula la longitud de _Lista_ y se asegura de que K no sea mayor que esta longitud. Luego, llama a **findSubstrings** para encontrar todas las sublistas de longitud K y las almacena en _Subs_. Después, se calcula la longitud de _Subs_ y se almacena en M. Por otro lado, el predicado **checkIntegerDivision** verifica si la longitud de _Lista_ es divisible por M y si esto se cumple entonces calcula D como la división entera de N entre M.Esta verificación es importante porque asegura que la subcadena puede repetirse un número entero de veces para formar la lista original. Posteriormente, **repeatSubstring** repite _Subs_ D veces, y almacena el resultado en R. Finalmente, **checkEquality** verifica si Lista y R son iguales, y si todas las condiciones anteriores son ciertas, asigna D a Result y hace un corte para evitar más retroceso una vez se encuentra una solución válida. La segunda cláusula del predicado incrementa K en 1 y llama recursivamente a **takeSubstrings** para continuar la búsqueda con el nuevo valor de K.

#### Acción

El predicado principal **action** determina si se debe cifrar o descifrar un mensaje basado en el valor de la opción O. Si O es 0 se llama al predicado **decode** para descifrar el mensaje S y almacenar el resultado en Result. Pero si O es 1 se llama al predicado **encode** para cifrar el mensaje S y almacenar el resultado en Result.

El predicado **decode** es responsable de descifrar el mensaje. Primero convierte el string S en una lista de caracteres utilizando **atom_chars** Luego, invierte la lista de caracteres usando **reverse** (predicado del preludio de Prolog) y almacena el resultado en **RListaChar**. Después, llama al predicado **convertASCIIToChar** con la lista de caracteres invertida _RListaChar_ para convertir los valores ASCII de vuelta a caracteres, formando así el string descifrado _DecodedString_.

El predicado **convertASCIIToChar** maneja la conversión de valores ASCII a caracteres. Si la lista de entrada está vacía, devuelve un string vacío. Si la lista tiene al menos tres elementos, los primeros tres caracteres se combinan en un string y se convierten a un número, que luego se verifica para estar en el rango adecuado utilizando **checkRange** Si el número está dentro del rango, se convierte a su carácter ASCII correspondiente. El predicado se llama recursivamente para procesar el resto de la lista, concatenando cada carácter convertido al string resultante. Si la lista tiene solo dos elementos, el proceso es similar pero sin la verificación de rango, y los dos caracteres se combinan en un número de dos dígitos que se convierte a su carácter ASCII correspondiente. El predicado **checkRange** verifica que un número esté en el rango de 100 a 122, que corresponde a los caracteres ASCII válidos para la entrada.

El predicado **encode** se encarga de cifrar el mensaje. Primero, convierte el string S en una lista de códigos ASCII utilizando **atom_codes**. Luego, invierte esta lista y aplica el predicado **invertASCII** a cada elemento de la lista invertida utilizando **maplist** (aplica un predicado a cada elemento de una lista y produce una nueva lista con los resultados), produciendo una lista de valores ASCII invertidos ASCIIList. Finalmente, convierte la lista de valores ASCII invertidos en un string **EncodedString**. Después, el predicado **invertNumber** invierte los dígitos de un número. Convierte el número en una lista de códigos de caracteres, invierte la lista de códigos y luego convierte la lista invertida de vuelta a un número. Por últmo, el predicado **invertASCII** aplica el predicado **invertNumber** a un código ASCII para obtener su valor invertido. Esto se utiliza durante el cifrado para invertir los valores ASCII de los caracteres del mensaje.

#### Subsecuencia

El predicado **subsequence** es el pedido en el ejercicio. Primero convierte las cadenas de entrada en listas de caracteres utilizando **atom_chars**, y las almacena en _FirstString_ y _SecondString_. Luego, llama al predicado **findSequence** para encontrar la subsecuencia común más larga entre _FirstString_ y _SecondString_, almacenando el resultado en _FindSequence_. A continuación, convierte la lista de caracteres _FindSequence_ de nuevo en una cadena utilizando **atom_chars**, y la almacena en Result. Finalmente, calcula la longitud de _FindSequence_ usando **length**, y la almacena en _Len_.

El predicado **findSequence** es la clave para encontrar la subsecuencia común más larga. Tiene varias cláusulas para manejar diferentes casos. La primera cláusula maneja el caso base en el que la primera lista es vacía. Si _FirstString_ está vacía, la subsecuencia común es una lista vacía. La segunda cláusula maneja el caso base en el que la segunda lista es vacía. Si _SecondString_ está vacía, la subsecuencia común es una lista vacía.

La tercera cláusula maneja el caso en el que los primeros elementos de ambas listas coinciden. Si H es el primer elemento común de ambas listas, se agrega a la subsecuencia común _FindSequence_. Luego, se llama recursivamente a **findSequence** con los restos de ambas listas para encontrar el resto de la subsecuencia común. El corte evita el retroceso innecesario después de encontrar una coincidencia, también evita que entre en un bucle de recursión infinito.

La cuarta cláusula maneja el caso en el que los primeros elementos de las listas no coinciden. Si H1 y H2 son diferentes, se realizan dos llamadas recursivas a **findSequence**. La primera llamada compara la lista original _FirstString_. La segunda llamada compara la lista original _SecondString_. Luego, se calculan las longitudes de ambas subsecuencias resultantes. Se compara la longitud de ambas subsecuencias y se selecciona la subsecuencia más larga como la subsecuencia común final _FindSequence_.

### Material Consultado

La página web de la documentación SWI-Prolog https://www.swi-prolog.org/ fue de gran ayuda para encontrar predicados en el preludio de Prolog que encajaran con las estrategias que utilizamos para resolver cada una de las partes del proyecto. Como se explicó en el apartado _Solución a cada parte_, de esa web consultamos los predicados **atom_chars**, **maplist**, **reverse** y **lenght**. También investigamos una forma de representar un condicional distinta a la forma convencional: con el operador **->**. Si la condición que está antes del -> se cumple, entonces se ejecutará lo que está después del operador. Así lo utilizamos en el predicado **findSequence** de la parte 4.