Tabacu Andrei Antonio 334AB

Algoritmul pe care l-am folosit este bazat pe urmarirea peretelui din dreapta.

Verific intai daca in dreapta am sau nu zid. Daca nu am, atunci voi schimba directia de mers in dreapta. Realizez doar o schimbare a orientarii de mers momentan, deplasarea pe urmatorul element facundu-se mai tarziu. Daca am zid in dreapta voi trece la urmatorul pas fara a schimba directia de mers.

Urmatorul pas este sa verific elementul din fata. Daca in fata nu am zid atunci nu modific directia de mers. Daca in fata am zid atunci voi realiza schimbarea orientarii spre stanga, zidul intalnit in fata devenind noul zid din dreapta pe care il urmez.

Urmatorul pas este de a ma deplasa pe elementul din fata. In urma ajustarilor orientarii facute anterior ma pot deplasa in fata si pastrez zidul in dreapta mea.

Ca si implementare in cod am avut nevoie de 6 stari pe langa cea de initializare facuta in default:

Starea 1: preiau coordonatele elementului din dreapta pe care il voi verifica in urmatoarea stare.

Starea 2: verific valoarea elementului din dreapta si realizez turn-ul la dreapta daca este necesar. Fie ca fac sau nu turn-ul voi trece in starea 3.

Starea 3: analog, preiau coordonatele elementului din fata pe care il voi verifica in starea urmatoare.

Starea 4: verific elementul din fata. Daca pot merge in fata voi trece direct in starea urmatoarea in care realizez deplasarea in fata. Daca in fata este zid, voi realiza turn-ul la stanga si ma voi intoarce in starea 3 pentru reluarea procesului de verificare a elementului din fata. (verificarea la dreapta nu este necesara, zidul din fata devenind zidul din dreapta in urma turn-ului la stanga)

Starea 5: marchez cu 2 elementul curent si realizez deplasarea pe elementul din fata. Daca elementul pe care tocmai m-am mutat se afla pe o linie sau coloana de margine atunci am labirintul s-a incheiat si voi trece in starea urmatoare pentru a incheia algoritmul. Daca nu, atunci voi relua algoritmul de la starea 1.

Starea 6: Marchez si acest ultim element si opresc parcurgerea labirintului.

Pentru orientarea in labirint am folosit variabila direction cu valori pentru fiecare punct cardinal atribuite in sens invers trigonometric de la 0 la 3: S-0 W-1 N-2 E-3. Pentru turn-urile intr-o anumita directie, adaugand sau scazand 1 variabilei se realizeaza schimbarea directiei de orientare in sensul dorit.