# Dieses Skript generiert einen Beispieldatensatz einer klinisches Studie zur
# Wirksamkeit unterschiedlicher Therapiemethoden, gemessen an Pre- und Post-
# BDI-Scores.

# Kurs:  "Programmierung und Deskriptive Statistik" im WS 23/24

# Directory management
work_dir <- getwd()                                      # Working directory
data_dir <- file.path(work_dir, "Daten")                 # Datenverzeichnispfad

# Anmerkung:
# -----------
# Anders als bei unseren bisherigen Skripten, in denen wir Daten von einem
# data_directory geladen (read.table()) haben, schreiben wird in diesem SKript
# unsere simulierten Daten in das data_directoy.


# Seed setzen
set.seed(5)                 # Für Replizierbarkeit

# Anmerkung:
# -----------
# Der seed-Wert ist ein Startwert für den Zufallsgenerator.
# Computerbasierte Zufallsgeneratoren erzeugt idR Pseudo-Zufallszahlen.
# Der Seed (Samen) ist der Ausgangswert für den Prozess.
# Wenn wir denn seed-Wert gleich halten, werden auch mit jeder Realisierung
# einer Zufallsvariablen die exact gleichen Werte "zufällig" gezogen.
# Damit ist unsere Datensimulation _replizierbar_.

# Simulationsparameter
n <- 50                     # Anzahl Proband:innnen pro Gruppe
mu <- c(                    # \mu- Werte (Erwartungswertparameter)
  18,  # Pre-Klassisch
  12,  # Post-Klassisch
  19,  # Pre-Online
  14   # Post-Online
)
sigsqr <- 3                 # \sigma^2 (Varianzparameter)
                            # (gleich für beide Gruppen und Messzeitpunkte)

# Datensimulation (und direkte Zuweisung in Spalten eines Dataframes)
daten <- data.frame(
  "Bedingung" = c(
    rep("Klassisch", n),    # Repliziere den character Wert "Klassisch" n mal
    rep("Online", n)        # Repliziere den character Wert "Online" n mal
  ),
  "Pre BDI" = c(
    # Für die ersten n Zeilen der Spalte "Pre BDI"
    round(                  # Runde die gegebenen Werte
      rnorm(                # Erzeuge "zufällige" Werte aus einer Normalverteil.
        n    = n,           # ... und zwar n Werte,
        mean = mu[1],       # ... mit Erwartungswertparameter mu[1]
        sd   = sqrt(sigsqr) # ... und Standardabweichungsparameter sigsqr
      )
    ),
    # Für die letzten n Zeilen der Spalte "Pre BDI"
    round(                  # Runde die gegebenen Werte
      rnorm(                # Erzeuge "zufällige" Werte aus einer Normalverteil.
        n    = n,           # ... und zwar n Werte,
        mean = mu[3],       # ... mit Erwartungswertparameter mu[3]
        sd   = sqrt(sigsqr) # ... und Standardabweichungsparameter sigsqr
      )
    )
  ),
  "Post BDI" = c(
    # Für die ersten n Zeilen der Spalte "Post BDI"
    round(                  # Runde die gegebenen Werte
      rnorm(                # Erzeuge "zufällige" Werte aus einer Normalverteil.
        n    = n,           # ... und zwar n Werte,
        mean = mu[2],       # ... mit Erwartungswertparameter mu[2]
        sd   = sqrt(sigsqr) # ... und Standardabweichungsparameter sigsqr
      )
    ),
    # Für die letzten n Zeilen der Spalte "Post BDI"
    round(                  # Runde die gegebenen Werte
      rnorm(                # Erzeuge "zufällige" Werte aus einer Normalverteil.
        n    = n,           # ... und zwar n Werte,
        mean = mu[4],       # ... mit Erwartungswertparameter mu[4]
        sd   = sqrt(sigsqr) # ... und Standardabweichungsparameter sigsqr
      )
    )
  )
)

# Datenspeicherung
fname <- file.path(data_dir, "psychotherapie_datensatz.csv")
write.csv(daten, file = fname, row.names = FALSE)
