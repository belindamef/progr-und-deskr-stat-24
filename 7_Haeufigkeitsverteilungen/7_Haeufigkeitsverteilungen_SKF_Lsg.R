# Beispiellösung für Selbstkontrollfragen aus Einheit (7) "Häufigkeitsverteilungen"
# des Kurses "Programmierung und Deskriptive Statistik" im WS 23/24
#
# Author: Belinda Fleischmann

# Directory management
# -----------------------------------------------------------------------------
# Wichtige Anmerkung:
#
# Was durch `getwd()` definiert wird hängt davon ab, was die aktuellen
# individuellen working-directory Einstellungen auf dem Rechner sind, auf dem
# ein Skript ausgeführt wird.
# Im Zweifel empfiehlt es sich, das vorher zu testen und/oder Pfade als
# absolute Pfade zu definieren!
# -----------------------------------------------------------------------------
work_dir <- getwd()                                 # Working directory
data_dir <- file.path(work_dir, "Daten")            # Datenverzeichnispfad
fig_dir <- file.path(work_dir, "Figures")           # Figures-Verzeichnispfad
rawdata_fname <- "psychotherapie_datensatz.csv"     # (base) Daten filename
rawdata_fpath <- file.path(data_dir, rawdata_fname) # Rohdaten Dateipfad (Input)

# Output-Ordner für plots erstellen, falls nicht existent
if (!file.exists(fig_dir)) {
  dir.create(fig_dir)
}

# Import data
data_df <-  read.table(rawdata_fpath, sep = ",", header = T)

# ------SKF 2) Plot Häufigkeitsverteilung Post-BDI------------------------------
graphics.off()  # Schließt alle eventuell noch offenen graphics devices

# Datensatz vorbereiten und Häufigkeiten berechnen
post_bdi <- data_df$Post.BDI  # Post-BDI Werte aus df in einen Vektor kopieren
n_post_bdi <- length(post_bdi)                # Anzahl der Datenwerte (100)
H_post_bdi <- as.data.frame(table(post_bdi))  # absolute Haeufigkeitsverteilung.
names(H_post_bdi) <- c("a", "h")              # Spaltenbenennung
H_post_bdi$r <- H_post_bdi$h / n_post_bdi     # relative Häufigkeitsverteilung


# Balken (bar) diagramme erzeugen
# ------------------------------------------------------------------------------

# ------Absolute Häufigkeit------
# Input für barplot() vorbereiten
h          <- H_post_bdi$h                 # h(a) Werte
names(h)   <- H_post_bdi$a                 # barplot braucht a Werte als names

dev.new()
barplot(                                   # Balkendiagramm
  h,                                       # absolute Haeufigkeiten
  col  = "gray90",                       # Balkenfarbe
  xlab = "a",                              # x Achsenbeschriftung
  ylab = "h(a)",                           # y Achsenbeschriftung
  ylim = c(0, 25),                         # y Achsengrenzen
  las  = 2,                                # x Tick Orientierung
  main = "Post BDI"                        # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_2_h(a)_post_bdi.pdf"),
  width = 8, height = 5
)


# ------Realtive Häufigkeit------
# Input für barplot() vorbereiten
h        <- H_post_bdi$r                    # h(r) Werte
names(h) <- H_post_bdi$a                    # barplot braucht a Werte als names

barplot(                                    # Balkendiagramm
  h,                                        # absolute Haeufigkeiten
  col  = "gray90",                        # Balkenfarbe
  xlab = "a",                               # x Achsenbeschriftung
  ylab = "h(r)",                            # y Achsenbeschriftung
  ylim = c(0, .25),                         # y Achsengrenzen
  las  = 2,                                 # x Tick Orientierung
  main = "Post BDI"                         # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_2_h(r)_post_bdi.pdf"),
  width = 8, height = 
)


# ------SKF 3) Plot Häufigkeitsverteilung Pre-Post-Diff-BDI--------------------
graphics.off()          # Schließt alle eventuell noch offenen graphics devices

# Datensatz vorbereiten
pre_bdi <- data_df$Pre.BDI     # Pre-BDI Werte aus df in einen Vektor kopieren
bdi_diff <- post_bdi - pre_bdi # Pre-post-BDI Differenzen berechnen und in einem Vektor speichern
n_bdi_diff <- length(bdi_diff)

H_diff_bdi <- as.data.frame(table(bdi_diff)) # Absolute Haeufigkeitsverteilung
names(H_diff_bdi) <- c("a", "h")             # Spaltenbenennung
H_diff_bdi$r <- H_diff_bdi$h / n_bdi_diff    # Relative Haeufigkeitsverteilung


