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

### 7. Operadores saturating

Ademas de los operadores de wrap, Zig tiene operadores "saturating" que limitan el resultado al valor maximo/minimo del tipo en lugar de hacer wrap:

```zig
const std = @import("std");

pub fn main() void {
    // Saturating: si excede el maximo, se queda en el maximo
    var brillo: u8 = 250;
    brillo = brillo +| 20;  // 250 + 20 = 270, pero u8 max es 255, asi que: 255
    std.debug.print("Brillo saturado: {}\n", .{brillo});  // 255
    
    // Comparacion: wrapping habria dado 14 (270 mod 256)
    var brillo_wrap: u8 = 250;
    brillo_wrap +%= 20;
    std.debug.print("Brillo con wrap: {}\n", .{brillo_wrap});  // 14
    
    // Saturating hacia abajo
    var volumen: u8 = 10;
    volumen = volumen -| 50;  // 10 - 50 = -40, pero u8 min es 0, asi que: 0
    std.debug.print("Volumen saturado: {}\n", .{volumen});  // 0
}
```

**Operadores saturating:**
- `+|` suma saturada (se detiene en el maximo)
- `-|` resta saturada (se detiene en el minimo)
- `*|` multiplicacion saturada

**Caso de uso real:** Procesamiento de imagenes (valores RGB 0-255), ajustes de audio, contadores que no deben hacer wrap.

### 8. Manipulacion de bits

Zig proporciona operadores para trabajar directamente con bits. Esto es esencial para protocolos binarios, graficos y optimizacion:

```zig
const std = @import("std");

pub fn main() void {
    // Un color RGBA empaquetado: 0xRRGGBBAA
    const color: u32 = 0xFF8040C0;  // R=255, G=128, B=64, A=192
    
    // Extraer componentes usando shift y mascara
    const r = (color >> 24) & 0xFF;  // Mover 24 bits a la derecha, quedarse con 8
    const g = (color >> 16) & 0xFF;  // Mover 16 bits
    const b = (color >> 8) & 0xFF;   // Mover 8 bits
    const a = color & 0xFF;          // Solo los ultimos 8 bits
    
    std.debug.print("R: {}, G: {}, B: {}, A: {}\n", .{r, g, b, a});
    
    // Empaquetar componentes de vuelta
    const nuevo_color: u32 = (@as(u32, 100) << 24) |  // R en bits 24-31
                             (@as(u32, 150) << 16) |  // G en bits 16-23
                             (@as(u32, 200) << 8) |   // B en bits 8-15
                             @as(u32, 255);           // A en bits 0-7
    std.debug.print("Nuevo color: 0x{X:0>8}\n", .{nuevo_color});
}
```

**Operadores de bits:**
- `>>` shift a la derecha (divide por potencia de 2)
- `<<` shift a la izquierda (multiplica por potencia de 2)
- `&` AND bitwise (mascara)
- `|` OR bitwise (combina)
- `^` XOR bitwise
- `~` NOT bitwise (invierte)

### 9. Tipos de bits arbitrarios

Una caracteristica unica de Zig: puedes crear enteros de cualquier tamanio de bits, no solo 8, 16, 32, 64:

```zig
const std = @import("std");

pub fn main() void {
    // Tipos de bits no estandar
    const nibble: u4 = 15;        // 0 a 15 (4 bits)
    const midi_velocity: u7 = 127; // 0 a 127 (MIDI usa 7 bits)
    const tile_coord: u12 = 4095;  // 0 a 4095 (coordenadas de mapa)
    
    std.debug.print("Nibble (u4): {}\n", .{nibble});
    std.debug.print("MIDI velocity (u7): {}\n", .{midi_velocity});
    std.debug.print("Tile coord (u12): {}\n", .{tile_coord});
    
    // Tambien con signo
    const small_offset: i3 = -4;   // -4 a 3
    std.debug.print("Small offset (i3): {}\n", .{small_offset});
    
    // Muy util para empaquetar datos
    // Por ejemplo: x (12 bits) + y (12 bits) + layer (8 bits) = 32 bits
    const x: u12 = 100;
    const y: u12 = 200;
    const layer: u8 = 5;
    
    // Empaquetar en u32
    const packed: u32 = (@as(u32, x) << 20) | (@as(u32, y) << 8) | @as(u32, layer);
    std.debug.print("Packed: 0x{X:0>8}\n", .{packed});
    
    // Desempaquetar
    const unpacked_x: u12 = @truncate(packed >> 20);
    const unpacked_y: u12 = @truncate((packed >> 8) & 0xFFF);
    const unpacked_layer: u8 = @truncate(packed & 0xFF);
    std.debug.print("Unpacked: x={}, y={}, layer={}\n", .{unpacked_x, unpacked_y, unpacked_layer});
}
```

