-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.3
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---
-- object: usr_reservas | type: ROLE --
-- DROP ROLE IF EXISTS usr_reservas;
CREATE ROLE usr_reservas WITH 
	CREATEDB
	CREATEROLE
	LOGIN
	 PASSWORD 'password123';
-- ddl-end --
COMMENT ON ROLE usr_reservas IS E'usuario para reservas';
-- ddl-end --


-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: db_reservas | type: DATABASE --
-- DROP DATABASE IF EXISTS db_reservas;
CREATE DATABASE db_reservas;
-- ddl-end --


-- object: parametricas | type: SCHEMA --
-- DROP SCHEMA IF EXISTS parametricas CASCADE;
CREATE SCHEMA parametricas;
-- ddl-end --
ALTER SCHEMA parametricas OWNER TO usr_reservas;
-- ddl-end --
COMMENT ON SCHEMA parametricas IS E'Es el esquema que organizara todas las parametricas del sistema';
-- ddl-end --

-- object: autenticacion | type: SCHEMA --
-- DROP SCHEMA IF EXISTS autenticacion CASCADE;
CREATE SCHEMA autenticacion;
-- ddl-end --
ALTER SCHEMA autenticacion OWNER TO usr_reservas;
-- ddl-end --
COMMENT ON SCHEMA autenticacion IS E'Es el esuqema para controlar la autenticacion de los usuarios';
-- ddl-end --

-- object: reservas | type: SCHEMA --
-- DROP SCHEMA IF EXISTS reservas CASCADE;
CREATE SCHEMA reservas;
-- ddl-end --
ALTER SCHEMA reservas OWNER TO usr_reservas;
-- ddl-end --
COMMENT ON SCHEMA reservas IS E'Es el esquema central del sistema que controla las reservas';
-- ddl-end --

SET search_path TO pg_catalog,public,parametricas,autenticacion,reservas;
-- ddl-end --

-- object: parametricas.estados | type: TABLE --
-- DROP TABLE IF EXISTS parametricas.estados CASCADE;
CREATE TABLE parametricas.estados (
	est_id smallint NOT NULL,
	est_nombre varchar NOT NULL,
	esp_descripcion varchar,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	usuario_registro integer,
	CONSTRAINT estados_pk PRIMARY KEY (est_id)
);
-- ddl-end --
COMMENT ON TABLE parametricas.estados IS E'Esta tabla controla todos los estados de los registros en el sistema';
-- ddl-end --
COMMENT ON COLUMN parametricas.estados.est_id IS E'identificdor de la tablas';
-- ddl-end --
COMMENT ON COLUMN parametricas.estados.est_nombre IS E'Es el nombre del estado';
-- ddl-end --
COMMENT ON COLUMN parametricas.estados.esp_descripcion IS E'Detalle del estado';
-- ddl-end --
COMMENT ON COLUMN parametricas.estados.usuario_registro IS E'Es el usuario que realizo el registro';
-- ddl-end --
ALTER TABLE parametricas.estados OWNER TO usr_reservas;
-- ddl-end --

-- object: autenticacion.usuarios | type: TABLE --
-- DROP TABLE IF EXISTS autenticacion.usuarios CASCADE;
CREATE TABLE autenticacion.usuarios (
	usu_id serial NOT NULL,
	usu_usuario varchar(50) NOT NULL,
	usu_password varchar NOT NULL,
	usu_fecha_vigencia date,
	per_id integer NOT NULL,
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT usu_usuario_uq UNIQUE (usu_usuario),
	CONSTRAINT usuarios_pk PRIMARY KEY (usu_id)
);
-- ddl-end --
COMMENT ON TABLE autenticacion.usuarios IS E'Es la tabla de los usuarios';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.usu_id IS E'Identificador de tabla';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.usu_usuario IS E'Nombre del usuario para autenticacion';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.usu_password IS E'Este es el password del usuario';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.usu_fecha_vigencia IS E'tiempo de vigencia del usuario, determina hascta cuando tendra acceso';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuarios.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE autenticacion.usuarios OWNER TO usr_reservas;
-- ddl-end --

-- object: autenticacion.roles | type: TABLE --
-- DROP TABLE IF EXISTS autenticacion.roles CASCADE;
CREATE TABLE autenticacion.roles (
	rol_id integer NOT NULL,
	rol_nombre varchar NOT NULL,
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT roles_pk PRIMARY KEY (rol_id)
);
-- ddl-end --
COMMENT ON TABLE autenticacion.roles IS E'Manejo de roles';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.rol_id IS E'Identificador de tabla';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.rol_nombre IS E'es el nombre del rol';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN autenticacion.roles.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE autenticacion.roles OWNER TO usr_reservas;
-- ddl-end --

