DROP DATABASE sic;
CREATE DATABASE sic;
USE sic;
CREATE TABLE bodegas
(
	codigo_bodega VARCHAR(5) PRIMARY KEY,
    nombre_bodega VARCHAR(60),
    estatus_bodega VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE lineas
(
	codigo_linea VARCHAR(5) PRIMARY KEY,
    nombre_linea VARCHAR(60),
    estatus_linea VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE marcas
(
	codigo_marca VARCHAR(5) PRIMARY KEY,
    nombre_marca VARCHAR(60),
    estatus_marca VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE productos
(
	codigo_producto VARCHAR(18) PRIMARY KEY,
    nombre_producto VARCHAR(60),
    codigo_linea VARCHAR(5),
    codigo_marca VARCHAR(5),
    existencia_producto FLOAT(10,2),
    estatus_producto VARCHAR(1),
    FOREIGN KEY (codigo_linea) REFERENCES lineas(codigo_linea),
    FOREIGN KEY (codigo_marca) REFERENCES marcas(codigo_marca)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE existencias
(
	codigo_bodega VARCHAR(5),
    codigo_producto VARCHAR(18),
    saldo_existencia FLOAT(10,2),
    PRIMARY KEY (codigo_bodega, codigo_producto),
	FOREIGN KEY (codigo_bodega) REFERENCES bodegas(codigo_bodega),
    FOREIGN KEY (codigo_producto) REFERENCES productos(codigo_producto)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE vendedores
(
	codigo_vendedor VARCHAR(5) PRIMARY KEY,
    nombre_vendedor VARCHAR(60),
    direccion_vendedor VARCHAR(60),
    telefono_vendedor VARCHAR(50),
    nit_vendedor VARCHAR(20),
    estatus_vendedor VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE clientes
(
	codigo_cliente VARCHAR(5) PRIMARY KEY,
    nombre_cliente VARCHAR(60),
    direccion_cliente VARCHAR(60),
    nit_cliente VARCHAR(20),
    telefono_cliente VARCHAR(50),
    codigo_vendedor VARCHAR(5),
    estatus_cliente VARCHAR(1),
    FOREIGN KEY (codigo_vendedor) REFERENCES vendedores(codigo_vendedor)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

create table moneda(
	id_moneda varchar(10) primary key,
    nombre_moneda varchar(20) not null,
    tipo_cambio float,
    estatus_moneda char(1)
)engine = InnoDB default charset=latin1;

create table sucursal (
id_sucursal int auto_increment primary key,
nombre varchar(20) not null,
direccion varchar(20) not null,
telefono varchar(20) not null
)engine=Innodb default charset=latin1;

create table proveedor(
id_proveedor int auto_increment primary key,
nombre varchar(128) not null,
direccion varchar(128) not null
)engine=Innodb default charset=latin1;

create table compra_encabezado(
id_compraE int not null primary key,
id_sucursal int not null,
id_proveedor int not null,
total double ,
fecha date not null,
foreign key (id_proveedor) references
proveedor(id_proveedor),
foreign key (id_sucursal) references
sucursal(id_sucursal)
)engine=Innodb default charset=latin1;

create table compra_detalle(
id_inventario int primary key not null,
id_compraE int not null,
id_moneda varchar(10) not null,
cantidad int not null,

foreign key (id_compraE) references
compra_encabezado(id_compraE),
foreign key(id_moneda) references
moneda(id_moneda)
)engine=Innodb default charset=latin1;

CREATE TABLE ventas_encabezado
(
	documento_ventaenca VARCHAR(10) PRIMARY KEY,
    codigo_cliente VARCHAR(5),
    fecha_ventaenca DATE,
    total_ventaenca FLOAT(10,2),
    estatus_ventaenca VARCHAR(1),
    FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo_cliente)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE ventas_detalle
(
	documento_ventaenca VARCHAR(10),
    codigo_producto VARCHAR(18),
    cantidad_ventadet FLOAT(10,2),
    costo_ventadet FLOAT(10,2),
    precio_ventadet FLOAT(10,2),
    codigo_bodega VARCHAR(5),
    PRIMARY KEY (documento_ventaenca, codigo_producto),
    FOREIGN KEY (documento_ventaenca) REFERENCES ventas_encabezado(documento_ventaenca),
    FOREIGN KEY (codigo_producto) REFERENCES productos(codigo_producto),
    FOREIGN KEY (codigo_bodega) REFERENCES bodegas(codigo_bodega)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
    