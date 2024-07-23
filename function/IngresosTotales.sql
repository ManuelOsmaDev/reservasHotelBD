BEGIN
    DECLARE v_IngresosTotales DECIMAL(10,2);

    SELECT SUM(MontoTotal) INTO v_IngresosTotales
    FROM Reservas
    WHERE Estado = 'Completada';

    RETURN v_IngresosTotales;
END