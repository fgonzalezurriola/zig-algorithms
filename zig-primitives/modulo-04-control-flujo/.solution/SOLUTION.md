# Soluciones del Modulo 04: Control de Flujo

## Enfoque general

Este modulo ensenya las estructuras de control fundamentales de Zig. A diferencia de otros lenguajes, Zig tiene algunas particularidades importantes: `if` y `switch` pueden ser expresiones que devuelven valores, y `switch` debe ser exhaustivo.

## Tarea 1: Clasificador de numeros

### Parte 1: Positivo/Negativo/Cero
La estructura if/else/else if es directa. La clave es el orden de las comparaciones.

### Parte 2: Nombre del mes
El switch es perfecto para este caso. Cada valor del 1-12 mapea a un string.

**Decision de diseno:** Usamos `else` para manejar valores invalidos. En un programa real, podrias querer manejar este caso de otra forma (retornar un error, por ejemplo).

### Parte 3: Anio bisiesto
La regla es mas compleja de lo que parece:
- Divisible por 4 -> candidato
- PERO si es divisible por 100, NO es bisiesto
- EXCEPTO si tambien es divisible por 400

Ejemplos:
- 2024: divisible por 4, no por 100 -> bisiesto
- 1900: divisible por 4 y 100, no por 400 -> NO bisiesto
- 2000: divisible por 4, 100 Y 400 -> bisiesto

## Tarea 2: Bucles y acumuladores

### Parte 1: Factorial
El patron clasico:
1. Inicializar resultado en 1 (elemento neutro de multiplicacion)
2. Multiplicar por n y decrementar n
3. Parar cuando n = 1

**Error comun:** Inicializar en 0 causaria que el resultado siempre sea 0.

### Parte 2: Suma de pares
Demostramos el uso de `continue` para saltar elementos. Alternativa sin continue:

```zig
if (num % 2 == 0) {
    suma_pares += num;
}
```

Ambas formas son validas. `continue` es mas util cuando hay mucho codigo despues que no quieres ejecutar.

### Parte 3: Multiplo de 7
Demostramos `break` para salir temprano. Sin break, tendriamos que usar una bandera booleana, lo cual es mas complicado.

## Tarea 3: Calculadora de notas

### Conversion a letras
Switch con rangos es perfecto aqui. Nota que usamos `...` que es inclusivo en ambos extremos.

### Conteo
Usamos switch como statement (sin devolver valor) para incrementar contadores. Nota la rama `else => {}` que no hace nada pero es necesaria para hacer el switch exhaustivo.

### Promedio
Combinamos:
- for para sumar
- Division entera (Zig no tiene division con decimales automatica para enteros)
- if como expresion para el estado

## Errores comunes a evitar

1. **Olvidar llaves en if:** Zig las requiere siempre
2. **Switch no exhaustivo:** Debe cubrir todos los valores posibles o tener `else`
3. **Division entera:** `suma / notas.len` da entero, no decimal
4. **Bucles infinitos:** Asegurate de que la condicion eventualmente sea falsa

## Extensiones posibles

- Usar switch con bloques para logica mas compleja
- Implementar un menu interactivo con while
- Agregar validacion de entrada con switch sobre rangos
- Calcular la mediana ademas del promedio
