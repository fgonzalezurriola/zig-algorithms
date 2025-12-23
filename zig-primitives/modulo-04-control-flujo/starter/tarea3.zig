const std = @import("std");

pub fn main() void {
    // Array de notas de un estudiante
    const notas = [_]u32{ 85, 92, 78, 65, 88, 70, 95, 82 };

    // ===========================================
    // PARTE 1: Convertir cada nota a letra e imprimir
    // ===========================================

    // Escala de calificaciones:
    // 90-100 = 'A'
    // 80-89  = 'B'
    // 70-79  = 'C'
    // 60-69  = 'D'
    // 0-59   = 'F'

    std.debug.print("Notas del estudiante:\n", .{});

    // TODO: Itera sobre las notas con for
    // Para cada nota, usa switch para convertirla a letra
    // Imprime: "  Nota XX -> Y" donde XX es el numero y Y es la letra

    // for (notas, 0..) |nota, i| {
    //     const letra = switch (nota) {
    //         ...
    //     };
    //     std.debug.print("  Nota {}: {} -> {c}\n", .{ i + 1, nota, letra });
    // }

    // ===========================================
    // PARTE 2: Contar cuantas notas de cada letra hay
    // ===========================================

    // TODO: Declara contadores para cada letra
    // var count_a: u32 = 0;
    // var count_b: u32 = 0;
    // ... etc

    // TODO: Itera de nuevo sobre las notas y cuenta cada tipo

    // std.debug.print("\nResumen:\n", .{});
    // std.debug.print("  A: {}\n", .{count_a});
    // std.debug.print("  B: {}\n", .{count_b});
    // ... etc

    // ===========================================
    // PARTE 3: Calcular promedio y determinar si aprueba
    // ===========================================

    // TODO: Suma todas las notas
    // var suma: u32 = 0;
    // for (notas) |nota| {
    //     ...
    // }

    // TODO: Calcula el promedio (suma / cantidad de notas)
    // const promedio = suma / notas.len;

    // TODO: Usa if como expresion para determinar el estado
    // const estado = if (promedio >= 60) "APROBADO" else "REPROBADO";

    // std.debug.print("\nPromedio: {}\n", .{promedio});
    // std.debug.print("Estado: {s}\n", .{estado});

    _ = notas;
}
