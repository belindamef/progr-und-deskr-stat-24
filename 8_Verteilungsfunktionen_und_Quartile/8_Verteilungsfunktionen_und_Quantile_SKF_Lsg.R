# Beispiellösung für Selbstkontrollfragen aus Einheit (8) "Verteilungsfunktionen
# und Quantile" des Kurses "Programmierung und Deskriptive Statistik"
# im WS 23/24
#
# author: Belinda Fleischmann

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

# ------SKF 2) kumulativen Häufigkeitsverteilungen der Post.BDI-----------------

# Datensatz vorbereiten
post_bdi <- data_df$Post.BDI     # Post-BDI Werte in einen Vektor kopieren
n <- length(post_bdi)            # Anzahl der Datenwerte
H <- as.data.frame(              # absolute Häufigkeitsverteilung als Dataframe
  table(post_bdi)
)
names(H) <- c("a", "h")          # Spaltenbennung
H$H <- cumsum(H$h)               # kumulative absolute Häufigkeitsverteilung
H$r <- H$h / n                   # relative Häufigkeitsverteilung
H$R <- cumsum(H$r)               # kumulative relative Häufigkeitsverteilung

# Visualisierung der kumulativen absoluten Häufigkeitsverteilung
graphics.off()                   # Offene graphical devices schließen
dev.new()                        # Abbildungsinitialisierung
Ha <- H$H                        # H(a) Werte
names(Ha) <- H$a                 # barplot braucht a Werte als names

barplot(                         # Balkendiagramm
  Ha,                            # H(a) Werte
  col  = "gray90",              # Balkenfarbe
  xlab = "a",                    # x Achsenbeschriftung
  ylab = "H(a)",                 # y Achsenbeschriftung
  ylim = c(0, 110),              # y Achsenlimits
  las  = 1,                      # Achsenticklabelorientierung
  main = "Post.BDI"              # Titel
)

dev.copy2pdf(
  file   = file.path(fig_dir, "8_skf_2_kum_abs_post.pdf"),
  width  = 8,
  height = 5
)

# Visualisierung der kumulativen relativen Häufigkeitsverteilung
graphics.off()                   # Offene graphical devices schließen
dev.new()                        # Abbildungsinitialisierung
R <- H$R                         # R(a) Werte
names(R) <- H$a                  # barplot braucht a Werte als names

barplot(                         # Balkendiagramm
  R,                             # R(a) Werte
  col  = "gray90",              # Balkenfarbe
  xlab = "a",                    # x Achsenbeschriftung
  ylab = "R(a)",                 # y Achsenbeschriftung
  ylim = c(0, 1),                # y Achsenlimits
  las  = 1,                      # Achsenticklabelorientierung
  main  = "Post.BDI"             # Titel
)

# PDF Speicherung
dev.copy2pdf(
  file   = file.path(fig_dir, "8_skf_2_kum_rel_post.pdf"),
  width  = 8,
  height = 5
)

# ------SKF 4) empirische Verteilungsfunktion der Post.BDI Daten----------------
# Datensatz vorbereiten
evf <- ecdf(post_bdi)               # Evaluation der EVF

# Visualisierung der empirischen Verteilungsfunktion
graphics.off()                      # Offene graphical devices schließen
dev.new()                           # Abbildungsinitialisierung

plot(                               # plot() weiß mit ecdf object umzugehen
  evf,                     # ecdf (empiric., cum. distribution function) Objekt
  xlab = TeX("$\\xi$"),    # x Achsenbeschriftung
  #xlab = "xi",            # x Achsenbeschriftung ohne LaTeX Formatierung
  ylab = TeX("$F(\\xi)$"), # y Achsenbeschriftung ohne LaTeX Formatierung
  #ylab = "F(xi)",
  main = "Pre.BDI Empirische Verteilungsfunktion"  # Titel
)

# PDF Speicherung
dev.copy2pdf(
  file   = file.path(fig_dir, "8_skf_4_evf_post.pdf"),
  width  = 8,
  height = 5
)

# ------SKF 7) obere Quartil des Beispieldatensatzes auf Folie 16---------------
# "Manuelle" Quantilbestimmung
x <- c(8.5, 1.5, 12., 4.5, 6.0,                    # Beispieldaten
  3.0, 3.0, 2.5, 6.0, 9.0
)
n <- length(x)                                     # Anzahl Datenwerte
x_s <- sort(x)                                     # sortierter Datensatz
p <- 0.75                                          # np = 7.5 \notin \mathbb{N}
x_p_man <- x_s[floor(n * p + 1)]                   # 0.75 Quantil

# Quantilbestimmung mit `quantile()` Funktion
x_p_fun <- quantile(x, 0.75, type = 1)             # 0.75 Quantil

# ------SKF 9) untere Quartil, Median, obere Quartil der Post.BDI Daten---------
post_bdi_s <- sort(post_bdi)
n <- length(post_bdi)

# "Manuell"
p_25 <- 0.25                                   # np_25 <- 25 \in \mathbb{N}
x_25_man <- (1 / 2) * (                        # 0.25 Quantil
  post_bdi_s[n * p_25]
  + post_bdi_s[n * p_25 + 1]
)
p_75 <- 0.75                                   # np_75 <- 75 \in \mathbb{N}
x_75_man <- (1 / 2) * (                        # 0.75 Quantil
  post_bdi_s[n * p_75]
  + post_bdi_s[n * p_75 + 1]
)
p_50 <- 0.5                                    # np_50 <- 50 \in \mathbb{N}
median_man <- (1 / 2) * (                      # 0.5 Quantil aka Median
  post_bdi_s[n * p_50]
  + post_bdi_s[n * p_50 + 1]
)

# Quantilbestimmung mit `quantile()` Funktion
x_25_fun <- quantile(post_bdi, 0.25, type = 1)
x_75_fun <- quantile(post_bdi, 0.75, type = 1)
median_fun <- median(post_bdi)

quartile <- c(
  "Min."    = min(post_bdi),
  "1st Qu." = x_25_man,
  "Median"  = median_man,
  "Mean"    = mean(post_bdi),
  "3rd Qu." = x_75_man,
  "Max."    = max(post_bdi)
)

# Vergleich mit 'summary()' Funktion
print(quartile, digits = 2)
print(summary(post_bdi))

# ------SKF 10) Boxplot der Post.BDI Daten--------------------------------------

# Boxplot
graphics.off()                      # Offene graphical devices schließen
dev.new()                           # Abbildungsinitialisierung
boxplot(                            # Boxplot
  post_bdi,                         # Datensatz
  horizontal  = TRUE,               # horizontale Darstellung
  range       = 0,                  # Whiskers bis zu min x und max x
  xlab        = "x",                # x Achsenbeschriftung
  main        = "Post.BDI Boxplot"  # Titel
)

# PDF Speicherung
dev.copy2pdf(
  file        = file.path(fig_dir, "8_skf_10_boxplot.pdf"),
  width       = 8,
  height      = 5
)

graphics.off()                   # Offene graphical devices schließen
