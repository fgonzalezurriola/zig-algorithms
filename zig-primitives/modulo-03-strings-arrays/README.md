# Modulo 03: Strings y Arrays en Zig

## Objetivo

Entender como Zig maneja las cadenas de texto (strings) y los arrays. Aprender la diferencia entre arrays de tamanio fijo y slices, y como iterar sobre colecciones de datos.

## Prerequisitos

Debes haber completado el Modulo 01 y 02.

---

## Codigo a estudiar

### 1. Strings literales

En Zig, los strings literales son arrays de bytes (`u8`) terminados en null:

```zig
const std = @import("std");

pub fn main() void {
    // String literal - tipo: *const [12:0]u8
    // Significa: puntero a array constante de 12 bytes, terminado en null
    const saludo = "Hola, Mundo!";
    
    // Imprimir el string completo
    std.debug.print("{s}\n", .{saludo});
    
    // Acceder a caracteres individuales (son u8)
    std.debug.print("Primer caracter: {c}\n", .{saludo[0]});
    std.debug.print("Segundo caracter: {c}\n", .{saludo[1]});
    
    // Longitud del string
    std.debug.print("Longitud: {}\n", .{saludo.len});
}
```

**Puntos clave:**
- Los strings son secuencias de bytes (`u8`)
- `.len` te da la longitud
- Accedes a caracteres con `[indice]`, empezando en 0
- `{s}` es el formato para strings, `{c}` para caracteres individuales

### 2. Arrays de tamanio fijo

Los arrays en Zig tienen tamanio conocido en tiempo de compilacion:

```zig
const std = @import("std");

pub fn main() void {
    // Array de 5 enteros - tipo explicito
    const numeros: [5]u32 = [5]u32{ 10, 20, 30, 40, 50 };
    
    // Zig puede inferir el tamanio con _
    const letras = [_]u8{ 'a', 'b', 'c', 'd' };
    
    // Acceder a elementos
    std.debug.print("Primer numero: {}\n", .{numeros[0]});
    std.debug.print("Ultima letra: {c}\n", .{letras[3]});
    
    // Longitud
    std.debug.print("Total numeros: {}\n", .{numeros.len});
    std.debug.print("Total letras: {}\n", .{letras.len});
    
    // Array inicializado con el mismo valor
    const ceros = [_]i32{ 0, 0, 0, 0, 0 };
    
    // Forma mas elegante: usando multiplicacion de arrays
    const unos: [5]i32 = [_]i32{1} ** 5;
    std.debug.print("Unos: {any}\n", .{unos});
}
```

**Sintaxis de arrays:**
- `[N]T` - array de N elementos de tipo T
- `[_]T{ ... }` - Zig infiere el tamanio
- `[_]T{valor} ** N` - repite el valor N veces

### 3. Iterar sobre arrays con for

El bucle `for` es la forma idiomatica de recorrer arrays:

```zig
const std = @import("std");

pub fn main() void {
    const notas = [_]u32{ 85, 92, 78, 90, 88 };
    
    // Forma basica: solo el valor
    std.debug.print("Notas:\n", .{});
    for (notas) |nota| {
        std.debug.print("  - {}\n", .{nota});
    }
    
    // Con indice
    std.debug.print("\nCon indices:\n", .{});
    for (notas, 0..) |nota, i| {
        std.debug.print("  Nota {}: {}\n", .{ i, nota });
    }
    
    // Iterar sobre un rango de numeros
    std.debug.print("\nContando del 1 al 5:\n", .{});
    for (1..6) |n| {
        std.debug.print("  {}\n", .{n});
    }
}
```

**Sintaxis del for:**
- `for (array) |elemento|` - itera sobre cada elemento
- `for (array, 0..) |elemento, indice|` - con indice empezando en 0
- `for (inicio..fin) |n|` - itera sobre un rango (fin excluido)

### 4. Slices: vistas a porciones de arrays

Un slice es una "vista" a una porcion de un array. No tiene tamanio fijo en tiempo de compilacion:

```zig
const std = @import("std");

pub fn main() void {
    const completo = [_]u32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    
    // Slice de los primeros 3 elementos
    const primeros: []const u32 = completo[0..3];
    std.debug.print("Primeros 3: {any}\n", .{primeros});
    
    // Slice del indice 5 al 8 (excluye el 8)
    const medio = completo[5..8];
    std.debug.print("Medio: {any}\n", .{medio});
    
    // Slice desde un punto hasta el final
    const ultimos = completo[7..];
    std.debug.print("Ultimos: {any}\n", .{ultimos});
    
    // Slice desde el inicio hasta un punto
    const hasta_cinco = completo[0..5];
    std.debug.print("Hasta 5: {any}\n", .{hasta_cinco});
    
    // Los slices tienen longitud
    std.debug.print("Longitud de primeros: {}\n", .{primeros.len});
}
```

**Sintaxis de slices:**
- `array[inicio..fin]` - desde inicio hasta fin (excluido)
- `array[inicio..]` - desde inicio hasta el final
- `array[0..fin]` - desde el inicio hasta fin

### 5. Arrays mutables

Para modificar elementos, declara el array con `var`:

