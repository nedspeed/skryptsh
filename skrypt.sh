#!/bin/bash

#skrypt wykonujacy operacje porzadkowe na plikach ze zdjeciami
#pierwszy argument to katalog ze zdjeciami, drugi argument to szerokosc zdjecia, trzeci argument to wysokosc zdjecia

#kopiuje z katalogu pliki w formacie JPEG/PNG i zmienia plikom rozszerzenia na pisane malymi literami
#zastepuje spacje w nazwach na podkreslenia
#zmienia rozmiar zdjec do wskazanego argumentem podanym w wywolaniu skryptu
#tworzy archiwum z tych plikow
cd $1   #przenosimy sie do miejsca zawierajacego obrazy wskazanego przez uzytkownika w pierwszym argumencie
mkdir tmp   #ukierunkowanie ponizszych zmian plikow na tmp(tymczasowy katalog)

for i in *.JPEG;   #dla poszczegolnego pliku(i) z rozszerzeniem JPEG
   do
    nowa_nazwa=$(echo $i | tr -s 'JPEG' 'jpeg' | tr -s ' ' '_')   #wystepujace w nazwie litery JPEG zastepujemy malymi i przestrzenie zastepujemy podkreslnikami
    cp -r $i tmp/$nowa_nazwa   #kopiujemy obraz ale pod zmieniona nazwa na spelniajaca warunki j.w.
    convert -resize $2x$3 $i tmp/$nowa_nazwa
done
 #convert -resize $2x$3 $i tmp/$nowa_nazwa
  for i in *.PNG;   #dla poszczegolnego pliku(j) z rozszerzeniem PNG
     do
      new_name=$(echo $i | tr -s 'PNG' 'png' | tr -s ' ' '_')   #wystepujace w nazwie litery PNG zastepujemy malymi i przestrzenie zastepujemy podkreslnikami
       cp -r $i tmp/$new_name   #kopiujemy obraz pod zmieniona nazwa na spelniajaca warunki j.w.
        convert -resize $2x$3 $i tmp/$new_name
       done
       #convert -resize $2x$3 $i tmp/$new_name
  tar -cvpf arch.tar.gz tmp   #archiwizujemy wszystkie skopiowane i zmodyfikowane pliki(c-tworzy nowe archiwum, v-zachowanie info o prawach dostepu
  rm -rf tmp   #bezwarunkowo usuwamy tymczasowy katalog                               # p-zachowuje info o prawach dostepu, f-odczytuje/zapisuje dane z pliku)
  #archiwizacja nastepuje wraz z kompresja w formacie gzip