**Por que usar tipos de bits arbitrarios:**
- Ahorro de memoria en estructuras grandes
- Representacion exacta de protocolos binarios
- Prevencion de errores (el tipo refleja el rango valido)
- Optimizaciones de cache

### 10. Tipos opcionales (?T)

En muchos lenguajes se usa `null` o `-1` para indicar "sin valor". Zig tiene un tipo especial para esto: el opcional `?T`.

```zig
const std = @import("std");

pub fn main() void {
    // Un optional puede tener un valor o ser null
    const quizas_numero: ?u32 = 42;
    const sin_valor: ?u32 = null;
    
    std.debug.print("quizas_numero: {?}\n", .{quizas_numero});  // 42
    std.debug.print("sin_valor: {?}\n", .{sin_valor});          // null
    
    // Para acceder al valor, debes "desenvolverlo"
    // Opcion 1: orelse - proporciona un valor por defecto
    const valor_seguro = quizas_numero orelse 0;
    std.debug.print("Con orelse: {}\n", .{valor_seguro});
    
    // Opcion 2: if con captura
    if (quizas_numero) |valor| {
        std.debug.print("Tiene valor: {}\n", .{valor});
    } else {
        std.debug.print("Es null\n", .{});
    }
    
    // Opcion 3: .? (unwrap inseguro, causa panic si es null)
    // Solo usar cuando SABES que no es null
    const valor_directo = quizas_numero.?;
    std.debug.print("Unwrap directo: {}\n", .{valor_directo});
}

// Funcion que puede fallar en encontrar algo
fn buscar_divisor(n: u32, divisor: u32) ?u32 {
    if (divisor == 0) return null;
    if (n % divisor != 0) return null;
    return n / divisor;
}
```

**Cuando usar opcionales:**
- Busquedas que pueden no encontrar resultado
- Valores de configuracion que pueden no estar definidos
- Parseo de datos que pueden ser invalidos

### 11. Valores centinela y validacion

Un patron comun es usar valores especiales (centinelas) para indicar estados especiales. Zig permite definir tipos con centinelas explicitos:

```zig
const std = @import("std");

pub fn main() void {
    // Ejemplo: temperatura con valor invalido
    // En lugar de usar -999 como "invalido", usamos optional
    const temp_valida: ?i16 = 25;
    const temp_error: ?i16 = null;
    
    // Validacion con rangos
    const sensor_reading: i16 = 150;
    const es_valido = validar_temperatura(sensor_reading);
    std.debug.print("Lectura {} es valida: {}\n", .{sensor_reading, es_valido});
    
    // Conversion segura con validacion
    if (i16_a_u8_seguro(sensor_reading)) |valor_u8| {
        std.debug.print("Convertido a u8: {}\n", .{valor_u8});
    } else {
        std.debug.print("Valor fuera de rango para u8\n", .{});
    }
}

fn validar_temperatura(temp: i16) bool {
    // Rango valido: -40 a 125 (sensor tipico)
    return temp >= -40 and temp <= 125;
}

fn i16_a_u8_seguro(valor: i16) ?u8 {
    if (valor < 0 or valor > 255) return null;
    return @intCast(valor);
}
```

**Patrones de validacion:**
- Rangos de sensores fisicos
- Limites de protocolo (puertos: 0-65535)
- Conversiones seguras entre tipos

### 12. Introspeccion de tipos en comptime

