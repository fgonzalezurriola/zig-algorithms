const std = @import("std");

pub fn main() void {
    const nota1: u32 = 85;
    const nota2: u32 = 72;
    const nota3: u32 = 90;
    const nota4: u32 = 45;
    const nota5: u32 = 58;

    const cantidad_notas: u32 = 5;

    // Calculate sum
    const suma: u32 = nota1 + nota2 + nota3 + nota4 + nota5;

    // Calculate average as float
    const suma_float: f64 = @floatFromInt(suma);
    const cantidad_float: f64 = @floatFromInt(cantidad_notas);
    const promedio: f64 = suma_float / cantidad_float;

    // Determine if passing
    const aprobado: bool = promedio >= 60.0;

    std.debug.print("Suma total: {}\n", .{suma});
    std.debug.print("Promedio: {d:.1}\n", .{promedio});
    std.debug.print("Aprobado: {}\n", .{aprobado});
}
