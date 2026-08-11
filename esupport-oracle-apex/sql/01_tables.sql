-- ============================================

-- TABELA: klienti

-- ============================================

CREATE TABLE klienti (

    klient_id        NUMBER,

    emer             VARCHAR2(50)   NOT NULL,

    mbiemer          VARCHAR2(50)   NOT NULL,

    nr_kontakti      VARCHAR2(20),

    email            VARCHAR2(100),

    adrese           VARCHAR2(200),

    karte_anetaresie VARCHAR2(30),

    CONSTRAINT pk_klienti PRIMARY KEY (klient_id)

);

-- ============================================

-- TABELA: rol

-- ============================================

CREATE TABLE rol (

    rol_id   NUMBER,

    emer_rol VARCHAR2(30) NOT NULL,

    CONSTRAINT pk_rol PRIMARY KEY (rol_id),

    CONSTRAINT uk_rol_emer UNIQUE (emer_rol)

);

-- ============================================

-- TABELA: pika_sherbimi

-- ============================================

CREATE TABLE pika_sherbimi (

    pika_id   NUMBER,

    emertimi  VARCHAR2(100) NOT NULL,

    adrese    VARCHAR2(200),

    email     VARCHAR2(100),

    nr_tel    VARCHAR2(20),

    CONSTRAINT pk_pika_sherbimi PRIMARY KEY (pika_id)

);

-- ============================================

-- TABELA: lloj_pajisje

-- ============================================

CREATE TABLE lloj_pajisje (

    lloj_pajisje_id NUMBER,

    emer            VARCHAR2(50) NOT NULL,

    CONSTRAINT pk_lloj_pajisje PRIMARY KEY (lloj_pajisje_id),

    CONSTRAINT uk_lloj_pajisje_emer UNIQUE (emer)

);

-- ============================================

-- TABELA: marka

-- ============================================

CREATE TABLE marka (

    marka_id NUMBER,

    emer     VARCHAR2(50) NOT NULL,

    CONSTRAINT pk_marka PRIMARY KEY (marka_id),

    CONSTRAINT uk_marka_emer UNIQUE (emer)

);

-- ============================================

-- TABELA: lloj_sherbimi

-- ============================================

CREATE TABLE lloj_sherbimi (

    sherbim_id NUMBER,

    emer       VARCHAR2(100) NOT NULL,

    pershkrim  VARCHAR2(300),

    cmim_baze  NUMBER(10,2),

    CONSTRAINT pk_lloj_sherbimi PRIMARY KEY (sherbim_id),

    CONSTRAINT uk_lloj_sherbimi_emer UNIQUE (emer)

);

-- ============================================

-- TABELA: perdorues

-- ============================================

CREATE TABLE perdorues (

    perdorues_id  NUMBER,

    username      VARCHAR2(50)  NOT NULL,

    password_hash VARCHAR2(200),

    emer          VARCHAR2(50)  NOT NULL,

    mbiemer       VARCHAR2(50)  NOT NULL,

    email         VARCHAR2(100),

    pika_id       NUMBER,

    rol_id        NUMBER        NOT NULL,

    CONSTRAINT pk_perdorues PRIMARY KEY (perdorues_id),

    CONSTRAINT uk_perdorues_username UNIQUE (username),

    CONSTRAINT fk_perdorues_pika FOREIGN KEY (pika_id) REFERENCES pika_sherbimi(pika_id),

    CONSTRAINT fk_perdorues_rol  FOREIGN KEY (rol_id)  REFERENCES rol(rol_id)

);

-- ============================================

-- TABELA: pajisje

-- ============================================

CREATE TABLE pajisje (

    pajisje_id              NUMBER,

    klient_id               NUMBER NOT NULL,

    lloj_pajisje_id         NUMBER NOT NULL,

    marka_id                NUMBER NOT NULL,

    serial_imei             VARCHAR2(50),

    data_blerjes            DATE,

    data_mbarimit_garancise DATE,

    CONSTRAINT pk_pajisje       PRIMARY KEY (pajisje_id),

    CONSTRAINT uk_pajisje_serial UNIQUE (serial_imei),

    CONSTRAINT fk_pajisje_klient FOREIGN KEY (klient_id)       REFERENCES klienti(klient_id),

    CONSTRAINT fk_pajisje_lloj   FOREIGN KEY (lloj_pajisje_id) REFERENCES lloj_pajisje(lloj_pajisje_id),

    CONSTRAINT fk_pajisje_marka  FOREIGN KEY (marka_id)        REFERENCES marka(marka_id)

);

-- ============================================

-- TABELA: pika_shp_sherbim (lidhese)

-- ============================================

CREATE TABLE pika_shp_sherbim (

    pika_id    NUMBER NOT NULL,

    sherbim_id NUMBER NOT NULL,

    CONSTRAINT pk_pika_shp_sherbim PRIMARY KEY (pika_id, sherbim_id),

    CONSTRAINT fk_pika_shp_pika   FOREIGN KEY (pika_id)    REFERENCES pika_sherbimi(pika_id),

    CONSTRAINT fk_pika_shp_sherbim FOREIGN KEY (sherbim_id) REFERENCES lloj_sherbimi(sherbim_id)

);

