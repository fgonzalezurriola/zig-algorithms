# Soluciones del Modulo 05: Funciones

## Enfoque general

Las funciones son la unidad basica de organizacion de codigo en Zig. Este modulo introduce la sintaxis de funciones, paso de parametros, y como trabajar con arrays mediante slices.

## Tarea 1: Funciones matematicas basicas

### valor_absoluto
La solucion usa `if` como expresion, que es idiomatico en Zig:
```zig
return if (n < 0) -n else n;
```

Alternativa con if tradicional:
```zig
if (n < 0) {
    return -n;
}
return n;
```

### es_par
Simple uso del operador modulo. Retorna directamente el resultado de la comparacion booleana.

### mayor_de_tres
Se puede resolver de varias formas:
1. Comparaciones anidadas (solucion usada)
2. Usando el patron `if (a > b) a else b` encadenado
3. Con variables temporales

**Decision de diseno:** Usamos variable mutable para mayor claridad, aunque seria posible hacerlo en una linea.

## Tarea 2: Funciones con arrays

### promedio
Dos pasos claros:
1. Sumar todos los elementos
2. Dividir por la cantidad

**Importante:** Usamos `@as(u32, @intCast(numeros.len))` porque `.len` es `usize` y necesitamos `u32` para la division.

### contiene
Patron clasico de busqueda lineal con retorno temprano. Cuando encuentras el valor, retornas `true` inmediatamente. Si terminas el loop sin encontrarlo, retornas `false`.

### contar_pares
Similar a suma pero con condicion. Incrementas el contador solo cuando el elemento es par.

## Tarea 3: Funciones que modifican

### sumar_a_todos
La clave es usar `|*elemento|` para capturar un puntero al elemento, y luego `elemento.*` para acceder/modificar el valor.

### aplicar_descuento
El calculo del descuento es: `precio * porcentaje / 100`. Hacemos esto en dos pasos para claridad.

**Nota:** Usamos division entera, asi que un descuento del 10% sobre 85 daria 8 (no 8.5).

### procesar_inventario
Demuestra composicion de funciones: llamamos a `aplicar_descuento` y luego mostramos los resultados.

## Errores comunes a evitar

1. **Olvidar el `&` al pasar arrays:** Los arrays no son slices automaticamente, necesitas `&array` para convertirlos.

2. **Tipo de slice incorrecto:** `[]const T` para solo lectura, `[]T` para modificacion.

3. **Modificar sin puntero:** Para modificar elementos en un loop, DEBES usar `|*elemento|`, no `|elemento|`.

4. **Division de tipos diferentes:** Si `len` es `usize` y quieres dividir por el, convierte los tipos correctamente.

## Extensiones posibles

- Implementar funciones genericas que funcionen con cualquier tipo numerico
- Crear funciones que retornen multiples valores usando structs
- Implementar algoritmos clasicos como ordenamiento burbuja
- Trabajar con slices de slices (matrices)
