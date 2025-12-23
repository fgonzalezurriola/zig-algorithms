const std = @import("std");

// ===========================================
// TAREA 2: Struct con metodos - Cuenta Bancaria
// ===========================================

// TODO: Define el struct CuentaBancaria con:
// - titular: []const u8
// - saldo: u32 (en centavos)
//
// Y estos metodos:
// - depositar(monto): suma monto al saldo
// - retirar(monto): resta monto del saldo (solo si hay suficiente)
// - transferir(destino, monto): transfiere a otra cuenta

// const CuentaBancaria = struct {
//     titular: []const u8,
//     saldo: u32,
//
//     pub fn depositar(self: *CuentaBancaria, monto: u32) void {
//         // TODO: incrementar saldo
//     }
//
//     pub fn retirar(self: *CuentaBancaria, monto: u32) bool {
//         // TODO: decrementar saldo si hay suficiente
//         // Retorna true si se pudo retirar, false si no
//     }
//
//     pub fn transferir(self: *CuentaBancaria, destino: *CuentaBancaria, monto: u32) bool {
//         // TODO: retirar de self y depositar en destino
//         // Retorna true si se pudo transferir
//     }
//
//     pub fn mostrar(self: CuentaBancaria) void {
//         // TODO: imprimir titular y saldo
//     }
// };

pub fn main() void {
    // TODO: Crear dos cuentas bancarias
    // var cuenta1 = CuentaBancaria{ .titular = "Ana", .saldo = 100000 };
    // var cuenta2 = CuentaBancaria{ .titular = "Carlos", .saldo = 50000 };

    // TODO: Mostrar saldos iniciales

    // TODO: Ana deposita $200
    // cuenta1.depositar(20000);

    // TODO: Carlos intenta retirar $600 (deberia fallar)
    // if (!cuenta2.retirar(60000)) {
    //     std.debug.print("Retiro fallido: saldo insuficiente\n", .{});
    // }

    // TODO: Ana transfiere $300 a Carlos
    // cuenta1.transferir(&cuenta2, 30000);

    // TODO: Mostrar saldos finales
}
