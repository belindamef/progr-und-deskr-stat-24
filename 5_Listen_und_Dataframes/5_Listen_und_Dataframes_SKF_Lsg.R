# Beispiellösung für Selbstkontrollfragen aus Einheit (5) "Listen und
# Dataframes" des Kurses "Programmierung und Deskriptive Statistik" im WS 23/24
#
# Autorin: Belinda Fleischmann

# ------SKF 3------
eine_liste <- list(c(FALSE, FALSE, FALSE),
                   "Sind alle Elemente falsch?",
                   TRUE,
                   abs)

# ------SKF 4------
# L[1] indiziert das erst Listenelement als Liste, während L[[1]] den Inhalt
# des Listenelements indiziert.

# Demonstration
eine_liste[4](-5)   # Indiziert das 4. Listenelement als "Listeneintrag"
eine_liste[[4]](-5) # Indiziert den Inhalt des 4. Listenelements,
                    # i.e. die Funktion `abs()`

typeof(eine_liste[4])
class(eine_liste[[4]])

# ------SKF 5------
fragen <- list("Ist blau eine Farbe?",
               "Was ist die Summe von ...?",
               "Antwort auf alle Fragen?")
antworten <- list(TRUE,
                  sum,
                  42)
q_and_a <- c(fragen, antworten)

# ------SKF 10------
iq_data_df <- data.frame(id      = seq(101, 130),
                         age     = sample(18:99, 30, replace = TRUE),
                         iq      = rnorm(30, mean = 100, sd = 15),
                         dropout = rbinom(30, 1, 0.05))
