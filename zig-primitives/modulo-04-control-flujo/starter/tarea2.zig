const std = @import("std");

pub fn main() void {
    // ===========================================
    // PARTE 1: Calcular el factorial de 5 usando while
    // ===========================================

    // El factorial de 5 es: 5 * 4 * 3 * 2 * 1 = 120

    // TODO: Declara una variable para el resultado (empieza en 1)
    // var factorial: u32 = 1;

    // TODO: Declara una variable para el contador (empieza en 5)
    // var n: u32 = 5;

    // TODO: Usa un bucle while que multiplique factorial por n
    // y decremente n hasta que n sea 1
    // while (n > 1) {
    //     ...
    // }

    // std.debug.print("5! = {}\n", .{factorial});

    // ===========================================
    // PARTE 2: Sumar solo los numeros pares de un array
    // ===========================================

    const numeros = [_]u32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

    // TODO: Usa for para iterar sobre el array
    // Si el numero es par (divisible por 2), sumalo
    // Si es impar, usa continue para saltarlo

    // var suma_pares: u32 = 0;
    // for (numeros) |num| {
    //     ...
    // }

    // std.debug.print("Suma de pares: {}\n", .{suma_pares});

    // ===========================================
    // PARTE 3: Encontrar el primer multiplo de 7 mayor que 50
    // ===========================================

    // TODO: Empieza en 51 y busca el primer numero divisible por 7
    // Usa while con break cuando lo encuentres

    // var numero: u32 = 51;
    // while (numero < 100) {
    //     ...
    // }

    // std.debug.print("Primer multiplo de 7 mayor que 50: {}\n", .{numero});

    _ = numeros;
}
