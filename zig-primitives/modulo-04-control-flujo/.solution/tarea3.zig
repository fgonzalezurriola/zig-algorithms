const std = @import("std");

pub fn main() void {
    const notas = [_]u32{ 85, 92, 78, 65, 88, 70, 95, 82 };

    // ===========================================
    // PARTE 1: Convertir cada nota a letra e imprimir
    // ===========================================

    std.debug.print("Notas del estudiante:\n", .{});

    for (notas, 0..) |nota, i| {
        const letra: u8 = switch (nota) {
            90...100 => 'A',
            80...89 => 'B',
            70...79 => 'C',
            60...69 => 'D',
            0...59 => 'F',
            else => '?',
        };
        std.debug.print("  Nota {}: {} -> {c}\n", .{ i + 1, nota, letra });
    }

    // ===========================================
    // PARTE 2: Contar cuantas notas de cada letra hay
    // ===========================================

    var count_a: u32 = 0;
    var count_b: u32 = 0;
    var count_c: u32 = 0;
    var count_d: u32 = 0;
    var count_f: u32 = 0;

    for (notas) |nota| {
        switch (nota) {
            90...100 => count_a += 1,
            80...89 => count_b += 1,
            70...79 => count_c += 1,
            60...69 => count_d += 1,
            0...59 => count_f += 1,
            else => {},
        }
    }

    std.debug.print("\nResumen:\n", .{});
    std.debug.print("  A: {}\n", .{count_a});
    std.debug.print("  B: {}\n", .{count_b});
    std.debug.print("  C: {}\n", .{count_c});
    std.debug.print("  D: {}\n", .{count_d});
    std.debug.print("  F: {}\n", .{count_f});

    // ===========================================
    // PARTE 3: Calcular promedio y determinar si aprueba
    // ===========================================

    var suma: u32 = 0;
    for (notas) |nota| {
        suma += nota;
    }

    const promedio = suma / notas.len;
    const estado = if (promedio >= 60) "APROBADO" else "REPROBADO";

    std.debug.print("\nPromedio: {}\n", .{promedio});
    std.debug.print("Estado: {s}\n", .{estado});
}
