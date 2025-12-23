const std = @import("std");

const Producto = struct {
    nombre: []const u8,
    precio: u32,
    cantidad: u32,

    pub fn valor_total(self: Producto) u32 {
        return self.precio * self.cantidad;
    }

    pub fn mostrar(self: Producto) void {
        std.debug.print("  {s}: ${}.{:0>2} x {} = ${}.{:0>2}\n", .{
            self.nombre,
            self.precio / 100,
            self.precio % 100,
            self.cantidad,
            self.valor_total() / 100,
            self.valor_total() % 100,
        });
    }
};

pub fn main() void {
    const laptop = Producto{
        .nombre = "Laptop",
        .precio = 100000,
        .cantidad = 5,
    };

    const mouse = Producto{
        .nombre = "Mouse",
        .precio = 2500,
        .cantidad = 20,
    };

    const teclado = Producto{
        .nombre = "Teclado",
        .precio = 5000,
        .cantidad = 15,
    };

    std.debug.print("=== Inventario ===\n\n", .{});

    laptop.mostrar();
    mouse.mostrar();
    teclado.mostrar();

    const valor_total = laptop.valor_total() + mouse.valor_total() + teclado.valor_total();

    std.debug.print("\n--- Total ---\n", .{});
    std.debug.print("Valor del inventario: ${}.{:0>2}\n", .{
        valor_total / 100,
        valor_total % 100,
    });
}
