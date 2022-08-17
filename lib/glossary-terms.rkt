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
     (es-mx ("aplicar" "applicado" "applicada") "dar argumentos a una función"))

    ((en-us ("argument") "the inputs to a function; the expressions for each argument follow the function name")
     (es-mx ("argumento") "los valores que se le dan a una función; las expresiones para los valores de cada argumento siguen el nombre de la función"))

    ((en-us ("ascending") "an order in which lower values appear first, and higher values appear after")
     (es-mx ("ascendente") "un orden de valores en la cual los más bajos aparecen primero y los más altos aparecen después"))

    ((en-us ("axis" "axes") "A reference line, used to determine the position of a coordinate")
     (es-mx ("eje") "Una línea de referencia, que se utiliza para determinar la posición de una coordenada."))

    ((en-us ("bar chart") "a display of categorical data that uses bars positioned over category values; each bar’s height reflects the count or percentage of data values in that category")
     (es-mx ("gráfico de barras") "una visualización de datos categóricos que utiliza barras colocadas sobre los valores de una categoría; la altura de cada barra refleja el número o el porcentaje de los valores en esa categoría"))

    ((en-us ("bias") "prejudice in favor of or against one outcome, person, or group compared with another, usually in a way considered to be unfair.")
     (es-mx ("bias") "prejudice in favor of or against one outcome, person, or group compared with another, usually in a way considered to be unfair."))

    ((en-us ("bin" "interval") "a range that values from a dataset can belong to; there is one bar in a histogram per bin")
     (es-mx ("intervalo") "un rango al que pueden pertenecer los valores de un conjunto de datos; hay una barra en un histograma por intervalo"))

    ((en-us ("Boolean") "a type of data with two values: true and false")
     (es-mx ("booleano") "un tipo de dato con dos valores: verdadero (true) y falso (false)"))

    ((en-us ("box plot") "the box plot (a.k.a. box-and whisker-plot) is a way of displaying a distribution of data based on the five-number summary: minimum, first quartile, median, third quartile, and maximum")
     (es-mx ("diagrama de caja" "diagramas de caja") "El diagrama de caja (también conocido como diagrama de caja y bigotes) es una forma de mostrar la distribución de datos basada en el resumen de cinco números: mínimo (el valor más bajo), primer cuartil, mediana, tercer cuartil y máximo (el valor más alto)."))

    ((en-us ("calling" "calls") "using a function by giving it inputs")
     (es-mx ("llamada") "Uso de una función dándole valores"))

    ((en-us ("category") "unique value(s) in a categorical dataset")
     (es-mx("categoría") "valores únicos en un conjunto de datos categórico"))

    ((en-us ("categorical data" "categorical") "data whose values are qualities that are not subject to the laws of arithmetic")
     (es-mx ("datos categóricos") "datos cuyos valores son cualidades que no están sujetas a las leyes de la aritmética"))

    ((en-us ("circle of evaluation" "circles of evaluation") "a 'sentence diagram' of the structure of a mathematical expression")
     (es-mx ("círculo de evaluación") "un diagrama de la estructura de una expresión matemática"))

    ((en-us ("clause") "a question and its corresponding answer in a conditional expression")
     (es-mx ("cláusula") "una pregunta y su correspondiente respuesta en una expresión condicional"))
    
    ((en-us ("chart") "visual reprsentations of how values in a dataset are distributed")
     (es-mx ("gráfico") "Representacion visual de la distribución de valores en un conjunto de datos."))

    ((en-us ("column") "set of values in a table of a particular type.  Every row has exactly 1 element in every column")
     (es-mx ("columna") "conjunto particular de valores en una tabla. Cada fila tiene exactamente 1 elemento en cada columna."))

    ((en-us ("combination") "the number of possible arrangements in a collection of items where the order of the selection does NOT matter. (ABC and CBA would be considered the same combination.)")
     (es-mx ("combinación") "el número de arreglos posibles con los elementos de un conjunto, donde el orden de los elementos usados NO importa. (ABC y CBA se consideran la misma combinación.)"))

    ((en-us ("comments" "comment") "messages in the code, generally ignored by the computer, to help people interacting with the code understand what it is doing")
     (es-mx ("comentarios de código") "anotaciones en el código que facilitan nuestra comprensión de lo que el código intenta hacer; la computadora no los lee"))

    ((en-us ("compound inequality" "compound inequalities") "an inequality that combines two simple inequalities using _and_ or _or_")
     (es-mx ("desigualdad compuesta") "una desigualdad que combina dos desigualdades simples con _o_ o _y_"))

    ((en-us ("conditional") "a code expression made of questions and answers")
     (es-mx ("condicional") "una expresión de código compuesta de preguntas y respuestas"))

    ((en-us ("confounding variable") "an unaccounted-for variable that influences the relationship between variables being analyzed")
     (es-mx ("confounding variable") ""))

    ((en-us ("constructor") "a function that creates instances of a data structure")
     (es-mx ("constructor") "la función que crea instancias de una estructura"))

    ((en-us ("contract") "a statement of the name, domain, and range of a function")
     (es-mx ("contrato") "una declaración con nombre, dominio y rango de una función"))

    ((en-us ("contract error") "errors where the code makes sense, but uses a function with the wrong number or type of arguments")
     (es-mx ("error de contrato") "errores donde el código tiene sentido, pero usa una función con el número o tipo de argumentos incorrectos"))

    ((en-us ("coordinate") "a number describing an object's location")
     (es-mx ("coordenada") "un número que describe la ubicación de un objeto"))

    ((en-us ("coordinate pair") "a set of numbers describing an object's location on the coordinate plane")
     (es-mx ("par ordenado") "conjunto de números que describen la ubicación de un objeto relacionándola con el eje-x (el primer valor del par ordenado) y con el eje-y (el segundo valor del par ordenado)"))

    ((en-us ("coordinate plane") "a grid formed by a pair of intersecting horizontal and vertical number lines")
     (es-mx ("plano de coordinadas" "plano cartesiano") "una cuadrícula formada por un par de rectas numéricas horizontales y verticales que se cruzan"))

    ((en-us ("correlation") "a single number somewhere between -1 and +1 that reports the direction and strength of the linear relationship between two quantitative variables (also known as the r-value)")
     (es-mx ("correlación") "un número entre -1 y +1 que informa sobre la dirección y la fuerza de la relación lineal entre dos variables cuantitativas (también conocido como el valor R)"))

    ((en-us ("data block") "code that lists the name, constructor(s), and field(s) of a data structure")
     (es-mx ("bloque de datos") "código que enumera el nombre, los constructores y los elementos de una estructura de datos"))

    ((en-us ("data row" "cases" "row") "a structured piece of data in a dataset that typically reports all the information gathered about a given individual")
     (es-mx ("fila de datos" "casos") "un conjunto de datos estructurados que usualmente representa toda la información recopilada sobre un individuo particular"))

    ((en-us ("data science") "the science of collecting, organizing, and drawing general conclusions from data, with the help of computers")
     (es-mx ("Ciencia de Datos") "la ciencia de recopilar, organizar y extraer conclusiones generales a partir de datos, con la ayuda de computadoras"))

    ((en-us ("dataset") "a collection of related information that is composed of separate elements, but can be manipulated as a unit by a computer")
     (es-mx ("conjunto de datos") "una colección de información relacionada que se compone de elementos separados, pero que una computadora puede manipular como una unidad"))

    ((en-us ("data structure") "a 'container' data type, which has fields that can hold other data (e.g. - a 'coordinate' is a data structure holding number fields x and y)")
     (es-mx ("estructura de datos" "estructuras de datos") "un tipo de dato con campos que pueden contener otros datos (por ejemplo, una 'coordenada' es una estructura de datos que contiene los campos numéricos *x* y *y*)"))

    ((en-us ("data type") "a way of classifying values, such as: Number, String, Image, Boolean, or any user-defined data structure")
     (es-mx ("tipo de datos" "tipos de datos") "Una manera de clasificar valores, como: Número, Cadena, Imagen, Booleano o cualquier estructura de datos definida por el usuario"))

    ((en-us ("debug") "to find and fix errors in one's code")
     (es-mx ("depurar") "encontrar y corregir errores en el código"))

    ((en-us ("define") "to associate a descriptive name with a value")
     (es-mx ("definir") "asociar un nombre descriptivo con un valor"))

    ((en-us ("definitions area") "the left-most text box in the Editor where definitions for values and functions are written")
     (es-mx ("área de definiciones") "el cuadro de texto en el editor, donde se definen valores y funciones"))

    ((en-us ("descending") "an order in which higher values appear first, and lower values appear after")
     (es-mx ("descendiente") "conjunto de valores ordenados de mayor a menor"))

    ((en-us ("design recipe") "a sequence of steps that helps people document, test, and write functions")
     (es-mx ("receta de diseño") "una secuencia de pasos que ayuda a las personas a documentar, probar y escribir funciones"))

    ((en-us ("dimension") "a measurement of something in a particular direction, especially height, length, or width. The dimensions of a computer screen, for example, are given as width x height.")
     (es-mx ("dimensión") "una medida de algo en una dirección particular, especialmente su altura, largo o ancho"))

    ((en-us ("direction") "the relationship between two quantitative variables: either they increase/decrease together or one may increase while the other decreases")
     (es-mx ("dirección") "la relación entre dos variables cuantitativas las cuales incrementan o decrecen juntas o una incrementa mientras la otra decrece"))

    ((en-us ("distribution") "a description of the number of times or relative probabilities that different quantities occur in a sample")
     (es-mx ("distribution") ""))

    ((en-us ("domain") "the type or set of inputs that a function expects")
     (es-mx ("dominio") "el tipo de input que requiere una función"))

    ((en-us ("dot accessor") "a way to extract the values of fields an instance")
     (es-mx ("punto-accesor") "Una manera de extraer valores de una estructura de datos"))
    
    ((en-us ("driver") "in pair programming, the person who is doing the typing, as directed by the navigator")
     (es-mx ("conductora") "en programación en pareja, la persona al teclado que sigue las indicaciones de la navegadora"))
    
    ((en-us ("edge") "a line segment on a solid figure, where two faces meet")
     (es-mx ("borde") "un segmento de recta en una figura tridimensional, donde dos caras se encuentran"))
    
    ((en-us ("editor") "software in which code can be written and evaluated")
     (es-mx ("editor") "software en el que se puede escribir y evaluar código"))

    ((en-us ("entry") "a single value in a table, belonging to a particular row and column")
     (es-mx ("dato") "un solo valor en una tabla, que pertenece a una fila y columna en particular"))

    ((en-us ("equation") "a mathematical description of the relationship between two variables or quantities, in which they are equal")
     (es-mx ("ecuación") "una descripción matemática de la relación entre dos variables o cantidades"))

    ((en-us ("error message") "information from the computer about errors in code")
     (es-mx ("mensaje de error" "mensajes de error") "información que provee la computadora sobre errores en el Código"))

    ((en-us ("evaluate") "perform the computation in an expression, producing an answer")
     (es-mx ("evaluar") "realizar los cálculos para obtener el valor de una expression"))

    ((en-us ("event") "something that happens outside of a running program, which the program can respond to")
     (es-mx ("eventos") "algo que sucede fuera de un programa en ejecución, al que el programa puede responder"))
    
    ((en-us ("event-based programming") "a style of programming in which every functions are written to respond to mouse-clicks, keypresses, etc.")
     (es-mx ("programacion basada en eventos") "un estilo de programación en el que se escriben todas las funciones para responder a los clics del ratón, pulsaciones de teclas, etc."))
    
    ((en-us ("example") "shows the use of a function on specific inputs and the computation the function should perform on those inputs")
     (es-mx ("ejemplos") "muestran el uso de una función con argumentos específicos y el cálculo que debe realizar la función con esos argumentos"))

    ((en-us ("examples block") "code that lists examples")
     (es-mx ("bloque de ejemplos") "código que enumera ejemplos"))
    
    ((en-us ("explanatory variable" "explanatory") "any variable that could impact the \"response variable\", generally plotted on the x-axis of a scatter plot")
     (es-mx ("variable explicativa") "cualquier factor que pueda influir en la variable de respuesta, generalmente representada en el eje x de un diagrama de dispersión."))

    ((en-us ("expression") "a computation written in the rules of some language (such as arithmetic, code, or a Circle of Evaluation)")
     (es-mx ("expresión") "un cálculo escrito en las reglas de algún lenguaje (como aritmética, código o un Círculo de Evaluación)"))
    
    ((en-us ("extend") "a table query that creates a table with new column(s), whose entries are computed with an expression")
     (es-mx ("extender") "una consulta de tabla que crea una tabla con nuevas columnas, cuyas entradas se calculan con una expresión"))
    
    ((en-us ("extract") "to construct a list using data from a particular column in a table")
     (es-mx ("extraer") "construir una lista de datos de una columna particular"))
    
    ((en-us ("face") "the flat surfaces on the outside of a solid figure")
     (es-mx ("cara") "las superficies planas en el exterior de una figura sólida"))
    
    ((en-us ("field") "a part of a data structure that has a name and holds a single value of a specified data type")
     (es-mx ("campo") "una parte de una estructura de datos que tiene un nombre y contiene un solo valor de un tipo específico"))
    
    ((en-us ("form") "the shape of a relationship between two quantitative variables: whether the two variables together vary linearly or in some other way")
     (es-mx ("forma") "la forma de una relación entre dos variables cuantitativas: si los dos variables varían juntas linealmente o de alguna otra manera"))
    
    ((en-us ("function") "a relation from a set of inputs to a set of possible outputs, where each input is related to exactly one output")
     (es-mx ("función") "una relación que consume argumentos y produce un resultado"))
    
    ((en-us ("function block") "code that names a function, lists its variables, and states the expression to compute when the function is used")
     (es-mx  ("bloque de función") "código que denomina la función, clasifica sus variables, y propone la expresión a evaluar cuando se utiliza la función"))
    
    ((en-us ("function definition" "definition") "code that names a function, lists its variables, and states the expression to compute when the function is used")
     (es-mx ("definición de función") "que designa una función, enumera sus variables e indica la expresión a evaluar cuando se utiliza la función"))

    ((en-us ("function notation") "a standard way to denote functions, beginning with a function name, such as _f_ or _gt_, the variable(s) the function takes in, such as _x_ or _size_, and a definition of what the function does using a formula in terms of the variable. For example, f(x) = x + 1 takes in a number and adds 1.")
     (es-mx ("notación de funciones") "una manera en la que una función puede ser representada usando símbolos y signos"))

    ((en-us ("frequency") "how often a particular value appears in a dataset")
     (es-mx ("frecuencia") "el número de veces que aparece un valor particular en un conjunto de datos"))
    
    ((en-us ("graph") "a diagram (such as a series of one or more points, lines, line segments, curves, or areas) that represents the variation of a variable in comparison with that of another variable.")
     (es-mx ("gráfico") "la representación en un plano de coordenadas de los pares ordenados, líneas, curvas o áreas que describen la relación entre dos variables"))

    ((en-us ("grouped sample") "a non-random subset of individuals chosen from a larger set, where the individuals belong to a specific group")
     (es-mx ("muestra agrupada") "un subconjunto no aleatorio de individuos elegidos de un conjunto de datos más grande, donde los individuos pertenecen a un grupo específico"))
    
    ((en-us ("handler") "Connects an event (like a tick or keypress) and a function within a reactor")
     (es-mx ("manejador") "Conecta un evento (como un tic o pulsación de tecla) y una función dentro de un reactor"))
    
    ((en-us ("header" "header row") "the titles of each column of a table, usually shown at the top")
     (es-mx ("encabezado") "los titulos de las columnas en una tabla de datos, que generalmente se muestran en la parte superior"))
    
    ((en-us ("helper function") "a small function that handles a specific part of another computation, and gets called from other functions")
     (es-mx ("función auxiliar") "Una función invocada desde otras funciones con el propósito de realizar una tarea concreta requerida por éstas" "operador"))
    
    ((en-us ("histogram") "a display of quantitative data that uses vertical bars positioned over bins (sub-intervals); each bar’s height reflects the count or percentage of data values in that bin.")
     (es-mx ("histograma") "Un gráfico de barras de frecuencia especial en el que cada barra cuenta la frecuencia de los valores que aparecen en un cierto intervalo."))
    
    ((en-us (("horizontal axis") ("x-axis")) "axis on a coordinate plane that runs from left to right")
     (es-mx ("eje horizontal") "eje en un diagrama de dispersión que va de izquierda a derecha"))
    
    ((en-us ("hypotenuse") "the side opposite the 90-degree angle in a right triangle")
     (es-mx ("hipotenusa") "el lado opuesto al ángulo de 90 grados en un triángulo rectángulo"))
    
    ((en-us ("identifier column") "a column of unique values which identify all the individual rows (e.g. - student IDs, SSNs, etc)")
     (es-mx ("columna de identificador") "una columna de valores únicos, que identifican todas las filas (por ejemplo - número de passaporte, número de estudiante, etc.)"))
    
    ((en-us ("image") "a type of data for pictures")
     (es-mx ("imagen") "un tipo de datos para representaciones visuales"))
    
    ((en-us ("inequality") "a mathematical description of the relationship between two variables or quantities, in which they are not necessarily equal")
     (es-mx ("desigualdad") "una afirmación que dos expresiones o valores no son iguales. hay varios símbolos de desigualdad que incluyen: desigual ≠, mayor que >, menor que <, menor o igual que ≤, mayor o igual que ≥"))
    
    ((en-us ("instance") "a specific example of a data structure, with specific values for each field (e.g. - (4,5) is an instance of an (x,y) coordinate")
    (es-mx ("instancia") "un ejemplo específico de una estructura de datos, con valores específicos para cada campo (por ejemplo, (4,5) es una instancia de una coordenada (x,y))"))
    
    ((en-us ("interactions area") "the right-most text box in the Editor, where expressions are entered to be evaluated")
     (es-mx ("área de interacciones") "el cuadro de texto a la derecha en el Editor, donde se ingresan las expresiones para ser evaluadas"))
    
    ((en-us ("interquartile range" "IQR") "(IQR) is one possible measure of spread, based on dividing a dataset into four parts. The values that divide each part are called the first quartile (Q1), the median, and third quartile (Q3). IQR is calculated as Q3 minus Q1.")
     (es-mx ("rango intercuartil" "IQR") "Posible medida de dispersión que está basada en la división de un conjunto de datos en cuatro partes. Los valores que dividen cada parte se denominan primer cuartil (Q1), mediana y tercer cuartil (Q3). IQR se calcula como Q3 menos Q1."))
    
    ((en-us ("intersection") "the set of values that makes both inequalities true")
     (es-mx ("intersección") "el conjunto de valores que hace que ambas desigualdades sean verdaderas"))
    
    ((en-us ("legal expression") "code that follows the Code Rules for a language")
     (es-mx ("expresión legal") "expresión que sigue las Reglas de Código para un lenguaje de programación"))
    
    ((en-us ("library") "a file containing definitions (functions, values, etc) that can be imported into another program")
     (es-mx ("biblioteca") "un archivo que contiene definiciones (funciones, valores, etc.) que se pueden importar a otro programa"))
    
    ((en-us ("line") "an infinite collection of points forming a straight one-dimensional figure having no thickness and extending infinitely in both directions")
     (es-mx ("línea") "una colección infinita de datos que forman una figura recta unidimensional que no tiene espesor y se extiende infinitamente en ambas direcciones"))
    
    ((en-us ("linear relationship" "linear") "sequences that change at a constant rate, or points forming a straight line on a graph")
     (es-mx ("lineal" "relación lineal") "una regla que calcula una cantidad a partir de otra, que se puede representar gráficamente como una línea recta o que se puede escribir como una secuencia de números que cambian a una tasa constante"))
    
    ((en-us ("linear regression") "a type of analysis that models the relationship between two quantitative variables. The result is known as a regression line, or line of best fit.")
     (es-mx ("regresión lineal") "un tipo de análisis que modela la relación entre dos variables cuantitativas. El resultado se conoce como línea de regresión o línea de mejor ajuste"))
    
    ((en-us ("line of best fit" "lines of best fit" "regression line" "regression lines" "least squares line") "summarizes the relationship (if linear) between two quantitative variables")
     (es-mx ("línea de mejor ajuste" "línea de tendencia" "mejor ajuste" "recta de mejor ajuste") "resume la relación (si es lineal) entre dos variables cuantitativas"))
    
    ((en-us ("list") "a data structure containing a sequence of values")
     (es-mx ("lista") "una estructura de datos que contiene una secuencia de valores"))
    
    ((en-us ("logic error") "errors in the way a programmer is thinking about a problem")
     (es-mx ("errores de logica") "errores en la forma en que un programador está pensando en un problema"))

    ((en-us ("mathematical expression") "a computation using the rules of arithmetic")
     (es-mx ("expresión matemática") "un cálculo realizado usando las reglas de la aritmética"))
    
    ((en-us ("maximum") "the largest value in a dataset")
     (es-mx ("máximo") "el mayor valor dentro de un grupo de números"))

    ((en-us (("mean") ("average")) "a representation of the center, or 'typical' value in a set of numbers, calculated as the sum of those numbers divided by the number of values.")
     (es-mx ("el promedio") "Un número que representa el centro o valor 'típico' en un conjunto de datos. Resultado que se obtiene al dividir la suma de varias cantidades entre el número de elementos sumados."))
    
    ((en-us ("median") "the middle element of a quantitative dataset")
     (es-mx ("mediana") "el elemento intermedio de un conjunto de datos cuantitativos ordenados"))

    ((en-us ("minimum") "the smallest value in a dataset")
     (es-mx ("mínimo") "el menor valor dentro de un grupo de números"))
    
    ((en-us ("method") "a function that is only associated with an instance of a data type, which consumes inputs and produces an output based on that instance")
     (es-mx ("método") "una función que solo está asociada con una instancia de un tipo de dato; la función consume argumentos y produce resultados basado en esa instancia"))
    
    ((en-us ("mode") "the most commonly appearing categorical or quantitative value or values in a dataset")
     (es-mx ("moda") "el valor (o valores) que ocurren con mayor frecuencia en un conjunto de datos"))
    
    ((en-us ("name") "how we refer to a function or value defined in a language (examples: +, *, star, circle)")
     (es-mx ("nombre") "cómo nos referimos a una función o valor definido en un idioma (ejemplos: +, *, star, circle)"))
    
    ((en-us ("null hypothesis") "the hypothesis that there is no significant difference between specified populations, any observed difference being due to sampling or experimental error.")
     (es-mx ("hipótesis nula") "la hipótesis de que no hay diferencia significativa entre poblaciones específicas, cualquier diferencia observada se debe a un error de muestreo o experimental."))

    ((en-us ("navigator") "in pair programming, the person who has their eyes on the screen directing the driver")
     (es-mx "navegadora" "en programación en pareja, la persona con los ojos en la pantalla, dirigiendo al conductor"))
    
    ((en-us ("negative correlation") "relationship in which one variable increases as the other decreases, and vice versa")
     (es-mx ("correlación negativa") "una relación en la que una variable incrementa a medida que la otra disminuye, y viceversa"))
    
    ((en-us ("nonlinear") "a pattern that is not a straight line when it is graphed")
     (es-mx ("relación no lineal" "no lineal") "tipo de relación que no es una línea recta cuando se representa gráficamente"))
    
    ((en-us ("normal" "normal distribution") "A normal distribution has a particular symmetric shape that bulges in the middle and tapers at the ends.")
     (es-mx ("distribución normal") "Una distribución normal tiene una forma simétrica particular que es más ancha en el medio y se estrecha en los extremos."))
    
    ((en-us ("number") "a data type representing a real number")
     (es-mx ("número") "un tipo de datos que representa un número real"))
    
    ((en-us ("operator") "a symbol that manipulates two Numbers and produces a result")
     (es-mx ("operador") "un símbolo que manipula dos números y produce un resultado"))
    
    ((en-us ("order") "an arrangement of data according to some pattern")
     (es-mx ("orden") "una disposición de datos de acuerdo con algún patrón"))

    ((en-us ("origin") "the point (0,0) where the horizontal and vertical axes intersect")
     (es-mx ("origen") "el punto (0,0) en el que el eje horizontal y el eje vertical se intersectan"))
    
    ((en-us ("outlier") "observations whose values are very different from the other observations in the same data set, perhaps due to experimental error. Outliers can also be indicative of data belonging to a different population from the rest of the established samples.")
     (es-mx ("valore atípico" "valores atípicos") "observaciones cuyos valores son muy diferentes al resto de observaciones del mismo grupo de datos, quizás debido a un error experimental. Los valores atípicos también pueden ser indicativos de datos pertenecientes a una población diferente del resto de las muestras establecidas."))
    
    ((en-us ("percentage") "a ratio showing the parts per hundred")
     (es-mx ("porcentaje") "la relación de proporción existente entre 2 números. Para hacerlo más intuitivo, se ha usado siempre la relación en términos de cien unidades"))

    ((en-us ("permutation") "the number of possible arrangements in a collection of items where the order of the selection matters (ABC and CBA would be considered different permutations)")
     (es-mx ("permutación") "el número de arreglos posibles en una colección de elementos donde el orden de la selección importa (ABC y CBA se considerarían permutaciones diferentes)"))
    
    ((en-us ("piecewise function") "a function that computes different expressions based on its input")
     (es-mx ("funciones por trozos") "una función que evalua diferentes expresiones basado en su argumento"))
    
    ((en-us ("pie chart") "a display that uses areas of a circular pie's slices to show percentages in each category")
     (es-mx ("gráfico circular") "Un gráfico donde el tamaño de cada sector circular corresponde a un valor en el conjunto de datos. Un recurso estadístico que se utiliza para representar porcentajes y proporciones"))
    
    ((en-us ("pixel") "the smallest unit that makes up a digital image. The more pixels, the more detailed an image or video can appear.")
     (es-mx ("pixel") "el elemento más pequeño en la que se puede descomponer una imagen digital. Cuantos más píxeles, más detallada puede aparecer una imagen o un video."))
    
    ((en-us ("positive correlation") "relationship in which one variable increases as the other increases, and vice versa")
     (es-mx ("correlación positiva") "una relación en la que los valores de ambas variables tienden a aumentar juntos"))
    
    ((en-us ("predictor function" "predictor") "a function which, given a value from one dataset, makes an educated guess at a related value in a different dataset")
     (es-mx ("función predictora") "una función que, dado un valor de un conjunto de datos, hace una suposición fundamentada sobre un valor relacionado en un conjunto de datos diferente"))
    
    ((en-us ("produce") "to compute a value from an expression")
     (es-mx ("producir") "calcular un valor a partir de una expresión"))
    
    ((en-us ("programming language") "a set of rules for writing code that a computer can evaluate")
     (es-mx ("lenguaje de programación") "un conjunto de reglas para escribir código que una computadora puede evaluar"))
    
    ((en-us ("purpose statement") "a concise, detailed description of what a function does with its inputs")
     (es-mx ("declaración de propósito") "una breve descripción de lo que hace una función"))
    
    ((en-us ("Pythagorean Theorem") "the relationship between the squares of the sides of a right triangle; can be used to find diagonal distances on the coordinate plane")
     (es-mx ("Teorema de Pitágoras") "en todo triángulo rectángulo, el cuadrado de la hipotenusa es igual a la suma de los cuadrados de los catetos; se puede usar para encontrar distancias diagonales en el plano de coordenadas"))

    ((en-us ("quantitative data" "quantitative") "number values for which arithmetic makes sense")
     (es-mx ("datos cuantitativos") "datos con valores que miden alguna cantidad; puede no tener un número fijo de valores posibles"))
    
    ((en-us ("quartile") "each of four equal groups into which a population can be divided according to the distribution of values of a particular variable.")
     (es-mx ("cuartiles") "valores que dividen una muestra de datos en cuatro partes iguales"))
    
    ((en-us ("r" "r-value") "a number between −1 and 1 that measures the direction and strength of a linear relationship between two quantitative variables (also known as correlation value)")
     (es-mx ("valor R") "un numero entre -1 y 1 que mide el dirección y la fuerza de una relación lineal entre dos variables cuantitativas"))
    
    ((en-us ("r-squared") "a number between 0 and 1 that measures the strength of association between two variables")
     (es-mx ("R-cuadrado") "un numero entre 0 y 1 que mide la fuerza de asociación entre dos variables"))
    
    ((en-us ("random sample") "a subset of individuals chosen from a larger set, such that each individual has the same probability of being chosen")
     (es-mx ("muestra aleatoria") "un subconjunto de individuos elegidos de un gran conjunto de datos que tiene la misma probabilidad de ser seleccionados"))
    
    ((en-us ("range") "the type or set of outputs that a function produces")
     (es-mx ("rango") "el tipo de datos que produce una función o la diferencia entre el valor más alto y el más bajo"))
    
    ((en-us ("range of a dataset") "the distance between minimum and maximum values")
     (es-mx ("rango de un conjunto de datos") "la distancia entre los valores mínimo y máximo"))

    ((en-us ("rate") "A comparison of two related quantities")
     (es-mx ("tasa") "Una comparación de dos cantidades relacionadas"))
    
    ((en-us ("ratio" "ratios") "the relative sizes of two or more values")
     (es-mx ("razón") "una comparación entre dos o más medidas"))
    
    ((en-us ("reactor") "a value that contains a current state, and functions for updating, drawing, and interacting with that state")
     (es-mx ("reactor") "un valor que contiene el estado corriente y funciones por actualizar, dibujar y interactuar con ese estado"))
    
    ((en-us ("rectangular prism") "a solid figure which has 6 faces, all of which are rectangular")
     (es-mx ("prisma rectangular") "una figura sólida que tiene 6 caras, todas ellas rectangulares"))
    
    ((en-us ("refactor") "the process of changing the style or structure of a program's code, without changing the program's behavior")
     (es-mx ("refactorizar") "el processo de cambiar el estilo o la estructura del código de un programa, sin cambiar el comportamiento del programa"))
    
    ((en-us ("response variable" "response") "the variable in a relationship that is presumed to be affected by the explanatory variable, generally plotted on the y-axis of a scatter plot")
     (es-mx ("variable de respuesta") "una variable de respuesta es una cantidad particular sobre la que hacemos una pregunta en nuestro estudio, generalmente representada en el eje y de un diagrama de dispersión"))
        
    ((en-us ("sample") "a set of individuals or objects collected or selected from a statistical population by a defined procedure")
     (es-mx ("muestra") "uun conjunto de individuos u objetos recopilados o seleccionados de una población estadística mediante un procedimiento definido"))
    
    ((en-us ("sample instances") "a collection of single instances, or also used to describe illustrative instances that we use to provide examples of a data structure")
     (es-mx ("instancias de muestra") "un conjunto de instancias únicas, usado para describir instancias ilustrativas que utilizamos para proporcionar ejemplos de una estructura de datos"))
    
   ((en-us ("sample size") "the number of participants or observations included in a study")
     (es-mx ("tamaño de la muestra") "aquel número determinado de sujetos o cosas que componen la muestra extraída de una población"))

    ((en-us ("scale" "scale up" "scale down") "resize an image to be larger or smaller while maintaining ratios and proportions")
     (es-mx ("escalar") "aumentar o reducir proporcionalmente"))
    
    ((en-us ("scatter plot") "a display of the relationship between two quantitative variables, graphing each explanatory value on the x axis and the accompanying response on the y axis")
     (es-mx ("gráfico de dispersión")  "Un gráfico donde los puntos se colocan en los ejes según pares de valores."))
    
    ((en-us ("selection bias") "the non-random selection of individuals, groups, or data")
     (es-mx ("selection bias") "the non-random selection of individuals, groups, or data"))

    ((en-us ("shape") "The aspect of a dataset - visible in a histogram or box plot - that describes which values are more or less common.")
     (es-mx ("forma de la distribución")  "el aspecto de un conjunto de datos -visible en una histograma o diagrama de caja - que describe cuáles de los valors son más o menos comun."))
        
    ((en-us ("skew" "skewness") "lack of balance in a dataset’s shape, arising from more values that are unusually low or high. Such values tend to trail off, rather than be separated by a gap (as with outliers).")
     (es-mx ("sesgo de una distribución") "falta de equilibrio en la forma de un conjunto de datos, que surge de la existencia de valores que son inusualmente bajos o altos. Estos valores tienden a aparecer como una cola más larga, en lugar de estar separados por un espacio (como es el caso de los valores atípicos)."))
    
    ((en-us ("skewed left" "skew left" "left skew") "A distribution is skewed left if there are a few values that are fairly low compared to the others. A histogram of data that is skewed left will have a clump of taller bars on the right, with smaller ones trailing off to the left, like the shape of the toes on a left foot.")
     (es-mx ("sesgo a la izquierda") "Una distribución está sesgada hacia la izquierda si hay algunos valores que son bastante bajos en comparación con los demás. Un histograma de datos que está sesgado hacia la izquierda tendrá un grupo de barras más altas a la derecha, y una cola de barras más reducida hacia la izquierda, como la forma de los dedos de un pie izquierdo.")) 
    
    ((en-us ("skewed right" "skew right" "right skew") "A distribution is skewed right if there are a few values that are fairly high compared to the bulk of data values. A histogram of data that is skewed right will have a clump of taller bars on the left, with smaller ones trailing off to the right, like the shape of the toes on a right foot.")
     (es-mx ("sesgo a la derecha") "Una distribución está sesgada a la derecha si hay algunos valores que son bastante altos en comparación con la mayor parte de los valores de los datos. Un histograma de datos que está sesgado a la derecha tendrá un grupo de barras más altas a la izquierda, y una cola de barras más reducida hacia la derecha, como la forma de los dedos del pie derecho."))

    ((en-us ("slope") "the steepness of a straight line on a graph")
     (es-mx ("pendiente") "la inclinación de una línea recta en un gráfico"))

    ((en-us ("solution set") "the set of all values or coordinate pairs that will make an equation, inequality, set of equations or set of inequalities true")
     (es-mx ("conjunto solución") "el conjunto de todos los elementos que hacen verdadera una ecuación o desigualdad"))
    
    ((en-us ("spread") "the extent to which values in a dataset vary, either from one another or from the center")
     (es-mx ("dispersión") "la medida en que los valores en un conjunto de datos varían, entre sí o desde el centro"))
    
    ((en-us ("standard deviation") "a number that measures spread of a data set using the typical distance of values from their mean")
     (es-mx ("Desviación Estándar") "un número que mide la dispersión de un conjunto de datos usando la distancia típica de los valores desde su media"))

    ((en-us ("state") "the value of a changing system at any point in time (i.e. a stoplight can be in the 'red', 'yellow' or 'green' state). In Pyret, the state of a Reactor is it's current value.")
     (es-mx ("estado") "el valor de un sistema que cambia en cualquier momento (es decir, un semáforo puede estar en un estado 'rojo', 'amarillo' o 'verde'). En Pyret, el estado de un reactor es su valor actual."))
    
    ((en-us ("statistical inference" "inference") "using information from a sample to draw conclusions about the larger population from which the sample was taken")
     (es-mx ("inferencia estadística") "utilizar información de una muestra para sacar conclusiones sobre la población más grande de la que se origina la muestra"))
    
    ((en-us ("strength") "of a relationship between two quantitative variables: how much the value of one variable tells us about the value of the other")
     (es-mx ("fuerza") "en una relación entre dos variables cuantitativas, cuánto nos dice el valor de una variable sobre el valor de la otra"))
    
    ((en-us ("string") "a data type for any sequence of characters between quotation marks (examples: \"hello\", \"42\", \"this is a string!\")")
     (es-mx ("cadena") "cualquier secuencia de caracteres entre comillas (ejemplos: \"hello\", \" 42\", \"esto es una cadena! \")"))
    
    ((en-us ("substitute") "replace a variable with a value or expression and evaluate or simplify the resulting expression")
     (es-mx ("sustitución") "reemplazar una variable por una cantidad o expresión y evaluar o simplificar"))
    
    ((en-us ("surface area") "the sum of the areas of all of the faces of a solid figure (polyhedron) or the total area that the surface of the object occupies")
     (es-mx ("área de superficie") "la suma de las áreas de todas las caras de una figura sólida (poliedro) o el área total que ocupa la superficie del objeto"))
    
    ((en-us ("symmetric" "symmetric distribution") "A symmetric distribution has a balanced shape, showing that it's just as likely for the variable to take lower values as higher values.")
     (es-mx ("distribución simétrica" "simétrica") "Una distribución simétrica tiene una forma equilibrada, lo que muestra que es igual de probable que la variable tome valores más bajos como valores más altos."))
    
    ((en-us ("syntax") "the set of rules that defines a language, whether it be spoken, written, or programmed.")
     (es-mx ("sintaxis") "El conjunto de reglas que define un lenguaje, ya sea que sea escrito, hablado o programado."))
    
    ((en-us ("syntax error") "errors where the computer cannot make sense of the code (e.g. - missing commas, missing parentheses, unclosed strings)")
     (es-mx ("errores de sintaxis") "errores en los que la computadora no puede entender en el código (por ejemplo, comas faltantes, paréntesis faltantes, cadenas sin cerrar)"))
    
    ((en-us ("table") "a data structure that stores data as rows, with entries in particular columns")
     (es-mx ("tabla de datos") "una colección de datos organizados en filas y columnas."))
        
    ((en-us ("threats to validity") "factors that can undermine the conclusion of a study")
     (es-mx ("amenazas a la validez") "factores que pueden perjudicar o debilitar la conclusion de un estudio"))
    
    ((en-us ("union") "the set of values that makes either or both of a set of inequalities true")
     (es-mx ("unión" "unión de conjuntos") "el conjunto de valores que hace que una o ambas desigualdades sean verdaderas"))
    
    ((en-us ("unit test") "an example showing the use of a function with a specific value or values, and the answer it should produce")
     (es-mx ("unidad de prueba") "un ejemplo que muestra el uso de una función con un valor o valores específicos y la respuesta que debe producir"))
    
    ((en-us ("value") "a specific piece of data, like 5 or \"hello\"")
     (es-mx ("valor") "una pieza específica de datos, como 5 o \" hello \""))
    
    ((en-us ("variable") "a name or symbol that stands for some value or expression, often a value or expression that changes")
     (es-mx ("variable") "algo que cambia"))
    
    ((en-us ("variable name") "name of the information that can be different each time a function is used")
     (es-mx ("nombre de variable") "nombre de la información que puede ser diferente cada vez que se utiliza una función"))
    
    ((en-us (("vertical axis") ("y-axis")) "number line on a coordinate plane that runs from bottom to top, indicating values in that direction")
     (es-mx ("eje vertical") "El eje en un gráfico de dispersión que corre de arriba hacia abajo"))
    
    ((en-us ("vertical line test") "a strategy for determining whether or not a graph represents a function by confirming that no vertical line can be drawn to reveal that an x-value corresponds to more than one y-value")
     (es-mx ("prueba de la línea vertical") "establece que una gráfica representa una función si y solo si todas las líneas verticales intersectan la gráfica a lo más una vez"))

    ((en-us ("x-coordinate") "first number of an ordered pair; represents the horizontal location of a point")
     (es-mx ("coordenada x") "primer número de un par ordenado; representa la ubicación horizontal del punto"))
    
    ((en-us ("y-intercept") "the point where a line or curve crosses the y-axis of a graph")
     (es-mx ("intercepto" "intercepto vertical" "intersección en el eje Y") "El punto donde la recta o curva cruza el eje vertical (y)."))

    ))
