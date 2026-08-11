-- ============================================================
-- eSupport - ORIGINAL INSERT DATA
-- Source: the user's original assignment data
-- Run after tables and sequences have been created.
-- ============================================================

--Tabela LLOJ SHERBIMI
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Diagnostikim','Kontroll i përgjithshëm i pajisjes',500);
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Nderrim Ekrani','Zëvendësim ekrani për pajisje',6000);
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Pastrimi i ventilatorit','Pastrimi i brendshëm i ventilatorit',1500);
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Nderrim SSD','Zëvendësim i diskut SSD',5000);
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Nderrim pompe lavatrice','Riparim pompë shkarkimi',3500);
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Riparim kompresor frigorifer','Riparim i kompresorit',8000);
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Instalim kondicioneri','Instalimi i një kondicioneri',6000);
INSERT INTO lloj_sherbimi VALUES (seq_lloj_sherbimi.NEXTVAL,'Update software','Rivendosje / instalim software',1200);


--PIKA SHERBIMI
INSERT INTO pika_sherbimi VALUES (seq_pika.NEXTVAL,'Pika Tirane Mobile','Tirane Qender','tirane@esuport.al','0681000001');
INSERT INTO pika_sherbimi VALUES (seq_pika.NEXTVAL,'Pika Durres ElectroHome','Durres Plazh','durres@esuport.al','0681000002');
INSERT INTO pika_sherbimi VALUES (seq_pika.NEXTVAL,'Pika Vlore Tech+','Vlore Uji i Ftohte','vlore@esuport.al','0681000003');
INSERT INTO pika_sherbimi VALUES (seq_pika.NEXTVAL,'Pika Shkoder TV Audio','Shkoder Perash','shkoder@esuport.al','0681000004');
INSERT INTO pika_sherbimi VALUES (seq_pika.NEXTVAL,'Pika Fier Mix','Fier Centër','fier@esuport.al','0681000005');
INSERT INTO pika_sherbimi VALUES (seq_pika.NEXTVAL,'Pika Elbasan Repair','Elbasan Kala','elbasan@esuport.al','0681000006');
INSERT INTO pika_sherbimi VALUES (seq_pika.NEXTVAL,'Pika Korce SmartFix','Korce Pazari i Vjeter','korce@esuport.al','0681000007');

--PIKA_SHP_SHERBIME
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Diagnostikim'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Nderrim Ekrani'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Durres ElectroHome'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Nderrim pompe lavatrice'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Durres ElectroHome'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Riparim kompresor frigorifer'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Vlore Tech+'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Pastrimi i ventilatorit'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Vlore Tech+'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Update software'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Shkoder TV Audio'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Diagnostikim'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Shkoder TV Audio'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Nderrim Ekrani'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Fier Mix'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Nderrim SSD'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Elbasan Repair'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Instalim kondicioneri'));
INSERT INTO pika_shp_sherbim VALUES ((SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Korce SmartFix'),(SELECT sherbim_id FROM lloj_sherbimi WHERE emer='Diagnostikim'));


--ROLE
INSERT INTO rol VALUES (seq_rol.NEXTVAL, 'ADMIN');
INSERT INTO rol VALUES (seq_rol.NEXTVAL, 'MENAXHER');
INSERT INTO rol VALUES (seq_rol.NEXTVAL, 'SPORTEL');


--PERDORUES
--Admini
INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'admin','x','Admin','System','admin@esuport.al',NULL,
 (SELECT rol_id FROM rol WHERE emer_rol='ADMIN'));
-- 7 menaxher (1 per cdo pike)
INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'mgr_tr','x','Elira','Mema','mgr_tr@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT rol_id FROM rol WHERE emer_rol='MENAXHER'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'mgr_dr','x','Ervin','Kola','mgr_dr@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Durres ElectroHome'),
 (SELECT rol_id FROM rol WHERE emer_rol='MENAXHER'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'mgr_vl','x','Jona','Basha','mgr_vl@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Vlore Tech+'),
 (SELECT rol_id FROM rol WHERE emer_rol='MENAXHER'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'mgr_sh','x','Ardit','Cela','mgr_sh@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Shkoder TV Audio'),
 (SELECT rol_id FROM rol WHERE emer_rol='MENAXHER'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'mgr_fr','x','Bora','Nallbani','mgr_fr@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Fier Mix'),
 (SELECT rol_id FROM rol WHERE emer_rol='MENAXHER'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'mgr_el','x','Soni','Prifti','mgr_el@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Elbasan Repair'),
 (SELECT rol_id FROM rol WHERE emer_rol='MENAXHER'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'mgr_ko','x','Vjollca','Hodo','mgr_ko@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Korce SmartFix'),
 (SELECT rol_id FROM rol WHERE emer_rol='MENAXHER'));
