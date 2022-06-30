CREATE TRIGGER srq_insert_trigger
    BEFORE INSERT ON Software_Requests
    FOR EACH ROW
    EXECUTE PROCEDURE secure_software_requests_ins_fnc ();

