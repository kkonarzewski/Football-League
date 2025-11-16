--zawodnicy, którzy grali w meczu
SELECT distinct zawodnik.id_zawodnika, imie, nazwisko
   FROM zawodnik, gra
   WHERE zawodnik.id_zawodnika=gra.id_zawodnika;

--zawodnicy, którzy strzelili bramkę
SELECT distinct zawodnik.id_zawodnika, imie, nazwisko
   FROM zawodnik inner join bramka
   on zawodnik.id_zawodnika=bramka.id_zawodnika;

--zawodnicy i liczba strzelonych przez nich bramek
select zawodnik.id_zawodnika, imie, nazwisko, count(bramka.id_zawodnika) as "ile zdobyl" 
from zawodnik left join bramka 
on zawodnik.id_zawodnika=bramka.id_zawodnika 
group by zawodnik.id_zawodnika, imie, nazwisko;

--średnia liczba kibiców na meczu, gdzie dana drużyna pełniła funkcję gospodarza
select nazwa, sum(ilosc_widzow)/count(gospodarz) as "srednia liczba widzow" 
from mecz, klub 
where id_klub=gospodarz 
group by gospodarz, nazwa;


--zawodnicy, którzy nie pochodzą z Polski
select * from zawodnik where narodowosc != 'Polska';

--kluby, które nie pełniły funkcji gospodarza w żadnym meczu
select * from klub
where id_klub not in (
  select gospodarz from mecz);

--zawodnicy, którzy są wychowankami jakiś klubów
select * from zawodnik where jest_wychowankiem is not null;

--kluby, które nie pełniły funkcji gościa
SELECT * FROM klub WHERE NOT EXISTS (SELECT * FROM mecz WHERE klub.id_klub=gosc);

--usuwanie trenerów, którzy nie pracują w żadnym klubie
delete from trener where id_klub is null;

--dodanie 1000 miejsc do stadionów, które miały między 2000 a 4000 miejsc
UPDATE stadion SET ilosc_miejsc = ilosc_miejsc+1000
WHERE ilosc_miejsc BETWEEN 2000 and 4000;