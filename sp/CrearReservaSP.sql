BEGIN
    DECLARE v_Dias INT;
    DECLARE v_PrecioPorNoche DECIMAL(10,2);
    DECLARE v_MontoTotal DECIMAL(10,2);
    DECLARE v_EstadoHabitacion VARCHAR(20);

    -- Verificar si la habitación está disponible
    SELECT estado INTO v_EstadoHabitacion
    FROM Habitaciones
    WHERE habitacion_id = p_HabitacionID;

    IF v_EstadoHabitacion != 'Disponible' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La habitación no está disponible.';
    ELSE
        -- Calcular número de días
        SET v_Dias = DATEDIFF(p_FechaFin, p_FechaInicio);

        -- Obtener precio por noche de la habitación
        SELECT precio_por_noche INTO v_PrecioPorNoche
        FROM Habitaciones
        WHERE habitacion_id = p_HabitacionID;

        -- Calcular el monto total
        SET v_MontoTotal = v_Dias * v_PrecioPorNoche;

        -- Insertar la reserva
        INSERT INTO Reservas (cliente_id, habitacion_id, fecha_inicio, fecha_inicio, monto_total, estado)
        VALUES (p_ClienteID, p_HabitacionID, p_FechaInicio, p_FechaFin, v_MontoTotal, 'Confirmada');

        -- Actualizar el estado de la habitación a 'Ocupada'
        UPDATE Habitaciones
        SET estado = 'Ocupada'
        WHERE habitacion_id = p_HabitacionID;
    END IF;
END