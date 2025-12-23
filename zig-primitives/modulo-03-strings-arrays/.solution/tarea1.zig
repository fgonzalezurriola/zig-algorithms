const std = @import("std");

pub fn main() void {
    // Array with days 1 through 7
    const dias = [_]u32{ 1, 2, 3, 4, 5, 6, 7 };

    // First day (index 0)
    std.debug.print("Primer dia: {}\n", .{dias[0]});

    // Last day (index 6, or use len - 1)
    std.debug.print("Ultimo dia: {}\n", .{dias[dias.len - 1]});

    // Calculate sum using a for loop
    var suma: u32 = 0;
    for (dias) |dia| {
        suma += dia;
    }

    // Sum should be 1+2+3+4+5+6+7 = 28
    std.debug.print("Suma de todos los dias: {}\n", .{suma});
}
