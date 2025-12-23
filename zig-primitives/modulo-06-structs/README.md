# Modulo 06: Structs en Zig

## Objetivo

Aprender a crear tipos de datos personalizados usando structs. Los structs permiten agrupar datos relacionados y definir metodos que operan sobre esos datos. Son la base para organizar programas mas complejos.

## Prerequisitos

Debes haber completado los Modulos 01 al 05.

---

## Codigo a estudiar

### 1. Definir y crear un struct

Un struct agrupa varios campos en un solo tipo:

```zig
const std = @import("std");

// Definicion del struct
const Punto = struct {
    x: i32,
    y: i32,
};

pub fn main() void {
    // Crear una instancia
    const p1 = Punto{
        .x = 10,
        .y = 20,
    };
    
    // Acceder a los campos
    std.debug.print("Punto: ({}, {})\n", .{ p1.x, p1.y });
    
    // Crear otro punto
    const origen = Punto{ .x = 0, .y = 0 };
    std.debug.print("Origen: ({}, {})\n", .{ origen.x, origen.y });
}
```

**Sintaxis:**
- `const NombreStruct = struct { campos };`
- Cada campo tiene nombre y tipo: `nombre: tipo,`
- Para crear: `NombreStruct{ .campo1 = valor1, .campo2 = valor2 }`
- Acceso con punto: `instancia.campo`

### 2. Structs mutables

Para modificar campos, la variable debe ser `var`:

```zig
const std = @import("std");

const Contador = struct {
    valor: u32,
    nombre: []const u8,
};

pub fn main() void {
    // Mutable - podemos modificar campos
    var contador = Contador{
        .valor = 0,
        .nombre = "Visitas",
    };
    
    std.debug.print("{s}: {}\n", .{ contador.nombre, contador.valor });
    
    // Incrementar
    contador.valor += 1;
    contador.valor += 1;
    contador.valor += 1;
    
    std.debug.print("{s}: {}\n", .{ contador.nombre, contador.valor });
    
    // Constante - no podemos modificar
    const fijo = Contador{ .valor = 100, .nombre = "Fijo" };
    std.debug.print("{s}: {}\n", .{ fijo.nombre, fijo.valor });
    // fijo.valor = 200;  // ERROR: no se puede modificar
}
```

### 3. Valores por defecto

Los campos pueden tener valores iniciales:

```zig
const std = @import("std");

const Configuracion = struct {
    puerto: u16 = 8080,
    max_conexiones: u32 = 100,
    debug: bool = false,
    nombre: []const u8 = "servidor",
};

pub fn main() void {
    // Usar todos los valores por defecto
    const config1 = Configuracion{};
    std.debug.print("Config1 - Puerto: {}, Debug: {}\n", .{ 
        config1.puerto, 
        config1.debug 
    });
    
    // Sobrescribir algunos valores
    const config2 = Configuracion{
        .puerto = 3000,
        .debug = true,
    };
    std.debug.print("Config2 - Puerto: {}, Debug: {}\n", .{ 
        config2.puerto, 
        config2.debug 
    });
    
    // Sobrescribir todo
    const config3 = Configuracion{
        .puerto = 443,
        .max_conexiones = 1000,
        .debug = false,
        .nombre = "produccion",
    };
    std.debug.print("Config3 - Puerto: {}, Nombre: {s}\n", .{ 
        config3.puerto, 
        config3.nombre 
    });
}
```

### 4. Metodos en structs

Los structs pueden tener funciones asociadas (metodos):

```zig
const std = @import("std");

const Rectangulo = struct {
    ancho: f32,
    alto: f32,
    
    // Metodo que recibe self (la instancia)
    pub fn area(self: Rectangulo) f32 {
        return self.ancho * self.alto;
    }
    
    pub fn perimetro(self: Rectangulo) f32 {
        return 2 * (self.ancho + self.alto);
    }
    
    pub fn es_cuadrado(self: Rectangulo) bool {
        return self.ancho == self.alto;
    }
    
    // Metodo que modifica la instancia
    pub fn escalar(self: *Rectangulo, factor: f32) void {
        self.ancho *= factor;
        self.alto *= factor;
    }
};

pub fn main() void {
    var rect = Rectangulo{ .ancho = 10.0, .alto = 5.0 };
    
    std.debug.print("Rectangulo: {} x {}\n", .{ rect.ancho, rect.alto });
    std.debug.print("Area: {d:.2}\n", .{rect.area()});
    std.debug.print("Perimetro: {d:.2}\n", .{rect.perimetro()});
    std.debug.print("Es cuadrado: {}\n", .{rect.es_cuadrado()});
    
    // Escalar el rectangulo
    rect.escalar(2.0);
    std.debug.print("\nDespues de escalar x2:\n", .{});
    std.debug.print("Rectangulo: {} x {}\n", .{ rect.ancho, rect.alto });
    std.debug.print("Area: {d:.2}\n", .{rect.area()});
}
```

