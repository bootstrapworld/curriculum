#lang racket

(provide *glossary-list*)

#|
Glossary for terminology used in the notes.  The first entry of each entry can be either
a single string or a list of keys that map to the same definition.

If a list of keys is provided, the generated glossary will use the first in the list
when it prints out the glossary for a particular unit
|#

(define *glossary-list*
  '(

    ((en-us ("accessor functions") "functions to extract values from a data structure")
     (es-mx ("funciones de acceso") "funciones para extraer valores de una estructura de datos"))

    ((en-us ("apply") "use a given function on some inputs")
     (es-mx ("aplicando") "use una función dada en algunas entradas"))

    ((en-us ("argument" "arguments") "the inputs to a function; expressions for arguments follow the name of a function")
     (es-mx ("argumento" "argumentos") "las entradas de una función; las expresiones de los argumentos siguen el nombre de una función"))

    ((en-us ("ascending") "an order in which lower values appear first, and higher values appear after")
     (es-mx ("ascendente") "un orden de valores en lo cual los más bajos aparecen primero y los más grandes aparecen después"))

    ((en-us ("axis") "A number line on a scatter plot, used to place points that represent pairs of values in data sets")
    #|(es-mx ("eje" "ejes") "...")|#)

    ((en-us ("bar chart" "bar charts") "a display of categorical data that uses bars positioned over category values; each bar’s height reflects the count or percentage of data values in that category")
    #|(es-mx ("gráfico de barras") "...")|#)

    ((en-us ("bin" "bins") "a range that values from a dataset can belong to; there is one bar in a histogram per bin")
     (es-mx ("intervalo" "intervalos") "un rango al que pueden pertenecer los valores de un conjunto de datos; hay una barra en un histograma por intervalo"))

    ((en-us ("Boolean" "Booleans") "a type of data with two values: true and false")
     (es-mx ("booleano") "un tipo de datos con dos valores: true y false"))

    ((en-us ("box plot" "box plots") "the box plot (a.k.a. box-and whisker-plot) is a way of displaying a distribution of data based on the five-number summary: minimum, first quartile, median, third quartile, and maximum")
     (es-mx ("diagrama de caja" "diagrama de caja y bigotes") "El diagrama de caja (también conocido como diagrama de caja y bigotes) es una forma de mostrar la distribución de datos basada en el resumen de cinco números: mínimo (el valor más bajo), primer cuartil, mediana, tercer cuartil y máximo (el valor más alto)."))

    ((en-us ("calling" "calls") "using a function by giving it inputs")
     (es-mx ("llamada" "llamadas") "Utilizando una función dándole entradas"))

    ((en-us ("category" "categories") "the set of possible values that a value in a categorical dataset can have")
     (es-mx("categoría") "el conjunto de valores posibles que puede tener un valor en un conjunto de datos categórico"))

    ((en-us ("categorical data") "data whose values are qualities that are not subject to the laws of arithmetic.")
     (es-mx ("datos categóricos") "datos cuyos valores son cualidades que no están sujetas a las leyes de la aritmética"))

    ((en-us ("circle of evaluation" "circles of evaluation") "a 'sentence diagram' of the structure of a mathematical expression")
     (es-mx ("círculo de evaluación") "un diagrama de la estructura de una expresión (aritmética o código)"))

    ((en-us ("clause") "a question and its corresponding answer in a conditional expression")
     (es-mx ("cláusula") "una pregunta y su respuesta correspondiente en una expresión condicional"))
    
    ((en-us ("chart" "charts") "visual reprsentations of how values in a dataset are distributed")
     (es-mx ("gráfico") "Representacion visual de cómo se distribuyen los valores en un conjunto de datos."))

    ((en-us ("column" "columns") "set of values in a table of a particular type.  Every row has exactly 1 element in every column")
     (es-mx ("columna") "conjunto de valores en una tabla de un tipo particular. Cada fila tiene exactamente 1 elemento en cada columna."))

    ((en-us ("combination" "combinations") "the number of possible arrangements in a collection of items where the order of the selection does NOT matter. (ABC and CBA would be considered the same combination.)")
     (es-mx ("combinación") "el número de arreglos posibles en una colección de artículos donde el orden de la selección NO importa. ABC y CBA se considerarían la misma combinación.)"))

    ((en-us ("conditional") "a code expression made of questions and answers")
     (es-mx ("condicional") "una expresión de código hecha de preguntas y respuestas"))

    ((en-us ("constructor") "a function that creates instances of a data structure")
     (es-mx ("función constructor") "La función que crea una estructura de datos particular"))

    ((en-us ("contract" "contracts") "a statement of the name, domain, and range of a function")
     (es-mx ("contrato") "una declaración del nombre, dominio y rango de una función"))

    ((en-us ("contract error" "contract errors") "errors where the code makes sense, but uses a function with the wrong number or type of arguments")
     (es-mx ("error de contrato") "errores donde el código tiene sentido, pero usa una función con el número o tipo de argumentos incorrectos"))

    ((en-us ("coordinate" "coordinates" "coordinate pair") "a number or set of numbers describing an object's location")
     (es-mx ("coordenada") "un número o conjunto de números que describen la ubicación de un objeto" "sistema de coordenadas"))

    ((en-us ("coordinate plane") "a grid formed by a pair of intersecting horizontal and vertical number lines")
      (es-mx ("plano coordinado" "plano de coordinadas" "plano cartesiano" "sistema cartesiano") "una cuadrícula formada por un par de rectas numéricas horizontales y verticales que se cruzan"))

    ((en-us ("correlation" "correlations") "a single number somewhere between -1 and +1 that reports the direction and strength of the linear relationship between two quantitative variables (also known as the r-value)")
      (es-mx ("correlación") "un número entre -1 y +1 que informa la dirección y la fuerza de la relación lineal entre dos variables cuantitativas (también conocido como el valor R)"))

    ((en-us ("data block") "code that lists the name, constructor(s), and field(s) of a data structure")
      (es-mx ("bloque de datos") "código que enumera el nombre, los constructores y los campos de una estructura de datos"))

    ((en-us ("data row" "data rows") "a structured piece of data in a dataset that typically reports all the information gathered about a given individual")
      (es-mx ("fila de datos") "datos estructurados de un conjunto de datos que normalmente informa toda la información recopilada sobre un individuo determinado"))

    ((en-us ("data science") "the science of collecting, organizing, and drawing general conclusions from data, with the help of computers")
      (es-mx ("Ciencia de Datos") "la ciencia de recoleccionar, organizar y sacar conclusiones generales a partir de datos, con la ayuda de computadoras"))

    ((en-us ("dataset" "datasets") "a collection of related information that is composed of separate elements, but can be manipulated as a unit by a computer")
      (es-mx ("conjunto de datos") "una colección de información relacionada que se compone de elementos separados, pero que una computadora puede manipular como una unidad"))

    ((en-us ("data structure") "a datatype which packages several datatypes as fields")
    (es-mx ("estructura de datos" "estructuras de datos") "Un grupo de valores que se pueden devolver como un único tipo de datos"))

    ((en-us ("data types" "data type") "a way of classifying values, such as: Number, String, Image, Boolean, or any user-defined data structure")
    (es-mx ("tipo de datos" "tipos de datos") "Una manera de clasificar valores, como: Número, Cadena, Imagen o Booleano"))

    ((en-us ("debug") "to find and fix errors in one's code")
      (es-mx ("depurar") "encontrar y corregir errores en el código"))

    ((en-us ("define") "to associate a descriptive name with a value")
    (es-mx ("definir") "asociar un nombre descriptivo con un valor"))

    ((en-us ("definitions area") "the left-most text box in the Editor where definitions for values and functions are written")
    (es-mx ("área de definiciones") "el cuadro de texto en el Editor, donde se escriben definiciones de valores y funciones"))

    ((en-us ("descending") "an order in which higher values appear first, and lower values appear after")
      (es-mx ("descendiente") "Los valores ordenados con el valor más grande primero, el segundo más grande siguiente, continuando así hasta que el más pequeño esté al final"))

    ((en-us ("design recipe") "a sequence of steps that helps people document, test, and write functions")
    (es-mx ("receta de diseño") "una secuencia de pasos que ayuda a las personas a documentar, probar y escribir funciones"))

    ((en-us ("direction") "the relationship between two quantitative variables: whether they tend to increase together, or whether as one goes up the other tends to go down")
      (es-mx ("dirección") "la relación entre dos variables cuantitativas - si es que tienden a incrementar juntas, o si, a medida que una sube, la otra tiende a bajar"))

    ((en-us ("domain") "the type or set of inputs that a function expects")
    (es-mx ("dominio") "el tipo de datos que espera una función"))

    ((en-us ("dot accessor") "a way to extract the values of fields an instance")
    #|(es-mx "dot-accessors" "Una manera de extraer valores de una estructura de datos")|#)
    
    ((en-us ("driver") "in pair programming, the person who is doing the typing"))
    
    ((en-us ("edge" "edges") "the line segments where the faces of solid figures meet in each of the 
    three dimensions."))
    
    ((en-us ("editor") "software in which you can write and evaluate code"))

    ((en-us ("entry" "entries") "a single value in a table, belonging to a particular row and column")
      (es-mex ("entrada") "un solo valor en una tabla, que pertenece a una fila y columna en particular"))

    ((en-us ("error message" "error messages") "information from the computer about errors in code")
    (es-mx ("mensaje de error" "mensajes de error") "información del equipo sobre errores en el código"))

    ((en-us ("evaluate") "perform the computation in an expression, producing an answer")
    (es-mx ("evaluar") "realizar el cálculo en una expresión, producir una respuesta"))

    ((en-us ("evaluates to") "the result of computing an expression")
    (es-mx ("equivale a" "equivale") "el resultado de calcular una expresión"))

    ((en-us ("event") "something that happens outside of a running program, which the program can respond to")
    (es-mx ("eventos") "algo que sucede fuera de un programa en ejecución, al que el programa puede responder"))
    
    ((en-us ("event-based programming") "a style of programming in which every functions are written to respond to mouse-clicks, keypresses, etc.")
    (es-mx ("programacion basada en eventos") "un estilo de programación en el que se escriben todas las funciones para responder a los clics del ratón, pulsaciones de teclas, etc."))
    
    ((en-us ("example" "examples" "Examples") "shows the use of a function on specific inputs and the computation the function should perform on those inputs")
    (es-mx ("ejemplos") "muestra el uso de una función en entradas específicas y el cálculo que debe realizar la función en esas entradas"))

    ((en-us ("examples block") "code that lists examples starting with 'examples:' and ends with 'end'"))
    
    ((en-us ("explanatory variable" "explanatory") "the variable in a relationship that is presumed to impact the other variable"))
    
    ((en-us ("expression") "a computation written in the rules of some language (such as arithmetic, code, or a Circle of Evaluation)")
    (es-mx ("expresión" "expresiones") "un cálculo escrito en las reglas de algún lenguaje (como aritmética, código o un Círculo de Evaluación)"))
    
    ((en-us ("extend" "extending" "extends") "a table query that creates a table with new column(s), whose entries are computed with an expression"))
    
    ((en-us ("extract") "to construct a list using data from a particular column in a table"))
    
    ((en-us ("face" "faces") "the shapes on the outside of a figure"))
    
    ((en-us ("field") "a part of a data structure that has a name and holds a single value of a specified datatype"))
    
    ((en-us ("form") "of a relationship between two quantitative variables: whether the two variables together vary linearly or in some other way"))
    
    ((en-us ("frequency bar chart" "frequency bar charts") "a bar chart in which each the length of each bar corresponds to the frequency of a particular value"))

    ((en-us ("function" "functions") "a mathematical object that consumes inputs and produces an output")
    (es-mx ("función" "funciones") "un objeto matemático que toma en algunas entradas y produce una salida"))
    
    ((en-us ("function block") "code that names a function, lists its variables, and states the expression to compute when the function is used"))
    
    ((en-us ("function definition" "function definitions") "code that names a function, lists its variables, and states the expression to compute when the function is used")
    (es-mx ("definición de función") "que designa una función, enumera sus variables e indica la expresión a calcular cuando se utiliza la función"))

    ((en-us ("frequency" "frequencies") "how often a particular value appears in a dataset"))
    
    ((en-us ("grouped sample" "grouped samples") "a non-random subset of individuals chosen from a larger set, where the individuals belong to a specific group"))
    
    ((en-us ("handler") "Connects an event (like a tick or keypress) and a function within a reactor"))
    
    ((en-us ("header" "header row" "headers" "header rows") "the titles of each column of a table, usually shown at the top"))
    
    ((en-us ("helper function") "a small function that handles a specific part of another computation, and gets called from other functions")
    (es-mx ("función auxiliar") "Una función invocada desde otras funciones con el propósito de realizar una tarea concreta requerida por éstas" "operador"))
    
    ((en-us ("histogram" "histograms") "a display of quantitative data that uses vertical bars positioned over bins (sub-intervals); each bar’s height reflects the count or percentage of data values in that bin.")
    (es-mx ("histograma" "histogramas") "Un gráfico de barras de frecuencia especial en el que cada barra cuenta la frecuencia de los valores que aparecen en un cierto intervalo."))
    
    ((en-us ("horizontal axis" "x-axis") "axis on a coordinate plane that runs from left to right")
    (es-mx ("eje horizontal") "eje en un diagrama de dispersión que va de izquierda a derecha"))
    
    ((en-us ("hypotenuse") "the side opposite the 90-degree angle in a right triangle")
    (es-mx ("hipotenusa") "el lado opuesto al ángulo de 90 grados en un triángulo rectángulo"))
    
    ((en-us ("identifier column") "a column of unique values which identify all the individual rows (e.g. - 
    student IDs, SSNs, etc)"))
    
    ((en-us ("image" "images") "a type of data for pictures")
    (es-mx ("imagen") "un tipo de datos para imágenes"))
    
    ((en-us ("instance") "a specific, packaged value of a data structure that contains other values in its fields")
    (es-mx ("instancias") "valores específicos de datos"))
    
    ((en-us ("interactions area") "the right-most text box in the Editor, where expressions are entered to be evaluated")
    (es-mx ("área de interacciones") "el cuadro de texto a la derecha en el Editor, donde se ingresan las expresiones para ser evaluadas"))
    
    ((en-us ("interquartile range" "IQR") "(IQR) is one possible measure of spread, based on dividing a dataset into four parts. The values that divide each part are called the first quartile (Q1), the median, and third quartile (Q3). IQR is calculated as Q3 minus Q1.")
      (es-mx ("rango intercuartil" "IQR") "IQR está basada en la división de un conjunto de datos en cuatro partes. Los valores que dividen cada parte se denominan primer cuartil (Q1), mediana y tercer cuartil (Q3). IQR se calcula como Q3 menos Q1."))
    
    ((en-us ("intersection" "intersections") "the set of values that makes both inequalities true")
      (es-mx ("intersección") "el conjunto de valores que hace que ambas desigualdades sean verdaderas"))
    
    ((en-us ("legal expression") "code that follows the Code Rules for a language")
    (es-mx ("expresión legal") "expresión que sigue las Reglas de Código para un lenguaje de programación"))
    
    ((en-us ("library" "libraries") "a collection of functions that can be made available to our program by using include"))
    
    ((en-us ("linear" "linear relationship") "a rule that computes one quantity from another, which can be graphed as a straight line or written as a sequence of numbers that change at a constant rate")
      (es-mx ("lineal" "relación lineal") "una regla que calcula una cantidad a partir de otra, que se puede representar gráficamente como una línea recta o que se puede escribir como una secuencia de números que cambian a una tasa constante"))
    
    ((en-us ("linear regression") "a type of analysis that models the relationship between two quantitative variables. The result is known as a regression line, or line of best fit.")
      (es-mx ("regresión lineal") "un tipo de análisis que modela la relación entre dos variables cuantitativas. El resultado se conoce como línea de regresión o línea de mejor ajuste"))
    
    ((en-us ("line of best fit" "lines of best fit" "regression line" "regression lines") "summarizes the relationship (if linear) between two quantitative variables")
      (es-mx ("línea de mejor ajuste" "línea de tendencia" "mejor ajuste" "recta de mejor ajuste") "resume la relación (si es lineal) entre dos variables cuantitativas"))
    
    ((en-us ("list" "lists") "a data structure containing a sequence of values"))
    
    ((en-us ("mathematical expression") "a computation using the rules of arithmetic")
    (es-mx ("expresión matemática") "un cálculo en aritmética"))
    
    ((en-us ("mean" "average") "a representation of the center, or 'typical' value in a set of numbers, calculated as the sum of those numbers divided by the number of values.")
    (es-mx ("el promedio") "Un número que representa el centro o valor 'típico' en un conjunto de datos. Resultado que se obtiene al dividir la suma de varias cantidades por el número de sumandos."))
    
    ((en-us ("median") "the middle element of a quantitative dataset")
    (es-mx ("mediana") "el elemento intermedio de un conjunto de datos cuantitativos ordenados."))
    
    ((en-us ("method") "a function that is only associated with an instance of a datatype, which consumes inputs and produces an output based on that instance"))
    
    ((en-us ("mode" "modes") "the most commonly appearing categorical or quantitative value or values in a dataset")
    (es-mx ("moda" "modas") "el valor (o valores) que ocurren con mayor frecuencia en un conjunto de datos"))
    
    ((en-us ("name") "how we refer to a function or value defined in a language (examples: +, *, star, circle)")
    (es-mx ("nombre") "cómo nos referimos a una función o valor definido en un idioma (ejemplos: +, *, estrella, círculo)"))
    
    ((en-us ("navigator") "in pair programming, the person who has their eyes on the screen helping the driver"))
    
    ((en-us ("negative correlation") "relationship in which one variable increases as the other decreases, and vice versa")
      (es-mx ("correlación negativa") "una relación en la que una variable incrementa a medida que la otra disminuye, y viceversa"))
    
    ((en-us ("nonlinear") "a pattern that is not a straight line when it is graphed")
      (es-mx ("relación no lineal" "no lineal") "un patrón que no es una línea recta cuando se grafica"))
    
    ((en-us ("normal" "normal distribution") "A normal distribution has a particular symmetric shape that bulges in the middle and tapers at the ends.")
      (es-mx ("distribución normal") "Una distribución normal tiene una forma simétrica particular que es más ancha en el medio y se estrecha en los extremos."))
    
    ((en-us ("number") "a data type representing a real number")
      (es-mx ("número") "un tipo de datos que representa un número real"))
    
    ((en-us ("operator" "operators") "a symbol that manipulates two Numbers and produces a result")
    (es-mx ("operador" "operadores") "un símbolo que manipula dos números y produce un resultado"))
    
    ((en-us ("order" "orders" "ordering") "an arrangement of data according to some pattern")
      (es-mx ("orden") "una disposición de datos de acuerdo con algún patrón"))
    
    ((en-us ("outlier" "outliers") "a data point that is unusually far above or below most of the others")
    (es-mx ("valore atípico" "valores atípicos") "observaciones cuyos valores son muy diferentes a las otras observaciones del mismo grupo de datos, quizás debido a un error experimental. Los valores atípicos también pueden ser indicativos de datos pertenecientes a una población diferente del resto de las muestras establecidas."))
    
    ((en-us ("permutation" "permutations") "the number of possible arrangements in a collection of items where the order of the selection matters (ABC and CBA would be considered different permutations)")
      (es-mx ("permutación") "el número de arreglos posibles en una colección de elementos donde el orden de la selección importa (ABC y CBA se considerarían permutaciones diferentes)"))
    
    ((en-us ("piecewise function" "piecewise functions") "a function that computes different expressions based on its input")
    (es-mx ("funciones por trozos") "una función que calcula diferentes expresiones basadas en su entrada"))
    
    ((en-us ("pie chart" "pie charts") "a display that uses areas of a circular pie's slices to show percentages in each category")
    (es-mx ("gráfico circular") "Un gráfico donde el tamaño de cada sector circular corresponde a un valor en el conjunto de datos. Un recurso estadístico que se utiliza para representar porcentajes y proporciones"))
    
    ((en-us ("pixel" "pixels") "the smallest unit that makes up a digital image. The more pixels, the more detailed an image or video can appear."))
    
    ((en-us ("positive correlation") "relationship in which one variable increases as the other increases, and vice versa")
    (es-mx ("correlación positiva") "una relación en la que los valores de ambas variables tienden a aumentar juntos"))
    
    ((en-us ("predictor function" "predictor") "a function which, given a value from one dataset, makes an educated guess at a related value in a different dataset"))
    
    ((en-us ("produce") "to compute a value from an expression")
    (es-mx ("producen") "para calcular un valor de una expresión"))
    
    ((en-us ("programming language") "a set of rules for writing code that a computer can evaluate")
    (es-mx ("lenguaje de programación") "un conjunto de reglas para escribir código que una computadora puede evaluar"))
    
    ((en-us ("purpose statement") "a concise, detailed description of what a function does with its inputs")
    (es-mx ("declaración de propósito") "una breve descripción de lo que hace una función"))
    
    ((en-us ("quantitative data") "number values for which arithmetic makes sense")
    (es-mx ("datos cuantitativos") "datos con valores que miden alguna cantidad; puede no tener un número fijo de valores posibles"))
    
    ((en-us ("quartiles" "quartile") "three values that divide a dataset into four equal-sized groups")
    (es-mx ("cuartiles") "valores que dividen una muestra de datos en cuatro partes iguales"))
    
    ((en-us ("r" "r-value") "a number between −1 and 1 that measures the direction and strength of a linear relationship between two quantitative variables (also known as correlation value)"))
    
    ((en-us ("r-squared") "a number between 0 and 1 that measures the strength of association between two variables"))
    
    ((en-us ("random sample" "random samples") "a subset of individuals chosen from a larger set, such that each individual has the same probability of being chosen"))
    
    ((en-us ("range") "the type or set of outputs that a function produces")
    (es-mx ("rango") "el tipo de datos que produce una función o la diferencia entre el valor más alto y el más bajo"))
    
    ((en-us ("range of a dataset") "the distance between minimum and maximum values"))

    ((en-us ("rate") "A comparison of two related quantities")
      (es-mx ("tasa") "Una comparación de dos cantidades relacionadas"))
    
    ((en-us ("reactor") "a value that contains a current state, and functions for updating, drawing, and interacting with that state"))
    
    ((en-us ("rectangular prism" "rectangular prisms") "a solid figure which has 6 faces, all of which are rectangular")
      (es-mx ("prisma rectangular") "una figura sólida que tiene 6 caras, todas las cuales son rectangulares"))
    
    ((en-us ("refactor" "refactoring") "the process of changing the style or structure of a program's code, without changing the program's behavior"))
    
    ((en-us ("response variable" "response") "the variable in a relationship that is presumed to be affected by the other variable"))
        
    ((en-us ("sample" "samples") "a set of individuals or objects collected or selected from a statistical population by a defined procedure"))
    
    ((en-us ("sample instances") "a collection of single instances, or also used to describe illustrative instances that we use to provide examples of a data structure"))
    
    ((en-us ("scatter plot" "scatter plots") "a display of the relationship between two quantitative variables, graphing each explanatory value on the x axis and the accompanying response on the y axis")
    (es-mx ("gráfico de dispersión")  "Un gráfico donde los puntos se colocan en los ejes según pares de valores."))
    
    ((en-us ("select" "selects" "selecting") "a query that creates a table containing only a subset of a specified table's columns"))
    
    ((en-us ("shape") "The aspect of a dataset that tells which values are more or less common"))
    
    ((en-us ("sieve") "a table query that creates a table containing only rows that satisfy a boolean expression"))
    
    ((en-us ("skew" "skewness") "lack of balance in a dataset’s shape, arising from more values that are unusually low or high. Such values tend to trail off, rather than be separated by a gap (as with outliers)."))
    
    ((en-us ("skewed left" "skew left" "left skew") "A distribution is skewed left if there are a few values that are fairly low compared to the bulk of data values. A display of the data will show a longer tail to the left."))
    
    ((en-us ("skewed right" "skew right" "right skew") "A distribution is skewed right if there are a few values that are fairly high compared to the bulk of data values. A display of the data will show a longer tail to the right."))
    
    ((en-us ("slope") "the steepness of a straight line on a graph")
    (es-mx ("pendiente") "la inclinación de una línea recta en un gráfico"))
    
    ((en-us ("spread") "the extent to which values in a dataset vary, either from one another or from the center"))
    
    ((en-us ("state") "the value of a changing system at any point in time (i.e. a stoplight can be in the 'red', 'yellow' or 'green' state). In Pyret, the state of a Reactor is it's current value."))
    
    ((en-us ("statistical inference") "using information from a sample to draw conclusions about the larger population from which the sample was taken"))
    
    ((en-us ("strength") "of a relationship between two quantitative variables: the extent to which knowing the value of one variable tells us something about the value of the other"))
    
    ((en-us ("string") "a data type for any sequence of characters between quotation marks (examples: \"hello\", \"42\", \"this is a string!\")")
    (es-mx ("cadena" "cadenas") "cualquier secuencia de caracteres entre comillas (ejemplos: \"hello\", \" 42\", \"esto es una cadena! \")"))
    
    ((en-us ("surface area") "the sum of the areas of the faces of a polyhedron or the total area that the surface of a solid object occupies"))
    
    ((en-us ("symmetric" "symmetric distribution") "A symmetric distribution has a balanced shape, showing that it's just as likely for the variable to take lower values as higher values.")
      (es-mx ("distribución simétrica" "simétrica") "Una distribución simétrica tiene una forma equilibrada, lo que muestra que es tan probable que la variable tome valores más bajos como valores más altos."))
    
    ((en-us ("syntax") "the set of rules that defines a language, whether it be spoken, written, or programmed.")
    (es-mx ("sintaxis") "El conjunto de reglas que define un lenguaje, ya sea que se hable, se escriba o se programe."))
    
    ((en-us ("syntax error" "syntax errors") "errors where the computer cannot make sense of the code (e.g. - missing commas, parentheses, unclosed strings)"))
    
    ((en-us ("table" "tables") "a data structure that stores data as rows, with entries in particular columns")
    (es-mx ("tabla de datos") "una colección de datos organizados en filas y columnas."))
    
    ((en-us ("table plan") "a sequence of steps that helps people write code for several table queries, in order to solve a problem"))
    
    ((en-us ("table query" "table queries") "an expression that consumes tables and creates a new table object"))
    
    ((en-us ("threats to validity") "factors that can undermine the conclusion of a study"))
    
    ((en-us ("union" "unions") "the set of values that makes either or both of a set of inequalities true")
      (es-mx ("unión" "unión de conjuntos") "el conjunto de valores que hace que una o ambas desigualdades sean verdaderas"))
    
    ((en-us ("unit test") "an example showing the use of a function with a specific value or values, and the answer it should produce")
    (es-mx ("unidad de prueba") "un ejemplo que muestra el uso de una función con un valor o valores específicos y la respuesta que debe producir"))
    
    ((en-us ("value" "values") "a specific piece of data, like 5 or \"hello\"")
    (es-mx ("valor" "valores") "una pieza específica de datos, como 5 o \" hello \""))
    
    ((en-us ("variable" "variables") "a letter or symbol that stands in for a value or expression")
    (es-mx ("variable") "algo que cambia"))
    
    ((en-us ("variable name") "name of the information that can be different each time a function is used")
    (es-mx ("nombre de variable") "nombre de la información que puede ser diferente cada vez que se utiliza una función"))
    
    ((en-us ("vertical axis" "y-axis") "number line on a coordinate plane that runs from bottom to top, indicating values in that direction")
    (es-mx ("eje vertical") "El eje en un gráfico de dispersión que corre arriba y abajo"))
    
    ((en-us ("y-intercept") "The point where a line or curve crosses the y-axis of a graph")
      (es-mx ("intercepto" "intercepto vertical" "intersección en el eje Y") "El punto donde la recta o curva cruza el eje vertical (y)."))

    ))
