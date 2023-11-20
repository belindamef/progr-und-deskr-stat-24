# Beispiel für simples Datenanalyseskript.
#
# Programmierung und Deskriptive Statistik WiSe 2023/24

# -----Directory & Paths Management--------------------------------------
# Definiere Pfade zu Daten- und Ergebnisordnern
work_dir <- getwd()                              # Working directory (Pfad)
data_dir <- file.path(work_dir, "Daten")         # Datenverzeichnispfad
results_dir <- file.path(work_dir, "Ergebnisse") # Ergebnisverzeichnispfad

# Definiere Input Dateiname (filname)
rawdat_fn <- "cushny.csv"                        # Rohdaten Dateiname
rawdat_fpath <- file.path(data_dir, rawdat_fn)   # Rohdaten Dateipfad

# Definiere Output Dateiname
out_fn <- readline(                              # User Input verwenden
                   paste("Wie soll die Output-Datei heißen? ",
                         "Dateiname: \n\n"))
#out_fn <- "dskr_stat.tsv"                       # Alternativ: Skript definieren # nolint
out_fpath <- file.path(results_dir, out_fn)      # Ergebnisse Dateipfad (Output)

# ------Datenimport------------------------------------------------------
daten_df <- read.table(rawdat_fpath)             # Einlesen der Datei

# Compute and print descriptive statistics
deskr_stat <- summary(daten_df)                  # Deskriptive Stat. berechnen
print(deskr_stat)                                # Ergebnisse ausgeben

# ------Datenexport-------------------------------------------------------
# Erstelle Ergebnisordner, falls nicht existent
if (!file.exists(results_dir)) {
  # If it doesn't exist, create the directory
  dir.create(results_dir)
  cat("Directory created:", results_dir, "\n")
} else {
  cat("Directory already exists:", results_dir, "\n")
}

# Speichere Ergebnisse
write.table(
            deskr_stat,             # Zu speichernde Daten
            file = out_fpath,        # Dateipfad (Speicherort)
            sep = "\t",              # Werteseperator (hier: tab)
            row.names = TRUE)        # keine Zeilennamen
