CREATE OR REPLACE VIEW vw_ticket_status_klient AS

SELECT

    t.ticket_id,

    t.klient_id,

    t.data_hapjes,

    t.status,

    t.prioritet,

    t.pershkrim_problemi,

    t.data_mbylljes,

    t.diagnoze,

    t.zgjidhja,

    t.perseritje_defekti_flag,

    p.serial_imei,

    lp.emer      AS lloj_pajisje,

    m.emer       AS marka,

    ps.emertimi  AS pika_sherbimi,

    CASE

        WHEN t.data_hapjes <= p.data_mbarimit_garancise THEN 'Y'

        ELSE 'N'

    END AS ne_garanci

FROM ticket t

JOIN pajisje p       ON t.pajisje_id      = p.pajisje_id

JOIN lloj_pajisje lp ON p.lloj_pajisje_id = lp.lloj_pajisje_id

JOIN marka m         ON p.marka_id        = m.marka_id

JOIN pika_sherbimi ps ON t.pika_id        = ps.pika_id;

CREATE OR REPLACE VIEW vw_ticket_sportel AS

SELECT

    t.ticket_id,

    t.klient_id,

    k.emer || ' ' || k.mbiemer AS klienti,

    p.serial_imei AS pajisja,

    t.pika_id,

    t.data_hapjes,

    t.status,

    t.pershkrim_problemi,

    t.prioritet,

    t.data_mbylljes,

    t.diagnoze,

    t.zgjidhja

FROM ticket t

JOIN klienti k ON t.klient_id  = k.klient_id

JOIN pajisje p ON t.pajisje_id = p.pajisje_id;

CREATE OR REPLACE VIEW vw_ticket_menaxher AS

SELECT

    t.ticket_id,

    t.klient_id,

    k.emer || ' ' || k.mbiemer AS klienti,

    p.serial_imei AS pajisja,

    t.pika_id,

    ps.emertimi AS pika_sherbimi,

    t.data_hapjes,

    t.status,

    t.pershkrim_problemi,

    t.prioritet,

    t.data_mbylljes,

    t.diagnoze,

    t.zgjidhja,

    t.perseritje_defekti_flag

FROM ticket t

JOIN klienti k        ON t.klient_id  = k.klient_id

JOIN pajisje p        ON t.pajisje_id = p.pajisje_id

JOIN pika_sherbimi ps ON t.pika_id    = ps.pika_id;
