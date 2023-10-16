# Beispiellösung für Selbstkontrollfragen aus Einheit (4) "Matrizen"
# des Kurses "Programmierung und Deskriptive Statistik" im WS 23/24
#
# author: Belinda Fleischmann

# ------SKF 2------
A <- matrix(c(4, 3, 2, 1,
              3, 2, 1, 4,
              2, 1, 4, 3),
            nrow = 3,
            byrow = TRUE)
B <- matrix(c(1, 0, 1, 0,
              0, 1, 0, 1,
              1, 0, 1, 0),
            nrow = 3,
            byrow = TRUE)

# ------SKF 3------
a_2 <- A[2, ]

# ------SKF 4------
b_.13 <- B[, c(1, 3)]

# ------SKF 5------
B[B == 0] <- -1

# ------SKF 6------
A[2, ] <- seq(1, 4)

# ------SKF 7------
A + B

# ------SKF 8------
A * 3

# ------SKF 9------
rbind(A, B)

# ------SKF 10------
cbind(A, B)
