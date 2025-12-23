const std = @import("std");

// ===========================================
// TAREA 2: Funciones que trabajan con arrays (slices)
// ===========================================

// TODO: Implementar promedio
// Calcula el promedio de todos los numeros en el slice
// Ejemplo: promedio([10, 20, 30]) -> 20
fn promedio(numeros: []const u32) u32 {
    // TODO: Tu implementacion aqui
    // 1. Suma todos los elementos
    // 2. Divide por la cantidad de elementos
    _ = numeros;
    return 0;
}

// TODO: Implementar contiene
// Retorna true si el valor esta en el array, false si no
// Ejemplo: contiene([1, 2, 3], 2) -> true
fn contiene(arr: []const i32, valor: i32) bool {
    // TODO: Tu implementacion aqui
    // Usa un for loop y retorna true cuando encuentres el valor
    _ = arr;
    _ = valor;
    return false;
}

// TODO: Implementar contar_pares
// Cuenta cuantos numeros pares hay en el array
// Ejemplo: contar_pares([1, 2, 3, 4, 5, 6]) -> 3
fn contar_pares(numeros: []const u32) u32 {
    // TODO: Tu implementacion aqui
    _ = numeros;
    return 0;
}

pub fn main() void {
    // Pruebas de promedio
    const notas = [_]u32{ 80, 90, 70, 85, 75 };
    std.debug.print("=== Promedio ===\n", .{});
    std.debug.print("Notas: {any}\n", .{notas});
    std.debug.print("Promedio: {} (esperado: 80)\n", .{promedio(&notas)});

    // Pruebas de contiene
    const numeros = [_]i32{ 10, 20, 30, 40, 50 };
    std.debug.print("\n=== Contiene ===\n", .{});
    std.debug.print("Array: {any}\n", .{numeros});
    std.debug.print("contiene(30) = {} (esperado: true)\n", .{contiene(&numeros, 30)});
    std.debug.print("contiene(25) = {} (esperado: false)\n", .{contiene(&numeros, 25)});

    // Pruebas de contar_pares
    const mixtos = [_]u32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    std.debug.print("\n=== Contar Pares ===\n", .{});
    std.debug.print("Array: {any}\n", .{mixtos});
    std.debug.print("Pares: {} (esperado: 5)\n", .{contar_pares(&mixtos)});
}
