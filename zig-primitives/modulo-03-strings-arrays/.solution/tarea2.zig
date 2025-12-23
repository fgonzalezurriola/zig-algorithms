const std = @import("std");

pub fn main() void {
    const temperaturas = [_]i32{ 22, 25, 18, 30, 35, 28, 20 };

    // Initialize max and min with first element
    var max: i32 = temperaturas[0];
    var min: i32 = temperaturas[0];
    var suma: i32 = 0;

    // Find max, min, and sum in one pass
    for (temperaturas) |temp| {
        if (temp > max) {
            max = temp;
        }
        if (temp < min) {
            min = temp;
        }
        suma += temp;
    }

    // Calculate average
    const suma_f: f64 = @floatFromInt(suma);
    const cantidad: f64 = @floatFromInt(temperaturas.len);
    const promedio: f64 = suma_f / cantidad;

    std.debug.print("Temperatura maxima: {}\n", .{max});
    std.debug.print("Temperatura minima: {}\n", .{min});
    std.debug.print("Promedio: {d:.2}\n", .{promedio});
}
