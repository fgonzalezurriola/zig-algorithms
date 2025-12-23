# Modulo 04: Control de Flujo en Zig

## Objetivo

Aprender a controlar el flujo de ejecucion en Zig usando condicionales (`if/else`), bucles (`while`, `for`), y la potente estructura `switch`. Tambien veremos como usar `break` y `continue` para control mas fino.

## Prerequisitos

Debes haber completado los Modulos 01, 02 y 03.

---

## Codigo a estudiar

### 1. Condicionales basicos: if/else

El `if` en Zig funciona de manera similar a otros lenguajes, pero con algunas particularidades:

```zig
const std = @import("std");

pub fn main() void {
    const edad: u32 = 18;
    
    // if basico
    if (edad >= 18) {
        std.debug.print("Eres mayor de edad\n", .{});
    }
    
    // if con else
    if (edad >= 21) {
        std.debug.print("Puedes beber en USA\n", .{});
    } else {
        std.debug.print("No puedes beber en USA\n", .{});
    }
    
    // if con else if
    const nota: u32 = 85;
    if (nota >= 90) {
        std.debug.print("Excelente!\n", .{});
    } else if (nota >= 80) {
        std.debug.print("Muy bien!\n", .{});
    } else if (nota >= 70) {
        std.debug.print("Bien\n", .{});
    } else {
        std.debug.print("Necesitas mejorar\n", .{});
    }
}
```

**Puntos clave:**
- Las condiciones NO llevan parentesis obligatorios (pero puedes usarlos)
- Las llaves `{}` son OBLIGATORIAS, no puedes omitirlas
- No existe el operador ternario `? :` de otros lenguajes

### 2. If como expresion

Una caracteristica poderosa de Zig: `if` puede devolver un valor:

```zig
const std = @import("std");

pub fn main() void {
    const temperatura: i32 = 25;
    
    // if como expresion - devuelve un valor
    const estado = if (temperatura > 30) 
        "caluroso" 
    else if (temperatura > 20) 
        "agradable" 
    else 
        "frio";
    
    std.debug.print("El clima esta {s}\n", .{estado});
    
    // Otro ejemplo: valor absoluto
    const numero: i32 = -42;
    const absoluto = if (numero < 0) -numero else numero;
    std.debug.print("Valor absoluto de {}: {}\n", .{ numero, absoluto });
    
    // Asignar maximo de dos valores
    const a: u32 = 15;
    const b: u32 = 23;
    const maximo = if (a > b) a else b;
    std.debug.print("El mayor es: {}\n", .{maximo});
}
```

**Importante:**
- Cuando usas `if` como expresion, DEBE tener un `else`
- Ambas ramas deben devolver el mismo tipo

### 3. Bucle while

El bucle `while` repite mientras una condicion sea verdadera:

```zig
const std = @import("std");

pub fn main() void {
    // while basico - contar del 1 al 5
    var i: u32 = 1;
    while (i <= 5) {
        std.debug.print("Contando: {}\n", .{i});
        i += 1;
    }
    
    // while con continue - saltar pares
    std.debug.print("\nSolo impares:\n", .{});
    var j: u32 = 0;
    while (j < 10) {
        j += 1;
        if (j % 2 == 0) {
            continue;  // Salta a la siguiente iteracion
        }
        std.debug.print("{} ", .{j});
    }
    std.debug.print("\n", .{});
    
    // while con break - salir temprano
    std.debug.print("\nBuscando el 7:\n", .{});
    var k: u32 = 0;
    while (k < 100) {
        k += 1;
        if (k == 7) {
            std.debug.print("Encontrado!\n", .{});
            break;  // Sale del bucle inmediatamente
        }
    }
}
```

**Puntos clave:**
- `continue` salta a la siguiente iteracion
- `break` sale del bucle inmediatamente
- Cuidado con bucles infinitos si olvidas incrementar

### 4. While con else

Zig permite un bloque `else` en `while` que se ejecuta si el bucle termina normalmente (sin `break`):

```zig
const std = @import("std");

pub fn main() void {
    const numeros = [_]u32{ 1, 3, 5, 7, 9 };
    
    // Buscar un numero par
    var i: usize = 0;
    while (i < numeros.len) : (i += 1) {
        if (numeros[i] % 2 == 0) {
            std.debug.print("Encontre un par: {}\n", .{numeros[i]});
            break;
        }
    } else {
        // Se ejecuta si NO hubo break
        std.debug.print("No hay numeros pares\n", .{});
    }
}
```

**Sintaxis alternativa del while:**
- `while (cond) : (incremento)` - el incremento se ejecuta en cada iteracion

### 5. Bucle for

El `for` itera sobre arrays, slices o rangos:

```zig
const std = @import("std");

pub fn main() void {
    const frutas = [_][]const u8{ "manzana", "pera", "naranja", "uva" };
    
    // for basico sobre array
    std.debug.print("Frutas disponibles:\n", .{});
    for (frutas) |fruta| {
        std.debug.print("  - {s}\n", .{fruta});
    }
    
    // for con indice
    std.debug.print("\nCon indices:\n", .{});
    for (frutas, 0..) |fruta, i| {
        std.debug.print("  {}: {s}\n", .{ i, fruta });
    }
    
    // for con break
    std.debug.print("\nBuscar 'pera':\n", .{});
    for (frutas) |fruta| {
        if (std.mem.eql(u8, fruta, "pera")) {
            std.debug.print("Encontrada!\n", .{});
            break;
        }
    }
    
    // for sobre rango
    std.debug.print("\nTabla del 5:\n", .{});
    for (1..11) |n| {
        std.debug.print("5 x {} = {}\n", .{ n, 5 * n });
    }
}
```