# Balken (bar) diagramme erzeugen
# -----------------------------------------------------------------------------

# ------Absolute Häufigkeit------
# Input für barplot() vorbereiten
h        <- H_diff_bdi$h                    # h(a) Werte
names(h) <- H_diff_bdi$a                    # barplot braucht a Werte als names

barplot(                                    # Balkendiagramm
  h,                                        # absolute Haeufigkeiten
  col      = "gray90",                    # Balkenfarbe
  xlab     = "a",                           # x Achsenbeschriftung
  ylab     = "h(a)",                        # y Achsenbeschriftung
  ylim     = c(0, 25),                      # y Achsengrenzen
  las      = 2,                             # x Tick Orientierung
  main     = "Pre-post BDI Diff"            # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_3_h(a)_diff_bdi.pdf"),
  width = 8, height = 5
)


# ------Realtive Häufigkeit------
# Input für barplot() vorbereiten
h        <- H_diff_bdi$r                    # h(r) Werte
names(h) <- H_diff_bdi$a                    # barplot braucht a Werte als names

barplot(                                    # Balkendiagramm
  h,                                        # Absolute Haeufigkeiten
  col  = "gray90",                        # Balkenfarbe
  xlab = "a",                               # x Achsenbeschriftung
  ylab = "h(r)",                            # y Achsenbeschriftung
  ylim = c(0, .25),                         # y Achsengrenzen
  las  = 2,                                 # x Tick Orientierung
  main = "Pre-post BDI Diff"                # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_3_h(r)_diff_bdi.pdf"),
  width = 8, height = 5
)


# ------SKF 4) Plot Häufigkeitsverteilung Pre-Post-Diff-BDI---------------------
graphics.off() # Schließt alle offenen graphics devices

# Datensätze vorbereiten und Häufigkeiten berechen
pre_bdi_f2f <- data_df$Pre.BDI[data_df$Bedingung == "Klassisch"]
pre_bdi_ONL <- data_df$Pre.BDI[data_df$Bedingung == "Online"]
post_bdi_f2f <- data_df$Post.BDI[data_df$Bedingung == "Klassisch"]
post_bdi_ONL <- data_df$Post.BDI[data_df$Bedingung == "Online"]
bdi_diff_f2f <- post_bdi_f2f - pre_bdi_f2f
bdi_diff_ONL <- post_bdi_ONL - pre_bdi_ONL
n_bdi_diff_f2f <- length(bdi_diff_f2f)
n_bdi_diff_ONL <- length(bdi_diff_ONL)

H_bdi_diff_f2f <- as.data.frame(table(bdi_diff_f2f)) # absolute Haeufigkeitsverteilung
H_bdi_diff_ONL <- as.data.frame(table(bdi_diff_ONL)) # absolute Haeufigkeitsverteilung
names(H_bdi_diff_f2f) <- c("a", "h")                 # Spaltenbenennung
names(H_bdi_diff_ONL) <- c("a", "h")                 # Spaltenbenennung
H_bdi_diff_f2f$r <- H_bdi_diff_f2f$h/n_bdi_diff_f2f  # Relative Haeufigkeiten
H_bdi_diff_ONL$r <- H_bdi_diff_ONL$h/n_bdi_diff_ONL  # Relative Haeufigkeiten



# ------Absolute Häufigkeit (f2f)------
# Input für barplot() vorbereiten
h        <- H_bdi_diff_f2f$h                # h(a) Werte
names(h) <- H_bdi_diff_f2f$a                # barplot braucht a Werte als names

barplot(                                    # Balkendiagramm
  h,                                        # absolute Haeufigkeiten
  col  = "gray90",                        # Balkenfarbe
  xlab = "a",                               # x Achsenbeschriftung
  ylab = "h(a)",                            # y Achsenbeschriftung
  ylim = c(0,25),                           # y Achsengrenzen
  las  = 2,                                 # x Tick Orientierung
  main = "Pre-post BDI Diff (f2f Gruppe)"   # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_4_h(a)_diff_bdi_f2f.pdf"),
  width = 8, height = 5
)


# ------realtive Häufigkeit (f2f) ------
# Input für barplot() vorbereiten
h        <- H_bdi_diff_f2f$r                # h(r) Werte
names(h) <- H_bdi_diff_f2f$a                # barplot braucht a Werte als names

