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

---

## Tarea 4: Operadores saturating vs wrapping

Este ejercicio demuestra la diferencia entre dos familias de operadores aritmeticos en Zig:

**Operadores saturating (`+|`, `-|`, `*|`):**
- El resultado se "satura" en el limite del tipo
- 250 +| 20 = 255 (no puede exceder el maximo de u8)
- 10 -| 30 = 0 (no puede ser menor que el minimo de u8)

**Operadores wrapping (`+%`, `-%`, `*%`):**
- El resultado "da la vuelta" usando aritmetica modular
- 250 +% 20 = 14 (270 mod 256)
- 10 -% 30 = 236 (equivalente a 256 - 20)

**Cuando usar cada uno:**
- **Saturating**: Procesamiento de imagenes, audio, cualquier caso donde exceder el limite debe "clampear" al maximo
- **Wrapping**: Checksums, hashing, casos donde el overflow es esperado y deseado

**Errores comunes:**
- Olvidar convertir el ajuste (i16) a u8 con `@intCast`
- No manejar correctamente los ajustes negativos (requiere `-|` en lugar de `+|`)

---

## Tarea 5: Manipulacion de bits

Este ejercicio ensena los operadores bitwise esenciales para trabajar con datos empaquetados.

**Conceptos clave:**

1. **Shift right (`>>`)**: Mueve bits hacia la derecha, dividiendo efectivamente por potencias de 2.
   - `0xFF8040C0 >> 24` mueve los bits de R (posicion 24-31) a la posicion 0-7

2. **AND bitwise (`&`)**: Mascara para quedarse solo con ciertos bits.
   - `valor & 0xFF` se queda solo con los ultimos 8 bits

3. **Shift left (`<<`)**: Mueve bits hacia la izquierda, multiplicando por potencias de 2.
   - `100 << 24` coloca el valor 100 en la posicion de R (bits 24-31)

4. **OR bitwise (`|`)**: Combina bits de diferentes fuentes.
   - `(R << 24) | (G << 16) | (B << 8) | A` empaqueta los 4 componentes

**El truco de `@truncate`:**
Las operaciones bitwise en u32 retornan u32. Para asignar a u8, usamos `@truncate` que descarta los bits superiores de forma segura.

**Alpha blending:**
La formula `resultado = frente * alpha + fondo * (1 - alpha)` es fundamental en graficos. Usamos u16 para los calculos intermedios porque `255 * 255 = 65025` excede u8.

---

## Tarea 6: Tipos de bits arbitrarios

Este ejercicio demuestra una caracteristica unica de Zig: tipos enteros de cualquier tamanio.

**Por que existen:**
- **Eficiencia de memoria**: En arrays grandes, usar u12 en lugar de u16 puede ahorrar gigas
- **Expresividad**: El tipo documenta el rango valido del dato
- **Seguridad**: El compilador previene asignar valores fuera de rango

**El patron de empaquetado:**
```
[ x: 12 bits ][ y: 12 bits ][ layer: 8 bits ]
  bits 20-31    bits 8-19     bits 0-7
```

Para empaquetar: shift izquierdo a la posicion correcta, luego OR
Para desempaquetar: shift derecho, luego mascara (si es necesario), luego @truncate

**La funcion `@truncate`:**
Convierte de un tipo mas grande a uno mas pequeno descartando bits superiores. Es seguro cuando sabemos que los bits descartados son cero (por ejemplo, despues de aplicar una mascara correcta).

**Clamp vs saturating:**
Para el movimiento saturado, usamos `@max(0, @min(valor, max))` en lugar de operadores saturating porque estamos trabajando con i32 intermedios, no directamente con u12.

**Errores comunes:**
- Olvidar que `packed` es una palabra reservada en Zig (usar otro nombre de variable)
- No aplicar mascara antes de truncar (puede resultar en valores incorrectos)
- Confundir el orden de los shifts (bits bajos vs altos)

---

## Tarea 7: Tipos opcionales

Este ejercicio introduce el tipo opcional `?T`, una de las caracteristicas mas importantes de Zig.

**Por que opcionales en lugar de null:**
- En C, `NULL` es un puntero que puede ser cualquier tipo. Es facil olvidar verificar.
- En Zig, `?T` es un tipo distinto. El compilador te OBLIGA a manejar el caso null.

