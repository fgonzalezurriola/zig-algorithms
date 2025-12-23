# Soluciones del Modulo 01: Variables y Constantes

## Enfoque general

El objetivo de este modulo es internalizar la filosofia de Zig respecto a la mutabilidad:

- **Inmutabilidad por defecto**: Usa `const` siempre que sea posible
- **Mutabilidad explicita**: Usa `var` solo cuando realmente necesites cambiar el valor

Esta filosofia hace que el codigo sea mas seguro y facil de razonar.

## Tarea 1: Declarar constantes

La clave es recordar la sintaxis: `const nombre: tipo = valor;`

**Errores comunes:**
- Olvidar los dos puntos antes del tipo
- Poner el tipo antes del nombre (como en C/Java)
- Confundir `f32` con `float`

## Tarea 2: Usar variables

Aqui practicamos operaciones aritmeticas basicas. Los operadores `+=` y `-=` funcionan igual que en otros lenguajes.

**Errores comunes:**
- Declarar con `const` y luego intentar modificar
- Olvidar que `-=` existe y escribir `puntos = puntos - 5`

## Tarea 3: Corregir errores

Este ejercicio refuerza la pregunta fundamental:

> "Este valor, se modifica despues de ser declarado?"

- Si se modifica -> `var`
- Si no se modifica -> `const`

Zig te obliga a ser explicito, lo cual es una ventaja para detectar errores.

## Decisiones de diseno

1. **Tipos explicitos vs inferidos**: En estos ejercicios usamos tipos explicitos para que te familiarices con la sintaxis. En codigo real, la inferencia es comun cuando el tipo es obvio.

2. **Por que u32 para puntos**: Es un tipo seguro para valores que sabemos seran positivos y no muy grandes. En aplicaciones reales, la eleccion del tipo depende del rango de valores esperado.

## Extensiones posibles

- Experimentar con diferentes tipos de enteros (u8, u16, i32)
- Ver que pasa cuando asignas un valor fuera del rango del tipo
- Probar operaciones entre tipos diferentes (spoiler: Zig no lo permite sin conversion explicita)
