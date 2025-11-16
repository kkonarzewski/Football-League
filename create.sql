create table stadion
(
    id_stadion          char(6)         not null,
    ilosc_miejsc        int             not null,
    miasto              varchar(32)     not null,
    ulica               varchar(32)     not null,
    nr_budynku          varchar(10)             ,
    CONSTRAINT stadion_id_stadion_pk PRIMARY KEY(id_stadion)
);

create table klub
(
    id_klub             char(6)         not null,
    nazwa               varchar(32)     not null,
    rok_zalozenia       char(4)         not null,
    id_stadion          char(6)         not null,
    CONSTRAINT klub_id_klub_pk PRIMARY KEY(id_klub),
    CONSTRAINT klub_id_stadion_fk FOREIGN KEY(id_stadion)
    REFERENCES stadion(id_stadion)
    on update cascade on delete cascade
);

create table trener
(
    id_trenera          char(6)         not null,
    data_urodzenia      date            not null,
    miejsce_urodzenia   varchar(32)     not null,
    imie                varchar(32)             ,
    nazwisko            varchar(32)     not null,
    pensja              varchar(32)             ,
    id_klub             char(6)                 ,
    CONSTRAINT trener_id_trenera_pk PRIMARY KEY(id_trenera),
    CONSTRAINT trener_id_klub_fk FOREIGN KEY(id_klub)
    REFERENCES klub(id_klub)
    on update cascade on delete set null
);

create table zawodnik
(
    id_zawodnika        char(6)         not null,
    data_urodzenia      date            not null,
    miejsce_urodzenia   varchar(32)     not null,
    narodowosc          varchar(32)     not null,
    imie                varchar(32)             ,
    nazwisko            varchar(32)     not null,
    pensja              varchar(32)             ,
    ma_kontrakt         char(6)                 ,
    jest_wychowankiem   char(6)                 ,
    CONSTRAINT zawodnik_id_zawodnika_pk PRIMARY KEY(id_zawodnika),
    CONSTRAINT zawodnik_ma_kontrakt_fk FOREIGN KEY(ma_kontrakt)
    REFERENCES klub(id_klub)
    on update cascade on delete set null,
    CONSTRAINT zawodnik_jest_wychowankiem_fk FOREIGN KEY(jest_wychowankiem)
    REFERENCES klub(id_klub)
    on update cascade on delete set null
);

create table mecz
(
    id_mecz             char(6)         not null,
    ilosc_widzow        int             not null,
    godz_rozpoczecia    char(5)         not null,
    id_stadion          char(6)         not null,
    gospodarz           char(6)         not null,  
    gosc                char(6)         not null,
    CONSTRAINT mecz_id_mecz_pk PRIMARY KEY(id_mecz),
    CONSTRAINT mecz_id_stadion_fk FOREIGN KEY(id_stadion)
    REFERENCES stadion(id_stadion)
    on update cascade on delete cascade,
    CONSTRAINT mecz_gospodarz_fk FOREIGN KEY(gospodarz)
    REFERENCES klub(id_klub)
    on update cascade on delete cascade,
    CONSTRAINT mecz_gosc_fk FOREIGN KEY(gosc)
    REFERENCES klub(id_klub)
    on update cascade on delete cascade
);

create table bramka
(
    id_bramki           char(6)         not null,
    czy_samobójcza      boolean         not null,
    minuta              varchar(6)      not null,
    id_zawodnika        char(6)         not null,
    id_mecz             char(6)         not null,
    CONSTRAINT bramka_id_bramki_pk PRIMARY KEY(id_bramki),
    CONSTRAINT bramka_id_zawodnika_fk FOREIGN KEY(id_zawodnika)
    REFERENCES zawodnik(id_zawodnika)
    on update cascade on delete cascade,
    CONSTRAINT bramka_id_mecz_fk FOREIGN KEY(id_mecz)
    REFERENCES mecz(id_mecz)
    on update cascade on delete cascade
);

create table gra
(
    id_zawodnika        char(6)         not null,
    id_mecz             char(6)         not null,
    CONSTRAINT gra_id_zawodnika_fk FOREIGN KEY(id_zawodnika)
    REFERENCES zawodnik(id_zawodnika)
    on update cascade on delete cascade,
    CONSTRAINT gra_id_mecz_fk FOREIGN KEY(id_mecz)
    REFERENCES mecz(id_mecz)
    on update cascade on delete cascade
)