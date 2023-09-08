# Dieses Skript wertet die Bedingunsabhängigen Deskriptiven Statistiken 
# Beispieldatensatz aus und erstellt Visualisierungen. 

# Kurs:  "Programmierung und Deskriptive Statistik" im WS 22/23

# Pakete laden
library(latex2exp)   # Für LaTeX-Schriftformatierung

# Datenmanagement
data_dir = file.path(getwd(), "Data")  # Pfad zum Datenorder (output der Simulation)
fig_dir = file.path(getwd(), "Figures")

# Output-Ordner erstellen, falls nicht existent
if (!file.exists(fig_dir)){
  dir.create(fig_dir)
}

# ------Datenvorverarbeitung----------------------------------------------------
fname       = file.path(data_dir, "psychotherapie_datensatz.csv")   # Einlesen
D           = read.table(fname, sep = ",", header = TRUE)           # Rohdaten
D$Delta.BDI = -(D$Post.BDI - D$Pre.BDI)                             # \Delta BDI Maß

# ------Auswertung deskriptiver Statistiken-------------------------------------
# Initialisierung eines Dataframes
tp            = c("Klassisch", "Online")            # Therapiebedingungen
ntp           = length(tp)                          # Anzahl Therapiebedingungen
S             = data.frame(                         # Dataframeerzeugung
                n         = rep(NaN,ntp),           # Stichprobengrößen
                Max       = rep(NaN,ntp),           # Maxima
                Min       = rep(NaN,ntp),           # Minima
                Median    = rep(NaN,ntp),           # Mediane
                Mean      = rep(NaN,ntp),           # Mittelwerte
                Var       = rep(NaN,ntp),           # Varianzen
                Std       = rep(NaN,ntp),           # Standardabweichungen
                row.names = tp)                     # Therapiebedingungen

# Iterative Auswertung deskriptiver Statistiken über Therapiebedingungen
for(i in 1:ntp){
  data        = D$Delta.BDI[D$Bedingung == tp[i]]   # Daten
  S$n[i]      = length(data)                        # Stichprobengröße
  S$Max[i]    = max(data)                           # Maxima
  S$Min[i]    = min(data)                           # Minima
  S$Median[i] = median(data)                        # Mediane
  S$Mean[i]   = mean(data)                          # Mittelwerte
  S$Var[i]    = var(data)                           # Varianzen
  S$Std[i]    = sd(data)                            # Standardabweichungen
}

# Ausgabe
cat('\n\nDeskriptive Statistiken: \n\n')
print(S)

# -------Bedingungsabhängige Visualisierung deskriptiver Statistiken------------
graphics.off()                                # Schließt alle eventuell noch offenen graphics devices
dev.new()

# Abbildung 1: Balkendiagramm und Boxplots
# ---------------------------------------------
# Abbildungsparameter
par(                                          # für Details siehe ?par
  mfcol       = c(1,2),                       # 1 x 2 Panelstruktur
  family      = "sans",                       # Serif-freier Fonttyp
  pty         = "m",                          # Maximale Abbildungsregion
  bty         = "l",                          # L förmige Box
  las         = 1,                            # Horizontale Achsenbeschriftung
  xaxs        = "i",                          # x-Achse bei y = 0
  yaxs        = "i",                          # y-Achse bei x = 0
  font.main   = 1,                            # Non-Bold Titel
  cex         = 1,                            # Textvergrößerungsfaktor
  cex.main    = 1.5)                          # Titeltextvergrößerungsfaktor

# Linkes Panel: Balkendiagramm mit Fehlerbalken
mw          = S$Mean                          # Gruppenmittelwert
sd          = S$Std                           # Gruppenstandardabweichung
names(mw)   = tp                              # barplot braucht x-Werte als names
x = barplot(                                  # Ausgabe der x-Ordinaten (?barplot für Details)
  mw,                                         # Mittelwerte = Balkenhöhe
  col         = "gray90",                     # Balkenfarbe
  ylim        = c(0,12),                      # y-Achsenbegrenzung
  xlim        = c(0,3),                       # x-Achsenbegrenzung 
  xlab        = "Bedingung",                  # x-Achsenbeschriftung    
  main        = TeX("$\\Delta BDI$"))         # Titel
  #main        = "Delta BDI")
