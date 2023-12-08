# Beispiellösung für Selbstkontrollfragen aus Einheit (3) "Vektoren"
# des Kurses "Programmierung und Deskriptive Statistik" im WS 23/24
#
# Autorin: Belinda Fleischmann

# ========== SKF 1 ==========================================================

# ------Erzeugung einelementiger Vektoren------
# Double
h <- 1
i <- 2.1e2
j <- 2.1e-2
k <- Inf
l <- NaN

# Integer
x <- 1L
y <- 200L

# Logical
x <- TRUE    # best pactice: TRUE und FALSE ausschreiben, statt T und F
y <- F       # geht auch; manchmal aus Platzgründen praktischer

# Character
x <- "a"     # best practice: double-quotes
y <- 'test'  # geht auch

# ------Erzeugung mehrelementiger Vektoren------
# Direkte Konkatenation
x <- c(1, 2, 3)              # numeric vector [1,2,3]
y <- c(0, x, 4)              # numeric vector [0,1,2,3,4]
s <- c("a", "b", "c")        # character vector ["a", "b", "c"]
l <- c(TRUE, FALSE)          # logical vector [TRUE, FALSE]
x <- c(1, "a", TRUE)         # character vector ["1", "a", "TRUE"]

# Erzeugung "leerer" Vektoren
v <- vector("double", 3)     # double vector [0,0,0]
w <- vector("integer", 3)    # integer vector [0,0,0]
l <- vector("logical", 2)    # logical vector [FALSE, FALSE]
s <- vector("character", 4)  # character vector ["", "", "", ""]

# Erzeugen “leerer” Vektoren mit double(), integer(), logical(), character()
v <- double(3)               # double vector [0,0,0]
w <- integer(3)              # integer vector [0,0,0]
l <- logical(2)              # logical vector [FALSE, FALSE]
s <- character(4)            # character vector ["", "", "", ""]

# ------Erzeugung von Vektoren als Sequenzen------
x <- 0:5                     # [0,1,2,3,4,5]
y <- 1.5:6.1                 # [1.5, 2.5, 3.5, 4.5, 5.5]

x_1 <- seq(0, 5)             # wie 0:5, [0,1,2,3,4,5]
x_2 <- seq(0, 1, len <- 5)   # 5 Zahlen zw. 0 (inkl.) und 1 (inkl.), equidistant
x_3 <- seq(0, 2, by <- .15)  # 0.15 Schritte zwischen 0 (inkl.) und 2 (max.)
x_4 <- seq(1, 0, by <- -.1)  # -0.1 Schritte zwischen 1 (inkl.) und 0 (min.)

x_1 <- seq.int(0, 5)           # wie 0:5, [0,1,2,3,4,5]
x_2 <- seq_len(5)              # Natuerliche Zahlen bis 5, [1,2,3,4,5]
x_3 <- seq_along(c("a", "b"))  # wie seq_len(length(c("a", "b")))

# ------Charakterisierung------
# Länge
x <- 0:10
length(x)        # Anzahl der Elemente des Vektors

# Datentyp
x <- 1:3L
typeof(x)        # Datentyp des atomic Vektors

y <- c(TRUE, FALSE, TRUE)
typeof(y)        # Datentyp des atomic vectors

is.double(x)     # Testen, ob der x vom Typ double ist
is.logical(y)    # Testen, ob der y vom Typ logical ist

x <- c(1.2, "a") # Kombination gemischter Datentypen (character schlaegt double)
typeof(x)        # Erzeugter Vektor ist vom Datentyp character

y <- c(1L, TRUE) # Kombination  gemischter Datentypen (integer schlaegt logical)
typeof(y)        # Erzeugter Vektor ist vom Typ integer

# Datentypangleichung (Coercion)
x <- c(0, 1, 1, 0)               # double Vektor
y <- as.logical(x)               # explicit coercion
x <- c(TRUE, FALSE, TRUE, TRUE)  # logical Vektor
s <- sum(x) # Summation in integer gewandelter logical Elemente
            # (implicit coercion)

# ------Indizierung------
x <- c("a", "b", "c")    # character vector ["a", "b", "c"]
y <- x[2]                # Kopie von "b" in y
x[3] <- "d"              # Aenderung von x zu x <- ["a", "b", "d"]

