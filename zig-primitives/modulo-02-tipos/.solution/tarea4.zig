const std = @import("std");

// =============================================================================
// TAREA 4: Ajuste de brillo con operadores saturating - SOLUCION
// =============================================================================

// Ajusta el brillo usando operadores SATURATING
fn ajustar_brillo_saturado(valor: u8, ajuste: i16) u8 {
    if (ajuste >= 0) {
        // Suma saturada: si excede 255, queda en 255
        const incremento: u8 = @intCast(@min(ajuste, 255));
        return valor +| incremento;
    } else {
        // Resta saturada: si baja de 0, queda en 0
        const decremento: u8 = @intCast(@min(-ajuste, 255));
        return valor -| decremento;
    }
}

// Ajusta el brillo usando operadores WRAPPING
fn ajustar_brillo_wrap(valor: u8, ajuste: i16) u8 {
    if (ajuste >= 0) {
        const incremento: u8 = @intCast(@as(u16, @intCast(ajuste)) % 256);
        return valor +% incremento;
    } else {
        const decremento: u8 = @intCast(@as(u16, @intCast(-ajuste)) % 256);
        return valor -% decremento;
    }
}

const Pixel = struct {
    r: u8,
    g: u8,
    b: u8,
};

fn ajustar_pixel_saturado(pixel: Pixel, ajuste: i16) Pixel {
    return Pixel{
        .r = ajustar_brillo_saturado(pixel.r, ajuste),
        .g = ajustar_brillo_saturado(pixel.g, ajuste),
        .b = ajustar_brillo_saturado(pixel.b, ajuste),
    };
}

pub fn main() void {
    std.debug.print("=== Comparacion: Saturating vs Wrapping ===\n\n", .{});

    const valor_alto: u8 = 250;
    const aumento: i16 = 20;

    std.debug.print("Valor original: {}\n", .{valor_alto});
    std.debug.print("Aumento: +{}\n\n", .{aumento});

    const resultado_sat = ajustar_brillo_saturado(valor_alto, aumento);
    const resultado_wrap = ajustar_brillo_wrap(valor_alto, aumento);

    std.debug.print("Resultado SATURADO: {} (esperado: 255)\n", .{resultado_sat});
    std.debug.print("Resultado WRAP: {} (esperado: 14)\n\n", .{resultado_wrap});

    const valor_bajo: u8 = 10;
    const disminucion: i16 = -30;

    std.debug.print("Valor original: {}\n", .{valor_bajo});
    std.debug.print("Ajuste: {}\n\n", .{disminucion});

    const resultado_sat2 = ajustar_brillo_saturado(valor_bajo, disminucion);
    const resultado_wrap2 = ajustar_brillo_wrap(valor_bajo, disminucion);

    std.debug.print("Resultado SATURADO: {} (esperado: 0)\n", .{resultado_sat2});
    std.debug.print("Resultado WRAP: {} (esperado: 236)\n\n", .{resultado_wrap2});

    std.debug.print("=== Ajuste de Pixel Completo ===\n\n", .{});

    const pixel_original = Pixel{ .r = 200, .g = 100, .b = 250 };
    const pixel_brillante = ajustar_pixel_saturado(pixel_original, 80);

    std.debug.print("Pixel original: R={}, G={}, B={}\n", .{ pixel_original.r, pixel_original.g, pixel_original.b });
    std.debug.print("Pixel +80 brillo: R={}, G={}, B={}\n", .{ pixel_brillante.r, pixel_brillante.g, pixel_brillante.b });
    std.debug.print("(Esperado: R=255, G=180, B=255)\n", .{});
}
