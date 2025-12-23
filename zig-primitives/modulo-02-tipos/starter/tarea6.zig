const std = @import("std");

// =============================================================================
// TAREA 6: Coordenadas compactas con tipos de bits arbitrarios
// =============================================================================
//
// Contexto: En juegos 2D con mapas de tiles, las coordenadas tienen rangos
// limitados. Por ejemplo, un mapa de 4096x4096 tiles solo necesita 12 bits
// por coordenada (u12: 0-4095).
//
// Empaquetar datos ahorra memoria y mejora el rendimiento de cache.
// En lugar de usar 3 x u32 (12 bytes), podemos usar un solo u32 (4 bytes):
//
//   [ x: 12 bits ][ y: 12 bits ][ layer: 8 bits ]
//   bits 20-31     bits 8-19     bits 0-7
//
// Zig soporta tipos como u4, u12, i3, etc. que reflejan exactamente
// el rango valido de los datos.
// =============================================================================

// Posicion en el mapa usando tipos de bits exactos
const Posicion = struct {
    x: u12, // 0-4095
    y: u12, // 0-4095
    layer: u8, // 0-255 (capas: suelo, objetos, aire, etc.)
};

// Empaqueta una posicion en un u32
// Layout: [ x: 12 bits ][ y: 12 bits ][ layer: 8 bits ]
fn empaquetar_posicion(pos: Posicion) u32 {
    // TODO: Empaquetar x, y, layer en un u32
    //
    // 1. Convierte cada componente a u32 con @as(u32, valor)
    // 2. Haz shift al lugar correcto:
    //    - x va en bits 20-31 (shift left 20)
    //    - y va en bits 8-19 (shift left 8)
    //    - layer va en bits 0-7 (no necesita shift)
    // 3. Combina con OR

    _ = pos;
    return 0; // Placeholder
}

// Desempaqueta un u32 a una Posicion
fn desempaquetar_posicion(valor_empaquetado: u32) Posicion {
    // TODO: Extraer x, y, layer del u32
    //
    // 1. Para x: shift right 20, luego truncate a u12
    // 2. Para y: shift right 8, mascara con 0xFFF, luego truncate a u12
    // 3. Para layer: mascara con 0xFF, luego truncate a u8
    //
    // La mascara 0xFFF = 4095 = 12 bits todos en 1
    // La mascara 0xFF = 255 = 8 bits todos en 1

    _ = valor_empaquetado;
    return Posicion{ .x = 0, .y = 0, .layer = 0 };
}

// Calcula la distancia Manhattan entre dos posiciones (misma layer)
fn distancia_manhattan(a: Posicion, b: Posicion) u16 {
    // TODO: Calcular |x1 - x2| + |y1 - y2|
    //
    // Cuidado: u12 - u12 puede ser negativo si no usamos el tipo correcto
    // Pista: Convierte a i32 para la resta, luego usa @abs()

    _ = a;
    _ = b;
    return 0; // Placeholder
}

// Mueve una posicion, respetando los limites del mapa
fn mover_saturado(pos: Posicion, dx: i16, dy: i16) Posicion {
    // TODO: Mover la posicion usando aritmetica saturada
    //
    // Si x + dx excede 4095, quedarse en 4095
    // Si x + dx es menor que 0, quedarse en 0
    // Mismo para y
    //
    // Pista: Puedes convertir x a i32, sumar dx, y luego clamp al rango 0-4095

    _ = pos;
    _ = dx;
    _ = dy;
    return Posicion{ .x = 0, .y = 0, .layer = 0 }; // Placeholder
}

pub fn main() void {
    std.debug.print("=== Tipos de Bits Arbitrarios ===\n\n", .{});

    // Mostrar rangos de los tipos
    std.debug.print("Rangos de tipos usados:\n", .{});
    std.debug.print("  u12: 0 a {}\n", .{std.math.maxInt(u12)});
    std.debug.print("  u8:  0 a {}\n\n", .{std.math.maxInt(u8)});

    std.debug.print("=== Empaquetado y Desempaquetado ===\n\n", .{});

    const pos_original = Posicion{ .x = 1234, .y = 5678 % 4096, .layer = 42 };
    std.debug.print("Posicion original: x={}, y={}, layer={}\n", .{ pos_original.x, pos_original.y, pos_original.layer });

    const empaquetado = empaquetar_posicion(pos_original);
    std.debug.print("Empaquetado: 0x{X:0>8}\n", .{empaquetado});

    const pos_recuperada = desempaquetar_posicion(empaquetado);
    std.debug.print("Recuperado: x={}, y={}, layer={}\n", .{ pos_recuperada.x, pos_recuperada.y, pos_recuperada.layer });

    const exito = (pos_original.x == pos_recuperada.x) and
        (pos_original.y == pos_recuperada.y) and
        (pos_original.layer == pos_recuperada.layer);
    std.debug.print("Round-trip exitoso: {}\n\n", .{exito});

    std.debug.print("=== Ahorro de Memoria ===\n\n", .{});

    std.debug.print("Sin empaquetar (3 x u32): {} bytes\n", .{@sizeOf(u32) * 3});
    std.debug.print("Empaquetado (1 x u32):    {} bytes\n", .{@sizeOf(u32)});
    std.debug.print("Ahorro: 66%%\n\n", .{});

    std.debug.print("=== Distancia Manhattan ===\n\n", .{});

    const punto_a = Posicion{ .x = 100, .y = 100, .layer = 0 };
    const punto_b = Posicion{ .x = 150, .y = 200, .layer = 0 };
    const dist = distancia_manhattan(punto_a, punto_b);
    std.debug.print("Distancia de ({},{}) a ({},{}): {}\n", .{ punto_a.x, punto_a.y, punto_b.x, punto_b.y, dist });
    std.debug.print("(Esperado: 150 = |100-150| + |100-200|)\n\n", .{});

    std.debug.print("=== Movimiento Saturado ===\n\n", .{});

    const pos_borde = Posicion{ .x = 4090, .y = 10, .layer = 1 };
    const pos_movida = mover_saturado(pos_borde, 100, -50);
    std.debug.print("Posicion: ({}, {})\n", .{ pos_borde.x, pos_borde.y });
    std.debug.print("Mover: dx=+100, dy=-50\n", .{});
    std.debug.print("Resultado: ({}, {})\n", .{ pos_movida.x, pos_movida.y });
    std.debug.print("(Esperado: x=4095 saturado, y=0 saturado)\n", .{});
}
