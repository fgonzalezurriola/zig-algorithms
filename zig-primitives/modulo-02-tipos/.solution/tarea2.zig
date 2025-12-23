const std = @import("std");

pub fn main() void {
    const celsius: i32 = 25;

    // Convert celsius to float, then apply formula
    const celsius_float: f64 = @floatFromInt(celsius);
    const fahrenheit: f64 = celsius_float * 9.0 / 5.0 + 32.0;

    // Convert back to integer (truncates, so 77.0 becomes 77)
    const fahrenheit_entero: i32 = @intFromFloat(fahrenheit);

    std.debug.print("Celsius: {}\n", .{celsius});
    std.debug.print("Fahrenheit: {d:.2}\n", .{fahrenheit});
    std.debug.print("Fahrenheit (entero): {}\n", .{fahrenheit_entero});

    // Part 2: Integer size conversions
    const valor_u32: u32 = 150;

    // Narrowing conversion requires @intCast
    const valor_u8: u8 = @intCast(valor_u32);

    // Widening conversion is implicit (u8 always fits in u64)
    const valor_u64: u64 = valor_u8;

    std.debug.print("u32: {}\n", .{valor_u32});
    std.debug.print("u8: {}\n", .{valor_u8});
    std.debug.print("u64: {}\n", .{valor_u64});
}
