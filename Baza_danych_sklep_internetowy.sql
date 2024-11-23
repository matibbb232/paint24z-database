SET check_function_bodies = false
;

CREATE TYPE "Status_zamowienia" AS ENUM('pending', 'shipped', 'delivered');

CREATE TYPE "Plec" AS ENUM('K','M');

CREATE TABLE "Administrator"(
id integer NOT NULL, "Pracownik_id" integer NOT NULL,
  CONSTRAINT "Administrator_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Adres"(
  id integer NOT NULL,
  "Kraj" varchar(30) NOT NULL,
  "Miasto" varchar(30) NOT NULL,
  "Ulica" varchar(30) NOT NULL,
  "Numer_budynku" varchar(5) NOT NULL,
  "Numer_lokalu" varchar(4),
  "Kod_pocztowy" varchar(6) NOT NULL,
  "Sklep_id" integer NOT NULL,
  "Klient_id" integer NOT NULL,
  "Pracownik_id" integer NOT NULL,
  CONSTRAINT "Adres_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Kategoria"(
  id integer NOT NULL,
  "Nazwa" varchar(50) NOT NULL,
  "Opis" text NOT NULL,
  "Produkt_id" integer NOT NULL,
  CONSTRAINT "Kategoria_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Klient"(
  id integer NOT NULL,
  "Adres_email" varchar(30) NOT NULL,
  "Numer_telefonu" varchar(15) NOT NULL,
  "Imie" varchar(30) NOT NULL,
  "Nazwisko" varchar(50) NOT NULL,
  "Plec" "Plec" NOT NULL,
  "Uzytkownik_id" integer NOT NULL,
  "Sklep_id" integer NOT NULL,
  CONSTRAINT "Klient_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Magazyn"(
  id integer NOT NULL,
  "Pojemnosc" integer NOT NULL,
  "Sklep_id" integer NOT NULL,
  "Adres_id" integer NOT NULL,
  CONSTRAINT "Magazyn_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Miejsce_w_magazynie"(
  id integer NOT NULL,
  "Produkt_id" integer NOT NULL,
  "Magazyn_id" integer NOT NULL,
  CONSTRAINT "Miejsce_w_magazynie_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Operator"(
id integer NOT NULL, "Pracownik_id" integer NOT NULL,
  CONSTRAINT "Operator_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Pracownik"(
  id integer NOT NULL,
  "Imie" varchar(30) NOT NULL,
  "Nazwisko" varchar(50) NOT NULL,
  "Data_urodzenia" date NOT NULL,
  "Pesel" char(11) NOT NULL,
  "Data_zatrudnienia" date NOT NULL,
  "Adres_email" varchar(30) NOT NULL,
  "Numer_telefonu" varchar(15) NOT NULL,
  "Numer_konta" char(26),
  "Uzytkownik_id" integer NOT NULL,
  "Sklep_id" integer NOT NULL,
  CONSTRAINT "Pracownik_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Producent"(
  id integer NOT NULL,
  "Nazwa" varchar(30) NOT NULL,
  "Produkt_id" integer NOT NULL,
  CONSTRAINT "Producent_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Produkt"(
  id integer NOT NULL,
  "Nazwa" varchar(100) NOT NULL,
  "Opis" text NOT NULL,
  "Cena" money NOT NULL,
  "Sklad" integer NOT NULL,
  "Sklep_id" integer NOT NULL,
  "Waga" internal NOT NULL,
  CONSTRAINT "Produkt_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Sklep"(
  id integer NOT NULL,
  "Nazwa" varchar(30) NOT NULL,
  "Adres_email" varchar(30) NOT NULL,
  "Numer_telefonu" varchar(15) NOT NULL,
  "NIP" integer(10) NOT NULL,
  CONSTRAINT "Sklep_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Szczegoly_zamowienia"(
  id integer NOT NULL,
  "Zamowienie_id" integer NOT NULL,
  "Produkt_id" integer NOT NULL,
  CONSTRAINT "Szczegoly_zamowienia_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Uzytkownik"(
  id integer NOT NULL,
  "Login" varchar(30) NOT NULL,
  "Haslo" varchar(50) NOT NULL,
  "Data_zalozenia" date NOT NULL,
  CONSTRAINT "Uzytkownik_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Zamowienie"(
  id integer NOT NULL,
  "Kwota" money NOT NULL,
  "Status" "Status_zamowienia" NOT NULL,
  "Data_zamowienia" date NOT NULL,
  "Data_wysylki" date NOT NULL,
  "Klient_id" integer NOT NULL,
  "Historia" varchar,
  CONSTRAINT "Zamowienie_pkey" PRIMARY KEY(id)
);

ALTER TABLE "Pracownik"
  ADD CONSTRAINT "Pracownik_Uzytkownik_id_fkey"
    FOREIGN KEY ("Uzytkownik_id") REFERENCES "Uzytkownik" (id);

ALTER TABLE "Klient"
  ADD CONSTRAINT "Klient_Uzytkownik_id_fkey"
    FOREIGN KEY ("Uzytkownik_id") REFERENCES "Uzytkownik" (id);

ALTER TABLE "Administrator"
  ADD CONSTRAINT "Administrator_Pracownik_id_fkey"
    FOREIGN KEY ("Pracownik_id") REFERENCES "Pracownik" (id);

ALTER TABLE "Operator"
  ADD CONSTRAINT "Operator_Pracownik_id_fkey"
    FOREIGN KEY ("Pracownik_id") REFERENCES "Pracownik" (id);

ALTER TABLE "Klient"
  ADD CONSTRAINT "Klient_Sklep_id_fkey"
    FOREIGN KEY ("Sklep_id") REFERENCES "Sklep" (id);

ALTER TABLE "Pracownik"
  ADD CONSTRAINT "Pracownik_Sklep_id_fkey"
    FOREIGN KEY ("Sklep_id") REFERENCES "Sklep" (id);

ALTER TABLE "Produkt"
  ADD CONSTRAINT "Produkt_Sklep_id_fkey"
    FOREIGN KEY ("Sklep_id") REFERENCES "Sklep" (id);

ALTER TABLE "Magazyn"
  ADD CONSTRAINT "Magazyn_Sklep_id_fkey"
    FOREIGN KEY ("Sklep_id") REFERENCES "Sklep" (id);

ALTER TABLE "Producent"
  ADD CONSTRAINT "Producent_Produkt_id_fkey"
    FOREIGN KEY ("Produkt_id") REFERENCES "Produkt" (id);

ALTER TABLE "Adres"
  ADD CONSTRAINT "Adres_Sklep_id_fkey"
    FOREIGN KEY ("Sklep_id") REFERENCES "Sklep" (id);

ALTER TABLE "Adres"
  ADD CONSTRAINT "Adres_Klient_id_fkey"
    FOREIGN KEY ("Klient_id") REFERENCES "Klient" (id);

ALTER TABLE "Kategoria"
  ADD CONSTRAINT "Kategoria_Produkt_id_fkey"
    FOREIGN KEY ("Produkt_id") REFERENCES "Produkt" (id);

ALTER TABLE "Zamowienie"
  ADD CONSTRAINT "Zamowienie_Klient_id_fkey"
    FOREIGN KEY ("Klient_id") REFERENCES "Klient" (id);

ALTER TABLE "Adres"
  ADD CONSTRAINT "Adres_Pracownik_id_fkey"
    FOREIGN KEY ("Pracownik_id") REFERENCES "Pracownik" (id);

ALTER TABLE "Magazyn"
  ADD CONSTRAINT "Magazyn_Adres_id_fkey"
    FOREIGN KEY ("Adres_id") REFERENCES "Adres" (id);

ALTER TABLE "Miejsce_w_magazynie"
  ADD CONSTRAINT "Miejsce_w_magazynie_Produkt_id_fkey"
    FOREIGN KEY ("Produkt_id") REFERENCES "Produkt" (id);

ALTER TABLE "Miejsce_w_magazynie"
  ADD CONSTRAINT "Miejsce_w_magazynie_Magazyn_id_fkey"
    FOREIGN KEY ("Magazyn_id") REFERENCES "Magazyn" (id);

ALTER TABLE "Szczegoly_zamowienia"
  ADD CONSTRAINT "Szczegoly_zamowienia_Zamowienie_id_fkey"
    FOREIGN KEY ("Zamowienie_id") REFERENCES "Zamowienie" (id);

ALTER TABLE "Szczegoly_zamowienia"
  ADD CONSTRAINT "Szczegoly_zamowienia_Produkt_id_fkey"
    FOREIGN KEY ("Produkt_id") REFERENCES "Produkt" (id);