-- object: autenticacion.usuario_roles | type: TABLE --
-- DROP TABLE IF EXISTS autenticacion.usuario_roles CASCADE;
CREATE TABLE autenticacion.usuario_roles (
	usurol_id serial NOT NULL,
	rol_id integer,
	usu_id integer NOT NULL,
	est_id smallint DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT usuario_roles_pk PRIMARY KEY (usurol_id)
);
-- ddl-end --
COMMENT ON TABLE autenticacion.usuario_roles IS E'Esta tabla determina los roles que tienen los usuarios';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.usurol_id IS E'identificador de tabla';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.rol_id IS E'este es la referencia al rol';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.usu_id IS E'la referencia al usuario';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN autenticacion.usuario_roles.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE autenticacion.usuario_roles OWNER TO usr_reservas;
-- ddl-end --

-- object: reservas.personas | type: TABLE --
-- DROP TABLE IF EXISTS reservas.personas CASCADE;
CREATE TABLE reservas.personas (
	per_id serial NOT NULL,
	per_nombre_completo varchar(300) NOT NULL,
	per_documento_identidad varchar NOT NULL,
	per_fecha_nacimiento date,
	per_telefono varchar(50),
	per_correo varchar(50),
	per_direccion varchar(100),
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT persona_pk PRIMARY KEY (per_id)
);
-- ddl-end --
COMMENT ON TABLE reservas.personas IS E'Tabla para registrar a todas las personas del sistema';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.per_id IS E'identificador de la tabla persona';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.per_nombre_completo IS E'Nombre completo de la persona';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.per_documento_identidad IS E'Numero de celular de la persona';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.per_fecha_nacimiento IS E'fecha de nacimiento de la persona';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.per_telefono IS E'numero de telefono o celular';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.per_correo IS E'correo electronico de la persona';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.per_direccion IS E'direccion de domicilio de la persona';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN reservas.personas.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE reservas.personas OWNER TO postgres;
-- ddl-end --

-- object: reservas.medicos | type: TABLE --
-- DROP TABLE IF EXISTS reservas.medicos CASCADE;
CREATE TABLE reservas.medicos (
	med_id serial NOT NULL,
	per_id integer NOT NULL,
	med_matricula varchar(50),
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT medico_pk PRIMARY KEY (med_id)
);
-- ddl-end --
COMMENT ON TABLE reservas.medicos IS E'registro de medicos';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.per_id IS E'referencia a la persona';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.med_matricula IS E'La matricula con la que ejerce el medico';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.est_id IS E'referencia al estado del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE reservas.medicos OWNER TO usr_reservas;
-- ddl-end --

-- object: parametricas.especialidades | type: TABLE --
-- DROP TABLE IF EXISTS parametricas.especialidades CASCADE;
CREATE TABLE parametricas.especialidades (
	esp_id smallint NOT NULL,
	esp_nombre varchar(200) NOT NULL,
	esp_observacion varchar,
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT especialidad_pk PRIMARY KEY (esp_id)
);
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.esp_id IS E'identificador de la tabla';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.esp_nombre IS E'nombre de la especialidad';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.esp_observacion IS E'observacion descriptiva de la especialidad';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN parametricas.especialidades.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE parametricas.especialidades OWNER TO usr_reservas;
-- ddl-end --

-- object: reservas.medicos_especialidades | type: TABLE --
-- DROP TABLE IF EXISTS reservas.medicos_especialidades CASCADE;
CREATE TABLE reservas.medicos_especialidades (
	medesp_id serial NOT NULL,
	med_id integer NOT NULL,
	esp_id integer NOT NULL,
	medesp_observacion varchar,
	"est _id" smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT medicos_especialidades_pk PRIMARY KEY (medesp_id)
);
-- ddl-end --
COMMENT ON TABLE reservas.medicos_especialidades IS E'un medico puede tener mas  de una especialidad';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.medesp_id IS E'identificador de la tabla';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.med_id IS E'referencia al medico';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.esp_id IS E'referencia a la especialidad';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.medesp_observacion IS E'observacion del registro de la especialidada';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades."est _id" IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN reservas.medicos_especialidades.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE reservas.medicos_especialidades OWNER TO usr_reservas;
-- ddl-end --

-- object: reservas.pacientes | type: TABLE --
-- DROP TABLE IF EXISTS reservas.pacientes CASCADE;
CREATE TABLE reservas.pacientes (
	pac_id serial NOT NULL,
	per_id integer NOT NULL,
	hismed_id integer NOT NULL,
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT pacientes_pk PRIMARY KEY (pac_id)
);
-- ddl-end --
COMMENT ON TABLE reservas.pacientes IS E'controla los pacientes del sistemas';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.per_id IS E'referencia a la persona';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.hismed_id IS E'referencia al numero de historial del paciente';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN reservas.pacientes.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE reservas.pacientes OWNER TO usr_reservas;
-- ddl-end --

