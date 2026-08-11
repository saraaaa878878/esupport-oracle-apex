CREATE OR REPLACE PROCEDURE kryej_sherbim (

    p_ticket_id IN NUMBER

)

AS

    v_pajisje_id   NUMBER;

    v_status       VARCHAR2(10);

    v_ne_garanci   CHAR(1);

    v_perseritje   CHAR(1);

    v_duhet_fature CHAR(1);

    v_fatura_id    NUMBER;

BEGIN

    SELECT pajisje_id, status

    INTO v_pajisje_id, v_status

    FROM ticket

    WHERE ticket_id = p_ticket_id

    FOR UPDATE;

    IF v_status <> 'CLOSED' THEN

        v_duhet_fature := 'N';

    ELSE

        v_ne_garanci := kontrollo_garanci(v_pajisje_id);

        v_perseritje := kontrollo_defekt_3muaj(p_ticket_id);

        IF v_ne_garanci = 'Y' OR v_perseritje = 'Y' THEN

            v_duhet_fature := 'N';

        ELSE

            v_duhet_fature := 'Y';

        END IF;

    END IF;

    IF v_duhet_fature = 'Y' THEN

        INSERT INTO fatura (fatura_id, ticket_id, data_fatures, total, paguar)

        VALUES (seq_fatura.NEXTVAL, p_ticket_id, SYSDATE, 0, 'N')

        RETURNING fatura_id INTO v_fatura_id;

        INSERT INTO fatura_detaje (fatura_id, sherbim_id, sasi, cmim, nentotal)

        VALUES (

            v_fatura_id,

            (SELECT sherbim_id FROM lloj_sherbimi WHERE ROWNUM = 1),

            1, 1000, 1000

        );

        UPDATE fatura

        SET total = llogarit_total_fature(v_fatura_id)

        WHERE fatura_id = v_fatura_id;

    END IF;

    UPDATE ticket

    SET status = 'CLOSED',

        data_mbylljes = SYSDATE

    WHERE ticket_id = p_ticket_id;

END;

/

-- EXECUTE kryej_sherbim(1);  -- sample/test call
CREATE OR REPLACE PROCEDURE regjistro_klient (

    p_perdorues_aktiv IN NUMBER,

    p_emer            IN VARCHAR2,

    p_mbiemer         IN VARCHAR2,

    p_email           IN VARCHAR2,

    p_tel             IN VARCHAR2,

    p_adrese          IN VARCHAR2

)

AS

    v_rol VARCHAR2(30);

BEGIN

    SELECT r.emer_rol

    INTO v_rol

    FROM perdorues p

    JOIN rol r ON p.rol_id = r.rol_id

    WHERE p.perdorues_id = p_perdorues_aktiv;

    IF v_rol <> 'SPORTEL' THEN

        RAISE_APPLICATION_ERROR(-20001, 'Vetem SPORTEL mund te regjistrojë klientë.');

    END IF;

    INSERT INTO klienti (klient_id, emer, mbiemer, email, nr_kontakti, adrese)

    VALUES (seq_klienti.NEXTVAL, p_emer, p_mbiemer, p_email, p_tel, p_adrese);

END;

/

-- EXECUTE regjistro_klient(9, 'Emri', 'Mbiemri', 'email@domain.com', '0691234567', 'Adresa');  -- sample/test call
CREATE OR REPLACE PROCEDURE hap_ticket (

    p_perdorues_aktiv IN NUMBER,

    p_klient_id       IN NUMBER,

    p_pajisje_id      IN NUMBER,

    p_pika_id         IN NUMBER,

    p_pershkrimi      IN VARCHAR2,

    p_prioritet       IN VARCHAR2

)

AS

    v_rol VARCHAR2(30);

BEGIN

    SELECT r.emer_rol

    INTO v_rol

    FROM perdorues p

    JOIN rol r ON p.rol_id = r.rol_id

    WHERE p.perdorues_id = p_perdorues_aktiv;

    IF v_rol <> 'SPORTEL' THEN

        RAISE_APPLICATION_ERROR(-20002, 'Vetem SPORTEL mund të hapë ticket.');

    END IF;

    INSERT INTO ticket (

        ticket_id, klient_id, pajisje_id, pika_id,

        hapur_nga_perdorues_id, data_hapjes, status,

        pershkrim_problemi, prioritet

    )

    VALUES (

        seq_ticket.NEXTVAL, p_klient_id, p_pajisje_id, p_pika_id,

        p_perdorues_aktiv, SYSDATE, 'OPEN',

        p_pershkrimi, p_prioritet

    );

END;

/

-- EXECUTE hap_ticket(9, 1, 1, 1, 'Problemi i testit', 'HIGH');  -- sample/test call
CREATE OR REPLACE PROCEDURE shto_perdorues (

    p_perdorues_aktiv IN NUMBER,

    p_username        IN VARCHAR2,

    p_emer            IN VARCHAR2,

    p_mbiemer         IN VARCHAR2,

    p_email           IN VARCHAR2,

    p_pika_id         IN NUMBER,

    p_rol_id          IN NUMBER

)

