# Modulo 01: Variables y Constantes en Zig

## Objetivo

Aprender la diferencia fundamental entre `const` y `var` en Zig, entender por que Zig prefiere la inmutabilidad por defecto, y practicar la declaracion de variables con tipos explicitos e inferidos.

## Introduccion a Zig

Zig es un lenguaje de programacion de sistemas disenado para ser simple, seguro y eficiente. A diferencia de otros lenguajes, Zig:

- No tiene garbage collector (como C/C++)
- Tiene un sistema de tipos estricto
- Prefiere la inmutabilidad por defecto
- Es muy explicito: no hay "magia" oculta

### Tu primer programa Zig

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hola, Zig!\n", .{});
}
```

**Desglose linea por linea:**

1. `const std = @import("std");` - Importa la biblioteca estandar de Zig
2. `pub fn main() void` - Define la funcion principal (pub = publica, void = no retorna nada)
3. `std.debug.print(...)` - Imprime texto a la consola de depuracion
4. `.{}` - Tupla vacia (los argumentos para formatear, lo veremos despues)

---

## Codigo a estudiar

### 1. Constantes con `const`

En Zig, `const` declara un valor que **nunca puede cambiar**. Es la opcion preferida y debes usarla siempre que sea posible.

```zig
const std = @import("std");

pub fn main() void {
    // Declaracion con tipo explicito
    const edad: u32 = 25;
    
    // Declaracion con tipo inferido (Zig deduce que es i32)
    const temperatura = -5;
    
    // Constante de punto flotante
    const pi: f64 = 3.14159;
    
    // Constante booleana
    const esta_activo: bool = true;
    
    std.debug.print("Edad: {}\n", .{edad});
    std.debug.print("Temperatura: {}\n", .{temperatura});
    std.debug.print("Pi: {d:.2}\n", .{pi});
    std.debug.print("Activo: {}\n", .{esta_activo});
}
```

**Puntos importantes:**

- El tipo va DESPUES del nombre: `nombre: tipo = valor`
- Si omites el tipo, Zig lo infiere automaticamente
- Los enteros sin signo usan `u` (u8, u16, u32, u64)
- Los enteros con signo usan `i` (i8, i16, i32, i64)
- El numero indica los bits (u32 = 32 bits, rango 0 a 4,294,967,295)

### 2. Variables con `var`

Usa `var` cuando necesites modificar el valor despues de declararlo:

```zig
const std = @import("std");

pub fn main() void {
    // Variable que puede cambiar
    var contador: u32 = 0;
    
    std.debug.print("Contador inicial: {}\n", .{contador});
    
    // Podemos modificar el valor
    contador = 1;
    std.debug.print("Contador despues: {}\n", .{contador});
    
    // Operaciones aritmeticas
    contador += 10;
    std.debug.print("Contador final: {}\n", .{contador});
}
```

### 3. Error comun: intentar modificar una constante

```zig
const std = @import("std");

pub fn main() void {
    const x = 10;
    x = 20;  // ERROR DE COMPILACION: cannot assign to constant
}
```

Zig no te dejara compilar si intentas modificar una constante. Esto es una caracteristica de seguridad.

### 4. Shadowing (re-declaracion)

A diferencia de otros lenguajes, Zig NO permite shadowing en el mismo scope:

```zig
const std = @import("std");

pub fn main() void {
    const x = 10;
    const x = 20;  // ERROR: redefinition of 'x'
}
```

### 5. Undefined y valores iniciales

Zig requiere que inicialices las variables, pero puedes usar `undefined` para indicar que el valor sera asignado despues:

```zig
const std = @import("std");

