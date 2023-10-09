# Beispiellösung für Selbstkontrollfragen aus Einheit (2) "R und RStudio
# Grundlagen" des Kurses "Programmierung und Deskriptive Statistik" im WS 22/23
#
# Author: Belinda Fleischmann

# ------ SKF 3 ---------------------------------
# Die Basics
print("Hallo Welt!")        # Textausgabe
print("Hallo R!")           # Begrüße R

# Arithmetische Operatoren
3 + 9                       # Addition
2 - 7                       # Subtraktion
3 * 2                       # Multiplikation
6 / 2                       # Division
2^3                         # Potenz mithilfe des Symbols ^
2**3                        # Potenz mithilfe des Symbols **
5 %/% 2                     # Ganzzahlige Teilung
5 %% 2                      # Modulo

# Logische Operatoren
2 == 3                      # Auswertung der Aussage '2 gleich 3'
2 != 3                      # Auswertung von '2 ungleich 3'
2 < 3                       # Auswertung von '2 kleiner als 3'
2 > 2                       # Auswertung von '2 groesser als 2'
4 <= 3                      # Auswertung von '4 kleiner gleich 3'
4 >= 4                      # Auswertung von '4 goesser gleich 4'
2 < 3 | 2 > 2               # Gilt EINE ODER BEIDE dieser Aussagen? (inklusiv)
xor(2 < 3, 2 > 2)           # Gilt EINE (nicht beide!) der Aussagen? (exklusiv) 
xor(2 < 3, 2 > 1)           # Gilt EINE (nicht beide!) der Aussagen? (exklusiv) 
2 < 3 & 2 > 2               # Gelten BEIDE (nicht nur eine!) Aussagen?
2 < 3 & 2 == 2              # Gelten BEIDE (nicht nur eine!) Aussagen?

# Mathematische Funktionen
abs(-3)                     # Betrag
sqrt(9)                     # Wurzel
ceiling(2.5)                # Aufrunden
floor(2.5)                  # Abrunden
round(2.5)                  # Mathematisches Runden
exp(1)                      # Wert der Exponentialfunktion für x = 1
log(1)                      # Wert der Logarithmusfunktion für x = 1

# Infixnotation von Operatoren (paar Beispiele)
`+`(2, 2)                   # Addition
`-`(2, 3)                   # Subtraktion
`*`(2, 4)                   # Multiplikation
`/`(2, 0.5)                 # Division

# Operatorpräzendez
?Syntax                     # Operator Syntax and Precedence in R anzeigen
2^2^3                       # Rechts-nach-links bei Potenzen
(2^2)^3                     # Überschreiben der rechts-nach-links Präzedenz
-1^2                        # Potenz vor unitärem Vorzeichen
(-1)^2                      # Überschreiben der Präzedenz Potenz-vor-Vorzeichen
2+3/4*5                     # 2+(3/4)*5 = 2+(0.75*5) = 2+3.75 = 5.75
2+3/(4*5)                   # 2+3/(4*5) = 2+3/20 = 2+0.15 = 2.15

# Variablenzuweisung
a = 1                      # a ist eine Variable vom Typ double, ihr Wert ist 1

# Das Gretchenbeispiel
hefte = 4                    # Definition der Variable 'hefte' und Wertzuweisung 4
stifte = 2                   # Definition der Variable 'stifte' und Wertzuweisung 2
fueller = 1                  # Definition der Variable 'fueller' und Wertzuweisung 1
gesamt = (                   # Berechnung der Gegenstandsanzahl
  hefte + stifte + fueller
  )  
gesamtpreis = (              # Berechung des Preises
  hefte*1 
  + stifte*2 
  + fueller*10
  )   
print(gesamt)                      
print(gesamtpreis)

# Workspace
ls()                         # Anzeigen aller Variablennamen im Workspace
rm(gesamtpreis)              # Löschen der Variable Gesamtpreis
rm(list = ls())              # Löschen aller Variablen

# Speicheradressen anzeigen
library(lobstr)              # Paket 'lobstr' laden
x = 1                        
obj_addr(x)
y = 1
obj_addr(y)
