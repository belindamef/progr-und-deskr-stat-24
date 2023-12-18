# Beispiellösung für Selbstkontrollfragen aus Einheit (9) "Maße der Zentralen 
# Tendenz" des Kurses "Programmierung und Deskriptive Statistik" im WS 23/24
#
# Author: Belinda Fleischmann

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

# Import data
data_df <- read.table(rawdata_fpath, sep = ",", header = TRUE)

# ------SKF 2) Mittelwert der Post.BDI Daten.----------------------------------
# "Manuelle" Mittelwertsbestimmung
x <- Data_df$Post.BDI                  # double Vektor der Post-BDI Werte Werte
n <- length(x)                         # Anzahl der Werte
x_bar_man <- (1 / n) * sum(x)          # Mittelwertsberechnung

# Mittelwertsbestimmung mit der Funtion mean()
x_bar_fun <- mean(x)

# ------SKF 5) Median der Post.BDI Daten---------------------------------------
# "Manuelle" Bestimmung des Median
x_s <- sort(x)                                  # aufsteigend sortierter Vektor
if (n %% 2 == 1) {                              # n ungerade, n mod 2 == 1
  x_tilde_man <- x_s[(n + 1) / 2]
} else {                                        # n gerade, n mod 2 == 0
  x_tilde_man <- (x_s[n / 2] + x_s[n / 2 + 1]) / 2
}

# Bestimmung des Median mit der Funktion median()
x_tilde_fun <- median(x)

# ------SKF 8) Modalwert der Post.BDI Daten------------------------------------
H <- as.data.frame(table(x))       # absolute Häufigkeitsverteilung (dataframe)
names(H) <- c("a", "h")            # Konsistente Benennung
mod <- H$a[which.max(H$h)]         # Modalwert
mod_num <- as.numeric(as.vector(mod))

# ------Zusammenfassende Ausgabe-----------------------------------------------
cat("Mittelwert:", x_bar_man,
    "\nMedian    :", x_tilde_man,
    "\nModalwert:", mod_num)
