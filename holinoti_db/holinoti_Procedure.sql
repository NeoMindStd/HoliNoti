DELIMITER //

CREATE PROCEDURE DISTANCE(lon double, lat double, side int)

BEGIN

SET @lon = lon;
SET @lat = lat;

SET @MBR_length = side;

SET @lon_diff = @MBR_length / 2 / ST_DISTANCE_SPHERE(POINT(@lon, @lat), POINT(@lon + IF(@lon < 0, 1, -1), @lat));
SET @lat_diff = @MBR_length / 2 / ST_DISTANCE_SPHERE(POINT(@lon, @lat), POINT(@lon, @lat + IF(@lat < 0, 1, -1)));

SET @diagonal = CONCAT('LINESTRING(', @lon -  IF(@lon < 0, 1, -1) * @lon_diff, ' ', @lat -  IF(@lon < 0, 1, -1) * @lat_diff, ',', @lon +  IF(@lon < 0, 1, -1) * @lon_diff, ' ', @lat +  IF(@lon < 0, 1, -1) * @lat_diff, ')');

SELECT *
FROM facility FORCE INDEX FOR JOIN (`SPATIAL_COORD`)
WHERE MBRCONTAINS(ST_LINESTRINGFROMTEXT(@diagonal), coordinates);
END

//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE NAMEDISTANCE(IN lon double, IN lat double, IN side int, IN nam varchar(255))

BEGIN

SET @lon = lon;
SET @lat = lat;
SET @nam = nam;

SET @R_nam = CONCAT('%',@nam,'%');

SET @MBR_length = side;

SET @lon_diff = @MBR_length / 2 / ST_DISTANCE_SPHERE(POINT(@lon, @lat), POINT(@lon + IF(@lon < 0, 1, -1), @lat));
SET @lat_diff = @MBR_length / 2 / ST_DISTANCE_SPHERE(POINT(@lon, @lat), POINT(@lon, @lat + IF(@lat < 0, 1, -1)));

SET @diagonal = CONCAT('LINESTRING(', @lon -  IF(@lon < 0, 1, -1) * @lon_diff, ' ', @lat -  IF(@lon < 0, 1, -1) * @lat_diff, ',', @lon +  IF(@lon < 0, 1, -1) * @lon_diff, ' ', @lat +  IF(@lon < 0, 1, -1) * @lat_diff, ')');

SELECT *
FROM facility FORCE INDEX FOR JOIN (`SPATIAL_COORD`)
WHERE MBRCONTAINS(ST_LINESTRINGFROMTEXT(@diagonal), coordinates) AND replace(name,' ','') LIKE @R_nam;
END

//

DELIMITER ;