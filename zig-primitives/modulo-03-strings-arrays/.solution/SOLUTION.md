# Soluciones del Modulo 03: Strings y Arrays

## Enfoque general

Este modulo introduce las estructuras de datos mas fundamentales: arrays y strings. En Zig, los strings son simplemente arrays de bytes, lo cual es importante entender.

## Tarea 1: Manipular arrays basicos

La clave es entender que:
- Los indices empiezan en 0
- `.len` da la longitud
- Para el ultimo elemento usa `array[array.len - 1]`

**Error comun:** Intentar acceder a `dias[7]` cuando el array tiene 7 elementos (el ultimo indice valido es 6).

## Tarea 2: Iterar y procesar

Para encontrar maximos y minimos:
1. Inicializa con el primer elemento
2. Compara cada elemento con el valor actual
3. Actualiza si encuentras uno mayor/menor

**Por que inicializar con el primer elemento:** Si inicializaras `max = 0` y todas las temperaturas fueran negativas, obtendrias un resultado incorrecto.

## Tarea 3: Trabajar con strings

La conversion a mayusculas aprovecha que en ASCII:
- Minusculas van de 97 ('a') a 122 ('z')
- Mayusculas van de 65 ('A') a 90 ('Z')
- La diferencia es siempre 32

Por eso `c - 32` convierte una minuscula a mayuscula.

## Decisiones de diseno

1. **Por que usar i32 para temperaturas:** Las temperaturas pueden ser negativas, por lo que necesitamos un tipo con signo.

2. **Por que no usar funciones de la biblioteca estandar:** En esta etapa, queremos que entiendas los fundamentos. Mas adelante veras que `std.mem` tiene funciones utiles para strings.

## Extensiones posibles

- Modificar arrays en lugar de solo leerlos
- Trabajar con slices de los arrays
- Implementar busqueda binaria en un array ordenado
- Contar la frecuencia de cada letra en un string
