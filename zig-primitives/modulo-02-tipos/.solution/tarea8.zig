const std = @import("std");

// =============================================================================
// TAREA 8: Validador de rangos de sensores - SOLUCION
// =============================================================================

const SensorData = struct {
    temperatura: i16,
    humedad: u8,
    presion: u16,
};

fn validar_temperatura(raw: i16) ?i16 {
    if (raw < -40 or raw > 125) return null;
    return raw;
}

fn validar_humedad(raw: u8) ?u8 {
    if (raw > 100) return null;
    return raw;
}

fn validar_presion(raw: u16) ?u16 {
    if (raw < 300 or raw > 1100) return null;
    return raw;
}

fn validar_sensor_completo(raw_temp: i16, raw_hum: u8, raw_pres: u16) ?SensorData {
    // Propagacion temprana con orelse
    const temp = validar_temperatura(raw_temp) orelse return null;
    const hum = validar_humedad(raw_hum) orelse return null;
    const pres = validar_presion(raw_pres) orelse return null;

    return SensorData{
        .temperatura = temp,
        .humedad = hum,
        .presion = pres,
    };
}

fn i16_a_u8_seguro(valor: i16) ?u8 {
    if (valor < 0 or valor > 255) return null;
    return @intCast(valor);
}

pub fn main() void {
    std.debug.print("=== Validador de Sensores ===\n\n", .{});

    std.debug.print("--- Validacion de Temperatura ---\n", .{});
    const temps = [_]i16{ -50, -40, 25, 125, 130 };
    for (temps) |t| {
        if (validar_temperatura(t)) |valido| {
            std.debug.print("  {} C: VALIDO ({})\n", .{ t, valido });
        } else {
            std.debug.print("  {} C: INVALIDO\n", .{t});
        }
    }

    std.debug.print("\n--- Validacion de Humedad ---\n", .{});
    const hums = [_]u8{ 0, 50, 100, 101, 255 };
    for (hums) |h| {
        if (validar_humedad(h)) |valido| {
            std.debug.print("  {} %%: VALIDO ({})\n", .{ h, valido });
        } else {
            std.debug.print("  {} %%: INVALIDO\n", .{h});
        }
    }

    std.debug.print("\n--- Validacion de Presion ---\n", .{});
    const pres = [_]u16{ 200, 300, 1013, 1100, 1200 };
    for (pres) |p| {
        if (validar_presion(p)) |valido| {
            std.debug.print("  {} hPa: VALIDO ({})\n", .{ p, valido });
        } else {
            std.debug.print("  {} hPa: INVALIDO\n", .{p});
        }
    }

    std.debug.print("\n--- Validacion Completa ---\n", .{});

    if (validar_sensor_completo(25, 50, 1013)) |data| {
        std.debug.print("Datos validos: T={}, H={}, P={}\n", .{ data.temperatura, data.humedad, data.presion });
    } else {
        std.debug.print("Datos validos: FALLO (no esperado)\n", .{});
    }

    if (validar_sensor_completo(25, 150, 1013)) |data| {
        std.debug.print("Humedad invalida: T={}, H={}, P={}\n", .{ data.temperatura, data.humedad, data.presion });
    } else {
        std.debug.print("Humedad invalida: null (correcto!)\n", .{});
    }

    std.debug.print("\n--- Conversion Segura i16 -> u8 ---\n", .{});
    const valores = [_]i16{ -10, 0, 128, 255, 256, 1000 };
    for (valores) |v| {
        if (i16_a_u8_seguro(v)) |u8_val| {
            std.debug.print("  {}: {} (u8)\n", .{ v, u8_val });
        } else {
            std.debug.print("  {}: fuera de rango\n", .{v});
        }
    }
}
