const std = @import("std");

pub fn main() void {
    // Mutable variable starting at 0
    var puntos: u32 = 0;

    std.debug.print("Puntos iniciales: {}\n", .{puntos});

    // Add 10 points
    puntos += 10;

    // Add 25 more points
    puntos += 25;

    // Subtract 5 points
    puntos -= 5;

    // Final result: 0 + 10 + 25 - 5 = 30
    std.debug.print("Puntos finales: {}\n", .{puntos});
}