-- object: reservas.horarios_medicos | type: TABLE --
-- DROP TABLE IF EXISTS reservas.horarios_medicos CASCADE;
CREATE TABLE reservas.horarios_medicos (
	hormed_id serial NOT NULL,
	med_id integer NOT NULL,
	hor_id smallint NOT NULL,
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT horarios_medicos_pk PRIMARY KEY (hormed_id)
);
-- ddl-end --
COMMENT ON TABLE reservas.horarios_medicos IS E'Determina los horarios en que los medico podra atender consultas';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.hormed_id IS E'identificador de la tabla';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.med_id IS E'referencia al medico';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.hor_id IS E'referencia a un turno con hora';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN reservas.horarios_medicos.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE reservas.horarios_medicos OWNER TO usr_reservas;
-- ddl-end --

-- object: reservas.citas | type: TABLE --
-- DROP TABLE IF EXISTS reservas.citas CASCADE;
CREATE TABLE reservas.citas (
	cit_id serial NOT NULL,
	pac_id integer NOT NULL,
	hormed_id integer NOT NULL,
	cit_fecha date NOT NULL,
	est_id smallint NOT NULL DEFAULT 2,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT citas_pk PRIMARY KEY (cit_id),
	CONSTRAINT horario_atencion_medico_uq UNIQUE (hormed_id,cit_fecha),
	CONSTRAINT paciente_atencion_uq UNIQUE (pac_id,hormed_id,cit_fecha)
);
-- ddl-end --
COMMENT ON TABLE reservas.citas IS E'Tabla para controlar las citas que sean asginadas';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.cit_id IS E'identificador  de la tabla';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.pac_id IS E'referencia del paciente';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.hormed_id IS E'horario en el que el medico atendera  la cita';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.cit_fecha IS E'fecha en la que se tomo la cita';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.est_id IS E'estado del registro\n0=INACTIVO\n1=ACTIVO\n2=RESERVADO\n3=CANCELADO\n4=ATENDIDO';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN reservas.citas.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE reservas.citas OWNER TO usr_reservas;
-- ddl-end --

-- object: parametricas.horarios | type: TABLE --
-- DROP TABLE IF EXISTS parametricas.horarios CASCADE;
CREATE TABLE parametricas.horarios (
	hor_id smallint NOT NULL,
	hor_inicio time NOT NULL,
	hor_fin time NOT NULL,
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT horarios_pk PRIMARY KEY (hor_id)
);
-- ddl-end --
COMMENT ON TABLE parametricas.horarios IS E'tabla para registrar horarios por turnos';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.hor_id IS E'identificador de tabla';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.hor_inicio IS E'Hora de inicio';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.hor_fin IS E'Hora de finalizacion';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN parametricas.horarios.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE parametricas.horarios OWNER TO usr_reservas;
-- ddl-end --

