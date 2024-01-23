# Dieses Skript wertet die Bedingunsabhängigen Deskriptiven Statistiken
# Beispieldatensatz aus und erstellt Visualisierungen.

# Kurs:  "Programmierung und Deskriptive Statistik" im WS 23/24

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

# ------Datenvorverarbeitung---------------------------------------------------
fname <- file.path(data_dir, "psychotherapie_datensatz.csv")  # Einlesen
daten <- read.table(fname, sep = ",", header = TRUE)          # Rohdaten
daten$Delta.BDI <- -(daten$Post.BDI - daten$Pre.BDI)          # \Delta BDI Maß

# ------Auswertung deskriptiver Statistiken------------------------------------
# Initialisierung eines Dataframes
th_bed <- c("Klassisch", "Online")                # Therapiebedingungen
n_th_bed <- length(th_bed)                        # Anzahl Therapiebedingungen
deskr_stat <- data.frame(                         # Dataframeerzeugung
  n         = rep(NaN, n_th_bed),                 # Stichprobengrößen
  Max       = rep(NaN, n_th_bed),                 # Maxima
  Min       = rep(NaN, n_th_bed),                 # Minima
  Median    = rep(NaN, n_th_bed),                 # Mediane
  Mean      = rep(NaN, n_th_bed),                 # Mittelwerte
  Var       = rep(NaN, n_th_bed),                 # Varianzen
  Std       = rep(NaN, n_th_bed),                 # Standardabweichungen
  row.names = th_bed                              # Therapiebedingungen
)

# Iterationen über Therapiebedingungen
for (i in 1:n_th_bed){
  data                 <- daten$Delta.BDI[daten$Bedingung == th_bed[i]]  # Daten
  deskr_stat$n[i]      <- length(data)                           # Stichpr.-Gr.
  deskr_stat$Max[i]    <- max(data)                              # Maxima
  deskr_stat$Min[i]    <- min(data)                              # Minima
  deskr_stat$Median[i] <- median(data)                           # Mediane
  deskr_stat$Mean[i]   <- mean(data)                             # Mittelwerte
  deskr_stat$Var[i]    <- var(data)                              # Varianzen
  deskr_stat$Std[i]    <- sd(data)                               # Standardabw.
}

# Ausgabe
cat("\n\nDeskriptive Statistiken: \n\n")
print(deskr_stat)

# -------Bedingungsabhängige Visualisierung deskriptiver Statistiken-----------
graphics.off()          # Schließt alle eventuell noch offenen graphics devices
dev.new()

# Abbildung 1: Balkendiagramm (links) und Boxplots (rechts)
# --------------------------------------------------------
# Abbildungsparameter
par(                                     # für Details siehe ?par
  mfcol     = c(1, 2),                   # 1 x 2 Panelstruktur
  family    = "sans",                    # Serif-freier Fonttyp
  pty       = "m",                       # Maximale Abbildungsregion
  bty       = "l",                       # L förmige Box
  las       = 1,                         # Horizontale Achsenbeschriftung
  xaxs      = "i",                       # x-Achse bei y = 0
  yaxs      = "i",                       # y-Achse bei x = 0
  font.main = 1,                         # Non-Bold Titel
  cex       = 1,                         # Textvergrößerungsfaktor
  cex.main  = 1.5                        # Titeltextvergrößerungsfaktor
)

# Linkes Panel: Balkendiagramm mit Fehlerbalken
mw        <- deskr_stat$Mean             # Gruppenmittelwert
sd        <- deskr_stat$Std              # Gruppenstandardabweichung
names(mw) <- th_bed                      # barplot braucht x-Werte als names