arrows(                                       # arrows() für Fehlerbalken (siehe ?arrows)
  x0          = x,                            # arrow start x-ordinate
  y0          = mw - sd,                      # arrow start y-ordinate
  x1          = x,                            # arrow end   x-ordinate
  y1          = mw + sd,                      # arrow end   y-ordinate
  code        = 3,                            # Pfeilspitzen beiderseits
  angle       = 90,                           # Pfeilspitzenwinkel -> Linie
  length      = 0.05)                         # Linielänge

# Rechtes Panel: Boxplot
boxplot(
  D$Delta.BDI ~ D$Bedingung,                    # Gruppierung der Delta.BDI Daten nach D$Bedingung
  ylim        = c(0,12),                        # y-Achsenbegrenzung
  col         = "gray90",                       # Boxfarbe
  ylab        = "",                             # y-Achsenbeschriftung
  xlab        = "Bedingung",                    # x-Achsenbeschriftung    
  main        = TeX("$\\Delta BDI$"))           # Titel

# PDF Speicherung
dev.copy2pdf(
  file        = file.path(fig_dir, "11_deskr_balk_box.pdf"),
  width       = 8,
  height      = 5)


# Abbildung 2: Histogramme
# ---------------------------------------------
graphics.off()                                # Schließt alle eventuell noch offenen graphics devices
dev.new()

# Histogrammparameter
h           = 1                               # gewünschte Klassenbreite
b_0         = min(D$Delta.BDI)                # b_0
b_k         = max(D$Delta.BDI)                # b_0
k           = ceiling((b_k - b_0)/h)          # Anzahl der Klassen
b           = seq(b_0, b_k, by = h)           # Klassen [b_{j-1}, b_j[
ylimits     = c(0,.25)                        # y-Achsenlimits
xlimits     = c(-2,14)                        # x-Achsenlimits
therapie    = c("Klassisch" , "Online")       # Therapiebedingungen
labs        = c("Klassische Therapie",        # Abbildungslabel
                "Online Therapie")

# Abbildungsparameter
par(                                          # für Details siehe ?par
  mfcol       = c(1,2),                       # 1 x 2 Panelstruktur
  family      = "sans",                       # Serif-freier Fonttyp
  pty         = "m",                          # Maximale Abbildungsregion
  bty         = "l",                          # L förmige Box
  las         = 1,                            # Horizontale Achsenbeschriftung
  xaxs        = "i",                          # x-Achse bei y = 0
  yaxs        = "i",                          # y-Achse bei x = 0
  font.main   = 1,                            # Non-Bold Titel
  cex         = 1,                            # Textvergrößerungsfaktor
  cex.main    = 1)                            # Titeltextvergrößerungsfaktor

# Iteration über Therapiebedingungen
for(i in 1:2){
  hist(
    D$Delta.BDI[D$Bedingung == therapie[i]],  # Delta.BDI Werte von Therapiebedingung i
    breaks    = b,                            # Histogrammklassen
    freq      = F,                            # normierte relative Häufigkeit
    xlim      = xlimits,                      # x-Achsenlimits
    ylim      = ylimits,                      # y-Achsenlimits
    xlab      = TeX("$\\Delta$ BDI"),         # x-Achsenbeschriftung
    ylab      = "",                           # y-Achsenbeschriftung
    main      = labs[i])                      # Titelbeschriftung
}

# PDF Speicherung
dev.copy2pdf(
  file        = file.path(fig_dir, "11_deskr_hist.pdf"),
  width       = 8,
  height      = 4)

graphics.off()