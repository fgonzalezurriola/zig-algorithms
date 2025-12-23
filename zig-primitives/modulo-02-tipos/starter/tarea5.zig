const std = @import("std");

// =============================================================================
// TAREA 5: Parsear color RGBA empaquetado
// =============================================================================
//
// Contexto: En graficos, un color RGBA se almacena frecuentemente en un u32.
// Formato: 0xRRGGBBAA donde cada componente ocupa 8 bits.
//
// Ejemplo: 0xFF8040C0
//   - R = 0xFF (255) - bits 24-31
//   - G = 0x80 (128) - bits 16-23
//   - B = 0x40 (64)  - bits 8-15
//   - A = 0xC0 (192) - bits 0-7
//
// Operadores necesarios:
//   >> : shift right (mueve bits a la derecha)
//   << : shift left (mueve bits a la izquierda)
//   &  : AND (mascara para quedarse con ciertos bits)
//   |  : OR (combina bits)
// =============================================================================

const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

// Extrae los componentes RGBA de un color empaquetado
fn extraer_componentes(color_empaquetado: u32) Color {
    // TODO: Extraer cada componente usando >> y &
    //
    // R esta en bits 24-31: (color >> 24) & 0xFF
    // G esta en bits 16-23: (color >> 16) & 0xFF
    // B esta en bits 8-15:  (color >> 8) & 0xFF
    // A esta en bits 0-7:   color & 0xFF
    //
    // Nota: El resultado de las operaciones es u32,
    // necesitas @truncate para convertir a u8

    _ = color_empaquetado;
    return Color{ .r = 0, .g = 0, .b = 0, .a = 0 }; // Placeholder
}

// Empaqueta componentes RGBA en un u32
fn empaquetar_color(color: Color) u32 {
    // TODO: Combinar los componentes usando << y |
    //
    // Primero convierte cada u8 a u32 con @as(u32, valor)
    // Luego haz shift a la posicion correcta
    // Finalmente combina con OR
    //
    // Resultado = (R << 24) | (G << 16) | (B << 8) | A

    _ = color;
    return 0; // Placeholder
}

// Mezcla dos colores usando alpha blending simple
// Formula: resultado = (foreground * alpha + background * (255 - alpha)) / 255
fn mezclar_alpha(fondo: Color, frente: Color) Color {
    // TODO: Implementar alpha blending
    //
    // El alpha del color de frente determina cuanto "se ve" del frente
    // alpha=255: solo se ve el frente
    // alpha=0: solo se ve el fondo
    // alpha=128: mezcla 50/50
    //
    // Para cada componente (r, g, b):
    //   resultado = (frente * alpha + fondo * (255 - alpha)) / 255
    //
    // Pista: Usa u16 o u32 para los calculos intermedios para evitar overflow

    _ = fondo;
    _ = frente;
    return Color{ .r = 0, .g = 0, .b = 0, .a = 255 }; // Placeholder
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

    // Verificar round-trip
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