barplot(                                    # Balkendiagramm
  h,                                        # absolute Haeufigkeiten
  col  = "gray90",                        # Balkenfarbe
  xlab = "a",                               # x Achsenbeschriftung
  ylab = "h(r)",                            # y Achsenbeschriftung
  ylim = c(0, .25),                         # y Achsengrenzen
  las  = 2,                                 # x Tick Orientierung
  main = "Pre-post BDI Diff (f2f Gruppe)"   # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_4_h(r)_diff_bdi_f2f.pdf"),
  width = 8, height = 5
)


# ------Absolute Häufigkeit (ONL)------
# Input für barplot() vorbereiten
h        <- H_bdi_diff_ONL$h                # h(a) Werte
names(h) <- H_bdi_diff_ONL$a                # barplot braucht a Werte als names

barplot(                                    # Balkendiagramm
  h,                                        # Absolute Haeufigkeiten
  col  = "gray90",                        # Balkenfarbe
  xlab = "a",                               # x Achsenbeschriftung
  ylab = "h(a)",                            # y Achsenbeschriftung
  ylim = c(0, 25),                          # y Achsengrenzen
  las  = 2,                                 # x Tick Orientierung
  main = "Pre-post BDI Diff (ONL Gruppe)"   # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_4_h(a)_diff_bdi_onl.pdf"),
  width = 8, height = 5
)


# ------realtive Häufigkeit (ONL) ------
# Input für barplot() vorbereiten
h        <- H_bdi_diff_ONL$r                # h(r) Werte
names(h) <- H_bdi_diff_ONL$a                # barplot braucht a Werte als names

barplot(                                    # Balkendiagramm
  h,                                        # Absolute Haeufigkeiten
  col  = "gray90",                        # Balkenfarbe
  xlab = "a",                               # x Achsenbeschriftung
  ylab = "h(r)",                            # y Achsenbeschriftung
  ylim = c(0,.25),                          # y Achsengrenzen
  las  = 2,                                 # x Tick Orientierung
  main = "Pre-post BDI Diff (ONL Gruppe)"   # Titel
)

# Diagramm als PDF speichern
dev.copy2pdf(
  file  = file.path(fig_dir, "7_skf_4_h(r)_diff_bdi_onl.pdf"),
  width = 8, height = 5
)

# ------SKF 8) Plot Häufigkeitsverteilung Pre-Post-Diff-BDI---------------------

# Vorbereitung des Wertes für das hist() Inputargument "breaks = ":

# für die Berechnung von Klassenbreiten benötigen wir zunächst die min/max Werte
# und die Anzahl der Datenpunkte
b_0_f2f <- min(bdi_diff_f2f)                     # b_0 (min Wert)
b_k_f2f <- max(bdi_diff_f2f)                     # b_k (max Wert)
b_0_ONL <- min(bdi_diff_ONL)                     # b_0 (min Wert)
b_k_ONL <- max(bdi_diff_ONL)                     # b_k (max Wert)
n_f2f   <- length(bdi_diff_f2f)                  # Anzahl Datenwerte
n_ONL   <- length(bdi_diff_ONL)                  # Anzahl Datenwerte

# a) Gewünschte Klassebreite von 3
# ---------------------------------
h        <- 3                                    # gewünschte Klassenbreite
b_h3_f2f <- seq(b_0_f2f, b_k_f2f, by = h)       # Klassen [b_{j-1}, b_j[

# Achtung!

# das Ergebnis von seq(b_0_f2f, b_k_f2f, by <- h) ist 
# (-12,  -9,  -6,  -3,   0), was nicht alle Werte abdeckt. Deshalbt fügen wir 
# einen break (i.e. die 3) hinzu
b_h3_f2f    <- c(b_h3_f2f, 3)
b_h3_ONL    <- seq(b_0_ONL, b_k_ONL, by = h)

# wie bei der ONL Gruppe, deckt auch hier das Ergebnis von seq() 
# nicht alle Werte ab, weshalb wir einen break hinzufügen
b_h3_ONL    <- c(b_h3_ONL, 0)

# b) Excelstandard
# ---------------------------------
k_f2f       <- ceiling(sqrt(n_f2f))                   # Anzahl der Klassen
k_ONL       <- ceiling(sqrt(n_ONL))                   # Anzahl der Klassen
b_excel_f2f <- seq(b_0_f2f, b_k_f2f, len = k_f2f + 1) # Klassen [b_{j-1}, b_j[
b_excel_ONL <- seq(b_0_ONL, b_k_ONL, len = k_ONL + 1) # Klassen [b_{j-1}, b_j[