Zig permite inspeccionar tipos en tiempo de compilacion. Esto es poderoso para crear codigo generico y validaciones automaticas:

```zig
const std = @import("std");

pub fn main() void {
    // @sizeOf: tamanio en bytes
    std.debug.print("Tamanio de u8: {} bytes\n", .{@sizeOf(u8)});    // 1
    std.debug.print("Tamanio de u32: {} bytes\n", .{@sizeOf(u32)});  // 4
    std.debug.print("Tamanio de u64: {} bytes\n", .{@sizeOf(u64)});  // 8
    
    // @bitSizeOf: tamanio en bits
    std.debug.print("Bits en u12: {}\n", .{@bitSizeOf(u12)});  // 12
    
    // @TypeOf: obtener el tipo de una expresion
    const x: u32 = 42;
    const TipoDeX = @TypeOf(x);
    std.debug.print("Tipo de x: {}\n", .{@typeName(TipoDeX)});
    
    // @typeInfo: informacion detallada del tipo
    const info = @typeInfo(u8);
    switch (info) {
        .int => |int_info| {
            std.debug.print("u8 es entero, bits: {}, signed: {}\n", 
                .{int_info.bits, int_info.signedness == .signed});
        },
        else => {},
    }
    
    // Limites del tipo
    std.debug.print("u8 max: {}\n", .{std.math.maxInt(u8)});
    std.debug.print("i8 min: {}\n", .{std.math.minInt(i8)});
}
```

**Builtins utiles:**
- `@sizeOf(T)` - bytes que ocupa el tipo
- `@bitSizeOf(T)` - bits que ocupa el tipo
- `@TypeOf(x)` - tipo de una expresion
- `@typeName(T)` - nombre del tipo como string
- `@typeInfo(T)` - metadatos completos del tipo
- `std.math.maxInt(T)` - valor maximo del tipo entero
- `std.math.minInt(T)` - valor minimo del tipo entero

---

## Conceptos clave

- **u8, u16, u32, u64**: Enteros sin signo de diferente tamanio
- **i8, i16, i32, i64**: Enteros con signo
- **f32, f64**: Numeros de punto flotante
- **bool**: Verdadero o falso
- **Casting explicito**: Zig nunca convierte tipos automaticamente
- **Overflow checking**: Zig detecta overflow en modo debug
- **Operadores wrapping (+%)**: Permiten que el valor "de la vuelta" al exceder el rango
- **Operadores saturating (+|)**: Limitan el valor al maximo/minimo del tipo
- **Operadores de bits (>>, <<, &, |)**: Manipulacion directa de bits
- **Tipos arbitrarios (u4, u12, i3)**: Enteros de cualquier tamanio de bits
- **Tipos opcionales (?T)**: Representan "valor o null" de forma segura
- **Introspeccion (@sizeOf, @typeInfo)**: Examinar tipos en comptime

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

### Tarea 4: Ajuste de brillo con saturating (Dificultad: Media)

**Objetivo**: Usar operadores saturating para simular ajustes de brillo en una imagen.

**Archivo**: `starter/tarea4.zig`

**Contexto real**: En procesamiento de imagenes, los valores RGB van de 0 a 255. Cuando aumentamos el brillo, no queremos que 250+20 se convierta en 14 (wrap), sino que se quede en 255 (saturacion). De igual forma, al oscurecer, no queremos valores negativos.

**Que hacer**:
1. Implementar `ajustar_brillo_saturado` usando operadores saturating (`+|`, `-|`)
2. Implementar `ajustar_brillo_wrap` usando operadores wrapping (`+%`, `-%`) para comparar
3. Aplicar ambos a un pixel de ejemplo

**Criterio de exito**: El brillo saturado nunca excede 255 ni baja de 0, mientras que el wrap "da la vuelta".

---

### Tarea 5: Parsear color RGBA empaquetado (Dificultad: Media-Alta)

**Objetivo**: Usar manipulacion de bits para extraer y empaquetar componentes de color.

**Archivo**: `starter/tarea5.zig`