--Sportel
INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_tr1','x','Ari','Kasa','sprtr1@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_tr2','x','Eno','Leka','sprtr2@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_dr','x','Adea','Hoxha','sprdr@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Durres ElectroHome'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_vl','x','Mira','Zeneli','sprvl@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Vlore Tech+'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_sh','x','Adel','Bushati','sprsh@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Shkoder TV Audio'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_fr1','x','Ina','Cela','sprfr1@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Fier Mix'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_fr2','x','Geri','Lame','sprfr2@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Fier Mix'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_el','x','Klea','Shehu','sprel@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Elbasan Repair'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));

INSERT INTO perdorues VALUES 
(seq_perdorues.NEXTVAL,'spr_ko','x','Rik','Molla','sprko@esuport.al',
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Korce SmartFix'),
 (SELECT rol_id FROM rol WHERE emer_rol='SPORTEL'));


--KLIENTE
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Ariola','Krasniqi','0691111111','ariola@mail.com','Tirane','KA01');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Besnik','Hysa','0692222222','besnik@mail.com','Durres','KA02');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Celia','Gjoni','0693333333','celia@mail.com','Vlore','KA03');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Dorian','Leka','0694444444','dorian@mail.com','Shkoder','KA04');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Ema','Duka','0695555555','ema@mail.com','Fier','KA05');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Florian','Mema','0696666666','florian@mail.com','Tirane','KA06');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Genta','Shala','0697777777','genta@mail.com','Korce','KA07');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Hektor','Pepa','0698888888','hektor@mail.com','Elbasan','KA08');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Ina','Zeneli','0699999999','ina@mail.com','Durres','KA09');
INSERT INTO klienti VALUES (seq_klienti.NEXTVAL,'Jon','Basha','0671111111','jon@mail.com','Fier','KA10');


-----LLOJ PAJISJE------
INSERT INTO lloj_pajisje VALUES (seq_lloj_pajisje.NEXTVAL, 'Telefon');
INSERT INTO lloj_pajisje VALUES (seq_lloj_pajisje.NEXTVAL, 'Laptop');
INSERT INTO lloj_pajisje VALUES (seq_lloj_pajisje.NEXTVAL, 'TV');
INSERT INTO lloj_pajisje VALUES (seq_lloj_pajisje.NEXTVAL, 'Lavatrice');
INSERT INTO lloj_pajisje VALUES (seq_lloj_pajisje.NEXTVAL, 'Frigorifer');
INSERT INTO lloj_pajisje VALUES (seq_lloj_pajisje.NEXTVAL, 'Kondicioner');



-----MARKA-----
INSERT INTO marka VALUES (seq_marka.NEXTVAL, 'Samsung');
INSERT INTO marka VALUES (seq_marka.NEXTVAL, 'Apple');
INSERT INTO marka VALUES (seq_marka.NEXTVAL, 'Dell');
INSERT INTO marka VALUES (seq_marka.NEXTVAL, 'LG');
INSERT INTO marka VALUES (seq_marka.NEXTVAL, 'Bosch');




-----PAJISJET-----------------------
--klient 1-2 pajisje
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ariola@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Samsung'),
 'IMEI-A1',
 DATE '2025-01-01',
 DATE '2027-01-01'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ariola@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Laptop'),
 (SELECT marka_id FROM marka WHERE emer='Dell'),
 'SN-A2',
 DATE '2024-03-10',
 DATE '2026-03-10'
);

--KLIENT 2 -3 PAJISJE
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='besnik@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Laptop'),
 (SELECT marka_id FROM marka WHERE emer='Dell'),
 'SN-B1',
 DATE '2023-01-01',
 DATE '2024-01-01'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='besnik@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Apple'),
 'IMEI-B2',
 DATE '2024-04-10',
 DATE '2026-04-10'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='besnik@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='TV'),
 (SELECT marka_id FROM marka WHERE emer='LG'),
 'SN-TV-B3',
 DATE '2022-06-01',
 DATE '2024-06-01'
);


--KLIENT 3
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='celia@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Samsung'),
 'IMEI-C1',
 DATE '2025-02-02',
 DATE '2027-02-02'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='celia@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Frigorifer'),
 (SELECT marka_id FROM marka WHERE emer='Bosch'),
 'SN-FRG-C2',
 DATE '2023-12-01',
 DATE '2025-12-01'
);


