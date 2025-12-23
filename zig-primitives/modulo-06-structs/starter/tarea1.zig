const std = @import("std");

// ===========================================
// TAREA 1: Crear y usar un struct de Producto
// ===========================================

// TODO: Define el struct Producto con estos campos:
// - nombre: []const u8
// - precio: u32 (en centavos, ej: 1000 = $10.00)
// - cantidad: u32

// const Producto = struct {
//     ...
// };

pub fn main() void {
    // TODO: Crea 3 productos de ejemplo
    // Ejemplo:
    // const laptop = Producto{
    //     .nombre = "Laptop",
    //     .precio = 100000,  // $1000.00
    //     .cantidad = 5,
    // };

    // TODO: Imprime los detalles de cada producto
    // Formato: "Producto: NOMBRE - $XX.XX x CANTIDAD"

    // TODO: Calcula el valor total del inventario
    // valor_total = suma de (precio * cantidad) para cada producto

    // std.debug.print("\n=== Inventario ===\n", .{});
    // ... imprimir productos ...

    // std.debug.print("\nValor total del inventario: ${}\n", .{valor_total / 100});
}
