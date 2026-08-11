CREATE OR REPLACE FUNCTION kontrollo_garanci (

    p_pajisje_id IN NUMBER

) RETURN CHAR

AS

    v_data_mbarimit DATE;

BEGIN

    SELECT data_mbarimit_garancise

    INTO v_data_mbarimit

    FROM pajisje

    WHERE pajisje_id = p_pajisje_id;

    IF v_data_mbarimit >= SYSDATE THEN

        RETURN 'Y';

    ELSE

        RETURN 'N';

    END IF;

END;

/

CREATE OR REPLACE FUNCTION kontrollo_defekt_3muaj (

    p_ticket_id IN NUMBER

) RETURN CHAR

AS

    v_pajisje_id   NUMBER;

    v_data_hapjes  DATE;

    v_count        NUMBER;

BEGIN

    SELECT pajisje_id, data_hapjes

    INTO v_pajisje_id, v_data_hapjes

    FROM ticket

    WHERE ticket_id = p_ticket_id;

    SELECT COUNT(*)

    INTO v_count

    FROM ticket

    WHERE pajisje_id = v_pajisje_id

      AND ticket_id <> p_ticket_id

      AND status = 'CLOSED'

      AND data_hapjes >= v_data_hapjes - 90;

    IF v_count >= 1 THEN

        RETURN 'Y';

    ELSE

        RETURN 'N';

    END IF;

END;

/

CREATE OR REPLACE FUNCTION llogarit_total_fature (

    p_fatura_id IN NUMBER

) RETURN NUMBER

AS

    v_total NUMBER := 0;

BEGIN

    SELECT NVL(SUM(nentotal), 0)

    INTO v_total

    FROM fatura_detaje

    WHERE fatura_id = p_fatura_id;

    RETURN v_total;

END;

/