--KLIENT 4
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='dorian@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='TV'),
 (SELECT marka_id FROM marka WHERE emer='LG'),
 'SN-TV-D1',
 DATE '2023-05-05',
 DATE '2025-05-05'
);


--KLIENT 5
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ema@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Lavatrice'),
 (SELECT marka_id FROM marka WHERE emer='Bosch'),
 'SN-LAV-E1',
 DATE '2024-01-01',
 DATE '2026-01-01'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ema@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Apple'),
 'IMEI-E2',
 DATE '2024-12-12',
 DATE '2026-12-12'
);


--KLIENT 6
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='florian@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Laptop'),
 (SELECT marka_id FROM marka WHERE emer='Dell'),
 'SN-F1',
 DATE '2023-03-03',
 DATE '2025-03-03'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='florian@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Samsung'),
 'IMEI-F2',
 DATE '2024-01-01',
 DATE '2026-01-01'
);

--KLIENT 7
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='genta@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Lavatrice'),
 (SELECT marka_id FROM marka WHERE emer='Bosch'),
 'SN-LAV-G1',
 DATE '2025-03-03',
 DATE '2027-03-03'
);


--KLIENT 8
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='hektor@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Kondicioner'),
 (SELECT marka_id FROM marka WHERE emer='LG'),
 'SN-KOND-H1',
 DATE '2024-01-01',
 DATE '2026-01-01'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='hektor@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Laptop'),
 (SELECT marka_id FROM marka WHERE emer='Dell'),
 'SN-H2',
 DATE '2024-07-07',
 DATE '2026-07-07'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='hektor@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Apple'),
 'IMEI-H3',
 DATE '2025-05-05',
 DATE '2027-05-05'
);


--KLIENT 9
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ina@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='TV'),
 (SELECT marka_id FROM marka WHERE emer='LG'),
 'SN-TV-I1',
 DATE '2023-03-03',
 DATE '2024-03-03'
);

INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ina@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Samsung'),
 'IMEI-I2',
 DATE '2024-02-02',
 DATE '2026-02-02'
);


--KLIENT 10
INSERT INTO pajisje VALUES (
 seq_pajisje.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='jon@mail.com'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Kondicioner'),
 (SELECT marka_id FROM marka WHERE emer='LG'),
 'SN-KOND-J1',
 DATE '2025-01-01',
 DATE '2027-01-01'
);


--TICKET----------------
INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ariola@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='IMEI-A1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr1'),
 SYSDATE-1,
 'OPEN',
 'Telefoni nuk ndizet pas update',
 'HIGH',
 NULL,NULL,NULL,NULL
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ariola@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-A2'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr2'),
 SYSDATE-10,
 'CLOSED',
 'Laptop me performance te ulet',
 'MED',
 SYSDATE-8,
 'Disk SSD i konsumuar',
 'U zevendesua SSD dhe u instalua OS i ri',
 'N'
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='besnik@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-B1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Vlore Tech+'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_vl'),
 SYSDATE-20,
 'CLOSED',
 'Laptop mbinxehje',
 'HIGH',
 SYSDATE-18,
 'Pastrimi i ventilatorit',
 'U pastrua ventilatori + u vendos paste termike',
 'N'
);



INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='besnik@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-B1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Fier Mix'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_fr1'),
 SYSDATE-70,
 'CLOSED',
 'Laptop mbinxehje (rasti 1)',
 'MED',
 SYSDATE-68,
 'Ventilator i bllokuar',
 'Pastrimi i ventilatorit i thjeshte',
 'N'
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='besnik@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-B1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Fier Mix'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_fr2'),
 SYSDATE-25,
 'CLOSED',
 'Laptop mbinxehje përsëri – rasti i dytë brenda 3 muajve.',
 'HIGH',
 SYSDATE-23,
 'Ventilator shumë i dëmtuar.',
 'U bë zëvendësimi i komplet modulit të ftohjes.',
 'Y'
);



INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='celia@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-FRG-C2'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Shkoder TV Audio'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_sh'),
 SYSDATE-5,
 'OPEN',
 'Frigoriferi nuk ftoh si duhet.',
 'MED',
 NULL,NULL,NULL,NULL
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ema@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-LAV-E1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Durres ElectroHome'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_dr'),
 SYSDATE-14,
 'CLOSED',
 'Lavatrice bën zhurmë gjatë centrifugimit.',
 'LOW',
 SYSDATE-12,
 'Pompe e dëmtuar.',
 'Zëvendësim pompe shkarkimi.',
 'N'
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ema@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='IMEI-E2'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr1'),
 SYSDATE-2,
 'OPEN',
 'Ekrani i telefonit i thyer pas rënie.',
 'HIGH',
 NULL,NULL,NULL,NULL
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='florian@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-F1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Vlore Tech+'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_vl'),
 SYSDATE-30,
 'CLOSED',
 'Laptop kërkon reinstall OS.',
 'MED',
 SYSDATE-28,
 'Software corrupted.',
 'U instalua Windows i ri.',
 'N'
);



INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='florian@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='IMEI-F2'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr2'),
 SYSDATE-3,
 'OPEN',
 'Telefoni nuk mban karikim.',
 'MED',
 NULL,NULL,NULL,NULL
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='genta@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-LAV-G1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Durres ElectroHome'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_dr'),
 SYSDATE-7,
 'OPEN',
 'Lavatrice nuk nxjerr ujin.',
 'HIGH',
 NULL,NULL,NULL,NULL
);



INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='hektor@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-KOND-H1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Elbasan Repair'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_el'),
 SYSDATE-18,
 'CLOSED',
 'Kondicioneri nuk ftoh.',
 'MED',
 SYSDATE-16,
 'Mungesë gazi.',
 'U mbush sistemi me gaz të ri.',
 'N'
);



INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='hektor@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-H2'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Fier Mix'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_fr1'),
 SYSDATE-40,
 'CLOSED',
 'Laptop fiket pa paralajmërim.',
 'MED',
 SYSDATE-38,
 'Bateri e konsumuar.',
 'U zëvendësua bateri origjinale.',
 'N'
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='hektor@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='IMEI-H3'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr1'),
 SYSDATE-6,
 'OPEN',
 'Zëri del shumë ulët.',
 'LOW',
 NULL,NULL,NULL,NULL
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ina@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-TV-I1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Shkoder TV Audio'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_sh'),
 SYSDATE-50,
 'CLOSED',
 'TV nuk ndizet.',
 'HIGH',
 SYSDATE-48,
 'Panel i djegur.',
 'Zëvendësim paneli.',
 'N'
);



INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='ina@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='IMEI-I2'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr2'),
 SYSDATE-4,
 'OPEN',
 'Sensor proximiteti nuk punon.',
 'MED',
 NULL,NULL,NULL,NULL
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='jon@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='SN-KOND-J1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Korce SmartFix'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_ko'),
 SYSDATE-9,
 'OPEN',
 'Kondicioneri pikon ujë.',
 'LOW',
 NULL,NULL,NULL,NULL
);


INSERT INTO ticket VALUES (
 seq_ticket.NEXTVAL,
 (SELECT klient_id FROM klienti WHERE email='celia@mail.com'),
 (SELECT pajisje_id FROM pajisje WHERE serial_imei='IMEI-C1'),
 (SELECT pika_id FROM pika_sherbimi WHERE emertimi='Pika Tirane Mobile'),
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr1'),
 SYSDATE-11,
 'CLOSED',
 'Telefoni bllokohet shpesh.',
 'LOW',
 SYSDATE-10,
 'Overload aplikacionesh.',
 'Pastruar cache, hequr apps të panevojshëm.',
 'N'
);



--DOKUMENTIM------

INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Telefoni Samsung nuk ndizet pas update',
 'Ky problem shkaktohet zakonisht nga një update i dështuar. Zgjidhja: hard reset + reinstalim firmware përmes SmartSwitch.',
 SYSDATE-20,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr1'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Samsung')
);


INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Laptop Dell me SSD të dëmtuar – simptomat',
 'Simptoma: ngadalësim ekstrem, freeze gjatë boot. Zgjidhja: kontroll SMART + zëvendësim SSD + klonim i të dhënave.',
 SYSDATE-18,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_vl'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Laptop'),
 (SELECT marka_id FROM marka WHERE emer='Dell')
);


INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Laptop Dell me SSD të dëmtuar – simptomat',
 'Simptoma: ngadalësim ekstrem, freeze gjatë boot. Zgjidhja: kontroll SMART + zëvendësim SSD + klonim i të dhënave.',
 SYSDATE-18,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_vl'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Laptop'),
 (SELECT marka_id FROM marka WHERE emer='Dell')
);



INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Lavatrice Bosch nuk shkarkon ujë',
 'Shkaku kryesor është pompë shkarkimi e bllokuar ose e djegur. Kontroll: filtri, tubi, më pas matja e rezistencës së pompës.',
 SYSDATE-9,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_dr'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Lavatrice'),
 (SELECT marka_id FROM marka WHERE emer='Bosch')
);


INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Lavatrice Bosch nuk shkarkon ujë',
 'Shkaku kryesor është pompë shkarkimi e bllokuar ose e djegur. Kontroll: filtri, tubi, më pas matja e rezistencës së pompës.',
 SYSDATE-9,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_dr'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Lavatrice'),
 (SELECT marka_id FROM marka WHERE emer='Bosch')
);


INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'TV LG ndizet por nuk ka figurë',
 'Shkaku kryesor: backlight LED i djegur. Kontrolli bëhet me testim të tensionit. Zgjidhja: zëvendësim i shiritave LED.',
 SYSDATE-50,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_sh'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='TV'),
 (SELECT marka_id FROM marka WHERE emer='LG')
);


INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Laptop me OS të dëmtuar – reinstall Windows',
 'Shkak: instalim i ndërprerë, malware ose file system i dëmtuar. Zgjidhja: backup + format + reinstall Windows + update drivers.',
 SYSDATE-28,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_vl'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Laptop'),
 NULL
);


INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Sensor i afërsisë nuk funksionon',
 'Zgjidhja: pastrim i veshjes së sensorit, kalibrim software ose zëvendësim i modulit të proximity sensor.',
 SYSDATE-4,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr2'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 NULL
);



INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Sensor i afërsisë nuk funksionon',
 'Zgjidhja: pastrim i veshjes së sensorit, kalibrim software ose zëvendësim i modulit të proximity sensor.',
 SYSDATE-4,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr2'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 NULL
);


INSERT INTO dokumentim VALUES (
 seq_dokumentim.NEXTVAL,
 'Ekrani i telefonit Apple nuk reagon',
 'Zgjidhja: kontroll digitizer, zëvendësim ekran, testim i flekskabllove. Shpesh shkak nga rënie.',
 SYSDATE-2,
 (SELECT perdorues_id FROM perdorues WHERE username='spr_tr1'),
 (SELECT lloj_pajisje_id FROM lloj_pajisje WHERE emer='Telefon'),
 (SELECT marka_id FROM marka WHERE emer='Apple')
);


-- FATURA

-- FATURA
INSERT INTO fatura VALUES (seq_fatura.NEXTVAL, (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'Laptop mbinxehje' AND status = 'CLOSED' AND ROWNUM = 1), SYSDATE-18, 2000, 'Y');

INSERT INTO fatura VALUES (seq_fatura.NEXTVAL, (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'Laptop mbinxehje (rasti 1)'), SYSDATE-68, 1500, 'Y');

INSERT INTO fatura VALUES (seq_fatura.NEXTVAL, (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'TV nuk ndizet.'), SYSDATE-48, 6000, 'Y');

INSERT INTO fatura VALUES (seq_fatura.NEXTVAL, (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'Laptop kërkon reinstall OS.'),SYSDATE-35, 5000, 'Y' );


-- FATURA_DETAJE
INSERT INTO fatura_detaje VALUES ((SELECT fatura_id FROM fatura WHERE ticket_id = (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'Laptop mbinxehje' AND status = 'CLOSED' AND ROWNUM = 1)), (SELECT sherbim_id FROM lloj_sherbimi WHERE emer = 'Diagnostikim'), 1, 500, 500);

INSERT INTO fatura_detaje VALUES ((SELECT fatura_id FROM fatura WHERE ticket_id = (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'Laptop mbinxehje' AND status = 'CLOSED' AND ROWNUM = 1)), (SELECT sherbim_id FROM lloj_sherbimi WHERE emer = 'Pastrimi i ventilatorit'), 1, 1500, 1500);

INSERT INTO fatura_detaje VALUES ((SELECT fatura_id FROM fatura WHERE ticket_id = (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'Laptop mbinxehje (rasti 1)')), (SELECT sherbim_id FROM lloj_sherbimi WHERE emer = 'Pastrimi i ventilatorit'), 1, 1500, 1500);

INSERT INTO fatura_detaje VALUES ((SELECT fatura_id FROM fatura WHERE ticket_id = (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'TV nuk ndizet.')), (SELECT sherbim_id FROM lloj_sherbimi WHERE emer = 'Nderrim Ekrani'), 1, 6000, 6000);

INSERT INTO fatura_detaje VALUES ((SELECT fatura_id FROM fatura WHERE ticket_id= (SELECT ticket_id FROM ticket WHERE pershkrim_problemi = 'Laptop kërkon reinstall OS.')), (SELECT sherbim_id FROM lloj_sherbimi WHERE emer = 'Update software'), 1, 7000, 7000);

COMMIT;
