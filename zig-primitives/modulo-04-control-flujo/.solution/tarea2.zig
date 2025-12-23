const std = @import("std");

pub fn main() void {
    // ===========================================
    // PARTE 1: Calcular el factorial de 5 usando while
    // ===========================================

    var factorial: u32 = 1;
    var n: u32 = 5;

    while (n > 1) {
        factorial *= n;
        n -= 1;
    }

    std.debug.print("5! = {}\n", .{factorial});

    // ===========================================
    // PARTE 2: Sumar solo los numeros pares de un array
    // ===========================================

    const numeros = [_]u32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

    var suma_pares: u32 = 0;
    for (numeros) |num| {
        if (num % 2 != 0) {
            continue;
        }
        suma_pares += num;
    }

    std.debug.print("Suma de pares: {}\n", .{suma_pares});

    // ===========================================
    // PARTE 3: Encontrar el primer multiplo de 7 mayor que 50
    // ===========================================

    var numero: u32 = 51;
    while (numero < 100) {
        if (numero % 7 == 0) {
            break;
        }
        numero += 1;
    }

    std.debug.print("Primer multiplo de 7 mayor que 50: {}\n", .{numero});
}
