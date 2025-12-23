const std = @import("std");

// =============================================================================
// TAREA 7: Busqueda con tipos opcionales
// =============================================================================
//
// Contexto: En muchos lenguajes se usa -1 o null para indicar "no encontrado".
// Esto es propenso a errores porque puedes olvidar verificar.
//
// En Zig, el tipo ?T (opcional) te OBLIGA a manejar el caso null.
// El compilador no te deja ignorarlo.
//
// Sintaxis:
//   ?u32         - un u32 opcional (puede ser un u32 o null)
//   return null  - retornar "sin valor"
//   return 42    - retornar un valor (Zig lo envuelve automaticamente)
//
// Para usar el valor:
//   valor orelse default    - usar default si es null
//   if (valor) |v| { ... }  - capturar el valor si existe
//   valor.?                 - unwrap (PANIC si es null!)
// =============================================================================

// Busca el valor maximo en un slice de u32
// Retorna null si el slice esta vacio
fn buscar_maximo(datos: []const u32) ?u32 {
    // TODO: Implementar
    // Si datos.len == 0, retornar null
    // Sino, recorrer y encontrar el maximo

    _ = datos;
    return null; // Placeholder
}

// Busca un valor en un slice y retorna su indice
// Retorna null si el valor no existe
fn buscar_indice(datos: []const u32, valor: u32) ?usize {
    // TODO: Implementar
    // Recorrer datos, si encontramos valor retornar el indice
    // Si no lo encontramos, retornar null

    _ = datos;
    _ = valor;
    return null; // Placeholder
}

// Division que retorna null si el divisor es 0
fn division_segura(dividendo: u32, divisor: u32) ?u32 {
    // TODO: Implementar
    // Si divisor es 0, retornar null
    // Sino, retornar el resultado de la division

    _ = dividendo;
    _ = divisor;
    return null; // Placeholder
}

// Busca el primer numero par en un slice
// Retorna null si no hay ningun par
fn buscar_primer_par(datos: []const u32) ?u32 {
    // TODO: Implementar
    // Un numero es par si numero % 2 == 0

    _ = datos;
    return null; // Placeholder
}

pub fn main() void {
    std.debug.print("=== Tipos Opcionales en Zig ===\n\n", .{});

    const numeros = [_]u32{ 5, 2, 8, 1, 9, 3 };
    const vacio = [_]u32{};

    // Test buscar_maximo
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

    // Test buscar_indice
    std.debug.print("\n--- buscar_indice ---\n", .{});
    const idx_8 = buscar_indice(&numeros, 8);
    const idx_99 = buscar_indice(&numeros, 99);

    std.debug.print("Indice de 8: {?} (esperado: 2)\n", .{idx_8});
    std.debug.print("Indice de 99: {?} (esperado: null)\n", .{idx_99});

    // Test division_segura
    std.debug.print("\n--- division_segura ---\n", .{});
    const div1 = division_segura(10, 3);
    const div2 = division_segura(10, 0);

    std.debug.print("10 / 3 = {?} (esperado: 3)\n", .{div1});
    std.debug.print("10 / 0 = {?} (esperado: null)\n", .{div2});

    // Uso de orelse
    std.debug.print("\n--- Uso de orelse ---\n", .{});
    const resultado = division_segura(100, 0) orelse 0;
    std.debug.print("100 / 0 con orelse 0: {}\n", .{resultado});

    // Test buscar_primer_par
    std.debug.print("\n--- buscar_primer_par ---\n", .{});
    const impares = [_]u32{ 1, 3, 5, 7 };
    const mixtos = [_]u32{ 1, 3, 4, 5 };

    std.debug.print("Primer par en impares: {?} (esperado: null)\n", .{buscar_primer_par(&impares)});
    std.debug.print("Primer par en mixtos: {?} (esperado: 4)\n", .{buscar_primer_par(&mixtos)});
}
