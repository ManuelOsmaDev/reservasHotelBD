BEGIN
    DECLARE v_EstadoHabitacion VARCHAR(20);

    -- Verificar si la habitación está ocupada
    SELECT estado INTO v_EstadoHabitacion
    FROM Habitaciones
    WHERE habitacion_id = p_HabitacionID;

    IF v_EstadoHabitacion = 'Ocupada' THEN
        -- Actualizar el estado de la habitación a 'Disponible'
        UPDATE Habitaciones
        SET estado = 'Disponible'
        WHERE habitacion_id = p_HabitacionID;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La habitación no está ocupada o no existe.';
    END IF;
END