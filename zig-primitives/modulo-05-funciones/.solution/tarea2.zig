const std = @import("std");

fn promedio(numeros: []const u32) u32 {
    var suma: u32 = 0;
    for (numeros) |n| {
        suma += n;
    }
    return suma / @as(u32, @intCast(numeros.len));
}

fn contiene(arr: []const i32, valor: i32) bool {
    for (arr) |n| {
        if (n == valor) {
            return true;
        }
    }
    return false;
}

fn contar_pares(numeros: []const u32) u32 {
    var contador: u32 = 0;
    for (numeros) |n| {
        if (n % 2 == 0) {
            contador += 1;
        }
    }
    return contador;
}

pub fn main() void {
    const notas = [_]u32{ 80, 90, 70, 85, 75 };
    std.debug.print("=== Promedio ===\n", .{});
    std.debug.print("Notas: {any}\n", .{notas});
    std.debug.print("Promedio: {} (esperado: 80)\n", .{promedio(&notas)});

    const numeros = [_]i32{ 10, 20, 30, 40, 50 };
    std.debug.print("\n=== Contiene ===\n", .{});
    std.debug.print("Array: {any}\n", .{numeros});
    std.debug.print("contiene(30) = {} (esperado: true)\n", .{contiene(&numeros, 30)});
    std.debug.print("contiene(25) = {} (esperado: false)\n", .{contiene(&numeros, 25)});

    const mixtos = [_]u32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    std.debug.print("\n=== Contar Pares ===\n", .{});
    std.debug.print("Array: {any}\n", .{mixtos});
    std.debug.print("Pares: {} (esperado: 5)\n", .{contar_pares(&mixtos)});
}
