const std = @import("std");

// =============================================================================
// TAREA 7: Busqueda con tipos opcionales - SOLUCION
// =============================================================================

fn buscar_maximo(datos: []const u32) ?u32 {
    if (datos.len == 0) return null;

    var max = datos[0];
    for (datos[1..]) |valor| {
        if (valor > max) {
            max = valor;
        }
    }
    return max;
}

fn buscar_indice(datos: []const u32, valor: u32) ?usize {
    for (datos, 0..) |item, idx| {
        if (item == valor) {
            return idx;
        }
    }
    return null;
}

fn division_segura(dividendo: u32, divisor: u32) ?u32 {
    if (divisor == 0) return null;
    return dividendo / divisor;
}

fn buscar_primer_par(datos: []const u32) ?u32 {
    for (datos) |valor| {
        if (valor % 2 == 0) {
            return valor;
        }
    }
    return null;
}

pub fn main() void {
    std.debug.print("=== Tipos Opcionales en Zig ===\n\n", .{});

    const numeros = [_]u32{ 5, 2, 8, 1, 9, 3 };
    const vacio = [_]u32{};

    std.debug.print("--- buscar_maximo ---\n", .{});
    if (buscar_maximo(&numeros)) |max| {
        std.debug.print("Maximo de numeros: {} (esperado: 9)\n", .{max});
    } else {
        std.debug.print("numeros esta vacio\n", .{});
    }

    if (buscar_maximo(&vacio)) |max| {
        std.debug.print("Maximo de vacio: {}\n", .{max});
    } else {
        std.debug.print("vacio esta vacio (correcto!)\n", .{});
    }

    std.debug.print("\n--- buscar_indice ---\n", .{});
    const idx_8 = buscar_indice(&numeros, 8);
    const idx_99 = buscar_indice(&numeros, 99);

    std.debug.print("Indice de 8: {?} (esperado: 2)\n", .{idx_8});
    std.debug.print("Indice de 99: {?} (esperado: null)\n", .{idx_99});

    std.debug.print("\n--- division_segura ---\n", .{});
    const div1 = division_segura(10, 3);
    const div2 = division_segura(10, 0);

    std.debug.print("10 / 3 = {?} (esperado: 3)\n", .{div1});
    std.debug.print("10 / 0 = {?} (esperado: null)\n", .{div2});

    std.debug.print("\n--- Uso de orelse ---\n", .{});
    const resultado = division_segura(100, 0) orelse 0;
    std.debug.print("100 / 0 con orelse 0: {}\n", .{resultado});

    std.debug.print("\n--- buscar_primer_par ---\n", .{});
    const impares = [_]u32{ 1, 3, 5, 7 };
    const mixtos = [_]u32{ 1, 3, 4, 5 };

    std.debug.print("Primer par en impares: {?} (esperado: null)\n", .{buscar_primer_par(&impares)});
    std.debug.print("Primer par en mixtos: {?} (esperado: 4)\n", .{buscar_primer_par(&mixtos)});
}
