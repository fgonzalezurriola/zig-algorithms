# Modulo 05: Funciones en Zig

## Objetivo

Aprender a definir y usar funciones en Zig. Entender como declarar parametros, tipos de retorno, y como las funciones interactuan con arrays y slices. Las funciones son fundamentales para organizar y reutilizar codigo.

## Prerequisitos

Debes haber completado los Modulos 01 al 04.

---

## Codigo a estudiar

### 1. Funcion basica

La estructura de una funcion en Zig:

```zig
const std = @import("std");

// Funcion que suma dos numeros
// Parametros: a (u32), b (u32)
// Retorna: u32
fn sumar(a: u32, b: u32) u32 {
    return a + b;
}

// Funcion que calcula el cuadrado
fn cuadrado(n: i32) i32 {
    return n * n;
}

pub fn main() void {
    const resultado = sumar(5, 3);
    std.debug.print("5 + 3 = {}\n", .{resultado});
    
    const c = cuadrado(7);
    std.debug.print("7^2 = {}\n", .{c});
    
    // Puedes usar el resultado directamente
    std.debug.print("10 + 20 = {}\n", .{sumar(10, 20)});
}
```

**Anatomia de una funcion:**
- `fn` - palabra clave para definir funcion
- `nombre` - identificador de la funcion
- `(parametros)` - lista de parametros con sus tipos
- `tipo_retorno` - tipo del valor que devuelve
- `{ cuerpo }` - codigo de la funcion

### 2. Funciones que no retornan valor (void)

Cuando una funcion solo ejecuta acciones sin devolver un valor:

```zig
const std = @import("std");

// void significa que no retorna nada
fn saludar(nombre: []const u8) void {
    std.debug.print("Hola, {s}!\n", .{nombre});
}

// Funcion que imprime una linea de separacion
fn separador() void {
    std.debug.print("-------------------\n", .{});
}

// Funcion que imprime un numero N veces
fn repetir_numero(n: u32, veces: u32) void {
    var i: u32 = 0;
    while (i < veces) : (i += 1) {
        std.debug.print("{} ", .{n});
    }
    std.debug.print("\n", .{});
}

pub fn main() void {
    saludar("Carlos");
    separador();
    repetir_numero(42, 5);
    separador();
    saludar("Maria");
}
```

**Nota:** Las funciones `void` no usan `return` con valor, pero pueden usar `return;` para salir temprano.

### 3. Funciones con multiples parametros

```zig
const std = @import("std");

// Calcular el area de un rectangulo
fn area_rectangulo(ancho: f32, alto: f32) f32 {
    return ancho * alto;
}

// Determinar si un numero esta en un rango
fn esta_en_rango(valor: i32, minimo: i32, maximo: i32) bool {
    return valor >= minimo and valor <= maximo;
}

// Calcular el precio con descuento
fn precio_con_descuento(precio: f32, porcentaje_descuento: f32) f32 {
    const descuento = precio * (porcentaje_descuento / 100.0);
    return precio - descuento;
}

pub fn main() void {
    const area = area_rectangulo(5.0, 3.0);
    std.debug.print("Area: {d:.2}\n", .{area});
    
    const edad: i32 = 25;
    if (esta_en_rango(edad, 18, 65)) {
        std.debug.print("Edad laboral\n", .{});
    }
    
    const precio_final = precio_con_descuento(100.0, 15.0);
    std.debug.print("Precio con 15% descuento: {d:.2}\n", .{precio_final});
}
```

### 4. Funciones que reciben arrays y slices

Para pasar arrays a funciones, usamos slices:

```zig
const std = @import("std");

// Sumar todos los elementos de un slice
fn sumar_elementos(numeros: []const u32) u32 {
    var suma: u32 = 0;
    for (numeros) |n| {
        suma += n;
    }
    return suma;
}

// Encontrar el valor maximo
fn maximo(numeros: []const i32) i32 {
    var max = numeros[0];
    for (numeros[1..]) |n| {
        if (n > max) {
            max = n;
        }
    }
    return max;
}

// Contar cuantos elementos cumplen una condicion
fn contar_mayores_que(numeros: []const u32, umbral: u32) u32 {
    var contador: u32 = 0;
    for (numeros) |n| {
        if (n > umbral) {
            contador += 1;
        }
    }
    return contador;
}

pub fn main() void {
    const datos = [_]u32{ 10, 25, 30, 5, 15, 40 };
    
    // Pasamos el array como slice con &
    const total = sumar_elementos(&datos);
    std.debug.print("Suma: {}\n", .{total});
    
    const temperaturas = [_]i32{ 22, -5, 30, 15, 28 };
    const max_temp = maximo(&temperaturas);
    std.debug.print("Temperatura maxima: {}\n", .{max_temp});
    
    const mayores = contar_mayores_que(&datos, 20);
    std.debug.print("Elementos mayores que 20: {}\n", .{mayores});
}
```

**Importante:**
- `[]const u32` es un slice de u32 (no podemos modificar los valores)
- `[]u32` seria un slice mutable
- `&array` convierte un array a slice

### 5. Funciones que modifican datos

Para modificar elementos, usamos slices mutables:

```zig
const std = @import("std");

// Duplicar cada elemento del array
fn duplicar_elementos(numeros: []u32) void {
    for (numeros) |*n| {
        n.* *= 2;
    }
}

// Llenar un array con un valor
fn llenar(arr: []i32, valor: i32) void {
    for (arr) |*elemento| {
        elemento.* = valor;
    }
}

// Invertir un array en su lugar
fn invertir(arr: []u32) void {
    if (arr.len < 2) return;
    
    var izq: usize = 0;
    var der: usize = arr.len - 1;
    
    while (izq < der) {
        const temp = arr[izq];
        arr[izq] = arr[der];
        arr[der] = temp;
        izq += 1;
        der -= 1;
    }
}

pub fn main() void {
    var numeros = [_]u32{ 1, 2, 3, 4, 5 };
    
    std.debug.print("Original: {any}\n", .{numeros});
    
    duplicar_elementos(&numeros);
    std.debug.print("Duplicado: {any}\n", .{numeros});
    
    invertir(&numeros);
    std.debug.print("Invertido: {any}\n", .{numeros});
    
    var otros = [_]i32{ 0, 0, 0, 0 };
    llenar(&otros, 42);
    std.debug.print("Lleno con 42: {any}\n", .{otros});
}
```

**Clave:** Para modificar, el array debe ser `var` y el slice no debe ser `const`.

### 6. Funciones que usan otras funciones

Las funciones pueden llamar a otras funciones:

```zig
const std = @import("std");

fn cuadrado(n: i32) i32 {
    return n * n;
}

fn suma(a: i32, b: i32) i32 {
    return a + b;
}

// Teorema de Pitagoras: c = sqrt(a^2 + b^2)
// Por ahora solo calculamos c^2
fn hipotenusa_cuadrado(a: i32, b: i32) i32 {
    return suma(cuadrado(a), cuadrado(b));
}

// Calcular distancia al cuadrado entre dos puntos
fn distancia_cuadrado(x1: i32, y1: i32, x2: i32, y2: i32) i32 {
    const dx = x2 - x1;
    const dy = y2 - y1;
    return hipotenusa_cuadrado(dx, dy);
}

pub fn main() void {
    // Triangulo 3-4-5
    const c2 = hipotenusa_cuadrado(3, 4);
    std.debug.print("3^2 + 4^2 = {} (debe ser 25)\n", .{c2});
    
    // Distancia entre (0,0) y (3,4)
    const dist2 = distancia_cuadrado(0, 0, 3, 4);
    std.debug.print("Distancia^2 de (0,0) a (3,4) = {}\n", .{dist2});
}
```

### 7. Retorno temprano

Puedes salir de una funcion antes de llegar al final:

```zig
const std = @import("std");

// Encontrar el indice de un elemento
fn buscar(arr: []const u32, objetivo: u32) ?usize {
    for (arr, 0..) |valor, i| {
        if (valor == objetivo) {
            return i;
        }
    }
    return null;
}

// Verificar si un array contiene solo positivos
fn todos_positivos(numeros: []const i32) bool {
    for (numeros) |n| {
        if (n <= 0) {
            return false;
        }
    }
    return true;
}

pub fn main() void {
    const datos = [_]u32{ 10, 20, 30, 40, 50 };
    
    if (buscar(&datos, 30)) |indice| {
        std.debug.print("30 encontrado en indice {}\n", .{indice});
    } else {
        std.debug.print("No encontrado\n", .{});
    }
    
    const positivos = [_]i32{ 1, 2, 3, 4, 5 };
    const mezclados = [_]i32{ 1, -2, 3, 4, 5 };
    
    std.debug.print("Todos positivos: {}\n", .{todos_positivos(&positivos)});
    std.debug.print("Todos positivos: {}\n", .{todos_positivos(&mezclados)});
}
```

**Nota:** El tipo `?usize` es un "optional" - puede contener un usize o null. Lo veremos en detalle mas adelante.

---

## Conceptos clave

- **fn**: Palabra clave para declarar funciones
- **Parametros**: Variables de entrada con tipos explicitos
- **Tipo de retorno**: Tipo del valor que devuelve (void si no devuelve nada)
- **Slices**: Forma de pasar arrays a funciones (`[]const T` o `[]T`)
- **return**: Devuelve un valor y sale de la funcion

---

## Tareas

### Tarea 1: Funciones matematicas basicas (Dificultad: Facil)

**Objetivo**: Crear funciones simples que reciben parametros y retornan valores.

**Archivo**: `starter/tarea1.zig`

**Que hacer**:
1. Implementar `valor_absoluto(n: i32) i32` - retorna el valor absoluto
2. Implementar `es_par(n: u32) bool` - retorna true si es par
3. Implementar `mayor_de_tres(a: i32, b: i32, c: i32) i32` - retorna el mayor

**Criterio de exito**: Todas las funciones retornan los valores correctos.

---

### Tarea 2: Funciones con arrays (Dificultad: Media)

**Objetivo**: Crear funciones que procesan slices.

**Archivo**: `starter/tarea2.zig`

**Que hacer**:
1. Implementar `promedio(numeros: []const u32) u32` - calcula el promedio
2. Implementar `contiene(arr: []const i32, valor: i32) bool` - busca un valor
3. Implementar `contar_pares(numeros: []const u32) u32` - cuenta numeros pares

**Criterio de exito**: Las funciones procesan correctamente los arrays de prueba.

---

### Tarea 3: Funciones que modifican y componen (Dificultad: Media)

**Objetivo**: Crear funciones que modifican arrays y se llaman entre si.

**Archivo**: `starter/tarea3.zig`

**Que hacer**:
1. Implementar `sumar_a_todos(arr: []i32, valor: i32) void` - suma valor a cada elemento
2. Implementar `aplicar_descuento(precios: []u32, porcentaje: u32) void` - reduce precios
3. Implementar una funcion que use las anteriores para procesar un inventario

**Criterio de exito**: Los arrays son modificados correctamente.

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

Para valor absoluto:
```zig
fn valor_absoluto(n: i32) i32 {
    return if (n < 0) -n else n;
}
```

Para es_par, usa el operador modulo: `n % 2 == 0`

Para mayor de tres, puedes encadenar comparaciones o usar if anidados.
</details>

<details>
<summary>Pista para Tarea 2</summary>

Para el promedio:
```zig
var suma: u32 = 0;
for (numeros) |n| {
    suma += n;
}
return suma / @as(u32, @intCast(numeros.len));
```

Para contiene, usa un for con return temprano cuando encuentres el valor.
</details>

<details>
<summary>Pista para Tarea 3</summary>

Para modificar elementos en un for:
```zig
for (arr) |*elemento| {
    elemento.* += valor;
}
```

El `*` en `|*elemento|` captura un puntero, y `elemento.*` accede al valor.
</details>

---

## Siguiente modulo

En el **Modulo 06: Structs** aprenderemos a crear nuestros propios tipos de datos combinando multiples valores en una sola estructura.