**Contexto real**: En graficos y protocolos de red, los datos se empaquetan en estructuras compactas. Un color RGBA se almacena comunmente en un solo u32: `0xRRGGBBAA`.

**Que hacer**:
1. Implementar `extraer_componentes` para obtener R, G, B, A de un u32
2. Implementar `empaquetar_color` para crear un u32 desde componentes individuales
3. Implementar `mezclar_alpha` para combinar dos colores usando alpha blending

**Criterio de exito**: Las funciones extraen y empaquetan correctamente los colores.

---

### Tarea 6: Coordenadas compactas con tipos arbitrarios (Dificultad: Alta)

**Objetivo**: Usar tipos de bits arbitrarios para representar datos compactos.

**Archivo**: `starter/tarea6.zig`

**Contexto real**: En desarrollo de juegos, las coordenadas de tiles en un mapa suelen tener rangos limitados. Si tu mapa es de 4096x4096 tiles, un u12 (0-4095) es suficiente. Empaquetar x, y, z en un u32 ahorra memoria.

**Que hacer**:
1. Definir una estructura usando tipos u12 para coordenadas
2. Implementar `empaquetar_posicion` que guarde x, y, layer en un u32
3. Implementar `desempaquetar_posicion` que recupere los valores
4. Verificar que los datos sobreviven el round-trip

**Criterio de exito**: Las coordenadas se empaquetan y desempaquetan sin perdida de datos.

---

### Tarea 7: Busqueda con tipos opcionales (Dificultad: Media)

**Objetivo**: Usar tipos opcionales (`?T`) para representar busquedas que pueden fallar.

**Archivo**: `starter/tarea7.zig`

**Contexto real**: En cualquier sistema, las busquedas pueden no encontrar resultados. En lugar de usar valores magicos como `-1` o `null` de C, Zig usa el tipo `?T` que es seguro y expresivo.

**Que hacer**:
1. Implementar `buscar_maximo` que retorna el maximo de un array, o null si esta vacio
2. Implementar `buscar_indice` que busca un valor y retorna su indice, o null si no existe
3. Implementar `division_segura` que retorna null si el divisor es 0
4. Usar `orelse` y `if` para manejar los resultados

**Criterio de exito**: Las funciones retornan `null` en casos invalidos y valores correctos en casos validos.

---

### Tarea 8: Validador de rangos de sensores (Dificultad: Media-Alta)

**Objetivo**: Crear validadores que conviertan datos crudos a tipos seguros usando opcionales.

**Archivo**: `starter/tarea8.zig`

**Contexto real**: Los sensores fisicos tienen rangos validos. Un sensor de temperatura puede leer -40C a 125C. Datos fuera de este rango son errores de hardware. Los sistemas embebidos deben detectar y manejar estos casos.

**Que hacer**:
1. Implementar `validar_temperatura` que acepta solo -40 a 125
2. Implementar `validar_humedad` que acepta solo 0 a 100
3. Implementar `validar_presion` que acepta solo 300 a 1100 hPa
4. Implementar `leer_sensor_completo` que valida todos los datos o retorna null

**Criterio de exito**: Los valores fuera de rango retornan null, los validos retornan el valor normalizado.

---

### Tarea 9: Inspector de tipos en comptime (Dificultad: Alta)

**Objetivo**: Usar builtins de introspeccion para crear utilidades genericas de tipos.

**Archivo**: `starter/tarea9.zig`

**Contexto real**: En sistemas embebidos y serializacion, necesitas saber exactamente cuantos bytes ocupa cada tipo. Los builtins de Zig permiten crear codigo que se adapta automaticamente a diferentes tipos.

**Que hacer**:
1. Implementar `info_tipo` que imprime tamanio, bits y rango de un tipo entero
2. Implementar `puede_contener` que verifica si un valor cabe en un tipo mas pequeno
3. Implementar `calcular_empaquetado` que calcula cuantos valores caben en N bytes
4. Usar `@typeInfo` para distinguir entre tipos signed y unsigned

**Criterio de exito**: Las funciones reportan correctamente los metadatos de cada tipo.

---

## Verificacion