x <- barplot(                            # Ausgabe der x-Ordinaten (s. ?barplot)
  height = mw,                           # Mittelwerte für Balkenhöhe
  col   = "gray90",                     # Balkenfarbe
  ylim  = c(0, 12),                      # y-Achsenbegrenzung
  xlim  = c(0, 3),                       # x-Achsenbegrenzung
  xlab  = "Bedingung",                   # x-Achsenbeschriftung
  main  = TeX("$\\Delta BDI$")           # Titel
  #main = "Delta BDI")                   # Alternativer Titel ohne TeX
)

# arrows() für Fehlerbalken (siehe ?arrows)
arrows(
  x0     = x,                            # arrow start x-ordinate
  y0     = mw - sd,                      # arrow start y-ordinate
  x1     = x,                            # arrow end   x-ordinate
  y1     = mw + sd,                      # arrow end   y-ordinate
  code   = 3,                            # Pfeilspitzen beiderseits
  angle  = 90,                           # Pfeilspitzenwinkel als Linie
  length = 0.05                          # Linielänge
)

# Rechtes Panel: Boxplot
boxplot(
  daten$Delta.BDI ~ daten$Bedingung,     # Gruppierung derDaten nach D$Bedingung
  ylim = c(0, 12),                       # y-Achsenbegrenzung
  col  = "gray90",                      # Boxfarbe
  ylab = "",                             # y-Achsenbeschriftung
  xlab = "Bedingung",                    # x-Achsenbeschriftung
  main = TeX("$\\Delta BDI$")            # Titel
)

# PDF Speicherung
dev.copy2pdf(
  file   = file.path(fig_dir, "11_deskr_balk_box.pdf"),
  width  = 8,
  height = 5
)

# Abbildung 2: Histogramme
# ---------------------------------------------
graphics.off()          # Schließt alle eventuell noch offenen graphics devices
dev.new()

# Histogrammparameter
h        <- 1                                 # gewünschte Klassenbreite
b_0      <- min(daten$Delta.BDI)              # b_0
b_k      <- max(daten$Delta.BDI)              # b_0
k        <- ceiling((b_k - b_0) / h)          # Anzahl der Klassen
b        <- seq(b_0, b_k, by = h)             # Klassen [b_{j-1}, b_j[
ylimits  <- c(0, .25)                         # y-Achsenlimits
xlimits  <- c(-2, 14)                         # x-Achsenlimits
therapie <- c("Klassisch", "Online")          # Therapiebedingungen
labs     <- c("Klassische Therapie",          # Abbildungslabel
              "Online Therapie")

# Abbildungsparameter
par(                                          # für Details siehe ?par
  mfcol       = c(1, 2),                      # 1 x 2 Panelstruktur
  family      = "sans",                       # Serif-freier Fonttyp
  pty         = "m",                          # Maximale Abbildungsregion
  bty         = "l",                          # L förmige Box
  las         = 1,                            # Horizontale Achsenbeschriftung
  xaxs        = "i",                          # x-Achse bei y = 0
  yaxs        = "i",                          # y-Achse bei x = 0
  font.main   = 1,                            # Non-Bold Titel
  cex         = 1,                            # Textvergrößerungsfaktor
  cex.main    = 1                             # Titeltextvergrößerungsfaktor
)

# Iteration über Therapiebedingungen
for (i in 1:2){
  hist(
    daten$Delta.BDI[daten$Bedingung == therapie[i]],  # Delta von Th.-Beding. i
    breaks = b,                                       # Histogrammklassen
    freq   = FALSE,                                   # normierte rel. Häufigk.
    xlim   = xlimits,                                 # x-Achsenlimits
    ylim   = ylimits,                                 # y-Achsenlimits
    xlab   = TeX("$\\Delta$ BDI"),                    # x-Achsenbeschriftung
    ylab   = "",                                      # y-Achsenbeschriftung
    main   = labs[i]                                  # Titelbeschriftung
  )
}

# PDF Speicherung
dev.copy2pdf(
  file   = file.path(fig_dir, "11_deskr_hist.pdf"),
  width  = 8,
  height = 4
)

graphics.off()          # Schließt alle eventuell noch offenen graphics devices