AS

    v_rol VARCHAR2(30);

BEGIN

    SELECT r.emer_rol

    INTO v_rol

    FROM perdorues p

    JOIN rol r ON p.rol_id = r.rol_id

    WHERE p.perdorues_id = p_perdorues_aktiv;

    IF v_rol <> 'MENAXHER' THEN

        RAISE_APPLICATION_ERROR(-20003, 'Vetem MENAXHER mund të shtojë perdorues.');

    END IF;

    INSERT INTO perdorues (perdorues_id, username, emer, mbiemer, email, pika_id, rol_id)

    VALUES (seq_perdorues.NEXTVAL, p_username, p_emer, p_mbiemer, p_email, p_pika_id, p_rol_id);

END;

/

-- EXECUTE shto_perdorues(2, 'username', 'Emri', 'Mbiemri', 'email@domain.com', 1, 3);  -- sample/test call
CREATE OR REPLACE PROCEDURE shto_sherbim (

    p_perdorues_aktiv IN NUMBER,

    p_emer_sherbimi   IN VARCHAR2,

    p_pershkrim       IN VARCHAR2,

    p_cmim_baze       IN NUMBER

)

AS

    v_rol VARCHAR2(30);

BEGIN

    SELECT r.emer_rol

    INTO v_rol

    FROM perdorues p

    JOIN rol r ON p.rol_id = r.rol_id

    WHERE p.perdorues_id = p_perdorues_aktiv;

    IF v_rol <> 'MENAXHER' THEN

        RAISE_APPLICATION_ERROR(-20004, 'Vetem MENAXHER mund të shtojë shërbime.');

    END IF;

    INSERT INTO lloj_sherbimi (sherbim_id, emer, pershkrim, cmim_baze)

    VALUES (seq_lloj_sherbimi.NEXTVAL, p_emer_sherbimi, p_pershkrim, p_cmim_baze);

END;

/

-- EXECUTE shto_sherbim(2, 'Shërbim i ri', 'Përshkrimi', 500);  -- sample/test call
CREATE OR REPLACE PROCEDURE shto_pike_sherbimi (

    p_perdorues_aktiv IN NUMBER,

    p_emertimi        IN VARCHAR2,

    p_adrese          IN VARCHAR2,

    p_email           IN VARCHAR2,

    p_tel             IN VARCHAR2

)

AS

    v_rol VARCHAR2(30);

BEGIN

    SELECT r.emer_rol

    INTO v_rol

    FROM perdorues p

    JOIN rol r ON p.rol_id = r.rol_id

    WHERE p.perdorues_id = p_perdorues_aktiv;

    IF v_rol <> 'MENAXHER' THEN

        RAISE_APPLICATION_ERROR(-20005, 'Vetem MENAXHER mund të shtojë pika shërbimi.');

    END IF;

    INSERT INTO pika_sherbimi (pika_id, emertimi, adrese, email, nr_tel)

    VALUES (seq_pika.NEXTVAL, p_emertimi, p_adrese, p_email, p_tel);

END;

/

-- EXECUTE shto_pike_sherbimi(2, 'Pika e re', 'Adresa', 'email@domain.com', '0691234567');  -- sample/test call
CREATE OR REPLACE PROCEDURE shfaq_ticket_info (

    p_ticket_id IN NUMBER

)

AS

    v_klient        VARCHAR2(200);

    v_pajisje       VARCHAR2(200);

    v_status        VARCHAR2(20);

    v_pershkrim     VARCHAR2(500);

    v_data_hapjes   DATE;

    v_data_mbylljes DATE;

    v_diag          VARCHAR2(500);

    v_zgjidhje      VARCHAR2(1000);

    v_garanci       CHAR(1);

    v_perseritje    CHAR(1);

    v_fatura_id     NUMBER;

    v_total         NUMBER;

    v_pajisje_id    NUMBER;

