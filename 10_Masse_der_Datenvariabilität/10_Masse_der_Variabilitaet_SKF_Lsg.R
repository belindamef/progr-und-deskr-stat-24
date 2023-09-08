# Beispiellösung für Selbstkontrollfragen aus Einheit (10) "Maße der Daten- 
# Variabilität" des Kurses "Programmierung und Deskriptive Statistik" im WS 22/23
#
# author: Belinda Fleischmann

# Directory management
work_dir = getwd()                                   # Working directory
data_dir = file.path(work_dir, "Data")               # Datenverzeichnispfad
fig_dir = file.path(work_dir, "Figures")             # Figures-Verzeichnispfad
rawdata_fname = "psychotherapie_datensatz.csv"       # (base) Daten filename
rawdata_fpath = file.path(data_dir, rawdata_fname)   # Rohdaten Dateipfad (Input)

# Output-Ordner erstellen, falls nicht existent
if (!file.exists(fig_dir)){
 dir.create(fig_dir)
}

# Import and prepare data
Data_df =  read.table(rawdata_fpath, sep = ",", header = T)
x       =  Data_df$Post.BDI             # double Vektor der Post-BDI Werte

# ------SKF 2) Spannbreite der Post.BDI Daten-----------------------------------
# "Manuelle" Berechnung
x_max   = max(x)                  # Maximum
x_min   = min(x)                  # Mininum
sb       = x_max - x_min           # Spannbreite
cat("Spannbreite (manuell): ", sb)

# automatische Spannbreitenberechnung
MinMax  = range(x)                # "automatische" Berechnung von min(x), max(x)
sb       = MinMax[2] - MinMax[1]  # Spannbreite
cat("\nSpannbreite (automatisch): ", sb)

# ------SKF 4) (empirische) Stichprobenvarianz der Post.BDI Daten---------------

# ------Stichprobenvarianz---------------------------------
# "Manuelle" Berechnung
n       = length(x)                       # Anzahl der Werte
s2      = (1/(n-1))*sum((x - mean(x))^2)  # Stichprobenvarianz
cat("\nStichprobenvarianz (manuell): ", s2)

# Berechnung mit var()
s2      = var(x)                          # "automatische" Stichprobenvarianz
cat("\nStichprobenvarianz (automatisch): ", s2)

# ------ empirische Stichprobenvarianz---------------------
# "Manuelle" Berechnung
s2_tilde = (1/n)*sum((x - mean(x))^2)     # Empirische Stichprobenvarianz
cat("\nEmpirische Stichprobenvarianz (manuell): ", s2_tilde)

# Berechnung mit var()
s2_tilde = ((n-1)/n)*var(x)               # "automatische" empirische Stichprobenvarianz
cat("\nEmpirische Stichprobenvarianz (automatisch): ", s2_tilde)

# ------SKF 8) (empirische) Stichprobenstandardabweichung der Post.BDI Daten----

# ------Stichprobenstandardabweichung----------------------------------
# "Manuelle" Berechnung
n     = length(x)                             # Anzahl der Werte
s     = sqrt((1/(n-1))*sum((x - mean(x))^2))  # Standardabweichung
cat("\nStichprobenstandardabweichung (manuell): ", s)

# Berechnung mit sd()
s     = sd(x)                                 # "automatische" Berechnung
cat("\nStichprobenstandardabweichung (automatisch): ", s)

# ------ empirische Stichprobenstandardabweichung---------------------
# "Manuelle" Berechnung
s_tilde	= sqrt((1/(n))*sum((x - mean(x))^2))  # empirische Standardabweichung
cat("\nEmpirische Stichprobenstandardabweichung (manuell): ", s_tilde)
# Berechnung mit sd()
s_tilde	= sqrt((n-1)/n)*sd(x)                 # "automatische" Berechnung
cat("\nEmpirische Stichprobenstandardabweichung (automatisch): ", s_tilde)

