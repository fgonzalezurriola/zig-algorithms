const std = @import("std");

pub fn main() void {
    // Temperature in Celsius (integer)
    const celsius: i32 = 25;

    // TODO: Convert celsius to fahrenheit using the formula: F = C * 9/5 + 32
    // Hint: You need to convert celsius to f64 first using @floatFromInt

    // TODO: Declare fahrenheit as f64 and calculate it
    // const fahrenheit: f64 = ...

    // TODO: Convert fahrenheit back to integer (truncating decimals)
    // const fahrenheit_entero: i32 = ...

    std.debug.print("Celsius: {}\n", .{celsius});
    // TODO: Uncomment after implementing
    // std.debug.print("Fahrenheit: {d:.2}\n", .{fahrenheit});
    // std.debug.print("Fahrenheit (entero): {}\n", .{fahrenheit_entero});

    // Part 2: Integer size conversions
    const valor_u32: u32 = 150;

    // TODO: Convert valor_u32 to u8 using @intCast
    // const valor_u8: u8 = ...

    // TODO: Convert valor_u8 to u64 (no cast needed - why?)
    // const valor_u64: u64 = ...

    // TODO: Uncomment after implementing
    // std.debug.print("u32: {}\n", .{valor_u32});
    // std.debug.print("u8: {}\n", .{valor_u8});
    // std.debug.print("u64: {}\n", .{valor_u64});
}
