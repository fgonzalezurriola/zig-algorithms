const std = @import("std");

pub fn main() void {
    // Example: declaring a string constant (array of characters)
    const nombre = "Tu Nombre";
    std.debug.print("Nombre: {s}\n", .{nombre});

    // TODO: Declare a constant 'anio_nacimiento' of type u16 with your birth year
    // TODO: Declare a constant 'altura' of type f32 with your height in meters (e.g., 1.75)
    // TODO: Declare a constant 'es_estudiante' of type bool (true or false)
    const anho_nacimiento: []const u8 = "2003";
    const altura: f32 = 1.71;
    const es_estudiante: bool = true;

    // Print all values
    std.debug.print("Año de nacimiento: {s:4}\n", .{anho_nacimiento});
    std.debug.print("altura: {d:.2}\n", .{altura});
    std.debug.print("es_estudiante: {}\n", .{es_estudiante});
}
