const std = @import("std");

pub fn main() void {
    // String constant
    const nombre = "Tu Nombre";

    // Birth year as unsigned 16-bit integer
    const anio_nacimiento: u16 = 1995;

    // Height as 32-bit floating point
    const altura: f32 = 1.75;

    // Boolean value
    const es_estudiante: bool = true;

    // Print all values
    std.debug.print("Nombre: {s}\n", .{nombre});
    std.debug.print("Anio de nacimiento: {}\n", .{anio_nacimiento});
    std.debug.print("Altura: {d:.2} metros\n", .{altura});
    std.debug.print("Es estudiante: {}\n", .{es_estudiante});
}