# c) Sturges Klassenzahl
# ---------------------------------
k_f2f         <- ceiling(log2(n_f2f) + 1)              # Anzahl der Klassen
k_ONL         <- ceiling(log2(n_ONL) + 1)              # Anzahl der Klassen
b_sturges_f2f <- seq(b_0_f2f, b_k_f2f, len = k_f2f + 1)# Klassen [b_{j-1}, b_j[
b_sturges_ONL <- seq(b_0_ONL, b_k_ONL, len = k_ONL)    # Klassen [b_{j-1}, b_j[

# d) Scott Klassenzahl (geg.: h)
# ---------------------------------
S_f2f       <- sd(bdi_diff_f2f)                        # Stichprobenstandardabweichung
S_ONL       <- sd(bdi_diff_ONL)                        # Stichprobenstandardabweichung
h_f2f       <- ceiling(3.49*S_f2f/(n_f2f^(1/3)))       # Klassenbreite
h_ONL       <- ceiling(3.49*S_ONL/(n_ONL^(1/3)))       # Klassenbreite
k_f2f       <- ceiling((b_k_f2f - b_0_f2f)/h_f2f)      # Anzahl der Klassen
k_ONL       <- ceiling((b_k_ONL - b_0_ONL)/h_ONL)      # Anzahl der Klassen
b_scott_f2f <- seq(b_0_f2f, b_k_f2f, len = k_f2f + 1)  # Klassen [b_{j-1}, b_j[
b_scott_ONL <- seq(b_0_ONL, b_k_ONL, len = k_ONL + 1)  # Klassen [b_{j-1}, b_j[


# Damit wir die gleichen Befehle zur Histogramm-erzeugung nicht 4x wiederholen
# müssen, erzeugen wir für verschiedene Ansätze (a bis d) Listen, durch die wir 
# mit for-loops iterieren können.
breaks_list_f2f <- list(
  "h3"            = b_h3_f2f,
  "Excelstandard" = b_excel_f2f,
  "Sturges"       = b_sturges_f2f,
  "Scott"         = b_scott_f2f
)
breaks_list_ONL <- list(
  "h3"            = b_h3_ONL,
  "Excelstandard" = b_excel_ONL,
  "Sturges"       = b_sturges_ONL,
  "Scott"         = b_scott_ONL
)

# Histogramme erstellen - f2f
for (breaks_method_name in names(breaks_list_f2f)) {
  graphics.off()

  # browser()                                                # pausiert loop
  # Achtet darauf, wie sich bei jeder Iteration der Wert der Variable
  # "breaks_method_name" ändert. 

  # Histogramm plotten
  hist(                                             # Histogramm
    bdi_diff_f2f,      # Datensatz, für den ein Histogramm erstellt werden soll
    breaks = breaks_list_f2f[[breaks_method_name]], # breaks
    xlim   = c(-15, 5),                             # x Achsen Limits
    ylim   = c(0, 25),                              # y Achsen Limits
    ylab   = "Häufigkeit",                          # y-Achsenbezeichnung
    xlab   = "",                                    # x-Achsenbezeichnung
    main   = paste("Post-Pre-BDI Differenz (f2f),", # Titel
      breaks_method_name
    )
  )

  # Diagramm als PDF speichern
  dev.copy2pdf(
    file = file.path(fig_dir, paste("7_skf_8_hist_diff_bdi_f2f_",
                                    breaks_method_name, ".pdf", sep = "")),
    width = 8, height = 5
  )
}

# Histogramme erstellen - ONL
for (breaks_method_name in names(breaks_list_ONL)) {
  graphics.off()

  # Histogramm plotten
  hist(                                                    # Histogramm
    bdi_diff_ONL,      # Datensatz, für den ein Histogramm erstellt werden soll
    breaks = breaks_list_ONL[[breaks_method_name]], # breaks
    xlim = c(-15, 5),                               # x Achsen Limits
    ylim = c(0, 25),                                # y Achsen Limits
    ylab = "Häufigkeit",                            # y-Achsenbezeichnung
    xlab = "",                                      # x-Achsenbezeichnung
    main = paste(
      "Post-Pre-BDI Differenz (ONL),",              # Titel
      breaks_method_name
    )
  )

  # Diagramm als PDF speichern
  dev.copy2pdf(
    file  = file.path(fig_dir, paste("7_skf_8_hist_diff_bdi_ONL_",
                                     breaks_method_name, ".pdf", sep = "")),
    width = 8, height = 5
  )
}

#------
graphics.off() # Schließt alle eventuell noch offenen graphics devices