```bash
# Ejecutar cada tarea
zig run starter/tarea1.zig
zig run starter/tarea2.zig
zig run starter/tarea3.zig
zig run starter/tarea4.zig
zig run starter/tarea5.zig
zig run starter/tarea6.zig
zig run starter/tarea7.zig
zig run starter/tarea8.zig
zig run starter/tarea9.zig

# Comparar con las soluciones
zig run .solution/tarea1.zig
zig run .solution/tarea2.zig
zig run .solution/tarea3.zig
zig run .solution/tarea4.zig
zig run .solution/tarea5.zig
zig run .solution/tarea6.zig
zig run .solution/tarea7.zig
zig run .solution/tarea8.zig
zig run .solution/tarea9.zig
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

<details>
<summary>Pista para Tarea 4</summary>

Los operadores saturating en Zig son:
- `+|` para suma saturada
- `-|` para resta saturada

El ajuste puede ser positivo (aumentar brillo) o negativo (disminuir).
- Si el ajuste es positivo: usa `valor +| @intCast(ajuste)`
- Si el ajuste es negativo: usa `valor -| @intCast(-ajuste)`

Compara el resultado con los operadores wrapping (`+%`, `-%`) para ver la diferencia.
</details>

<details>
<summary>Pista para Tarea 5</summary>

Para extraer componentes de un u32 empaquetado como 0xRRGGBBAA:
- R esta en los bits 24-31: `(color >> 24) & 0xFF`
- G esta en los bits 16-23: `(color >> 16) & 0xFF`
- B esta en los bits 8-15: `(color >> 8) & 0xFF`
- A esta en los bits 0-7: `color & 0xFF`

Para empaquetar, haz shift y OR:
```zig
(@as(u32, r) << 24) | (@as(u32, g) << 16) | (@as(u32, b) << 8) | @as(u32, a)
```
</details>

<details>
<summary>Pista para Tarea 6</summary>

Para empaquetar un u12 en parte de un u32:
1. Primero convierte a u32 con `@as(u32, valor)`
2. Luego haz shift a la posicion correcta
3. Combina con OR

Para desempaquetar:
1. Haz shift para mover los bits a la posicion 0
2. Usa `@truncate` para convertir a u12 (descarta bits extra)

Estructura sugerida para el u32: `[x: 12 bits][y: 12 bits][layer: 8 bits]`
</details>

<details>
<summary>Pista para Tarea 7</summary>

Para retornar un opcional:
- `return null;` cuando no hay resultado
- `return valor;` cuando si hay (Zig lo envuelve automaticamente)

Para usar el resultado:
```zig
// Opcion 1: valor por defecto
const resultado = buscar_maximo(datos) orelse 0;

// Opcion 2: if con captura
if (buscar_indice(datos, 42)) |idx| {
    // usar idx
} else {
    // no encontrado
}
```
</details>

<details>
<summary>Pista para Tarea 8</summary>

Patron de validacion con opcional:
```zig
fn validar_temperatura(raw: i16) ?i16 {
    if (raw < -40 or raw > 125) return null;
    return raw;
}
```

Para la estructura completa, usa optional chaining:
```zig
const temp = validar_temperatura(raw_temp) orelse return null;
const hum = validar_humedad(raw_hum) orelse return null;
// Si llegamos aqui, ambos son validos
return SensorData{ .temp = temp, .hum = hum };
```
</details>

<details>
<summary>Pista para Tarea 9</summary>

Para obtener informacion del tipo:
```zig
const info = @typeInfo(u8);
switch (info) {
    .int => |int_info| {
        const bits = int_info.bits;
        const es_signed = int_info.signedness == .signed;
    },
    else => {},
}
```

Para verificar si un valor cabe:
```zig
fn puede_contener(comptime T: type, valor: anytype) bool {
    const max = std.math.maxInt(T);
    const min = std.math.minInt(T);
    return valor >= min and valor <= max;
}
```
</details>

---

## Siguiente modulo

En el **Modulo 03: Strings y Arrays** aprenderemos a trabajar con cadenas de texto y colecciones de datos del mismo tipo.
