# Beispiellösung für Selbstkontrollfragen aus Einheit (5) "Listen und Dataframes"
# des Kurses "Programmierung und Deskriptive Statistik" im WS 22/23
#
# author: Belinda Fleischmann

# ------SKF 3------
eine_liste = list(c(1,2,3),
                  "nur ein Wort",
                  FALSE,
                  sqrt)

# ------SKF 4------
# L[1] indiziert das erst Listenelement als Liste, während L[[1]] den Inhalt des 
# Listenelements indiziert.

# ------SKF 5------
fragen = list("Ist blau eine Farbe?",
              "Was ist die Summe von ...?",
              "Antwort auf alle Fragen?")
antworten = list(T, 
                 sum, 
                 42)
q_and_a = c(fragen, antworten)

# ------SKF 10------
iq_data_df = data.frame(id      = seq(101,130),
                        age     = sample(18:99, 30, replace=T),
                        iq      = rnorm(30, mean=100, sd=15),
                        dropout = rbinom(30, 1, 0.05))

