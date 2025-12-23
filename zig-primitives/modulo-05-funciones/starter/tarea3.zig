const std = @import("std");

// ===========================================
// TAREA 3: Funciones que modifican arrays
// ===========================================

// TODO: Implementar sumar_a_todos
// Suma el valor dado a cada elemento del array
// Ejemplo: [1, 2, 3] con valor=10 -> [11, 12, 13]
fn sumar_a_todos(arr: []i32, valor: i32) void {
    // TODO: Tu implementacion aqui
    // Usa for con puntero: for (arr) |*elemento|
    // Modifica con: elemento.* += valor
    _ = arr;
    _ = valor;
}

// TODO: Implementar aplicar_descuento
// Reduce cada precio por el porcentaje dado
// Ejemplo: [100, 200] con 10% -> [90, 180]
fn aplicar_descuento(precios: []u32, porcentaje: u32) void {
    // TODO: Tu implementacion aqui
    // descuento = precio * porcentaje / 100
    // nuevo_precio = precio - descuento
    _ = precios;
    _ = porcentaje;
}

// TODO: Implementar procesar_inventario
// Esta funcion debe:
// 1. Aplicar un 20% de descuento a todos los precios
// 2. Mostrar los precios finales
fn procesar_inventario(precios: []u32) void {
    // TODO: Tu implementacion aqui
    // 1. Llama a aplicar_descuento con 20%
    // 2. Imprime cada precio
    _ = precios;
}

pub fn main() void {
    // Prueba de sumar_a_todos
    var numeros = [_]i32{ 1, 2, 3, 4, 5 };
    std.debug.print("=== Sumar a Todos ===\n", .{});
    std.debug.print("Original: {any}\n", .{numeros});
    sumar_a_todos(&numeros, 10);
    std.debug.print("Despues de sumar 10: {any}\n", .{numeros});
    std.debug.print("(esperado: [11, 12, 13, 14, 15])\n", .{});

    // Prueba de aplicar_descuento
    var precios = [_]u32{ 100, 200, 150, 80 };
    std.debug.print("\n=== Aplicar Descuento ===\n", .{});
    std.debug.print("Precios originales: {any}\n", .{precios});
    aplicar_descuento(&precios, 10);
    std.debug.print("Despues de 10%% descuento: {any}\n", .{precios});
    std.debug.print("(esperado: [90, 180, 135, 72])\n", .{});

    // Prueba de procesar_inventario
    var inventario = [_]u32{ 500, 1000, 750, 250 };
    std.debug.print("\n=== Procesar Inventario ===\n", .{});
    std.debug.print("Precios originales: {any}\n", .{inventario});
    procesar_inventario(&inventario);
    std.debug.print("(esperado: 20%% de descuento aplicado)\n", .{});
}