```zig
const std = @import("std");

pub fn main() void {
    // Array mutable
    var puntuaciones = [_]u32{ 0, 0, 0, 0, 0 };
    
    std.debug.print("Inicial: {any}\n", .{puntuaciones});
    
    // Modificar elementos individuales
    puntuaciones[0] = 100;
    puntuaciones[1] = 85;
    puntuaciones[2] = 92;
    
    std.debug.print("Modificado: {any}\n", .{puntuaciones});
    
    // Modificar en un loop
    for (&puntuaciones) |*p| {
        p.* += 5; // Sumar 5 a cada elemento
    }
    
    std.debug.print("Con bonus: {any}\n", .{puntuaciones});
}
```

**Para modificar en un loop:**
- Usa `&array` para obtener referencias
- Usa `|*elemento|` para capturar un puntero
- Usa `elemento.*` para acceder/modificar el valor

### 6. Operaciones con strings

```zig
const std = @import("std");

pub fn main() void {
    const nombre = "Ana";
    const apellido = "Garcia";
    
    // Iterar sobre caracteres
    std.debug.print("Letras del nombre: ", .{});
    for (nombre) |c| {
        std.debug.print("{c} ", .{c});
    }
    std.debug.print("\n", .{});
    
    // Comparar strings
    const otro_nombre = "Ana";
    const son_iguales = std.mem.eql(u8, nombre, otro_nombre);
    std.debug.print("Son iguales: {}\n", .{son_iguales});
    
    // Buscar un caracter
    if (std.mem.indexOf(u8, apellido, "c")) |pos| {
        std.debug.print("'c' encontrada en posicion: {}\n", .{pos});
    } else {
        std.debug.print("'c' no encontrada\n", .{});
    }
}
```

**Funciones utiles de std.mem:**
- `std.mem.eql(u8, a, b)` - compara dos strings
- `std.mem.indexOf(u8, str, patron)` - busca un patron

---

## Conceptos clave

- **String literal**: Array de bytes terminado en null (`*const [N:0]u8`)
- **Array**: Coleccion de tamanio fijo conocido en compilacion
- **Slice**: Vista a una porcion de un array, tamanio conocido en runtime
- **for**: Itera sobre arrays, slices o rangos
- **Indices**: Empiezan en 0, acceso con `[i]`

---

## Tareas

### Tarea 1: Manipular arrays basicos (Dificultad: Facil)

**Objetivo**: Practicar la creacion y acceso a arrays.

**Archivo**: `starter/tarea1.zig`

**Que hacer**:
1. Crear un array con los dias de la semana (como numeros del 1 al 7)
2. Imprimir el primer y ultimo dia
3. Calcular e imprimir la suma de todos los dias

**Criterio de exito**: El programa muestra primer dia=1, ultimo dia=7, suma=28.

---

### Tarea 2: Iterar y procesar (Dificultad: Media)

**Objetivo**: Usar for loops para procesar arrays.

**Archivo**: `starter/tarea2.zig`

**Que hacer**:
1. Dado un array de temperaturas, encontrar la temperatura maxima
2. Encontrar la temperatura minima
3. Calcular el promedio

**Criterio de exito**: Muestra max=35, min=18, promedio correcto.

---

### Tarea 3: Trabajar con strings (Dificultad: Media)

**Objetivo**: Manipular strings y caracteres.

**Archivo**: `starter/tarea3.zig`

**Que hacer**:
1. Dado un string, contar cuantas vocales contiene
2. Determinar si el string contiene la letra 'z'
3. Imprimir el string en mayusculas

**Criterio de exito**: El programa cuenta correctamente las vocales y transforma a mayusculas.

---

## Verificacion

```bash
# Ejecutar cada tarea
zig run starter/tarea1.zig
zig run starter/tarea2.zig
zig run starter/tarea3.zig

# Comparar con las soluciones
zig run .solution/tarea1.zig
zig run .solution/tarea2.zig
zig run .solution/tarea3.zig
```

---

## Pistas

<details>
<summary>Pista para Tarea 1</summary>

Para crear el array: `const dias = [_]u32{ 1, 2, 3, 4, 5, 6, 7 };`

Para el ultimo elemento, recuerda que los indices empiezan en 0, asi que el septimo elemento esta en `dias[6]` o puedes usar `dias[dias.len - 1]`.

Para la suma, usa un loop for con una variable acumuladora.
</details>

<details>
<summary>Pista para Tarea 2</summary>

Para encontrar el maximo, empieza asumiendo que el primer elemento es el maximo:

```zig
var max = temperaturas[0];
for (temperaturas) |temp| {
    if (temp > max) {
        max = temp;
    }
}
```

Para el minimo es similar pero con `<`.
</details>

<details>
<summary>Pista para Tarea 3</summary>

Para verificar si un caracter es una vocal, puedes comparar:

```zig
if (c == 'a' or c == 'e' or c == 'i' or c == 'o' or c == 'u') {
    contador += 1;
}
```

Para convertir a mayusculas, los caracteres ASCII minusculos (a-z) son 32 mayor que sus mayusculas. Asi que `'a' - 32 = 'A'`.
</details>

---

## Siguiente modulo

En el **Modulo 04: Control de Flujo** aprenderemos sobre condicionales (`if`), bucles (`while`, `for`), y las estructuras de control especificas de Zig como `switch`.