# Indizierung mit einem Vektor positiver Zahlen
x <- c(1, 4, 9, 16, 25)  # [1,4,9,16,25] <- [1^2, 2^2, 3^2, 4^2, 5^2]
y <- x[1:3]          # 1:3 erzeugt Vektor [1,2,3], x[1:3] = x[1,2,3] = [1,4,9]
z <- x[c(1, 3, 5)]   # c(1,3,5) erzeugt Vektor [1,3,5], x[c(1,3,5)] = [1,9,25]

# Indizierung mit einem Vektor negativer Zahlen
x <- c(1, 4, 9, 16, 25)    # [1,4,9,16,25] = [1^2, 2^2, 3^2, 4^2, 5^2]
y <- x[c(-2, -4)]      # Alle Komponenten ausser 2 und 4, x[c(-2,-4)] = [1,9,25]
# z <- x[c(-1,2)]      # Gemischte Indizierung nicht erlaubt (Fehlermeldung)
# Anmerkung: die obere zeile ist rauskommentiert, damit dieses Skript ohne
# Fehlermeldung durchlaufen kann. Um den Fehler zu reproduzieren,
# einfach den hashtag vor `z <- x[c(-1,2)]` entfernen

# Indizierung mit einem logischen Vektor
x <- c(1, 4, 9, 16, 25)   # [1,4,9,16,25] = [1^2, 2^2, 3^2, 4^2, 5^2]
y <- x[c(T, T, F, F, T)]  # TRUE Komponenten, x[c(T,T,F,F,T)] = [1,4,25]
z <- x[x > 5]             # x > 5 = [F,F,T,T,T], x[x > 5] = [9,16,25]

# Indizierung mit einem character Vektor
x <- c(1, 4, 9, 16, 25)   # [1,4,9,16,25] = [1^2, 2^2, 3^2, 4^2, 5^2]
names(x) <- c("a", "b")   # Benennung der Komponenten als [a b <NA> <NA> <NA>]
y <- x["a"]               # x["a"] = 1 # nolint: commented_code_linter.

# Out-of-range Indizes verursachen keine Fehler, sondern geben NA aus
x <- c(1, 4, 9, 16, 25)   # [1,4,9,16,25] = [1^2, 2^2, 3^2, 4^2, 5^2]
y <- x[10]                # x[10] = NA (Not Applicable)

# Nichtganzzahlige Indizes verursachen keine Fehler, sondern werden abgerundet
y <- x[4.9]               # x[4.9] = x[4] = 16 #  nolint: commented_code_linter.
z <- x[-4.9]              # x[-4.9] = x[-4] = [1,4,9,25]

# Leere Indizes indizieren den gesamten Vektor
y <- x[]                  # y = x  # nolint: commented_code_linter.

# ------Arithmetik------
# Unitäre arithmetische Operatoren und Funktionen
a <- seq(0, 1, len <- 11) # a = [ 0.0, 0.1 , ..., 0.9, 1.0]
b <- -a                   # b = [-0.0, -0.1, ..., -0.9, -1.0]
v <- a^2                  # v = [0.0^2 , 0.1^2 , ..., 0.9^2  , 1.0^2  ]
w <- log(a)               # w <- [ln(0.0), ln(0.1), ..., ln(0.9), ln(1.0)]

# Binäre arithmetische Operatoren
a <- c(1, 2, 3) # a = [1,2,3]
b <- c(2, 1, 4) # b = [2,1,4]
v <- a + b      # v = [1,2,3] + [2,1,4] = [1+2,2+1,3+4] = [3, 3, 7]
w <- a - b      # w = [1,2,3] - [2,1,4] = [1-2,2-1,3-4] = [-1, 1, -1]
x <- a * b      # x = [1,2,3] * [2,1,4] = [1*2,2*1,3*4] = [   2,  2,   12]
y <- a / b      # y = [1,2,3] / [2,1,4] = [1/2,2/1,3/4] = [0.50,  2, 0.75]

# Vektoren und Skalare
a <- c(1, 2, 3) # a = [1,2,3]
b <- 2          # b = [2]
v <- a + b      # v = [1,2,3] + [2,2,2] = [1+2,2+2,3+2] = [3, 4, 5]
w <- a - b      # w = [1,2,3] - [2,2,2] = [1-2,2-2,3-2] = [-1, 2, 1]
x <- a * b      # x = [1,2,3] * [2,2,2] = [1*2,2*2,3*2] = [ 2, 4, 6]
y <- a / b      # y = [1,2,3] / [2,2,2] = [1/2,2/2,3/2] = [0.5, 1, 1.5]

