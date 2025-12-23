const std = @import("std");

const CuentaBancaria = struct {
    titular: []const u8,
    saldo: u32,

    pub fn depositar(self: *CuentaBancaria, monto: u32) void {
        self.saldo += monto;
    }

    pub fn retirar(self: *CuentaBancaria, monto: u32) bool {
        if (self.saldo < monto) {
            return false;
        }
        self.saldo -= monto;
        return true;
    }

    pub fn transferir(self: *CuentaBancaria, destino: *CuentaBancaria, monto: u32) bool {
        if (!self.retirar(monto)) {
            return false;
        }
        destino.depositar(monto);
        return true;
    }

    pub fn mostrar(self: CuentaBancaria) void {
        std.debug.print("  {s}: ${}.{:0>2}\n", .{
            self.titular,
            self.saldo / 100,
            self.saldo % 100,
        });
    }
};

pub fn main() void {
    var cuenta_ana = CuentaBancaria{
        .titular = "Ana",
        .saldo = 100000,
    };

    var cuenta_carlos = CuentaBancaria{
        .titular = "Carlos",
        .saldo = 50000,
    };

    std.debug.print("=== Saldos Iniciales ===\n", .{});
    cuenta_ana.mostrar();
    cuenta_carlos.mostrar();

    std.debug.print("\n--- Ana deposita $200 ---\n", .{});
    cuenta_ana.depositar(20000);
    cuenta_ana.mostrar();

    std.debug.print("\n--- Carlos intenta retirar $600 ---\n", .{});
    if (!cuenta_carlos.retirar(60000)) {
        std.debug.print("Retiro fallido: saldo insuficiente\n", .{});
    }
    cuenta_carlos.mostrar();

    std.debug.print("\n--- Ana transfiere $300 a Carlos ---\n", .{});
    if (cuenta_ana.transferir(&cuenta_carlos, 30000)) {
        std.debug.print("Transferencia exitosa\n", .{});
    }

    std.debug.print("\n=== Saldos Finales ===\n", .{});
    cuenta_ana.mostrar();
    cuenta_carlos.mostrar();
}
