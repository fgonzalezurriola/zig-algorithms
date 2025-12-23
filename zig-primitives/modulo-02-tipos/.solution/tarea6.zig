const std = @import("std");

// =============================================================================
// TAREA 6: Coordenadas compactas con tipos de bits arbitrarios - SOLUCION
// =============================================================================

const Posicion = struct {
    x: u12,
    y: u12,
    layer: u8,
};

fn empaquetar_posicion(pos: Posicion) u32 {
    // Layout: [ x: 12 bits ][ y: 12 bits ][ layer: 8 bits ]
    return (@as(u32, pos.x) << 20) |
        (@as(u32, pos.y) << 8) |
        @as(u32, pos.layer);
}

fn desempaquetar_posicion(valor_empaquetado: u32) Posicion {
    return Posicion{
        .x = @truncate(valor_empaquetado >> 20),
        .y = @truncate((valor_empaquetado >> 8) & 0xFFF),
        .layer = @truncate(valor_empaquetado & 0xFF),
    };
}

fn distancia_manhattan(a: Posicion, b: Posicion) u16 {
    // Convertir a i32 para poder restar sin problemas de signo
    const ax: i32 = @intCast(a.x);
    const ay: i32 = @intCast(a.y);
    const bx: i32 = @intCast(b.x);
    const by: i32 = @intCast(b.y);

    // Calcular diferencias absolutas
    const dx: u16 = @intCast(@abs(ax - bx));
    const dy: u16 = @intCast(@abs(ay - by));

    return dx + dy;
}

fn mover_saturado(pos: Posicion, dx: i16, dy: i16) Posicion {
    // Convertir a i32 para calculos intermedios
    const new_x_i32: i32 = @as(i32, pos.x) + @as(i32, dx);
    const new_y_i32: i32 = @as(i32, pos.y) + @as(i32, dy);

    // Clamp al rango valido de u12 (0-4095)
    const max_val: i32 = std.math.maxInt(u12);
    const clamped_x = @max(0, @min(new_x_i32, max_val));
    const clamped_y = @max(0, @min(new_y_i32, max_val));

    return Posicion{
        .x = @intCast(clamped_x),
        .y = @intCast(clamped_y),
        .layer = pos.layer,
    };
}

pub fn main() void {
    std.debug.print("=== Tipos de Bits Arbitrarios ===\n\n", .{});

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
