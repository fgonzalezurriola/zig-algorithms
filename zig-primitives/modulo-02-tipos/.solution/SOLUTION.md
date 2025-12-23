# Soluciones del Modulo 02: Tipos Primitivos

## Enfoque general

Este modulo enfatiza la importancia de elegir el tipo correcto para cada dato y como Zig requiere conversiones explicitas entre tipos.

## Tarea 1: Elegir tipos correctos

La clave es pensar en:
1. El rango de valores posibles
2. Si el valor puede ser negativo
3. Si necesita decimales

**Errores comunes:**
- Usar i32 para todo cuando u8 seria suficiente
- Olvidar que las temperaturas pueden ser negativas
- Usar enteros para precios con centavos

## Tarea 2: Conversiones de tipo

Aqui se practican las funciones built-in de conversion:
- `@floatFromInt()` para convertir entero a flotante
- `@intFromFloat()` para convertir flotante a entero
- `@intCast()` para convertir entre tamanios de enteros

**Nota importante:** Cuando conviertes de un tipo mas pequeno a uno mas grande (u8 a u64), no necesitas cast porque siempre es seguro. Pero al reves (u32 a u8), Zig requiere `@intCast` porque podria perder datos.

## Tarea 3: Calculadora de estadisticas

Este ejercicio combina:
- Aritmetica basica
- Conversion de tipos (entero a flotante para el promedio)
- Operadores de comparacion

**Por que convertir a flotante para el promedio:**
En la mayoria de lenguajes, 350/5 = 70 (division entera). Pero si las notas sumaran 351, 351/5 = 70 (perdemos el .2). Para calcular promedios exactos, convertimos a flotante primero.

## Extensiones posibles

- Encontrar la nota maxima y minima
- Calcular la desviacion estandar
- Experimentar con operadores de wraparound (+%, -%)