**Diferencia entre for y while:**
- `for` es para iterar sobre colecciones o rangos conocidos
- `while` es para condiciones generales

### 6. Switch

El `switch` es muy poderoso en Zig, mas que en muchos otros lenguajes:

```zig
const std = @import("std");

pub fn main() void {
    const dia: u8 = 3;
    
    // switch basico
    const nombre_dia = switch (dia) {
        1 => "Lunes",
        2 => "Martes",
        3 => "Miercoles",
        4 => "Jueves",
        5 => "Viernes",
        6 => "Sabado",
        7 => "Domingo",
        else => "Dia invalido",
    };
    std.debug.print("Hoy es {s}\n", .{nombre_dia});
    
    // switch con rangos
    const nota: u32 = 85;
    const calificacion = switch (nota) {
        0...59 => "Reprobado",
        60...69 => "Suficiente",
        70...79 => "Bien",
        80...89 => "Muy bien",
        90...100 => "Excelente",
        else => "Nota invalida",
    };
    std.debug.print("Calificacion: {s}\n", .{calificacion});
    
    // switch con multiples valores
    const letra: u8 = 'a';
    const tipo = switch (letra) {
        'a', 'e', 'i', 'o', 'u' => "vocal",
        'b'...'d', 'f'...'h', 'j'...'n', 'p'...'t', 'v'...'z' => "consonante",
        else => "no es letra",
    };
    std.debug.print("'{c}' es una {s}\n", .{ letra, tipo });
}
```

**Caracteristicas del switch:**
- DEBE cubrir todos los casos posibles o tener `else`
- Puede usar rangos con `...` (inclusivo)
- Puede agrupar valores con `,`
- Puede devolver un valor (es una expresion)

### 7. Switch con bloques

Para casos que necesitan multiples lineas:

```zig
const std = @import("std");

pub fn main() void {
    const opcion: u8 = 2;
    
    const resultado = switch (opcion) {
        1 => blk: {
            std.debug.print("Procesando opcion 1...\n", .{});
            break :blk 100;
        },
        2 => blk: {
            std.debug.print("Procesando opcion 2...\n", .{});
            const valor = 50 * 2;
            break :blk valor;
        },
        else => 0,
    };
    
    std.debug.print("Resultado: {}\n", .{resultado});
}
```

**Sintaxis de bloques etiquetados:**
- `blk: { ... break :blk valor; }` - el bloque tiene nombre y puede devolver un valor

---

## Conceptos clave

- **if/else**: Condicionales que pueden ser expresiones
- **while**: Bucle basado en condicion, soporta break/continue
- **for**: Iteracion sobre colecciones o rangos
- **switch**: Seleccion multiple, debe ser exhaustivo
- **break**: Sale del bucle actual
- **continue**: Salta a la siguiente iteracion

---

## Tareas

### Tarea 1: Clasificador de numeros (Dificultad: Facil)

**Objetivo**: Practicar if/else y switch basico.

**Archivo**: `starter/tarea1.zig`

**Que hacer**:
1. Dado un numero, determinar si es positivo, negativo o cero usando if/else
2. Dado un numero del 1-12, devolver el nombre del mes usando switch
3. Determinar si un anio es bisiesto

**Criterio de exito**: El programa clasifica correctamente varios numeros de ejemplo.

---

### Tarea 2: Bucles y acumuladores (Dificultad: Media)

**Objetivo**: Usar while y for con break/continue.

**Archivo**: `starter/tarea2.zig`

**Que hacer**:
1. Usando while, calcular el factorial de 5 (5! = 120)
2. Usando for, sumar solo los numeros pares de un array
3. Encontrar el primer multiplo de 7 mayor que 50

**Criterio de exito**: Factorial=120, suma de pares correcta, multiplo=56.

---

### Tarea 3: Calculadora de notas (Dificultad: Media)

**Objetivo**: Combinar switch como expresion con iteracion.

**Archivo**: `starter/tarea3.zig`

**Que hacer**:
1. Dado un array de notas numericas, convertir cada una a letra (A, B, C, D, F)
2. Contar cuantas notas de cada letra hay
3. Determinar si el estudiante aprueba (promedio >= 60)

**Criterio de exito**: Convierte correctamente las notas y muestra el resumen.

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

Para el if/else de positivo/negativo/cero:

```zig
if (numero > 0) {
    // positivo
} else if (numero < 0) {
    // negativo
} else {
    // cero
}
```

Para anio bisiesto: un anio es bisiesto si es divisible por 4, EXCEPTO si es divisible por 100, A MENOS que tambien sea divisible por 400.

```zig
const es_bisiesto = (anio % 4 == 0 and anio % 100 != 0) or (anio % 400 == 0);
```
</details>

<details>
<summary>Pista para Tarea 2</summary>

Para el factorial con while:

```zig
var factorial: u32 = 1;
var n: u32 = 5;
while (n > 1) {
    factorial *= n;
    n -= 1;
}
```

Para encontrar el primer multiplo de 7 mayor que 50, empieza en 51 y usa un while con break.
</details>

<details>
<summary>Pista para Tarea 3</summary>

Para convertir nota a letra usa switch con rangos:

```zig
const letra = switch (nota) {
    90...100 => 'A',
    80...89 => 'B',
    // etc...
};
```

Para contar las letras, puedes usar variables separadas: `var count_a: u32 = 0;`
</details>

---

## Siguiente modulo

En el **Modulo 05: Funciones** aprenderemos a definir nuestras propias funciones, pasar parametros, retornar valores, y organizar mejor nuestro codigo.
