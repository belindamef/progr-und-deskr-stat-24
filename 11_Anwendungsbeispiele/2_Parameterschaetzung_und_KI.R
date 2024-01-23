# Dieses Skript schätzt Parameter und Konfidenzintervalle.

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

# ------Deskriptive Statistiken auswerten--------------------------------------
deskr_skript_pfad <- file.path(                   # Pfad zum Skript deskr. Stat.
  work_dir,
  "11_Anwendungsbeispiele",
  "1_Deskriptive_Stat.R"
)
source(deskr_skript_pfad)                         # Führt gesamtes Skript aus

# ------Parameterschätzung-----------------------------------------------------
# Analyseparameter
th_bed <- c("Klassisch", "Online")      # Therapiebedingungen
n_th_bed <- length(th_bed)              # Anzahl an Therapiebedingungen
n <- 50                                 # Anzahl  Beobachtungen pro Therapiebed.

# Initialisierung eines Dataframes
theta_hats <- data.frame(
  mu_hat      = rep(NaN, n_th_bed),     # ML Schätzer für \mu_i
  sigsqr_hat = rep(NaN, n_th_bed)       # Varianzschätzer für \sigma^2_i
)

# Iterationen über Therapiebedingungen
for (i in 1:n_th_bed){
  data <- daten$Delta.BDI[daten$Bedingung == th_bed[i]]        # Daten
  theta_hats$mu_hat[i] <- mean(data)                    # MLS  für \mu_i
  theta_hats$sigsqr_hat[i] <- var(data)                # Schätzer für \sig^2_i
}

# Ausgabe
cat("\n\nParameterschaetzung: \n\n")
print(theta_hats)

# ------Konfidenzintervalle bestimmen-------------------------------------------

# Für Erwartungswertparameter \mu
# --------------------------------

# Analyseparameter
th_bed <- c("Klassisch", "Online")  # Therapiebedingungen
n_th_bed <- length(th_bed)          # Anzahl an Therapiebedingungen
n <- 50                             # Anzahl von Beobachtungen pro Therapiebed.

# Iterationen über Therapiebedingungen
ki_mu <- data.frame(                          # Dataframeerzeugung
  untere_Grenze = rep(NaN, n_th_bed),         # untere KI Grenze
  mu_hat        = rep(NaN, n_th_bed),         # Erwartungswertparameterschätzer
  obere_Grenze  = rep(NaN, n_th_bed),         # obere KI Grenze
  row.names     = th_bed                      # Therapiebedingungen
)

# Konfidenzintervallparameter
delta   <- 0.95                               # Konfidenzlevel
psi_inv <- qt((1 + delta) / 2, n - 1)         # \psi^-1((\delta + 1)/2, n-1)

# Konfidenzintervallevaluation
for (i in 1:n_th_bed){
  data <- daten$Delta.BDI[daten$Bedingung == th_bed[i]]
  x_bar <- mean(data)                            # Stichprobenmittel
  std <- sd(data)                                # Stichprobenstandardabweichung
  ki_mu$untere_Grenze[i] <- x_bar - (std / sqrt(n)) * psi_inv # untere KI Grenze
  ki_mu$mu_hat[i] <- x_bar                                    # \mu Schätzer
  ki_mu$obere_Grenze[i] <- x_bar + (std / sqrt(n)) * psi_inv  # obere KI Grenze
}

# Ausgabe
cat("\n\nKonfidenzintervall für Erwartungswertparameter: \n\n")
print(ki_mu)

# -----------------------------
# Für Varianzparameter
# -----------------------------

# Analyseparameter
th_bed <- c("Klassisch", "Online")  # Therapiebedingungen
n_th_bed <- length(th_bed)          # Anzahl an Therapiebedingungen
n <- 50                             # Anzahl von Beobachtungen pro Therapiebed.

# Initialisierung eines dataframes
ki_sigsqr <- data.frame(
  untere_Grenze = rep(NaN, n_th_bed),               # untere KI Grenze
  sigsqr_hat    = rep(NaN, n_th_bed),               # Varianzparameterschätzer
  obere_Grenze  = rep(NaN, n_th_bed),               # obere KI Grenze
  row.names     = th_bed                            # Therapiebedingungen
)

# Konfidenzintervallparameter
delta <- 0.95                                       # Konfidenzlevel
xi_1  <- qchisq((1 - delta) / 2, n - 1)             # \Xi^2((1-\delta)/2; n - 1)
xi_2  <- qchisq((1 + delta) / 2, n - 1)             # \Xi^2((1+\delta)/2; n - 1)

# Konfidenzintervallevaluation
for (i in 1:n_th_bed){
  data <- daten$Delta.BDI[daten$Bedingung == th_bed[i]]
  s2 <- var(data)                                   # Stichprobenvarianz
  ki_sigsqr$untere_Grenze[i] <- (n - 1) * s2 / xi_2 # untere KI Grenze
  ki_sigsqr$sigsqr_hat[i] <- s2                     # Varianzparameterschätzer
  ki_sigsqr$obere_Grenze[i] <- (n - 1) * s2 / xi_1  # obere KI Grenze
}

# Ausgabe
cat("\n\nKonfidenzintervall für Varianzparameter: \n\n")
print(ki_sigsqr)