**Sintaxis basica:**
```zig
fn buscar(datos: []u32, valor: u32) ?usize {
    for (datos, 0..) |item, idx| {
        if (item == valor) return idx;
    }
    return null;
}
```

**Tres formas de usar opcionales:**

1. **`orelse`** - Proporcionar valor por defecto:
   ```zig
   const idx = buscar(datos, 42) orelse 0;
   ```

2. **`if` con captura** - Manejar ambos casos:
   ```zig
   if (buscar(datos, 42)) |idx| {
       // usar idx
   } else {
       // no encontrado
   }
   ```

3. **`.?` (unwrap)** - Solo cuando SABES que no es null:
   ```zig
   const idx = buscar(datos, 42).?; // PANIC si es null!
   ```

**Errores comunes:**
- Usar `.?` sin verificar primero (causa panic en runtime)
- Olvidar que el slice vacio es un caso especial

---

## Tarea 8: Validacion con opcionales

Este ejercicio aplica opcionales para validacion de datos, un patron muy comun en sistemas embebidos y APIs.

**El patron de validacion:**
```zig
fn validar_temperatura(raw: i16) ?i16 {
    if (raw < -40 or raw > 125) return null;
    return raw;
}
```

**Propagacion temprana con `orelse return null`:**
```zig
fn validar_todo(temp: i16, hum: u8) ?SensorData {
    const t = validar_temperatura(temp) orelse return null;
    const h = validar_humedad(hum) orelse return null;
    return SensorData{ .temp = t, .hum = h };
}
```

Este patron es similar a los "early returns" de otros lenguajes, pero con seguridad de tipos.

**Por que es mejor que valores centinela:**
- `-999` como "temperatura invalida" puede ser olvidado
- `null` como retorno de funcion tipada te obliga a manejarlo
- El tipo `?i16` documenta que la funcion puede fallar

**Errores comunes:**
- Olvidar que `orelse return null` termina la funcion inmediatamente
- No manejar todos los casos de borde (ej: exactamente en el limite)

---

## Tarea 9: Introspeccion de tipos

Este ejercicio muestra los poderosos builtins de Zig para examinar tipos en tiempo de compilacion.

**Builtins principales:**

| Builtin | Descripcion | Ejemplo |
|---------|-------------|---------|
| `@sizeOf(T)` | Bytes en memoria | `@sizeOf(u32)` = 4 |
| `@bitSizeOf(T)` | Bits logicos | `@bitSizeOf(u12)` = 12 |
| `@TypeOf(x)` | Tipo de expresion | `@TypeOf(42)` = comptime_int |
| `@typeName(T)` | Nombre como string | `@typeName(u8)` = "u8" |
| `@typeInfo(T)` | Metadatos completos | Ver abajo |

**Usando @typeInfo:**
```zig
const info = @typeInfo(u8);
switch (info) {
    .int => |int_info| {
        // int_info.bits = 8
        // int_info.signedness = .unsigned
    },
    else => {},
}
```

**Funciones de std.math:**
```zig
std.math.maxInt(u8)  // 255
std.math.minInt(i8)  // -128
```

**Aplicaciones practicas:**
- Crear funciones genericas que se adaptan al tipo
- Verificar en comptime que un tipo cumple requisitos
- Generar documentacion automatica
- Calcular layouts de memoria para serializacion

**El concepto de eficiencia de bits:**
Zig almacena tipos como u12 en el siguiente tamanio natural (16 bits / 2 bytes).
- u12 usa 12 bits pero ocupa 16 en memoria = 75% eficiencia
- u4 usa 4 bits pero ocupa 8 en memoria = 50% eficiencia
- Esto es importante para optimizar estructuras grandes

**Errores comunes:**
- Confundir `@sizeOf` (bytes) con `@bitSizeOf` (bits)
- Olvidar que los tipos no-estandar tienen padding
- No manejar el caso `else` en el switch de @typeInfo

---

## Extensiones posibles

- Encontrar la nota maxima y minima
- Calcular la desviacion estandar
- Implementar conversion de color RGB a HSV usando operaciones de bits
- Crear un empaquetador para timestamps compactos (ano, mes, dia, hora, minuto)
- Implementar un sistema de permisos tipo UNIX usando operadores bitwise
- Crear un validador generico que funcione con cualquier tipo entero
- Implementar un serializador binario usando @sizeOf y @bitSizeOf
