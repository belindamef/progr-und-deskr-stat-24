# Beispiel für simples Datenanalyseskript. 

# Directory and file name Management
work_dir = getwd()                                 # Working directory (Pfad)
data_dir = file.path(work_dir, "Data")             # Datenverzeichnispfad
results_dir = file.path(work_dir, "Results")       # Ergebnisverzeichnispfad

rawdata_fname = "cushny.csv"                       # (base) Daten filename
rawdata_fpath = file.path(data_dir, rawdata_fname) # Rohdaten Dateipfad (Input)
out_fname = readline(                              # User Input als Dateinamen verwenden
  "Wie soll die Output-Datei heißen? Dateiname: \n\n")
# out_fname = "descr_stats.csv"                    # (base) Results filename in Skript definieren
out_fpath = file.path(results_dir, out_fname)      # Ergebnisse Dateipfad (Output)

# Datenimport
Data_df = read.table(rawdata_fpath)                # Einlesen der Datei

# Compute and print descriptive statistics
descr_stats = summary(Data_df)                     # Deskriptive Statistiken berechnen
print(descr_stats)                                 # Ergebnisse ausgeben

# Datenexport
write.table(descr_stats,                           # Daten, die gespeichert werden sollen
  file = out_fpath,                                # Pfad/Dateiname (Speicherort)
  sep = "\t",                                      # Werteseperator (hier: Kommata, weil csv)
  row.names = T)                                   # keine Zeilennamen
