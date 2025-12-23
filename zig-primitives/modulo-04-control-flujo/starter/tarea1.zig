const std = @import("std");

pub fn main() void {
    // ===========================================
    // PARTE 1: Clasificar si un numero es positivo, negativo o cero
    // ===========================================

    const numero: i32 = -5;

    // TODO: Usa if/else para clasificar el numero
    // Si es mayor que 0, imprime "Positivo"
    // Si es menor que 0, imprime "Negativo"
    // Si es igual a 0, imprime "Cero"

    std.debug.print("El numero {} es: ", .{numero});
    // TODO: Tu codigo aqui (descomenta y completa)
    // if (numero > 0) {
    //     std.debug.print("Positivo\n", .{});
    // } else if ...
    std.debug.print("???\n", .{});

    // ===========================================
    // PARTE 2: Dado un numero del 1-12, obtener el nombre del mes
    // ===========================================

    const mes: u8 = 7;

    // TODO: Usa switch para obtener el nombre del mes
    // 1 = "Enero", 2 = "Febrero", ..., 12 = "Diciembre"
    // Para cualquier otro valor, retorna "Mes invalido"

    // Descomenta y completa el switch:
    const nombre_mes = switch (mes) {
        1 => "???",
        2 => "???",
        3 => "???",
        4 => "???",
        5 => "???",
        6 => "???",
        7 => "???",
        8 => "???",
        9 => "???",
        10 => "???",
        11 => "???",
        12 => "???",
        else => "Mes invalido",
    };

    std.debug.print("Mes {}: {s}\n", .{ mes, nombre_mes });

    // ===========================================
    // PARTE 3: Determinar si un anio es bisiesto
    // ===========================================

    const anio: u32 = 2024;

    // TODO: Un anio es bisiesto si:
    // - Es divisible por 4 Y NO es divisible por 100
    // - O es divisible por 400
    // Usa una expresion if para determinar esto

    // Descomenta y completa:
    const es_bisiesto = false;
    // const es_bisiesto = (anio % 4 == 0 and ...) or ...;
    _ = anio;

    std.debug.print("El anio 2024 ", .{});
    if (es_bisiesto) {
        std.debug.print("ES bisiesto\n", .{});
    } else {
        std.debug.print("NO es bisiesto\n", .{});
    }
}