**Tipos de self:**
- `self: NombreStruct` - recibe una copia (no puede modificar)
- `self: *NombreStruct` - recibe un puntero (puede modificar)

### 5. Funciones asociadas (sin self)

Funciones del struct que no operan sobre una instancia:

```zig
const std = @import("std");

const Circulo = struct {
    radio: f32,
    
    // Constructor - crea una nueva instancia
    pub fn nuevo(radio: f32) Circulo {
        return Circulo{ .radio = radio };
    }
    
    // Constructor alternativo
    pub fn unitario() Circulo {
        return Circulo{ .radio = 1.0 };
    }
    
    pub fn area(self: Circulo) f32 {
        return 3.14159 * self.radio * self.radio;
    }
    
    pub fn diametro(self: Circulo) f32 {
        return 2 * self.radio;
    }
};

pub fn main() void {
    // Usar el constructor
    const c1 = Circulo.nuevo(5.0);
    std.debug.print("Circulo 1 - Radio: {d:.2}, Area: {d:.2}\n", .{ 
        c1.radio, 
        c1.area() 
    });
    
    // Usar constructor alternativo
    const c2 = Circulo.unitario();
    std.debug.print("Circulo unitario - Radio: {d:.2}, Area: {d:.2}\n", .{ 
        c2.radio, 
        c2.area() 
    });
    
    // Crear directamente
    const c3 = Circulo{ .radio = 10.0 };
    std.debug.print("Circulo 3 - Diametro: {d:.2}\n", .{c3.diametro()});
}
```

### 6. Structs con otros structs (composicion)

Un struct puede contener otros structs:

```zig
const std = @import("std");

const Punto = struct {
    x: f32,
    y: f32,
    
    pub fn distancia_al_origen(self: Punto) f32 {
        return @sqrt(self.x * self.x + self.y * self.y);
    }
};

const Linea = struct {
    inicio: Punto,
    fin: Punto,
    
    pub fn nueva(x1: f32, y1: f32, x2: f32, y2: f32) Linea {
        return Linea{
            .inicio = Punto{ .x = x1, .y = y1 },
            .fin = Punto{ .x = x2, .y = y2 },
        };
    }
    
    pub fn longitud(self: Linea) f32 {
        const dx = self.fin.x - self.inicio.x;
        const dy = self.fin.y - self.inicio.y;
        return @sqrt(dx * dx + dy * dy);
    }
};

const Triangulo = struct {
    p1: Punto,
    p2: Punto,
    p3: Punto,
    
    pub fn nuevo(x1: f32, y1: f32, x2: f32, y2: f32, x3: f32, y3: f32) Triangulo {
        return Triangulo{
            .p1 = Punto{ .x = x1, .y = y1 },
            .p2 = Punto{ .x = x2, .y = y2 },
            .p3 = Punto{ .x = x3, .y = y3 },
        };
    }
};

pub fn main() void {
    const linea = Linea.nueva(0, 0, 3, 4);
    std.debug.print("Linea de ({}, {}) a ({}, {})\n", .{
        linea.inicio.x, linea.inicio.y,
        linea.fin.x, linea.fin.y,
    });
    std.debug.print("Longitud: {d:.2}\n", .{linea.longitud()});
    
    const triangulo = Triangulo.nuevo(0, 0, 3, 0, 0, 4);
    std.debug.print("\nTriangulo con vertices:\n", .{});
    std.debug.print("  ({}, {})\n", .{ triangulo.p1.x, triangulo.p1.y });
    std.debug.print("  ({}, {})\n", .{ triangulo.p2.x, triangulo.p2.y });
    std.debug.print("  ({}, {})\n", .{ triangulo.p3.x, triangulo.p3.y });
}
```

### 7. Arrays de structs

Trabajar con colecciones de structs:

