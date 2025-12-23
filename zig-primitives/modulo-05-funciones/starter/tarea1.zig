const std = @import("std");

// ===========================================
// TAREA 1: Implementar funciones matematicas basicas
// ===========================================

// TODO: Implementar valor_absoluto
// Debe retornar el valor absoluto de n
// Ejemplo: valor_absoluto(-5) -> 5, valor_absoluto(3) -> 3
fn valor_absoluto(n: i32) i32 {
    // TODO: Tu implementacion aqui
    _ = n;
    return 0;
}

// TODO: Implementar es_par
// Debe retornar true si n es par, false si es impar
// Ejemplo: es_par(4) -> true, es_par(7) -> false
fn es_par(n: u32) bool {
    // TODO: Tu implementacion aqui
    _ = n;
    return false;
}

// TODO: Implementar mayor_de_tres
// Debe retornar el mayor de los tres numeros
// Ejemplo: mayor_de_tres(5, 9, 3) -> 9
fn mayor_de_tres(a: i32, b: i32, c: i32) i32 {
    // TODO: Tu implementacion aqui
    _ = a;
    _ = b;
    _ = c;
    return 0;
}

pub fn main() void {
    // Pruebas de valor_absoluto
    std.debug.print("=== Valor Absoluto ===\n", .{});
    std.debug.print("valor_absoluto(-5) = {} (esperado: 5)\n", .{valor_absoluto(-5)});
    std.debug.print("valor_absoluto(3) = {} (esperado: 3)\n", .{valor_absoluto(3)});
    std.debug.print("valor_absoluto(0) = {} (esperado: 0)\n", .{valor_absoluto(0)});

    // Pruebas de es_par
    std.debug.print("\n=== Es Par ===\n", .{});
    std.debug.print("es_par(4) = {} (esperado: true)\n", .{es_par(4)});
    std.debug.print("es_par(7) = {} (esperado: false)\n", .{es_par(7)});
    std.debug.print("es_par(0) = {} (esperado: true)\n", .{es_par(0)});

    // Pruebas de mayor_de_tres
    std.debug.print("\n=== Mayor de Tres ===\n", .{});
    std.debug.print("mayor_de_tres(5, 9, 3) = {} (esperado: 9)\n", .{mayor_de_tres(5, 9, 3)});
    std.debug.print("mayor_de_tres(10, 2, 7) = {} (esperado: 10)\n", .{mayor_de_tres(10, 2, 7)});
    std.debug.print("mayor_de_tres(1, 1, 1) = {} (esperado: 1)\n", .{mayor_de_tres(1, 1, 1)});
}
