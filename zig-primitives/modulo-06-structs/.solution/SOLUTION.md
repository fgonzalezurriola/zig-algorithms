# Soluciones del Modulo 06: Structs

## Enfoque general

Los structs son la forma principal de crear tipos de datos personalizados en Zig. Combinan datos relacionados y pueden tener metodos asociados.

## Tarea 1: Struct de Producto

### Diseno del struct
El struct Producto tiene tres campos basicos. Usamos centavos para el precio para evitar problemas con decimales (patron comun en programacion financiera).

### Metodo valor_total
Agregamos un metodo que calcula `precio * cantidad`. Esto encapsula la logica y hace el codigo mas legible.

### Formato de precios
Para mostrar precios como "$X.XX":
- `precio / 100` da la parte entera
- `precio % 100` da los centavos
- `{:0>2}` asegura que siempre hay 2 digitos para centavos

## Tarea 2: Cuenta Bancaria con metodos

### Tipos de self
- `depositar` usa `*CuentaBancaria` porque modifica el saldo
- `mostrar` usa `CuentaBancaria` (valor) porque solo lee
- `retirar` y `transferir` usan puntero porque modifican

### Logica de retiro
Primero verificamos si hay saldo suficiente. Solo restamos si es posible. Retornamos bool para indicar exito/fallo.

### Composicion en transferir
`transferir` reutiliza `retirar` y `depositar`. Si el retiro falla, no hacemos nada. Esto es composicion de metodos.

**Error comun:** Olvidar el `&` al pasar la cuenta destino. `destino` ya es un puntero, pero cuando llamamos `self.transferir(&cuenta2, ...)`, necesitamos `&` porque `cuenta2` es un valor.

## Tarea 3: Composicion de structs

### Structs anidados
`Persona` contiene un campo de tipo `Direccion`. Esto es composicion: una persona "tiene" una direccion.

### Inicializacion anidada
Puedes inicializar todo junto:
```zig
const p = Persona{
    .nombre = "Ana",
    .direccion = .{
        .calle = "Principal",
        ...
    },
};
```

La sintaxis `.{ ... }` es azucar sintactica cuando el tipo se puede inferir.

### Comparacion de strings
Usamos `std.mem.eql(u8, str1, str2)` porque en Zig no puedes comparar strings con `==`. Esto compara contenido, no punteros.

## Errores comunes a evitar

1. **Olvidar `*` para metodos que modifican:** Si necesitas cambiar campos, `self` debe ser puntero.

2. **Comparar strings con `==`:** Esto compara punteros, no contenido. Usa `std.mem.eql`.

3. **No inicializar todos los campos:** Si un campo no tiene valor por defecto, DEBES inicializarlo.

4. **Confundir `.{ }` con `{ }`:** La sintaxis de struct literal lleva punto antes de las llaves.

## Extensiones posibles

- Agregar validacion en metodos (ej: no permitir precios negativos)
- Implementar un constructor `fn nuevo()` para cada struct
- Agregar mas metodos de utilidad (ej: `esMayorDeEdad()` para Persona)
- Crear un array de cuentas bancarias y calcular totales
