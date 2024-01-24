# Dieses Skript führt Hypothesentests durch.

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


# ------------------------------------------------------------------------------
#        Deskriptive Statistiken auswerten
# ------------------------------------------------------------------------------
deskr_skript_pfad <- file.path(                   # Pfad zum Skript deskr. Stat.
  work_dir,
  "11_Anwendungsbeispiele",
  "1_Deskriptive_Stat.R"
)
source(deskr_skript_pfad)                         # Führt gesamtes Skript aus

# ------------------------------------------------------------------------------
#        Parameter und Konfidenzintervalle schätzen
# -----------------------------------------------------------------------------

ps_ki_skript_pfad <- file.path(                   # Pfad zum Skript PS und KI
  work_dir,
  "11_Anwendungsbeispiele",
  "2_Parameterschaetzung_und_KI.R"
)
source(ps_ki_skript_pfad)                         # Führt gesamtes Skript aus

# ------------------------------------------------------------------------------
#        Hypothesentests
# ------------------------------------------------------------------------------

# Datenauswahl
y_1 <- daten$Delta.BDI[daten$Bedingung == "Klassisch"]  # Daten Klassische Th.
y_2 <- daten$Delta.BDI[daten$Bedingung == "Online"]     # Daten Online Th.
n_1 <- length(y_1)                                    # Stichprobengröße n_1
n_2 <- length(y_2)                                    # Stichprobengröße n_2

# ------Einstichproben T-Tests--------------------------------------------------

# ----------
# Kommentar:
# Wir führen hier Einstichproben T-Tests getrennt für beide Gruppen durch.
# Im Prinzp kann der Einstichproben T-Test natürlich auch für die gesamte
# Stichprobe, also unabhängig von Therapiebedingung durchgeführt werden.
# ----------

# Test-Parameter definieren
mu_0 <- 0            # H_0 Hypothesenparameter, hier \mu_0 = 0
alpha_0 <- 0.05      # Signifikanzniveau
k_alpha_0 <- qt(     # kritischer Wert (gleich für beide Gruppen, da n_1 = n_2)
  1 - (alpha_0 / 2), n_1 - 1
)

# Einstichproben T-Test mit den Daten der Gruppe Klassische Therapie
y_bar_1 <-  mean(y_1)               # Gruppenspez. Stichprobenmittel (Klassisch)
t_klassisch <- (                    # T-Teststatistik
  sqrt(n_1) * (
    (y_bar_1 - mu_0) / sd(y_1)
  )
)
if (abs(t_klassisch) > k_alpha_0) { # Test 1_{|t| >= k_alpha_0}
  phi_kl <- 1
} else {
  phi_kl <- 0
}

p_klassisch <- 2 * (1 - pt(t_klassisch, n_1 - 1))    # p-Wert

# Ausgabe
options(digits = 2)
cat(
  "\n\n\nManueller Einstichproben T-Test (Klassische Th): ",
  "\n\n\nParameterschätzwert    =", ki_mu[1, "mu_hat"],
  "\n95%-Konfidenzintervall =", ki_mu[1, "untere_Grenze"],
                                ki_mu[1, "obere_Grenze"],
  "\nSignifikanzlevel       =", alpha_0,
  "\nKritischer Wert        =", k_alpha_0,
  "\nTeststatistik          =", t_klassisch,
  "\nTestwert               =", phi_kl,
  "\np-Wert                 =", p_klassisch
)

cat("\n\n\nAutomatischer Einstichproben T-Test (Klassische Th):\n")
varphi_kl <- t.test(y_1)
print(varphi_kl)

# Einstichproben T-Test mit den Daten der Gruppe Klassische Therapie
y_bar_2  <- mean(y_2)       # Gruppenspezifisches Stichprobenmittel (Klassisch)
t_online <- sqrt(n_2) * ((y_bar_2 - mu_0) / sd(y_2)) # T-Teststatistik
if (abs(t_online) > k_alpha_0) {                     # Test 1_{|t| >= k_alpha_0}
  phi_kl <- 1
} else {
  phi_kl <- 0
}

p_online <- 2 * (1 - pt(t_online, n_1 - 1))         # p-Wert

# Ausgabe
options(digits = 2)
cat("\n\nManueller Einstichproben T-Test (Online-Th): ",
  "\n\nParameterschätzwert    =", ki_mu[1, "mu_hat"],
  "\n95%-Konfidenzintervall =", ki_mu[1, "untere_Grenze"], ki_mu[1, "obere_Grenze"],
  "\nSignifikanzlevel       =", alpha_0,
  "\nKritischer Wert        =", k_alpha_0,
  "\nTeststatistik          =", t_online,
  "\nTestwert               =", phi_kl,
  "\np-Wert                 =", p_online
)

cat("\n\n\nAutomatischer Einstichproben T-Test (Online-Th): \n")
varphi_onl <- t.test(y_2)
print(varphi_onl)

# Zweistichproben T-Test
mu_0 <- 0                           # H_0 Hypothesenparameter, hier \mu_0 = 0
alpha_0   <- 0.05                   # Signifikanzniveau
k_alpha_0 <- qt(                    # kritischer Wert
  1 - (alpha_0 / 2), n_1 + n_2 - 2
)
s_12      <- sqrt(                  # gepoolte Standardabweichung s_12
  (sum((y_1 - y_bar_1)^2)
   + sum((y_2 - y_bar_2)^2))
  / (n_1 + n_2 - 2)
)
t         <- (                      # Zweistichproben-T-Teststatistik
  sqrt((n_1 * n_2) / (n_1 + n_2))
) * ((y_bar_1 - y_bar_2 - mu_0) / s_12)
if (abs(t) >= k_alpha_0) {          # Test 1_{|t| >= k_alpha_0|}
  phi <- 1                          # Ablehnen von H_0
} else {
  phi <- 0                          # Nicht Ablehnen von H_0
}
pval      <- (2                     # p-Wert
  * (1 - pt(abs(t), n_1 + n_2 - 2))
)

# Ausgabe
cat("\nManueller Zweistichproben T-Test: \n\nx_bar_1   = ", y_bar_1,
    "\nx_bar_2   = ", y_bar_2,
    "\nfg        = ", n_1 + n_2 - 2,
    "\nalpha_0   = ", alpha_0,
    "\nk_alpha_0 = ", k_alpha_0,
    "\nt         = ", t,
    "\nphi       = ", phi,
    "\np-Wert    = ", pval)

# Automatischer Zweistichproben-T-Test
varphi <- t.test(                   # ?t.test für Details
  y_1,                              # Datensatz x_1
  y_2,                              # Datensatz x_2
  var.equal   = TRUE,               # \sigma_1^2 = \sigma_2^2
  alternative = c("two.sided"),     # H_1: \mu_1 \neq \mu_2
  conf.level  = 1 - alpha_0         # \delta = 1 - \alpha_0
)

# Ausgabe
cat("\n\n\nAutomatischer Zweistichproben T-Test (Online): \n")
print(varphi)

# Genauere Ausgabe t
paste(varphi[1])

# Genauere Ausgabe p
paste(varphi[3])