const std = @import("std");

pub fn main() void {
    // ===========================================
    // PARTE 1: Clasificar si un numero es positivo, negativo o cero
    // ===========================================

    const numero: i32 = -5;

    std.debug.print("El numero {} es: ", .{numero});
    if (numero > 0) {
        std.debug.print("Positivo\n", .{});
    } else if (numero < 0) {
        std.debug.print("Negativo\n", .{});
    } else {
        std.debug.print("Cero\n", .{});
    }

    // ===========================================
    // PARTE 2: Dado un numero del 1-12, obtener el nombre del mes
    // ===========================================

    const mes: u8 = 7;

    const nombre_mes = switch (mes) {
        1 => "Enero",
        2 => "Febrero",
        3 => "Marzo",
        4 => "Abril",
        5 => "Mayo",
        6 => "Junio",
        7 => "Julio",
        8 => "Agosto",
        9 => "Septiembre",
        10 => "Octubre",
        11 => "Noviembre",
        12 => "Diciembre",
        else => "Mes invalido",
    };

    std.debug.print("Mes {}: {s}\n", .{ mes, nombre_mes });

    // ===========================================
    // PARTE 3: Determinar si un anio es bisiesto
    // ===========================================

    const anio: u32 = 2024;

    const es_bisiesto = (anio % 4 == 0 and anio % 100 != 0) or (anio % 400 == 0);

    std.debug.print("El anio {} ", .{anio});
    if (es_bisiesto) {
        std.debug.print("ES bisiesto\n", .{});
    } else {
        std.debug.print("NO es bisiesto\n", .{});
    }
}