```zig
const std = @import("std");

const Estudiante = struct {
    nombre: []const u8,
    nota: u32,
    
    pub fn aprobo(self: Estudiante) bool {
        return self.nota >= 60;
    }
};

fn promedio_clase(estudiantes: []const Estudiante) u32 {
    var suma: u32 = 0;
    for (estudiantes) |e| {
        suma += e.nota;
    }
    return suma / @as(u32, @intCast(estudiantes.len));
}

fn contar_aprobados(estudiantes: []const Estudiante) u32 {
    var aprobados: u32 = 0;
    for (estudiantes) |e| {
        if (e.aprobo()) {
            aprobados += 1;
        }
    }
    return aprobados;
}

pub fn main() void {
    const clase = [_]Estudiante{
        .{ .nombre = "Ana", .nota = 85 },
        .{ .nombre = "Carlos", .nota = 72 },
        .{ .nombre = "Maria", .nota = 55 },
        .{ .nombre = "Pedro", .nota = 90 },
        .{ .nombre = "Laura", .nota = 68 },
    };
    
    std.debug.print("Estudiantes:\n", .{});
    for (clase) |e| {
        const estado = if (e.aprobo()) "Aprobado" else "Reprobado";
        std.debug.print("  {s}: {} ({s})\n", .{ e.nombre, e.nota, estado });
    }
    
    std.debug.print("\nPromedio: {}\n", .{promedio_clase(&clase)});
    std.debug.print("Aprobados: {}/{}\n", .{ contar_aprobados(&clase), clase.len });
}
```

---

## Conceptos clave

- **struct**: Tipo compuesto que agrupa campos relacionados
- **Campos**: Variables dentro del struct con nombre y tipo
- **Metodos**: Funciones que reciben `self` para operar sobre la instancia
- **self**: Referencia a la instancia actual (valor o puntero)
- **Constructores**: Funciones asociadas que crean instancias
- **Composicion**: Structs que contienen otros structs

---

## Tareas

### Tarea 1: Struct de producto (Dificultad: Facil)

**Objetivo**: Crear un struct basico con campos y acceder a ellos.

**Archivo**: `starter/tarea1.zig`

**Que hacer**:
1. Definir un struct `Producto` con campos: nombre, precio, cantidad
2. Crear varios productos de ejemplo
3. Calcular el valor total del inventario (precio * cantidad para cada uno)

**Criterio de exito**: Muestra los productos y el valor total correctamente.

---

### Tarea 2: Struct con metodos (Dificultad: Media)

**Objetivo**: Agregar metodos a un struct.

**Archivo**: `starter/tarea2.zig`

**Que hacer**:
1. Definir un struct `CuentaBancaria` con campos: titular, saldo
2. Implementar metodo `depositar(monto)` que suma al saldo
3. Implementar metodo `retirar(monto)` que resta del saldo (si hay suficiente)
4. Implementar metodo `transferir(destino, monto)` entre cuentas

**Criterio de exito**: Las operaciones bancarias funcionan correctamente.

---

### Tarea 3: Composicion de structs (Dificultad: Media)

**Objetivo**: Crear structs que contienen otros structs.

**Archivo**: `starter/tarea3.zig`

**Que hacer**:
1. Definir struct `Direccion` con: calle, numero, ciudad
2. Definir struct `Persona` que contiene una `Direccion`
3. Crear un array de personas y mostrar sus datos
4. Implementar una funcion que filtre personas por ciudad

**Criterio de exito**: Los structs anidados funcionan y el filtrado es correcto.

---

## Verificacion

```bash
# Ejecutar cada tarea
zig run starter/tarea1.zig
zig run starter/tarea2.zig
zig run starter/tarea3.zig

# Comparar con las soluciones
zig run .solution/tarea1.zig
zig run .solution/tarea2.zig
zig run .solution/tarea3.zig
```

---

## Pistas

<details>
<summary>Pista para Tarea 1</summary>

```zig
const Producto = struct {
    nombre: []const u8,
    precio: u32,
    cantidad: u32,
};

const p = Producto{
    .nombre = "Laptop",
    .precio = 1000,
    .cantidad = 5,
};

const valor = p.precio * p.cantidad;
```
</details>

<details>
<summary>Pista para Tarea 2</summary>

Para metodos que modifican, usa puntero a self:
```zig
pub fn depositar(self: *CuentaBancaria, monto: u32) void {
    self.saldo += monto;
}
```

Para transferir, necesitas dos punteros: origen y destino.
</details>

<details>
<summary>Pista para Tarea 3</summary>

Para structs anidados:
```zig
const Persona = struct {
    nombre: []const u8,
    direccion: Direccion,
};

const p = Persona{
    .nombre = "Juan",
    .direccion = Direccion{
        .calle = "Principal",
        .numero = 123,
        .ciudad = "Madrid",
    },
};
```

Para comparar strings usa `std.mem.eql(u8, str1, str2)`.
</details>

---

## Siguiente modulo

En el **Modulo 07** exploraremos mas conceptos avanzados como enums, unions y manejo de errores en Zig.
