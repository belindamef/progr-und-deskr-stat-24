# Beispiellösung für Selbstkontrollfragen aus Einheit (10) "Maße der Daten-
# Variabilität" des Kurses "Programmierung und Deskriptive Statistik" im
# WS 23/24
#
# Autorin: Belinda Fleischmann

# Pakete laden
library(latex2exp)                                   # Für LaTeX Formatierung

# Directory management
work_dir <- getwd()                                  # Working directory
data_dir <- file.path(work_dir, "Daten")             # Datenverzeichnispfad
fig_dir <- file.path(work_dir, "Figures")            # Figures-Verzeichnispfad
rawdata_fname <- "psychotherapie_datensatz.csv"      # (base) Daten filename
rawdata_fpath <- file.path(data_dir, rawdata_fname)  # Rohdaten Dateipfad

# Output-Ordner erstellen, falls nicht existent
if (!file.exists(fig_dir)) {
  dir.create(fig_dir)
}


# Daten importieren und vorbereiten
data_df <- read.table(rawdata_fpath, sep = ",", header = TRUE)
x <- data_df$Post.BDI                        # Double Vektor der Post-BDI Werte

# ------SKF 2) Spannbreite der Post.BDI Daten----------------------------------
# "Manuelle" Berechnung
x_max <- max(x)                              # Maximum
x_min <- min(x)                              # Mininum
sb <- x_max - x_min                          # Spannbreite
cat("Spannbreite (manuell): ", sb)           # Ausgabe

# Berechnung mit range()
MinMax <- range(x)                           # Berechnung min(x), max(x)
sb <- MinMax[2] - MinMax[1]                  # Spannbreite
cat("\nSpannbreite (automatisch): ", sb)     # Ausgabe

# ------SKF 4) (empirische) Stichprobenvarianz der Post.BDI Daten--------------

# ------Stichprobenvarianz---------------------------------
# "Manuelle" Berechnung
n <- length(x)                               # Anzahl der Werte
s2 <- (1 / (n - 1)) * sum((x - mean(x))^2)   # Stichprobenvarianz
cat("\nStichprobenvarianz (manuell): ", s2)  # Ausgabe

# Berechnung mit var()
s2 <- var(x)                                 # Stichprobenvarianz
cat("\nStichprobenvarianz (automatisch): ",  # Ausgabe
    s2)

# ------ Empirische Stichprobenvarianz---------------------
# "Manuelle" Berechnung
s2_tilde <- (1 / n) * sum((x - mean(x))^2)   # Empirische Stichprobenvarianz
cat("\nEmpirische Stichprobenvarianz ",      # Ausgabe
    "(manuell): ", s2_tilde)

# Berechnung mit var()
s2_tilde <- ((n - 1) / n) * var(x)           # Empirische Stichprobenvarianz
cat("\nEmpirische Stichprobenvarianz ",      # Ausgabe
    "(automatisch): ", s2_tilde)

# ------SKF 8) (empirische) Stichprobenstandardabweichung der Post.BDI Daten---

# ------Stichprobenstandardabweichung----------------------------------
# "Manuelle" Berechnung
n <- length(x)                               # Anzahl der Werte
s <- (                                       # Standardabweichung
  sqrt((1 / (n - 1)) * sum((x - mean(x))^2))
)
cat("\nStichprobenstandardabweichung ",      # Ausgabe
    "(manuell): ", s)

# Berechnung mit sd()
s <- sd(x)                                   # Standardabweichung
cat("\nStichprobenstandardabweichung ",      # Ausgabe
    "(automatisch): ", s)

# ------ Empirische Stichprobenstandardabweichung---------------------
# "Manuelle" Berechnung
s_tilde	<- (                                 # Empirische Standardabweichung
  sqrt((1 / (n)) * sum((x - mean(x))^2))
)
cat("\nEmpirische ",                         # Ausgabe
    "Stichprobenstandardabweichung ",
    "(manuell): ", s_tilde)
# Berechnung mit sd()
s_tilde	<- sqrt((n - 1) / n) * sd(x)         # Empirische Standardabweichung
cat("\nEmpirische ",                         # Ausgabe
    "Stichprobenstandardabweichung ",
    "(automatisch): ", s_tilde)
