const std = @import("std");

pub fn main() void {
    const texto = "programacion";

    // Count vowels
    var vocales: u32 = 0;
    for (texto) |c| {
        if (c == 'a' or c == 'e' or c == 'i' or c == 'o' or c == 'u') {
            vocales += 1;
        }
    }

    // Check for letter 'z'
    var tiene_z: bool = false;
    for (texto) |c| {
        if (c == 'z') {
            tiene_z = true;
            break;
        }
    }

    // Print in uppercase
    std.debug.print("En mayusculas: ", .{});
    for (texto) |c| {
        if (c >= 'a' and c <= 'z') {
            std.debug.print("{c}", .{c - 32});
        } else {
            std.debug.print("{c}", .{c});
        }
    }
    std.debug.print("\n", .{});

    std.debug.print("Cantidad de vocales: {}\n", .{vocales});
    std.debug.print("Contiene 'z': {}\n", .{tiene_z});
}