-- ============================================

-- TABELA: ticket

-- ============================================

CREATE TABLE ticket (

    ticket_id               NUMBER,

    klient_id               NUMBER         NOT NULL,

    pajisje_id              NUMBER         NOT NULL,

    pika_id                 NUMBER         NOT NULL,

    hapur_nga_perdorues_id  NUMBER         NOT NULL,

    data_hapjes             DATE           DEFAULT SYSDATE NOT NULL,

    status                  VARCHAR2(10)   DEFAULT 'OPEN'  NOT NULL,

    pershkrim_problemi      VARCHAR2(500)  NOT NULL,

    prioritet               VARCHAR2(10),

    data_mbylljes           DATE,

    diagnoze                VARCHAR2(500),

    zgjidhja                VARCHAR2(1000),

    perseritje_defekti_flag CHAR(1),

    CONSTRAINT pk_ticket           PRIMARY KEY (ticket_id),

    CONSTRAINT ck_ticket_status    CHECK (status IN ('OPEN','CLOSED')),

    CONSTRAINT ck_ticket_prioritet CHECK (prioritet IS NULL OR prioritet IN ('LOW','MED','HIGH')),

    CONSTRAINT ck_ticket_perseritje CHECK (perseritje_defekti_flag IS NULL OR perseritje_defekti_flag IN ('Y','N')),

    CONSTRAINT fk_ticket_klient    FOREIGN KEY (klient_id)             REFERENCES klienti(klient_id),

    CONSTRAINT fk_ticket_pajisje   FOREIGN KEY (pajisje_id)            REFERENCES pajisje(pajisje_id),

    CONSTRAINT fk_ticket_pika      FOREIGN KEY (pika_id)               REFERENCES pika_sherbimi(pika_id),

    CONSTRAINT fk_ticket_hapur_nga FOREIGN KEY (hapur_nga_perdorues_id) REFERENCES perdorues(perdorues_id)

);

-- ============================================

-- TABELA: fatura

-- ============================================

CREATE TABLE fatura (

    fatura_id    NUMBER,

    ticket_id    NUMBER         NOT NULL,

    data_fatures DATE           DEFAULT SYSDATE NOT NULL,

    total        NUMBER(10,2)   DEFAULT 0 NOT NULL,

    paguar       CHAR(1)        DEFAULT 'N' NOT NULL,

    CONSTRAINT pk_fatura        PRIMARY KEY (fatura_id),

    CONSTRAINT uk_fatura_ticket UNIQUE (ticket_id),

    CONSTRAINT ck_fatura_paguar CHECK (paguar IN ('Y','N')),

    CONSTRAINT fk_fatura_ticket FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id)

);

-- ============================================

-- TABELA: fatura_detaje

-- ============================================

CREATE TABLE fatura_detaje (

    fatura_id  NUMBER        NOT NULL,

    sherbim_id NUMBER        NOT NULL,

    sasi       NUMBER        DEFAULT 1 NOT NULL,

    cmim       NUMBER(10,2)  NOT NULL,

    nentotal   NUMBER(10,2)  NOT NULL,

    CONSTRAINT pk_fatura_detaje PRIMARY KEY (fatura_id, sherbim_id),

    CONSTRAINT ck_fd_sasi     CHECK (sasi > 0),

    CONSTRAINT ck_fd_cmim     CHECK (cmim >= 0),

    CONSTRAINT ck_fd_nentotal CHECK (nentotal >= 0),

    CONSTRAINT fk_fd_fatura  FOREIGN KEY (fatura_id)  REFERENCES fatura(fatura_id),

    CONSTRAINT fk_fd_sherbim FOREIGN KEY (sherbim_id) REFERENCES lloj_sherbimi(sherbim_id)

);

-- ============================================

-- TABELA: dokumentim

-- ============================================

CREATE TABLE dokumentim (

    dokumentim_id   NUMBER,

    titull          VARCHAR2(200)  NOT NULL,

    pershkrim       VARCHAR2(2000) NOT NULL,

    data_krijimit   DATE           DEFAULT SYSDATE NOT NULL,

    krijuar_nga_id  NUMBER         NOT NULL,

    lloj_pajisje_id NUMBER,

    marka_id        NUMBER,

    CONSTRAINT pk_dokumentim PRIMARY KEY (dokumentim_id),

    CONSTRAINT fk_dokumentim_perdorues    FOREIGN KEY (krijuar_nga_id)   REFERENCES perdorues(perdorues_id),

    CONSTRAINT fk_dokumentim_lloj_pajisje FOREIGN KEY (lloj_pajisje_id)  REFERENCES lloj_pajisje(lloj_pajisje_id),

    CONSTRAINT fk_dokumentim_marka        FOREIGN KEY (marka_id)         REFERENCES marka(marka_id)

);
