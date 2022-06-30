CREATE OR REPLACE FUNCTION secure_software_requests_ins_fnc ()
    RETURNS TRIGGER
    AS $$
BEGIN
    SELECT
        *
    FROM
        Software_Requests;
    IF Software_Requests.Request_Start_Date > Software_Requests.Request_Closed_Date THEN
        RAISE EXCEPTION 'Start date cannot be later!';
    END IF;
END;
$$
LANGUAGE 'plpgsql';

