const std = @import("std");

// =============================================================================
// TAREA 9: Inspector de tipos en comptime - SOLUCION
// =============================================================================

const TypeInfo = struct {
    nombre: []const u8,
    bytes: usize,
    bits: u16,
    es_signed: bool,
    valor_min: i128,
    valor_max: u128,
};

fn obtener_info_tipo(comptime T: type) TypeInfo {
    const info = @typeInfo(T);

    switch (info) {
        .int => |int_info| {
            const es_signed = int_info.signedness == .signed;
            return TypeInfo{
                .nombre = @typeName(T),
                .bytes = @sizeOf(T),
                .bits = int_info.bits,
                .es_signed = es_signed,
                .valor_min = if (es_signed) std.math.minInt(T) else 0,
                .valor_max = std.math.maxInt(T),
            };
        },
        else => unreachable,
    }
}

fn puede_contener(comptime T: type, valor: i64) bool {
    const max: i64 = @intCast(std.math.maxInt(T));
    const info = @typeInfo(T);

    switch (info) {
        .int => |int_info| {
            if (int_info.signedness == .signed) {
                const min: i64 = @intCast(std.math.minInt(T));
                return valor >= min and valor <= max;
            } else {
                return valor >= 0 and valor <= max;
            }
        },
        else => return false,
    }
}

fn valores_por_bytes(comptime T: type, bytes: usize) usize {
    return bytes / @sizeOf(T);
}

fn es_unsigned(comptime T: type) bool {
    const info = @typeInfo(T);
    switch (info) {
        .int => |int_info| {
            return int_info.signedness == .unsigned;
        },
        else => return false,
    }
}

fn eficiencia_bits(comptime T: type) u8 {
    const bits_utiles = @bitSizeOf(T);
    const bits_reales = @sizeOf(T) * 8;
    return @intCast(bits_utiles * 100 / bits_reales);
}

pub fn main() void {
    std.debug.print("=== Inspector de Tipos ===\n\n", .{});

    std.debug.print("--- Informacion de Tipos ---\n", .{});

    inline for ([_]type{ u8, i8, u16, i16, u32, i32 }) |T| {
        const info = obtener_info_tipo(T);
        std.debug.print("{s}: {} bytes, {} bits, signed={}, min={}, max={}\n", .{
            info.nombre,
            info.bytes,
            info.bits,
            info.es_signed,
            info.valor_min,
            info.valor_max,
        });
    }

    std.debug.print("\n--- Verificacion de Rango ---\n", .{});
    std.debug.print("100 cabe en u8: {} (esperado: true)\n", .{puede_contener(u8, 100)});
    std.debug.print("256 cabe en u8: {} (esperado: false)\n", .{puede_contener(u8, 256)});
    std.debug.print("-1 cabe en u8: {} (esperado: false)\n", .{puede_contener(u8, -1)});
    std.debug.print("-1 cabe en i8: {} (esperado: true)\n", .{puede_contener(i8, -1)});
    std.debug.print("-129 cabe en i8: {} (esperado: false)\n", .{puede_contener(i8, -129)});

    std.debug.print("\n--- Valores por Kilobyte ---\n", .{});
    std.debug.print("u8 en 1KB: {} valores\n", .{valores_por_bytes(u8, 1024)});
    std.debug.print("u16 en 1KB: {} valores\n", .{valores_por_bytes(u16, 1024)});
    std.debug.print("u32 en 1KB: {} valores\n", .{valores_por_bytes(u32, 1024)});
    std.debug.print("u64 en 1KB: {} valores\n", .{valores_por_bytes(u64, 1024)});

    std.debug.print("\n--- Verificacion de Signo ---\n", .{});
    std.debug.print("u32 es unsigned: {} (esperado: true)\n", .{es_unsigned(u32)});
    std.debug.print("i32 es unsigned: {} (esperado: false)\n", .{es_unsigned(i32)});

    std.debug.print("\n--- Eficiencia de Bits ---\n", .{});
    std.debug.print("u8 eficiencia: {}%% (esperado: 100%%)\n", .{eficiencia_bits(u8)});
    std.debug.print("u16 eficiencia: {}%% (esperado: 100%%)\n", .{eficiencia_bits(u16)});
    std.debug.print("u12 eficiencia: {}%% (esperado: 75%%)\n", .{eficiencia_bits(u12)});
    std.debug.print("u4 eficiencia: {}%% (esperado: 50%%)\n", .{eficiencia_bits(u4)});
}
