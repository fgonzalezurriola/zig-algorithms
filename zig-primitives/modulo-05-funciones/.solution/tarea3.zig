const std = @import("std");

fn sumar_a_todos(arr: []i32, valor: i32) void {
    for (arr) |*elemento| {
        elemento.* += valor;
    }
}

fn aplicar_descuento(precios: []u32, porcentaje: u32) void {
    for (precios) |*precio| {
        const descuento = precio.* * porcentaje / 100;
        precio.* -= descuento;
    }
}

fn procesar_inventario(precios: []u32) void {
    aplicar_descuento(precios, 20);

    std.debug.print("Precios con descuento:\n", .{});
    for (precios, 0..) |precio, i| {
        std.debug.print("  Producto {}: ${}\n", .{ i + 1, precio });
    }
}

pub fn main() void {
    var numeros = [_]i32{ 1, 2, 3, 4, 5 };
    std.debug.print("=== Sumar a Todos ===\n", .{});
    std.debug.print("Original: {any}\n", .{numeros});
    sumar_a_todos(&numeros, 10);
    std.debug.print("Despues de sumar 10: {any}\n", .{numeros});
    std.debug.print("(esperado: [11, 12, 13, 14, 15])\n", .{});

    var precios = [_]u32{ 100, 200, 150, 80 };
    std.debug.print("\n=== Aplicar Descuento ===\n", .{});
    std.debug.print("Precios originales: {any}\n", .{precios});
    aplicar_descuento(&precios, 10);
    std.debug.print("Despues de 10%% descuento: {any}\n", .{precios});
    std.debug.print("(esperado: [90, 180, 135, 72])\n", .{});

    var inventario = [_]u32{ 500, 1000, 750, 250 };
    std.debug.print("\n=== Procesar Inventario ===\n", .{});
    std.debug.print("Precios originales: {any}\n", .{inventario});
    procesar_inventario(&inventario);
    std.debug.print("(esperado: 20%% de descuento aplicado)\n", .{});
}
