const std = @import("std");

// =============================================================================
// TAREA 9: Inspector de tipos en comptime
// =============================================================================
//
// Contexto: Zig permite inspeccionar tipos en tiempo de compilacion.
// Esto es util para:
//   - Crear codigo generico que se adapta al tipo
//   - Verificar restricciones en comptime
//   - Generar documentacion automatica
//   - Calcular layouts de memoria
//
// Builtins utiles:
//   @sizeOf(T)      - bytes que ocupa T
//   @bitSizeOf(T)   - bits que ocupa T
//   @TypeOf(expr)   - tipo de una expresion
//   @typeName(T)    - nombre del tipo como string
//   @typeInfo(T)    - metadatos completos (signedness, bits, etc)
//
// std.math:
//   std.math.maxInt(T) - valor maximo de tipo entero T
//   std.math.minInt(T) - valor minimo de tipo entero T
// =============================================================================

// Estructura para guardar informacion de un tipo
const TypeInfo = struct {
    nombre: []const u8,
    bytes: usize,
    bits: u16,
    es_signed: bool,
    valor_min: i128,
    valor_max: u128,
};

// Obtiene informacion completa de un tipo entero
fn obtener_info_tipo(comptime T: type) TypeInfo {
    // TODO: Implementar
    // Usa @typeName, @sizeOf, @bitSizeOf
    // Usa @typeInfo para obtener signedness
    // Usa std.math.minInt y std.math.maxInt para los limites
    //
    // Pista para @typeInfo:
    //   const info = @typeInfo(T);
    //   switch (info) {
    //       .int => |int_info| {
    //           // int_info.bits, int_info.signedness
    //       },
    //       else => unreachable,
    //   }

    _ = T;
    return TypeInfo{
        .nombre = "TODO",
        .bytes = 0,
        .bits = 0,
        .es_signed = false,
        .valor_min = 0,
        .valor_max = 0,
    };
}

// Verifica si un valor i64 cabe en un tipo T mas pequeno
fn puede_contener(comptime T: type, valor: i64) bool {
    // TODO: Implementar
    // Obtener min y max de T usando std.math
    // Verificar que valor este en rango
    //
    // Cuidado: std.math.minInt retorna el tipo T, necesitas convertir

    _ = T;
    _ = valor;
    return false; // Placeholder
}

// Calcula cuantos valores de tipo T caben en N bytes
fn valores_por_bytes(comptime T: type, bytes: usize) usize {
    // TODO: Implementar
    // Usar @sizeOf para obtener el tamanio de T

    _ = T;
    _ = bytes;
    return 0; // Placeholder
}

// Verifica si un tipo es unsigned
fn es_unsigned(comptime T: type) bool {
    // TODO: Implementar
    // Usar @typeInfo y verificar signedness

    _ = T;
    return false; // Placeholder
}

// Calcula el porcentaje de eficiencia de un tipo de bits arbitrario
// Ej: u12 ocupa 16 bits en memoria (2 bytes), pero solo usa 12
// Eficiencia = 12/16 * 100 = 75%
fn eficiencia_bits(comptime T: type) u8 {
    // TODO: Implementar
    // bits_utiles = @bitSizeOf(T)
    // bits_reales = @sizeOf(T) * 8
    // eficiencia = bits_utiles * 100 / bits_reales

    _ = T;
    return 0; // Placeholder
}

pub fn main() void {
    std.debug.print("=== Inspector de Tipos ===\n\n", .{});

    // Test obtener_info_tipo
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

    // Test puede_contener
    std.debug.print("\n--- Verificacion de Rango ---\n", .{});
    std.debug.print("100 cabe en u8: {} (esperado: true)\n", .{puede_contener(u8, 100)});
    std.debug.print("256 cabe en u8: {} (esperado: false)\n", .{puede_contener(u8, 256)});
    std.debug.print("-1 cabe en u8: {} (esperado: false)\n", .{puede_contener(u8, -1)});
    std.debug.print("-1 cabe en i8: {} (esperado: true)\n", .{puede_contener(i8, -1)});
    std.debug.print("-129 cabe en i8: {} (esperado: false)\n", .{puede_contener(i8, -129)});

    // Test valores_por_bytes
    std.debug.print("\n--- Valores por Kilobyte ---\n", .{});
    std.debug.print("u8 en 1KB: {} valores\n", .{valores_por_bytes(u8, 1024)});
    std.debug.print("u16 en 1KB: {} valores\n", .{valores_por_bytes(u16, 1024)});
    std.debug.print("u32 en 1KB: {} valores\n", .{valores_por_bytes(u32, 1024)});
    std.debug.print("u64 en 1KB: {} valores\n", .{valores_por_bytes(u64, 1024)});

    // Test es_unsigned
    std.debug.print("\n--- Verificacion de Signo ---\n", .{});
    std.debug.print("u32 es unsigned: {} (esperado: true)\n", .{es_unsigned(u32)});
    std.debug.print("i32 es unsigned: {} (esperado: false)\n", .{es_unsigned(i32)});

    // Test eficiencia_bits
    std.debug.print("\n--- Eficiencia de Bits ---\n", .{});
    std.debug.print("u8 eficiencia: {}%% (esperado: 100%%)\n", .{eficiencia_bits(u8)});
    std.debug.print("u16 eficiencia: {}%% (esperado: 100%%)\n", .{eficiencia_bits(u16)});
    std.debug.print("u12 eficiencia: {}%% (esperado: 75%%)\n", .{eficiencia_bits(u12)});
    std.debug.print("u4 eficiencia: {}%% (esperado: 50%%)\n", .{eficiencia_bits(u4)});
}
