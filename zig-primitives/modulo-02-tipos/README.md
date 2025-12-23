# Modulo 02: Tipos Primitivos en Zig

## Objetivo

Dominar los tipos de datos primitivos de Zig: enteros de diferentes tamanios, numeros de punto flotante, booleanos y el tipo especial `void`. Entender cuando usar cada tipo y como Zig maneja el overflow de enteros.

## Prerequisitos

Debes haber completado el Modulo 01 (Variables y Constantes).

---

## Codigo a estudiar

### 1. Tipos de enteros

Zig tiene una gran variedad de tipos enteros. El nombre sigue un patron simple:
- Primera letra: `u` (unsigned/sin signo) o `i` (signed/con signo)
- Numero: cantidad de bits

```zig
const std = @import("std");

pub fn main() void {
    // Enteros sin signo (solo positivos, incluyendo 0)
    const byte: u8 = 255;           // 0 a 255
    const small: u16 = 65535;       // 0 a 65,535
    const medium: u32 = 4294967295; // 0 a 4,294,967,295
    const big: u64 = 18446744073709551615; // 0 a 18 quintillones

    // Enteros con signo (positivos y negativos)
    const temp_byte: i8 = -128;     // -128 a 127
    const temp_small: i16 = -32768; // -32,768 a 32,767
    const temp_medium: i32 = -2147483648; // -2 mil millones a 2 mil millones
    const temp_big: i64 = -9223372036854775808; // Muy grande

    std.debug.print("u8 max: {}\n", .{byte});
    std.debug.print("i8 min: {}\n", .{temp_byte});
}
```

**Rangos de tipos comunes:**

| Tipo | Minimo | Maximo | Uso tipico |
|------|--------|--------|------------|
| u8   | 0      | 255    | Bytes, colores RGB |
| u16  | 0      | 65,535 | Puertos de red |
| u32  | 0      | 4.2 mil millones | IDs, contadores |
| i8   | -128   | 127    | Datos de sensores |
| i16  | -32,768 | 32,767 | Audio |
| i32  | -2.1B  | 2.1B   | Uso general |

### 2. Tipos de punto flotante

Para numeros con decimales, Zig ofrece `f16`, `f32`, `f64` y `f128`:

```zig
const std = @import("std");

pub fn main() void {
    // f32: precision simple (suficiente para la mayoria de casos)
    const precio: f32 = 19.99;
    
    // f64: precision doble (para calculos cientificos)
    const pi: f64 = 3.141592653589793;
    
    // Notacion cientifica
    const avogadro: f64 = 6.022e23;
    const muy_pequeno: f64 = 1.6e-19;
    
    // Operaciones basicas
    const suma = precio + 5.0;
    const division = precio / 3.0;
    
    std.debug.print("Precio: {d:.2}\n", .{precio});
    std.debug.print("Pi: {d:.10}\n", .{pi});
    std.debug.print("Avogadro: {e}\n", .{avogadro});
    std.debug.print("Suma: {d:.2}\n", .{suma});
}
```

**Cuando usar cada tipo:**
- `f32`: Graficos, juegos, la mayoria de aplicaciones
- `f64`: Calculos cientificos, financieros donde la precision importa

### 3. Booleanos

El tipo `bool` solo tiene dos valores: `true` y `false`.

```zig
const std = @import("std");

pub fn main() void {
    const es_valido: bool = true;
    const esta_vacio: bool = false;
    
    // Operadores logicos
    const ambos = es_valido and esta_vacio;    // false (AND)
    const alguno = es_valido or esta_vacio;    // true (OR)
    const negacion = !es_valido;               // false (NOT)
    
    std.debug.print("es_valido: {}\n", .{es_valido});
    std.debug.print("ambos: {}\n", .{ambos});
    std.debug.print("alguno: {}\n", .{alguno});
    std.debug.print("negacion: {}\n", .{negacion});
    
    // Comparaciones (producen booleanos)
    const edad: u32 = 25;
    const es_adulto = edad >= 18;
    const es_joven = edad < 30;
    
    std.debug.print("Es adulto: {}\n", .{es_adulto});
}
```

**Operadores de comparacion:**
- `==` igual a
- `!=` diferente de
- `<` menor que
- `>` mayor que
- `<=` menor o igual
- `>=` mayor o igual

### 4. Inferencia de tipos

Cuando no especificas el tipo, Zig lo infiere:

```zig
const std = @import("std");

pub fn main() void {
    // Zig infiere i32 para enteros literales
    const x = 42;
    
    // Zig infiere f64 para flotantes literales
    const y = 3.14;
    
    // Zig infiere bool
    const z = true;
    
    // Para ver los tipos, usamos @TypeOf
    std.debug.print("Tipo de x: {}\n", .{@typeName(@TypeOf(x))});
    std.debug.print("Tipo de y: {}\n", .{@typeName(@TypeOf(y))});
    std.debug.print("Tipo de z: {}\n", .{@typeName(@TypeOf(z))});
}
```

