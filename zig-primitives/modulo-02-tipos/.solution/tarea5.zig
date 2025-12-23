const std = @import("std");

// =============================================================================
// TAREA 5: Parsear color RGBA empaquetado - SOLUCION
// =============================================================================

const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

fn extraer_componentes(color_empaquetado: u32) Color {
    // Shift right para mover los bits a la posicion 0
    // AND con 0xFF para quedarnos solo con los 8 bits menos significativos
    return Color{
        .r = @truncate((color_empaquetado >> 24) & 0xFF),
        .g = @truncate((color_empaquetado >> 16) & 0xFF),
        .b = @truncate((color_empaquetado >> 8) & 0xFF),
        .a = @truncate(color_empaquetado & 0xFF),
    };
}

fn empaquetar_color(color: Color) u32 {
    // Shift left para mover cada componente a su posicion
    // OR para combinar todos los bits
    return (@as(u32, color.r) << 24) |
        (@as(u32, color.g) << 16) |
        (@as(u32, color.b) << 8) |
        @as(u32, color.a);
}

fn mezclar_alpha(fondo: Color, frente: Color) Color {
    // Alpha blending: resultado = frente * alpha + fondo * (255 - alpha)
    // Dividimos por 255 para normalizar
    const alpha: u16 = frente.a;
    const inv_alpha: u16 = 255 - alpha;

    // Calculos en u16 para evitar overflow
    const r: u8 = @truncate((@as(u16, frente.r) * alpha + @as(u16, fondo.r) * inv_alpha) / 255);
    const g: u8 = @truncate((@as(u16, frente.g) * alpha + @as(u16, fondo.g) * inv_alpha) / 255);
    const b: u8 = @truncate((@as(u16, frente.b) * alpha + @as(u16, fondo.b) * inv_alpha) / 255);

    return Color{ .r = r, .g = g, .b = b, .a = 255 };
}

pub fn main() void {
    std.debug.print("=== Extraccion de Color RGBA ===\n\n", .{});

    const color_empaquetado: u32 = 0xFF8040C0;
    std.debug.print("Color empaquetado: 0x{X:0>8}\n\n", .{color_empaquetado});

    const componentes = extraer_componentes(color_empaquetado);
    std.debug.print("Componentes extraidos:\n", .{});
    std.debug.print("  R: {} (esperado: 255)\n", .{componentes.r});
    std.debug.print("  G: {} (esperado: 128)\n", .{componentes.g});
    std.debug.print("  B: {} (esperado: 64)\n", .{componentes.b});
    std.debug.print("  A: {} (esperado: 192)\n\n", .{componentes.a});

    std.debug.print("=== Empaquetado de Color ===\n\n", .{});

    const mi_color = Color{ .r = 100, .g = 150, .b = 200, .a = 255 };
    const empaquetado = empaquetar_color(mi_color);
    std.debug.print("Color original: R={}, G={}, B={}, A={}\n", .{ mi_color.r, mi_color.g, mi_color.b, mi_color.a });
    std.debug.print("Empaquetado: 0x{X:0>8} (esperado: 0x6496C8FF)\n\n", .{empaquetado});

    const recuperado = extraer_componentes(empaquetado);
    const coincide = (recuperado.r == mi_color.r) and
        (recuperado.g == mi_color.g) and
        (recuperado.b == mi_color.b) and
        (recuperado.a == mi_color.a);
    std.debug.print("Round-trip exitoso: {}\n\n", .{coincide});

    std.debug.print("=== Alpha Blending ===\n\n", .{});

    const fondo = Color{ .r = 255, .g = 255, .b = 255, .a = 255 };
    const frente = Color{ .r = 255, .g = 0, .b = 0, .a = 128 };

    std.debug.print("Fondo (blanco): R={}, G={}, B={}\n", .{ fondo.r, fondo.g, fondo.b });
    std.debug.print("Frente (rojo 50%% alpha): R={}, G={}, B={}, A={}\n", .{ frente.r, frente.g, frente.b, frente.a });

    const mezclado = mezclar_alpha(fondo, frente);
    std.debug.print("Resultado mezcla: R={}, G={}, B={}\n", .{ mezclado.r, mezclado.g, mezclado.b });
    std.debug.print("(Esperado aproximado: R=255, G=127, B=127 - rosa claro)\n", .{});
}
