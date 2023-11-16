
CREATE OR REPLACE FUNCTION raise_exception_on_primary_promotion() RETURNS VOID AS $$
BEGIN
    -- if current server is slave, then check if repmgr recorded a promotion event in recent past
    -- raise a custom exception if there is Promotion, which will allow the client-application to act upon it
    IF pg_is_in_recovery() THEN
        IF EXISTS (
            SELECT 1
            FROM repmgr.events
            WHERE
                event_timestamp >= now() - interval '10 second'
                AND details LIKE '%was successfully promoted%'
        ) THEN
            RAISE EXCEPTION 'A promotion event was detected.';
        END IF;
    ELSE
        -- 
        PERFORM 0;
    END IF;
END;
$$ LANGUAGE plpgsql;
