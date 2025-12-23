const std = @import("std");

pub fn main() void {
    // TODO: Choose the correct type for each variable based on the description

    // Age of a person (0-150 years, never negative)
    const edad = 25; // TODO: Add type annotation

    // Temperature in Celsius (can be negative, like -40)
    const temperatura = -15; // TODO: Add type annotation

    // Price of a product with cents (like 19.99)
    const precio = 29.99; // TODO: Add type annotation

    // Number of visits to a website (could be millions)
    const visitas = 1500000; // TODO: Add type annotation

    // Is the user logged in?
    const esta_logueado = true; // TODO: Add type annotation

    // A single byte value (0-255)
    const byte_valor = 128; // TODO: Add type annotation

    // Print all values to verify
    std.debug.print("Edad: {}\n", .{edad});
    std.debug.print("Temperatura: {}\n", .{temperatura});
    std.debug.print("Precio: {d:.2}\n", .{precio});
    std.debug.print("Visitas: {}\n", .{visitas});
    std.debug.print("Logueado: {}\n", .{esta_logueado});
    std.debug.print("Byte: {}\n", .{byte_valor});
}
