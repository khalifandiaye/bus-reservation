DROP PROCEDURE IF EXISTS search_trips; 
DELIMITER $$
CREATE PROCEDURE search_trips(IN DEPT_CITY INT, 
							  IN ARRV_CITY INT,
							  IN DEPT_DATE VARCHAR(10),
							  IN PSSGR_NO INT,
                              IN BUS_TYPE INT)
BEGIN
SELECT  dept.bus_status_id,
		dept.city_name       		AS departure_city,
	    dept.station_name    		AS departure_station_name,
	    dept.station_address 		AS departure_station_address,
        dept.departure_time,
		arrv.city_name       		AS arrival_city,
        arrv.station_name    		AS arrival_station_name,
		arrv.station_address 		AS arrival_station_address,
		arrv.arrival_time,
        SUM(trff.fare) * PSSGR_NO 	AS fare
FROM   
	-- departure trip information
	    (SELECT dtrp.bus_status_id,
				ddtl.city_name,
			 	ddtl.station_name, 
				ddtl.station_address,
				dtrp.departure_time
         FROM trip dtrp
           INNER JOIN
			 (SELECT drdt.id      AS route_details_id,
				     dsta.name    AS station_name,
			 		 dcty.name    AS city_name,                               			
					 dsta.address AS station_address
			  FROM   route_details drdt
				INNER JOIN route    drou ON drou.id = drdt.route_id
				INNER JOIN segment  dseg ON dseg.id = drdt.segment_id        			
				INNER JOIN station  dsta ON dsta.id = dseg.departure_station_id			   
				INNER JOIN location dcty ON dcty.id = dsta.location_id             			     
			 WHERE  dcty.id = DEPT_CITY) ddtl
		   ON dtrp.route_details_id = ddtl.route_details_id
		 WHERE DATE(dtrp.departure_time) >= SUBDATE(DATE(DEPT_DATE), INTERVAL 3 DAY)
		   AND DATE(dtrp.departure_time) <= ADDDATE(DATE(DEPT_DATE), INTERVAL 3 DAY)
			-- DATE(dtrp.departure_time) = DATE(DEPT_DATE)
		   AND DATE(dtrp.departure_time) >= ADDDATE(NOW(), INTERVAL 30 MINUTE)) dept
	INNER JOIN	 
	-- arrival trip information
        (SELECT atrp.bus_status_id,
                adtl.city_name,
				adtl.station_name, 
			    adtl.station_address,
				atrp.arrival_time
         FROM trip atrp 
           INNER JOIN     
			(SELECT ardt.id      AS route_details_id,
					acty.name    AS city_name,
					asta.name    AS station_name,                               			
					asta.address AS station_address			   
			 FROM   route_details ardt                                       			    
			   INNER JOIN segment  aseg ON ardt.segment_id = aseg.id          			
			   INNER JOIN station  asta ON asta.id = aseg.arrival_station_id			   
			   INNER JOIN location acty ON acty.id = asta.location_id             			     
			 WHERE  acty.id = ARRV_CITY) adtl
		   ON atrp.route_details_id = adtl.route_details_id) arrv
    ON dept.bus_status_id = arrv.bus_status_id
-- fare information
	INNER JOIN trip ftrp
      ON dept.bus_status_id = ftrp.bus_status_id
        AND dept.departure_time <= ftrp.departure_time
	    AND arrv.arrival_time >= ftrp.arrival_time
    INNER JOIN route_details frdt 
      ON ftrp.route_details_id = frdt.id
    INNER JOIN tariff trff 
	  ON frdt.segment_id = trff.segment_id 
        AND trff.bus_type_id = BUS_TYPE
	INNER JOIN remained_seats rmst
	  ON rmst.start_location_id = DEPT_CITY AND 
		 rmst.end_location_id = ARRV_CITY AND 
		 rmst.bus_status_id = dept.bus_status_id
WHERE   -- departure date is in range of valid fare dates
        trff.valid_from IN (SELECT MAX(ttrf.valid_from) 
                            FROM   tariff ttrf 
                            WHERE  ttrf.valid_from <= ftrp.departure_time AND
								   ttrf.segment_id = trff.segment_id) AND
        rmst.number_of_remained_seats >= PSSGR_NO
GROUP BY ftrp.bus_status_id;
END $$
DELIMITER ;
					
