# Dieses Skript generiert einen Beispieldatensatz einer klinisches Studie zur 
# Wirksamkeit unterschiedlicher Therapiemethoden, gemessen an prä- und post-
# BDI-scores. 
# Kurs:  "Programmierung und Deskriptive Statistik" im WS 22/23


# Datenmanagement
data_dir = file.path(getwd(), "Data")  # Pfad zum Datenorder (output der Simulation)

# Seed setzen
set.seed(5)                         # Für Replizierbarkeit

# Simulationsparameter
n      = 50                         # Anzahl Proband:innnen pro Gruppe
mu     = c(18, 12, 19, 14)          # \mu's (prä-klassisch, post-klassisch, prä-online, post-online)
sigsqr = 3                          # \sigma^2

# Datensimulation 
D = data.frame(
  c(rep("Klassisch",n), rep("Online", n)),
  c(round(rnorm(n, mu[1], sqrt(sigsqr))), round(rnorm(n, mu[3], sqrt(sigsqr)))),
  c(round(rnorm(n, mu[2], sqrt(sigsqr))), round(rnorm(n, mu[4], sqrt(sigsqr)))))
colnames(D)  = c("Bedingung", "Pre BDI", "Post BDI")

# Datenspeicherung
fname        = file.path(data_dir, "psychotherapie_datensatz.csv") 
write.csv(D, file = fname, row.names = F)