-- object: reservas.historial_medico | type: TABLE --
-- DROP TABLE IF EXISTS reservas.historial_medico CASCADE;
CREATE TABLE reservas.historial_medico (
	hismed_id serial NOT NULL,
	hismed_codificacion varchar NOT NULL,
	est_id smallint NOT NULL DEFAULT 1,
	fecha_registro timestamp NOT NULL DEFAULT now(),
	fecha_modificacion timestamp,
	fecha_eliminacion timestamp,
	usuario_registro integer NOT NULL,
	usuario_modificacion integer NOT NULL,
	usuario_eliminacion integer NOT NULL,
	CONSTRAINT hismed_codificacion_uq UNIQUE (hismed_codificacion),
	CONSTRAINT historial_medico_pk PRIMARY KEY (hismed_id)
);
-- ddl-end --
COMMENT ON TABLE reservas.historial_medico IS E'tabla para controlar el historial medico de un paciente';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.hismed_id IS E'identificador de tabla';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.hismed_codificacion IS E'es la codificacion del historial HIS-CVP00001/2025';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.est_id IS E'estado del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.fecha_registro IS E'fecha en el que se creo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.fecha_modificacion IS E'fecha en la que se realizo algun cambio en el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.fecha_eliminacion IS E'fecha en la que se realizo la eliminacion del registro';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.usuario_registro IS E'es el id de usuario (usu_id )que hizo el registro';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.usuario_modificacion IS E'es el id de usuario (usu_id )que hizo la modificacion';
-- ddl-end --
COMMENT ON COLUMN reservas.historial_medico.usuario_eliminacion IS E'es el id de usuario (usu_id )que hizo la eliminacion';
-- ddl-end --
ALTER TABLE reservas.historial_medico OWNER TO usr_reservas;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE autenticacion.usuarios DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE autenticacion.usuarios ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: per_id_fk | type: CONSTRAINT --
-- ALTER TABLE autenticacion.usuarios DROP CONSTRAINT IF EXISTS per_id_fk CASCADE;
ALTER TABLE autenticacion.usuarios ADD CONSTRAINT per_id_fk FOREIGN KEY (per_id)
REFERENCES reservas.personas (per_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE autenticacion.roles DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE autenticacion.roles ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE autenticacion.usuario_roles DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE autenticacion.usuario_roles ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: usu_id_fk | type: CONSTRAINT --
-- ALTER TABLE autenticacion.usuario_roles DROP CONSTRAINT IF EXISTS usu_id_fk CASCADE;
ALTER TABLE autenticacion.usuario_roles ADD CONSTRAINT usu_id_fk FOREIGN KEY (usu_id)
REFERENCES autenticacion.usuarios (usu_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rol_id_fk | type: CONSTRAINT --
-- ALTER TABLE autenticacion.usuario_roles DROP CONSTRAINT IF EXISTS rol_id_fk CASCADE;
ALTER TABLE autenticacion.usuario_roles ADD CONSTRAINT rol_id_fk FOREIGN KEY (rol_id)
REFERENCES autenticacion.roles (rol_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.personas DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE reservas.personas ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: per_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.medicos DROP CONSTRAINT IF EXISTS per_id_fk CASCADE;
ALTER TABLE reservas.medicos ADD CONSTRAINT per_id_fk FOREIGN KEY (per_id)
REFERENCES reservas.personas (per_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.medicos DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE reservas.medicos ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE parametricas.especialidades DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE parametricas.especialidades ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: esp_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.medicos_especialidades DROP CONSTRAINT IF EXISTS esp_id_fk CASCADE;
ALTER TABLE reservas.medicos_especialidades ADD CONSTRAINT esp_id_fk FOREIGN KEY (esp_id)
REFERENCES parametricas.especialidades (esp_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: med_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.medicos_especialidades DROP CONSTRAINT IF EXISTS med_id_fk CASCADE;
ALTER TABLE reservas.medicos_especialidades ADD CONSTRAINT med_id_fk FOREIGN KEY (med_id)
REFERENCES reservas.medicos (med_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.medicos_especialidades DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE reservas.medicos_especialidades ADD CONSTRAINT est_id_fk FOREIGN KEY ("est _id")
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: per_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.pacientes DROP CONSTRAINT IF EXISTS per_id_fk CASCADE;
ALTER TABLE reservas.pacientes ADD CONSTRAINT per_id_fk FOREIGN KEY (per_id)
REFERENCES reservas.personas (per_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id | type: CONSTRAINT --
-- ALTER TABLE reservas.pacientes DROP CONSTRAINT IF EXISTS est_id CASCADE;
ALTER TABLE reservas.pacientes ADD CONSTRAINT est_id FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: hismed_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.pacientes DROP CONSTRAINT IF EXISTS hismed_fk CASCADE;
ALTER TABLE reservas.pacientes ADD CONSTRAINT hismed_fk FOREIGN KEY (hismed_id)
REFERENCES reservas.historial_medico (hismed_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: med_id | type: CONSTRAINT --
-- ALTER TABLE reservas.horarios_medicos DROP CONSTRAINT IF EXISTS med_id CASCADE;
ALTER TABLE reservas.horarios_medicos ADD CONSTRAINT med_id FOREIGN KEY (med_id)
REFERENCES reservas.medicos (med_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: hor_id | type: CONSTRAINT --
-- ALTER TABLE reservas.horarios_medicos DROP CONSTRAINT IF EXISTS hor_id CASCADE;
ALTER TABLE reservas.horarios_medicos ADD CONSTRAINT hor_id FOREIGN KEY (hor_id)
REFERENCES parametricas.horarios (hor_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.horarios_medicos DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE reservas.horarios_medicos ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: hormed_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.citas DROP CONSTRAINT IF EXISTS hormed_id_fk CASCADE;
ALTER TABLE reservas.citas ADD CONSTRAINT hormed_id_fk FOREIGN KEY (hormed_id)
REFERENCES reservas.horarios_medicos (hormed_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: pac_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.citas DROP CONSTRAINT IF EXISTS pac_id_fk CASCADE;
ALTER TABLE reservas.citas ADD CONSTRAINT pac_id_fk FOREIGN KEY (pac_id)
REFERENCES reservas.pacientes (pac_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.citas DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE reservas.citas ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id | type: CONSTRAINT --
-- ALTER TABLE parametricas.horarios DROP CONSTRAINT IF EXISTS est_id CASCADE;
ALTER TABLE parametricas.horarios ADD CONSTRAINT est_id FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: est_id_fk | type: CONSTRAINT --
-- ALTER TABLE reservas.historial_medico DROP CONSTRAINT IF EXISTS est_id_fk CASCADE;
ALTER TABLE reservas.historial_medico ADD CONSTRAINT est_id_fk FOREIGN KEY (est_id)
REFERENCES parametricas.estados (est_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