pub fn main() void {
    // Declaras que existira, pero el valor viene despues
    var resultado: u32 = undefined;
    
    // Ahora le asignas un valor
    resultado = 42;
    
    std.debug.print("Resultado: {}\n", .{resultado});
}
```

**Advertencia:** Usar una variable `undefined` antes de asignarle un valor causa comportamiento indefinido. Zig te lo permite porque confia en ti, pero debes ser cuidadoso.

---

## Conceptos clave

- **`const`**: Valor inmutable, no puede cambiar despues de la asignacion. Preferido por defecto.
- **`var`**: Valor mutable, puede cambiar. Usalo solo cuando sea necesario.
- **Tipo explicito**: `const x: u32 = 10` - Tu defines el tipo
- **Tipo inferido**: `const x = 10` - Zig deduce el tipo (en este caso i32)
- **`undefined`**: Marcador para valores que seran asignados despues

---

## Tareas

### Tarea 1: Declarar constantes (Dificultad: Facil)

**Objetivo**: Practicar la declaracion de constantes con tipos explicitos e inferidos.

**Archivo**: `starter/tarea1.zig`

**Que hacer**:
1. Declarar una constante `nombre` de tipo array de caracteres (ya esta hecho como ejemplo)
2. Declarar una constante `anio_nacimiento` de tipo `u16` con tu anio de nacimiento
3. Declarar una constante `altura` de tipo `f32` con tu altura en metros
4. Declarar una constante `es_estudiante` de tipo `bool`

**Criterio de exito**: El programa compila y muestra los 4 valores correctamente.

---

### Tarea 2: Usar variables (Dificultad: Facil)

**Objetivo**: Practicar el uso de variables mutables y operaciones basicas.

**Archivo**: `starter/tarea2.zig`

**Que hacer**:
1. Crear una variable `puntos` que empiece en 0
2. Sumarle 10 puntos
3. Sumarle 25 puntos mas
4. Restarle 5 puntos
5. Imprimir el resultado final

**Criterio de exito**: El programa muestra "Puntos finales: 30".

---

### Tarea 3: Corregir errores (Dificultad: Media)

**Objetivo**: Identificar y corregir errores relacionados con const/var.

**Archivo**: `starter/tarea3.zig`

**Que hacer**: El archivo contiene varios errores de compilacion. Debes:
1. Identificar que lineas causan error
2. Decidir si el error se corrige cambiando `const` por `var` o viceversa
3. Hacer las correcciones minimas necesarias

**Criterio de exito**: El programa compila y ejecuta sin errores.

---

## Verificacion

Para compilar y ejecutar cada tarea:

```bash
# Compilar y ejecutar
zig run starter/tarea1.zig

# Solo compilar (para verificar errores)
zig build-exe starter/tarea1.zig

# Limpiar archivos generados
rm -f starter/*.o starter/tarea1 starter/tarea2 starter/tarea3
```

Si no tienes Zig instalado:

```bash
# En Ubuntu/Debian
sudo snap install zig --classic

# En macOS con Homebrew
brew install zig

# Verificar instalacion
zig version
```

---

## Pistas

<details>
<summary>Pista para Tarea 1</summary>

Los tipos que necesitas:
- `u16` para el anio (valores entre 0 y 65535)
- `f32` para altura con decimales
- `bool` para verdadero/falso

Ejemplo: `const mi_valor: f32 = 1.75;`
</details>

<details>
<summary>Pista para Tarea 2</summary>

Para sumar a una variable existente puedes usar:
- `puntos = puntos + 10;` (forma larga)
- `puntos += 10;` (forma corta, preferida)

Para restar: `puntos -= 5;`
</details>

<details>
<summary>Pista para Tarea 3</summary>

Preguntate para cada variable:
- Se modifica su valor en alguna linea posterior?
- Si SI se modifica -> debe ser `var`
- Si NO se modifica -> debe ser `const`

Zig te obliga a usar `const` cuando es posible.
</details>

---

## Siguiente modulo

En el **Modulo 02: Tipos Primitivos** exploraremos en detalle todos los tipos de datos basicos de Zig: enteros de diferentes tamanios, numeros de punto flotante, booleanos y el tipo especial `void`.
