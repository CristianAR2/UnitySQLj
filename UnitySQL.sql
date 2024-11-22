CREATE DATABASE restauranteu;
GO

USE restauranteu;
GO



CREATE TABLE sala (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    mesas INT NOT NULL
);
GO


CREATE TABLE pedido (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_sala INT NOT NULL,
    num_mesa INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT GETDATE(),
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('PENDIENTE', 'FINALIZADO')) DEFAULT 'PENDIENTE',
    usuario VARCHAR(100) NOT NULL,
    CONSTRAINT FK_pedido_sala FOREIGN KEY (id_sala) REFERENCES sala(id)
);
GO


CREATE TABLE detalle_pedido (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL,
    id_pedido INT NOT NULL,
    CONSTRAINT FK_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id)
);
GO


CREATE TABLE detalle_factura (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_detallepedido INT NOT NULL,
    CONSTRAINT FK_detalle_factura FOREIGN KEY (id_detallepedido) REFERENCES detalle_pedido(id)
);
GO


CREATE TABLE horarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    horas INT NOT NULL,
    descripcion VARCHAR(45) NOT NULL,
    turno VARCHAR(45) NOT NULL
);
GO


CREATE TABLE rol (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL
);
GO


CREATE TABLE empleado (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    documento VARCHAR(45) NOT NULL,
    cargo VARCHAR(45) NOT NULL,
    id_rol INT NOT NULL,
    id_horario INT NOT NULL,
    CONSTRAINT FK_empleado_rol FOREIGN KEY (id_rol) REFERENCES rol(id),
    CONSTRAINT FK_empleado_horario FOREIGN KEY (id_horario) REFERENCES horarios(id)
);
GO


CREATE TABLE formas_pago (
    id INT IDENTITY(1,1) PRIMARY KEY,
    [desc] VARCHAR(100) NOT NULL
);
GO


CREATE TABLE factura (
    id INT IDENTITY(1,1) PRIMARY KEY,
    codigo BIGINT NOT NULL,
    fecha DATETIME NOT NULL,
    total DECIMAL(10,5) NOT NULL,
    id_formas INT NOT NULL,
    id_detallefactura INT NOT NULL,
    CONSTRAINT FK_factura_formas_pago FOREIGN KEY (id_formas) REFERENCES formas_pago(id),
    CONSTRAINT FK_factura_detalle_factura FOREIGN KEY (id_detallefactura) REFERENCES detalle_factura(id)
);
GO


CREATE TABLE platos (
    id INT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha DATE NULL,
    pedidos INT NOT NULL,
    CONSTRAINT FK_platos_pedido FOREIGN KEY (pedidos) REFERENCES pedido(id)
);
GO


CREATE TABLE usuario (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    correo VARCHAR(200) NOT NULL,
    pass VARCHAR(50) NOT NULL,
    rol INT NOT NULL,
    CONSTRAINT FK_usuario_rol FOREIGN KEY (rol) REFERENCES rol(id)
);
GO
