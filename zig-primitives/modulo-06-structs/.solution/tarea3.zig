const std = @import("std");

const Direccion = struct {
    calle: []const u8,
    numero: u32,
    ciudad: []const u8,

    pub fn mostrar(self: Direccion) void {
        std.debug.print("{s} #{}, {s}", .{
            self.calle,
            self.numero,
            self.ciudad,
        });
    }
};

const Persona = struct {
    nombre: []const u8,
    edad: u32,
    direccion: Direccion,

    pub fn mostrar(self: Persona) void {
        std.debug.print("{s} ({} anios)\n", .{ self.nombre, self.edad });
        std.debug.print("  Direccion: ", .{});
        self.direccion.mostrar();
        std.debug.print("\n\n", .{});
    }
};

fn contar_de_ciudad(personas: []const Persona, ciudad: []const u8) u32 {
    var contador: u32 = 0;
    for (personas) |p| {
        if (std.mem.eql(u8, p.direccion.ciudad, ciudad)) {
            contador += 1;
        }
    }
    return contador;
}

pub fn main() void {
    const personas = [_]Persona{
        .{
            .nombre = "Ana Garcia",
            .edad = 28,
            .direccion = .{
                .calle = "Gran Via",
                .numero = 123,
                .ciudad = "Madrid",
            },
        },
        .{
            .nombre = "Carlos Lopez",
            .edad = 35,
            .direccion = .{
                .calle = "Las Ramblas",
                .numero = 456,
                .ciudad = "Barcelona",
            },
        },
        .{
            .nombre = "Maria Rodriguez",
            .edad = 42,
            .direccion = .{
                .calle = "Alcala",
                .numero = 789,
                .ciudad = "Madrid",
            },
        },
        .{
            .nombre = "Pedro Martinez",
            .edad = 31,
            .direccion = .{
                .calle = "Diagonal",
                .numero = 101,
                .ciudad = "Barcelona",
            },
        },
    };

    std.debug.print("=== Lista de Personas ===\n\n", .{});
    for (personas) |p| {
        p.mostrar();
    }

    std.debug.print("--- Estadisticas por Ciudad ---\n", .{});
    const en_madrid = contar_de_ciudad(&personas, "Madrid");
    const en_barcelona = contar_de_ciudad(&personas, "Barcelona");

    std.debug.print("Personas en Madrid: {}\n", .{en_madrid});
    std.debug.print("Personas en Barcelona: {}\n", .{en_barcelona});
}
