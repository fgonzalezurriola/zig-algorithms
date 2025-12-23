const std = @import("std");

pub fn main() void {
    // TODO: Create a variable 'puntos' of type u32, starting at 0
    var puntos: u32 = 0;
    std.debug.print("Puntos iniciales: {}\n", .{0}); // Change 0 to puntos

    // TODO: Add 10 points
    puntos += 10;
    // TODO: Add 25 more points
    puntos += 25;
    // TODO: Subtract 5 points
    puntos -= 5;
    // TODO: Print the final result (should be 30)
    std.debug.print("Puntos finales: {d:.2}", .{puntos});
    // std.debug.print("Puntos finales: {}\n", .{puntos});
}
