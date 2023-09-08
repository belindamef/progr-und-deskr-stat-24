# Dieses Skript schätzt Parameter und Konfidenzintervalle. 

# Kurs:  "Programmierung und Deskriptive Statistik" im WS 22/23

# Pakete laden
library(latex2exp)   # Für LaTeX-Schriftformatierung

# Datenmanagement
data_dir = file.path(getwd(), "Data")  # Pfad zum Datenordner (output der Simulation)
deskr_skript_pfad = file.path(getwd(), 
                              "11_Anwendungsbeispiele", 
                              "1_Deskriptive_Stat.R")

# ------Deskriptive Statistiken auswerten---------------------------------------
source(deskr_skript_pfad)

# ------Parameterschätzung------------------------------------------------------
# Initialisierung eines Dataframes
tp          = c("Klassisch", "Online")                  # Therapiebedingungen
ntp         = length(tp)                                # Anzahl Therapiebedingungen
theta_hats  = data.frame(
  mu_ML= rep(NaN,ntp),                                  # ML Schätzer für \mu_i
  sigsqr_VAR = rep(NaN,ntp))                            # Varianzschätzer für \sigma^2_i

# Iterationen über Therapiebedingungen
for(i in 1:ntp){
  data            = D$Delta.BDI[D$Bedingung == tp[i]]   # Daten
  theta_hats$mu_ML[i]      = mean(data)                 # ML Schätzer für \mu_i
  theta_hats$sigsqr_VAR[i] = var(data)                  # Varianzschätzer für \sigma_2^_i
}

# Ausgabe
cat('\n\nParameterschaetzung: \n\n')
print(theta_hats)

# ------Konfidenzintervalle bestimmen-------------------------------------------

# -----------------------------
# Für Erwartungswertparameter
# -----------------------------

# Analyseparameter
t       = c("Klassisch", "Online")         # Therapiebedingungen
ntp     = length(tp)                       # Anzahl an Therapiebedingungen
n       = 50                               # Anzahl von Beobachtungen pro Therapiebedingung
C_mu    = data.frame(                      # Dataframeerzeugung
  G_u       = rep(NaN,ntp),                # untere KI Grenze
  mu_hat    = rep(NaN,ntp),                # Erwartungswertparameterschätzer
  G_o       = rep(NaN,ntp),                # obere KI Grenze
  row.names = tp)                          # Therapiebedingungen

# Konfidenzintervallparameter
delta   = 0.95                             # Konfidenzlevel
psi_inv = qt((1+delta)/2,n-1)              # \psi^-1((\delta + 1)/2, n-1)

# Konfidenzintervallevaluation
for(i in 1:ntp){
  data        = D$Delta.BDI[D$Bedingung == t[i]]  # Stichprobenrealisierung
  X_bar       = mean(data)                        # Stichprobenmittel
  S           = sd(data)                          # Stichprobenstandardabweichung
  C_mu$G_u[i]    = X_bar - (S/sqrt(n))*psi_inv    # untere KI Grenze
  C_mu$mu_hat[i] = X_bar                          # Erwartungswertparameterschätzer
  C_mu$G_o[i]    = X_bar + (S/sqrt(n))*psi_inv    # obere KI Grenze
  }

# Ausgabe
cat('\n\nKonfidenzintervall für Erwartungswertparameter: \n\n')
print(C_mu)

# -----------------------------
# Für Varianzparameter
# -----------------------------

# Analyseparameter
t       = c("Klassisch", "Online")                    # Therapiebedingungen
ntp     = length(tp)                                  # Anzahl an Therapiebedingungen
n       = 50                                          # Anzahl von BeobaC_sigsqrhtungen pro Therapiebedingung
C_sigsqr     = data.frame(                            # Dataframeerzeugung
  G_u        = rep(NaN,ntp),                          # untere KI Grenze
  sigsqr_hat = rep(NaN,ntp),                          # Varianzparameterschätzer
  G_o        = rep(NaN,ntp),                          # obere KI Grenze
  row.names  = tp)                                    # Therapiebedingungen

# Konfidenzintervallparameter
delta   = 0.95                                        # Konfidenzlevel
xi_1    = qchisq((1-delta)/2, n - 1)                  # \Xi^2((1-\delta)/2; n - 1)
xi_2    = qchisq((1+delta)/2, n - 1)                  # \Xi^2((1+\delta)/2; n - 1)

# Konfidenzintervallevaluation
for(i in 1:ntp){
  data            = D$Delta.BDI[D$Bedingung == t[i]]  # Stichprobenrealisierung
  S2              = var(data)                         # Stichprobenvarianz
  C_sigsqr$G_u[i]        = (n-1)*S2/xi_2              # untere KI Grenze
  C_sigsqr$sigsqr_hat[i] = S2                         # Varianzparameterschätzer
  C_sigsqr$G_o[i]        = (n-1)*S2/xi_1              # obere KI Grenze
  }

# Ausgabe
cat('\n\nKonfidenzintervall für Varianzparameter: \n\n')
print(C_sigsqr)
