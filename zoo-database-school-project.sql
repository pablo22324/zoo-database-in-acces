-- glowna_finanse query - creates balance of the zoo
SELECT k_sumowanie_zyski.zyski, k_sumowanie_wydatki.wydatki, k_sumowanie_pensji.[Wydatki na pracownikow], [zyski]-[wydatki]-[Wydatki na pracownikow] AS bilans_finansowy
FROM k_sumowanie_zyski, k_sumowanie_wydatki, k_sumowanie_pensji
GROUP BY k_sumowanie_zyski.zyski, k_sumowanie_wydatki.wydatki, k_sumowanie_pensji.[Wydatki na pracownikow], [zyski]-[wydatki]-[Wydatki na pracownikow];
-- k_firmy_i_towary - returns information about suppliers and their products
SELECT dostawcy.nip, dostawcy.regon, dostawcy.nazwa_firmy, towar.rodzaj_pozywienia, towar.marka_pozywienia, towar.ilosc_porcji, towar.cena_za_porcje
FROM dostawcy LEFT JOIN towar ON dostawcy.id_dostawcy = towar.id_dostawcy;
-- k_licznik_zwierzat_na_wybiegach counts the amount of animals on every enclosure
SELECT Count(zwierzeta.id_wybiegu) AS PoliczOfid_wybiegu, zwierzeta.id_gatunku
FROM zwierzeta
GROUP BY zwierzeta.id_gatunku;
-- simple queries that are just adding up data together
SELECT Round([rozmiar]/6)-1 AS ile_zwierzat, wybieg.rozmiar, wybieg.id_wybiegu
FROM wybieg;
--
SELECT stanowiska.id_stanowiska, Sum(stanowiska.pensja) AS SumaOfpensja
FROM stanowiska LEFT JOIN handlowcy ON stanowiska.id_stanowiska = handlowcy.id_stanowiska
GROUP BY stanowiska.id_stanowiska
HAVING (((stanowiska.id_stanowiska) Like 1));
--
SELECT stanowiska.id_stanowiska, Sum(stanowiska.pensja) AS SumaOfpensja
FROM stanowiska LEFT JOIN lekarze ON stanowiska.id_stanowiska = lekarze.id_stanowiska
GROUP BY stanowiska.id_stanowiska
HAVING (((stanowiska.id_stanowiska) Like 3));
--
SELECT stanowiska.id_stanowiska, Sum(stanowiska.pensja) AS SumaOfpensja
FROM stanowiska LEFT JOIN opiekun ON stanowiska.id_stanowiska = opiekun.id_stanowiska
GROUP BY stanowiska.id_stanowiska
HAVING (((stanowiska.id_stanowiska) Like 2));
--
SELECT towar.id_pozywienia, towar.rodzaj_pozywienia, towar.marka_pozywienia, towar.ilosc_porcji, towar.cena_za_porcje, [ilosc_porcji]*[cena_za_porcje] AS laczna_cena
FROM towar
GROUP BY towar.id_pozywienia, towar.rodzaj_pozywienia, towar.marka_pozywienia, towar.ilosc_porcji, towar.cena_za_porcje, [ilosc_porcji]*[cena_za_porcje];
--
SELECT k_pomocnicza_pensje_handlowcy.SumaOfpensja, k_pomocnicza_pensje_lekarzy.SumaOfpensja, k_pomocnicza_pensji_opieknow.SumaOfpensja, [k_pomocnicza_pensje_handlowcy]![SumaOfpensja]+[k_pomocnicza_pensje_lekarzy]![SumaOfpensja]+[k_pomocnicza_pensji_opieknow]![SumaOfpensja] AS [Wydatki na pracownikow]
FROM k_pomocnicza_pensje_lekarzy, k_pomocnicza_pensji_opieknow, k_pomocnicza_pensje_handlowcy;
--
SELECT Sum(k_pomocnicza_wydatki.laczna_cena) AS wydatki
FROM k_pomocnicza_wydatki;
--
SELECT Sum(kwoty_biletow.laczna_cena) AS zyski
FROM kwoty_biletow;
--

--query that shows detailed information about habitat of enclosure
SELECT wybieg.id_wybiegu, wybieg.rozmiar, zwierzeta.id_zwierzecia, zwierzeta.imie_zwierzecia, zwierzeta.plec, IIf([k_pomocnicza_liczenie_miejsca]!ile_zwierzat>0,[k_pomocnicza_liczenie_miejsca]!ile_zwierzat,"małe_zwierze") AS ile_moze_byc_na_wybiegu, IIf([k_pomocnicza_liczenie_miejsca]!ile_zwierzat>0,[k_pomocnicza_liczenie_miejsca]!ile_zwierzat-k_licznik_zwierzat_na_wybiegach!PoliczOfid_wybiegu,"-") AS ile_miejsca_zostalo
FROM (wybieg INNER JOIN k_pomocnicza_liczenie_miejsca ON wybieg.id_wybiegu = k_pomocnicza_liczenie_miejsca.id_wybiegu) LEFT JOIN (zwierzeta LEFT JOIN k_licznik_zwierzat_na_wybiegach ON zwierzeta.id_gatunku = k_licznik_zwierzat_na_wybiegach.id_gatunku) ON wybieg.id_wybiegu = zwierzeta.id_wybiegu;