**Tipos inferidos por defecto:**
- Enteros literales -> `comptime_int` (se convierte segun contexto)
- Flotantes literales -> `comptime_float` (se convierte segun contexto)
- Booleanos -> `bool`

### 5. Conversion de tipos (casting)

Zig NO hace conversiones implicitas. Debes ser explicito:

```zig
const std = @import("std");

pub fn main() void {
    const entero: i32 = 42;
    
    // Convertir entero a flotante
    const flotante: f64 = @floatFromInt(entero);
    std.debug.print("Como flotante: {d}\n", .{flotante});
    
    // Convertir flotante a entero (trunca decimales)
    const pi: f64 = 3.99;
    const truncado: i32 = @intFromFloat(pi);
    std.debug.print("Truncado: {}\n", .{truncado}); // Imprime 3
    
    // Convertir entre tamanios de enteros
    const pequeno: u8 = 200;
    const grande: u32 = pequeno; // OK: u8 cabe en u32
    std.debug.print("Grande: {}\n", .{grande});
    
    // Para reducir tamanio, usa @intCast
    const valor_grande: u32 = 100;
    const valor_pequeno: u8 = @intCast(valor_grande);
    std.debug.print("Pequeno: {}\n", .{valor_pequeno});
}
```

**Funciones de conversion comunes:**
- `@intFromFloat(x)` - flotante a entero
- `@floatFromInt(x)` - entero a flotante
- `@intCast(x)` - entre tipos de enteros

### 6. Overflow de enteros

Zig detecta overflow en tiempo de ejecucion (en modo debug):

```zig
const std = @import("std");

pub fn main() void {
    var x: u8 = 250;
    
    // Esto causaria panic en modo debug si x llegara a 256
    x += 5; // OK: 255
    
    std.debug.print("x: {}\n", .{x});
    
    // Para permitir overflow (wraparound), usa operadores especiales
    var y: u8 = 250;
    y +%= 10; // Wrap: 250 + 10 = 260 -> 4 (260 mod 256)
    std.debug.print("y con wrap: {}\n", .{y});
}
```

**Operadores con wrap (permiten overflow):**
- `+%` suma con wrap
- `-%` resta con wrap
- `*%` multiplicacion con wrap

---

## Conceptos clave

- **u8, u16, u32, u64**: Enteros sin signo de diferente tamanio
- **i8, i16, i32, i64**: Enteros con signo
- **f32, f64**: Numeros de punto flotante
- **bool**: Verdadero o falso
- **Casting explicito**: Zig nunca convierte tipos automaticamente
- **Overflow checking**: Zig detecta overflow en modo debug

---

## Tareas

### Tarea 1: Elegir tipos correctos (Dificultad: Facil)

**Objetivo**: Practicar la eleccion del tipo apropiado para cada situacion.

**Archivo**: `starter/tarea1.zig`

**Que hacer**: Hay varias variables declaradas. Asigna el tipo correcto segun la descripcion en los comentarios.

**Criterio de exito**: El programa compila sin warnings y muestra todos los valores.

---

### Tarea 2: Conversiones de tipo (Dificultad: Media)

**Objetivo**: Practicar las conversiones explicitas entre tipos.

**Archivo**: `starter/tarea2.zig`

**Que hacer**: 
1. Convertir una temperatura de Celsius (entero) a Fahrenheit (flotante)
2. Convertir el resultado de vuelta a entero (redondeado)
3. Convertir entre diferentes tamanios de enteros

**Criterio de exito**: El programa muestra las conversiones correctas.

---

### Tarea 3: Calculadora de estadisticas (Dificultad: Media)

**Objetivo**: Aplicar tipos y operaciones para calcular estadisticas basicas.

**Archivo**: `starter/tarea3.zig`

**Que hacer**: Dado un conjunto de calificaciones:
1. Calcular la suma total
2. Calcular el promedio (como flotante)
3. Determinar si el promedio es aprobatorio (>= 60)

**Criterio de exito**: El programa calcula correctamente suma=350, promedio=70.0, aprobado=true.

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

- Para edades de personas: u8 es suficiente (0-255)
- Para dinero con centavos: usa f32 o f64
- Para contadores grandes: u32 o u64
- Para temperaturas que pueden ser negativas: usa tipos con signo (i32)
</details>

<details>
<summary>Pista para Tarea 2</summary>

La formula Celsius a Fahrenheit es: `F = C * 9/5 + 32`

Para hacer esta operacion en Zig:
1. Primero convierte el Celsius entero a flotante
2. Haz la operacion
3. Para redondear al convertir de vuelta, puedes sumar 0.5 antes de truncar
</details>

<details>
<summary>Pista para Tarea 3</summary>

Para calcular el promedio:
1. Suma todos los valores (resultado sera u32 o i32)
2. Convierte la suma a f64 usando @floatFromInt
3. Divide por la cantidad de elementos (tambien convertido a f64)
4. Compara con >= 60.0 para obtener el booleano
</details>

---

## Siguiente modulo

En el **Modulo 03: Strings y Arrays** aprenderemos a trabajar con cadenas de texto y colecciones de datos del mismo tipo.
