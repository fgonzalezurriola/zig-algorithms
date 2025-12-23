const std = @import("std");

pub fn main() void {
    // Fix 1: contador needs to change, so use var
    var contador: i32 = 0;
    contador += 1;
    contador += 1;
    std.debug.print("Contador: {}\n", .{contador});

    // Fix 2: pi never changes, use const
    const pi = 3.14159;
    std.debug.print("Pi: {d:.5}\n", .{pi});

    // Fix 3: mensaje never changes, use const
    const mensaje = "Hola Zig";
    std.debug.print("Mensaje: {s}\n", .{mensaje});

    // Fix 4: temperatura needs to change, use var
    var temperatura: i32 = 20;
    temperatura = temperatura + 5;
    std.debug.print("Temperatura: {}\n", .{temperatura});
}