BEGIN

    DBMS_OUTPUT.PUT_LINE('---------------------------------------');

    SELECT

        c.emer || ' ' || c.mbiemer,

        p.serial_imei,

        t.status,

        t.pershkrim_problemi,

        t.data_hapjes,

        t.data_mbylljes,

        t.diagnoze,

        t.zgjidhja,

        t.pajisje_id

    INTO

        v_klient, v_pajisje, v_status, v_pershkrim,

        v_data_hapjes, v_data_mbylljes, v_diag, v_zgjidhje,

        v_pajisje_id

    FROM ticket t

    JOIN klienti c ON t.klient_id = c.klient_id

    JOIN pajisje p ON t.pajisje_id = p.pajisje_id

    WHERE t.ticket_id = p_ticket_id;

    v_garanci    := kontrollo_garanci(v_pajisje_id);

    v_perseritje := kontrollo_defekt_3muaj(p_ticket_id);

    DBMS_OUTPUT.PUT_LINE('Ticket ID: '  || p_ticket_id);

    DBMS_OUTPUT.PUT_LINE('Klienti: '    || v_klient);

    DBMS_OUTPUT.PUT_LINE('Pajisja: '    || v_pajisje);

    DBMS_OUTPUT.PUT_LINE('Gjendja: '    || v_status);

    DBMS_OUTPUT.PUT_LINE('Problemi: '   || v_pershkrim);

    DBMS_OUTPUT.PUT_LINE('Hapur me: '   || TO_CHAR(v_data_hapjes, 'YYYY-MM-DD'));

    IF v_status = 'CLOSED' THEN

        DBMS_OUTPUT.PUT_LINE('Mbyllur me: ' || TO_CHAR(v_data_mbylljes, 'YYYY-MM-DD'));

        DBMS_OUTPUT.PUT_LINE('Diagnoza: '   || v_diag);

        DBMS_OUTPUT.PUT_LINE('Zgjidhja: '   || v_zgjidhje);

    END IF;

    DBMS_OUTPUT.PUT_LINE('Ne garanci? '         || v_garanci);

    DBMS_OUTPUT.PUT_LINE('Defekt i perseritir? ' || v_perseritje);

    BEGIN

        SELECT fatura_id, total

        INTO v_fatura_id, v_total

        FROM fatura

        WHERE ticket_id = p_ticket_id;

        DBMS_OUTPUT.PUT_LINE('Fature ID: ' || v_fatura_id);

        DBMS_OUTPUT.PUT_LINE('Totali: '    || v_total);

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            DBMS_OUTPUT.PUT_LINE('Nuk ka fature per kete ticket.');

    END;

    DBMS_OUTPUT.PUT_LINE('---------------------------------------');

EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE('Ticket nuk u gjet: ' || p_ticket_id);

END;

/

-- EXECUTE shfaq_ticket_info(1);  -- sample/test call
CREATE OR REPLACE PROCEDURE shto_dokumentim (

    p_perdorues_id    IN NUMBER,

    p_titull          IN VARCHAR2,

    p_pershkrim       IN VARCHAR2,

    p_lloj_pajisje_id IN NUMBER,

    p_marka_id        IN NUMBER

)

AS

    v_count NUMBER;

BEGIN

    SELECT COUNT(*)

    INTO v_count

    FROM perdorues

    WHERE perdorues_id = p_perdorues_id;

    IF v_count = 0 THEN

        RAISE_APPLICATION_ERROR(-20010, 'Perdoruesi nuk ekziston.');

    END IF;

    INSERT INTO dokumentim (

        dokumentim_id, titull, pershkrim, data_krijimit,

        krijuar_nga_id, lloj_pajisje_id, marka_id

    )

    VALUES (

        seq_dokumentim.NEXTVAL, p_titull, p_pershkrim, SYSDATE,

        p_perdorues_id, p_lloj_pajisje_id, p_marka_id

    );

END;

/

CREATE OR REPLACE PROCEDURE kerkoni_ticketet_hapura (

    p_perdorues_id IN NUMBER

)

AS

BEGIN

    FOR t IN (

        SELECT t.ticket_id,

               k.emer || ' ' || k.mbiemer AS klienti,

               t.status,

               t.pershkrim_problemi,

               t.data_hapjes,

               t.prioritet,

               p.serial_imei AS pajisje,

               ps.emertimi AS pika_sherbimi

        FROM ticket t

        JOIN klienti k       ON t.klient_id  = k.klient_id

        JOIN pajisje p       ON t.pajisje_id = p.pajisje_id

        JOIN pika_sherbimi ps ON t.pika_id   = ps.pika_id

        WHERE t.status = 'OPEN'

        AND t.hapur_nga_perdorues_id = p_perdorues_id

    ) LOOP

        DBMS_OUTPUT.PUT_LINE('Ticket ID: '        || t.ticket_id);

        DBMS_OUTPUT.PUT_LINE('Klienti: '          || t.klienti);

        DBMS_OUTPUT.PUT_LINE('Statusi: '          || t.status);

        DBMS_OUTPUT.PUT_LINE('Problemi: '         || t.pershkrim_problemi);

        DBMS_OUTPUT.PUT_LINE('Data hapjes: '      || TO_CHAR(t.data_hapjes, 'YYYY-MM-DD'));

        DBMS_OUTPUT.PUT_LINE('Prioriteti: '       || t.prioritet);

        DBMS_OUTPUT.PUT_LINE('Pajisja: '          || t.pajisje);

        DBMS_OUTPUT.PUT_LINE('Pika sherbimit: '   || t.pika_sherbimi);

        DBMS_OUTPUT.PUT_LINE('------------------------------------------');

    END LOOP;

END;

/
