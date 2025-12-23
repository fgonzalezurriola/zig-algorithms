const std = @import("std");

// This file contains errors related to const/var usage.
// Find and fix the errors so the program compiles and runs correctly.

pub fn main() void {
    // Error 1: This value needs to change later
    var contador: i32 = 0;
    contador += 1;
    contador += 1;
    std.debug.print("Contador: {}\n", .{contador});

    // Error 2: This value never changes, why use var?
    const pi = 3.14159;
    std.debug.print("Pi: {d:.5}\n", .{pi});

    // Error 3: Same issue here
    const mensaje = "Hola Zig";
    std.debug.print("Mensaje: {s}\n", .{mensaje});

    // Error 4: This one is tricky - what should it be?
    var temperatura: i32 = 20;
    temperatura = temperatura + 5;
    std.debug.print("Temperatura: {}\n", .{temperatura});
}
