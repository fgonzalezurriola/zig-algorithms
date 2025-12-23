const std = @import("std");

// ===========================================
// TAREA 3: Composicion de structs
// ===========================================

// TODO: Define el struct Direccion con:
// - calle: []const u8
// - numero: u32
// - ciudad: []const u8

// const Direccion = struct {
//     ...
// };

// TODO: Define el struct Persona con:
// - nombre: []const u8
// - edad: u32
// - direccion: Direccion

// const Persona = struct {
//     ...
//
//     // Metodo para mostrar los datos
//     pub fn mostrar(self: Persona) void {
//         // TODO: imprimir nombre, edad y direccion completa
//     }
// };

// TODO: Implementar funcion que cuenta personas de una ciudad
// fn contar_de_ciudad(personas: []const Persona, ciudad: []const u8) u32 {
//     // Usa std.mem.eql(u8, str1, str2) para comparar strings
// }

pub fn main() void {
    // TODO: Crear un array de 3-4 personas con sus direcciones
    // Ejemplo:
    // const personas = [_]Persona{
    //     .{
    //         .nombre = "Ana",
    //         .edad = 28,
    //         .direccion = .{
    //             .calle = "Principal",
    //             .numero = 123,
    //             .ciudad = "Madrid",
    //         },
    //     },
    //     // ... mas personas
    // };

    // TODO: Mostrar todas las personas
    // std.debug.print("=== Lista de Personas ===\n\n", .{});
    // for (personas) |p| {
    //     p.mostrar();
    // }

    // TODO: Contar cuantas personas viven en "Madrid"
    // const en_madrid = contar_de_ciudad(&personas, "Madrid");
    // std.debug.print("\nPersonas en Madrid: {}\n", .{en_madrid});
}
