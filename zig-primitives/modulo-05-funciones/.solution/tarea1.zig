const std = @import("std");

fn valor_absoluto(n: i32) i32 {
    return if (n < 0) -n else n;
}

fn es_par(n: u32) bool {
    return n % 2 == 0;
}

fn mayor_de_tres(a: i32, b: i32, c: i32) i32 {
    var mayor = a;
    if (b > mayor) {
        mayor = b;
    }
    if (c > mayor) {
        mayor = c;
    }
    return mayor;
}

pub fn main() void {
    std.debug.print("=== Valor Absoluto ===\n", .{});
    std.debug.print("valor_absoluto(-5) = {} (esperado: 5)\n", .{valor_absoluto(-5)});
    std.debug.print("valor_absoluto(3) = {} (esperado: 3)\n", .{valor_absoluto(3)});
    std.debug.print("valor_absoluto(0) = {} (esperado: 0)\n", .{valor_absoluto(0)});

    std.debug.print("\n=== Es Par ===\n", .{});
    std.debug.print("es_par(4) = {} (esperado: true)\n", .{es_par(4)});
    std.debug.print("es_par(7) = {} (esperado: false)\n", .{es_par(7)});
    std.debug.print("es_par(0) = {} (esperado: true)\n", .{es_par(0)});

    std.debug.print("\n=== Mayor de Tres ===\n", .{});
    std.debug.print("mayor_de_tres(5, 9, 3) = {} (esperado: 9)\n", .{mayor_de_tres(5, 9, 3)});
    std.debug.print("mayor_de_tres(10, 2, 7) = {} (esperado: 10)\n", .{mayor_de_tres(10, 2, 7)});
    std.debug.print("mayor_de_tres(1, 1, 1) = {} (esperado: 1)\n", .{mayor_de_tres(1, 1, 1)});
}
