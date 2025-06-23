-- SEEDERS para estados
INSERT TO parametricas.estados (est_id,	est_nombre, esp_descripcion,usuario_registro) VALUES
(0, 'INACTIVO','Estado para registros inactivos', 0),
(1, 'ACTIVO','Estado para registros activos',0),
(2, 'RESERVADOS','Estado para citas reservadas', 0),
(3, 'CANDELADO','Estado para citas cancelados', 0),
(4, 'ATENDIDO','Estado para citas atendidas ', 0);

-- SEEDERS para especialidades  
INSERT TO parametricas.especialidades (esp_id,	esp_nombre, esp_observacion,usuario_registro) VALUES
(1, 'DERMATOLOGIA','Observacion de la especialidad',0),
(2, 'ODONTOLOGIA','Obsrvacion de la especialidad', 0),
(3, 'TRAUMATOLOGIA','Observacion de la especialidad', 0);

-- SEEDERS para horarios  
INSERT TO parametricas.horarios (hor_id,	hor_inicio, hor_fin, usuario_registro) VALUES
(1, '08:00','09:00',0),
(2, '09:00','10:00', 0),
(3, '10:00','11:00', 0),
(4, '14:00','15:00', 0),
(5, '15:00','16:00', 0),
(6, '16:00','17:00', 0);

-- SEEDERS para horarios  
INSERT INTO parametricas.horarios (hor_id,	hor_inicio, hor_fin, usuario_registro) VALUES
(1, '08:00','09:00',0),
(2, '09:00','10:00', 0),
(3, '10:00','11:00', 0),
(4, '14:00','15:00', 0),
(5, '15:00','16:00', 0),
(6, '16:00','17:00', 0);

-- SEEDERS para roles  
INSERT INTO autenticacion.roles (rol_id, rol_nombre, usuario_registro) VALUES
(1, 'ADMINISTRADOR',0),
(2, 'MEDICO', 0),
(3, 'PACIENTE', 0);

-- SEEDERS para roles  (administrador)
INSERT INTO reservas.personas (per_id, per_nombre_completo, per_documento_identidad, usuario_registro) VALUES
(0, 'ADMINISTRADOR','000000',0);

-- SEEDERS para roles  (administrador)
INSERT INTO autenticacion.usuarios (usu_id, usu_usuario, usu_password, per_id, usuario_registro) VALUES
(0, 'admin','ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 0,0); --> password123

-- SEEDER PARA  usuario_roles
INSERT INTO autenticacion.usuario_roles (rol_id, usu_id, usuario_registro) VALUES
(1, 0,0);