# Recycling
x <- 1:2               # x = [1,2], length(x) = 2
y <- 3:6               # y = [3,4,5,6], length(y) = 4
v <- x + y             # v = [1,2,1,2] + [3,4,5,6] = [4,6,6,8]
x <- c(1, 3, 5)        # x = [1,3,5], length(x) = 3
y <- c(2, 4, 6, 8, 10) # y <- [2,4,6,8,10], length(y) = 5
v <- x + y             # v = [1,3,5,1,3] + [2,4,6,8,10] = [3,7,11,9,13]
                       # Nach dieser Zeile sollte eine warning message erscheinen

# Rechnen mit fehlenden Werte (NA)
3 * NA     # Multiplikation eines NA Wertes ergibt NA
NA < 2     # Relationaler Vergleich eines NA Wertes ergibt NA
NA^0       # NA hoch 0 ergibt 1, weil jeder Wert hoch 0 eins ergibt (?)
NA & FALSE # NA UND FALSE  ergibt FALSE, weil jeder Wert UND FALSE FALSE ergibt

# Auf NA testen
x <- c(NA, 5, NA, 10)  # Vektor mit NAs
x == NA                # Kein Testen auf NAs : 5 <-<- NA ist NA, nicht FALSE
is.na(x)               # Logisches Testen auf NA

# ------Attribute------
a <- 1:3               # ein numerischer Vektor

# Aufrufen aller Attribute
attributes(a)          # Per dedault hat ein atmoic vector keine Attribute

# Einzelne Attribute zuweisen
attr(a, "S") <- "W"    # a bekommt Attribut mit Schluessel S und Wert W

# Einzelne Attribute aufrufen
attr(a, "S")           # Das Attribut mit Schluessel S hat den Wert W

# Attribute werden bei Operationen oft entfernt
b <- a[1]              # Kopie des ersten Elements von a in Vektor b
attributes(b)          # Aufrufen aller Attribute von b

# Das Attribut 'names'
v <- c(x = 1, y = 2, z = 3)  # Elementnamengeneration bei Vektorerzeugung
y <- 4:6                     # Erzeugung eines Vektors
names(y) <- c("a", "b", "c") # Definition von Namen nach Vektorerzeugung
v["y"]                       # Indizierung per Namen
y["b"]                       # Indizierung per Namen
names(v)                     # Elementnamenaufruf
names(y)                     # Elementnamenaufruf

# Ein Vektor als Sinneinheit
p <- c(age    <- 31,
       height <- 198,
       weight <- 75)

# ========== SKF 6 ==========================================================
ein_vektor <- seq(0, 1, by = 0.05)

# ========== SKF 7 ==========================================================
# Bestimme die Laenge des Vektors
laenge_vektor <- length(ein_vektor)

# Kreiere einen Vektor mit jeder 2. Zahl in der Sequenz 1 - [Laenge des Vektors]
ungerade_indizes <- seq(1, laenge_vektor, by = 2)

# Kreiere einen neuen Vektor, der nur die Elemente 0.0, 0.1, ..., 1.0 enthält
ein_neuer_vektor <- ein_vektor[ungerade_indizes]

# ========== SKF 8 ==========================================================
# Kreiere einen Vektor mit jeder 2. Zahl in der Sequenz 2 - [Laenge des Vektors]
gerade_indizes <- seq(2, laenge_vektor, by = 2)

# Kreiere einen neuen Vektor, der nur die Elemente 0.0, 0.1, ..., 1.0 enthält
noch_ein_neuer_vektor <- ein_vektor[-gerade_indizes]

# ========== SKF 9 ==========================================================
# Kreiere einen Vektor, der die letzten 10 Indizes enthält
letzte_10_indizes <- seq(laenge_vektor - 9, laenge_vektor)

# Kreiere einen neuen Vektor, der nur die letzten 10 Elem. des Vektors enthält
letzter_neuer_vektor <- ein_vektor[letzte_10_indizes]

# Anmerkungen:
# ------------
# Die hier gewählten Variablennamen sind natürlich viel zu lang.
# Sie wurden hier aus didaktischen Gründen gewählt.
#
# Bei Fehlermeldung (Error in ...) würde die execution unterbrochen
# werden, und diese letzte Zeile nicht ausgegeben. Bei Warnungen
# (Warning message) hingegen wird die execution nicht unterbrochen.
