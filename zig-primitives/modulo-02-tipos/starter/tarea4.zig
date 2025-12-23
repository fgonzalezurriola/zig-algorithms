const std = @import("std");

// =============================================================================
// TAREA 4: Ajuste de brillo con operadores saturating
// =============================================================================
//
// Contexto: En procesamiento de imagenes, los valores RGB van de 0 a 255.
// Cuando ajustamos el brillo:
// - Aumentar: sumar al valor actual
// - Disminuir: restar al valor actual
//
// Problema: Si un pixel tiene R=250 y aumentamos brillo en 20:
// - Con aritmetica normal: 250 + 20 = 270, pero 270 > 255 = OVERFLOW!
// - Con wrapping (+%): 270 mod 256 = 14 (el pixel se vuelve muy oscuro!)
// - Con saturating (+|): min(270, 255) = 255 (se queda en blanco puro)
//
// En imagenes, saturating es casi siempre lo que queremos.
// =============================================================================

// Ajusta el brillo usando operadores SATURATING
// El resultado nunca excede 255 ni baja de 0
fn ajustar_brillo_saturado(valor: u8, ajuste: i16) u8 {
    // TODO: Implementar usando +| y -|
    // Si ajuste es positivo: sumar con saturacion
    // Si ajuste es negativo: restar con saturacion
    // Pista: Necesitaras convertir el ajuste a u8 con @intCast

    _ = valor;
    _ = ajuste;
    return 0; // Placeholder
}

// Ajusta el brillo usando operadores WRAPPING (para comparar)
// El resultado "da la vuelta" si excede los limites
fn ajustar_brillo_wrap(valor: u8, ajuste: i16) u8 {
    // TODO: Implementar usando +% y -%
    // Mismo comportamiento pero con wrap en lugar de saturacion

    _ = valor;
    _ = ajuste;
    return 0; // Placeholder
}

// Representa un pixel RGB
const Pixel = struct {
    r: u8,
    g: u8,
    b: u8,
};

// Aplica ajuste de brillo a todo el pixel (saturado)
fn ajustar_pixel_saturado(pixel: Pixel, ajuste: i16) Pixel {
    // TODO: Aplicar ajustar_brillo_saturado a cada componente
    _ = pixel;
    _ = ajuste;
    return Pixel{ .r = 0, .g = 0, .b = 0 }; // Placeholder
}

pub fn main() void {
    std.debug.print("=== Comparacion: Saturating vs Wrapping ===\n\n", .{});

    // Caso 1: Aumentar brillo (overflow potencial)
    const valor_alto: u8 = 250;
    const aumento: i16 = 20;

    std.debug.print("Valor original: {}\n", .{valor_alto});
    std.debug.print("Aumento: +{}\n\n", .{aumento});

    const resultado_sat = ajustar_brillo_saturado(valor_alto, aumento);
    const resultado_wrap = ajustar_brillo_wrap(valor_alto, aumento);

    std.debug.print("Resultado SATURADO: {} (esperado: 255)\n", .{resultado_sat});
    std.debug.print("Resultado WRAP: {} (esperado: 14)\n\n", .{resultado_wrap});

    // Caso 2: Disminuir brillo (underflow potencial)
    const valor_bajo: u8 = 10;
    const disminucion: i16 = -30;

    std.debug.print("Valor original: {}\n", .{valor_bajo});
    std.debug.print("Ajuste: {}\n\n", .{disminucion});

    const resultado_sat2 = ajustar_brillo_saturado(valor_bajo, disminucion);
    const resultado_wrap2 = ajustar_brillo_wrap(valor_bajo, disminucion);

    std.debug.print("Resultado SATURADO: {} (esperado: 0)\n", .{resultado_sat2});
    std.debug.print("Resultado WRAP: {} (esperado: 236)\n\n", .{resultado_wrap2});

    // Caso 3: Pixel completo
    std.debug.print("=== Ajuste de Pixel Completo ===\n\n", .{});

    const pixel_original = Pixel{ .r = 200, .g = 100, .b = 250 };
    const pixel_brillante = ajustar_pixel_saturado(pixel_original, 80);

    std.debug.print("Pixel original: R={}, G={}, B={}\n", .{ pixel_original.r, pixel_original.g, pixel_original.b });
    std.debug.print("Pixel +80 brillo: R={}, G={}, B={}\n", .{ pixel_brillante.r, pixel_brillante.g, pixel_brillante.b });
    std.debug.print("(Esperado: R=255, G=180, B=255)\n", .{});
}
