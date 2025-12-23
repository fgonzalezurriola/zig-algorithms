const std = @import("std");

pub fn main() void {
    // Age: unsigned 8-bit is enough (0-255 range)
    const edad: u8 = 25;

    // Temperature: signed because it can be negative
    const temperatura: i16 = -15;

    // Price: floating point for cents
    const precio: f32 = 29.99;

    // Website visits: could be millions, use u32
    const visitas: u32 = 1500000;

    // Boolean for logged in status
    const esta_logueado: bool = true;

    // Single byte value
    const byte_valor: u8 = 128;

    std.debug.print("Edad: {}\n", .{edad});
    std.debug.print("Temperatura: {}\n", .{temperatura});
    std.debug.print("Precio: {d:.2}\n", .{precio});
    std.debug.print("Visitas: {}\n", .{visitas});
    std.debug.print("Logueado: {}\n", .{esta_logueado});
    std.debug.print("Byte: {}\n", .{byte_valor});
}
