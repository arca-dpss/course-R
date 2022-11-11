#---

# Inequality Pre-Processing

#---


# Importare Dati ----------------------------------------------------------

dat <- read.csv("exercises/data/inequality_sub.csv", 
                sep = ";", 
                header = TRUE)

# Check dei dati ----------------------------------------------------------

nrow(dat)
ncol(dat)
str(dat)

# Cambiamo i nomi delle colonne -------------------------------------------

# i nomi delle colonne vanno bene ma spesso è meglio semplicificare il più
# possibile

# in particolare:
# - usare lo stesso carattere (esempio "_") per separare parole nei nomi delle
#   colonne
# - togliere i caratteri strani (esempio "..")
# - mettere tutto in minuscolo

# gsub permette di sostituire un certo carattere o pattern di caratteri in
# tutte le stringhe

new_names <- tolower(names(dat)) # tutto minuscolo
new_names <- gsub("\\.$", "", new_names) # se la stringa finisce con un ., toglilo
new_names <- gsub("\\.\\.", "_", new_names)
new_names <- gsub("\\.", "_", new_names)

names(dat) <- new_names # cambiamo i nomi delle colonne

# Tipologia colonne -------------------------------------------------------

# alcune colonne numeriche sono trattate come caratteri perchè la virgola
# è usata per separare i decimali (in R usiamo il punto)

head(dat$environmental_concern)

# se proviamo a convertire in numero questo non funziona

head(as.numeric(dat$environmental_concern))

# dobbiamo prima sostituire la virgola con il punto e poi convertire
# vediamo tutte le colonne che hanno una virgola (?any)

cols_with_comma <- sapply(dat, function(x) any(grepl(",", x)))
cols_with_dots <- lapply(dat[, cols_with_comma], function(x) gsub(",", ".", x))

# convertiamo le colonne

cols_with_dots <- lapply(cols_with_dots, as.numeric)

# mettiamo le colonne "giuste" al nostro dataframe

dat_new <- dat[, !cols_with_comma]

dat_new <- cbind(dat_new, cols_with_dots)

# rimettiamo in ordine le colonne

dat_new <- dat_new[new_names]


# quanti NA? --------------------------------------------------------------

# vediamo quanti NA ci sono in ogni colonna e in caso eliminiamo le colonne
# che hanno troppe informazioni mancanti

perc_NA <- sapply(dat_new, function(x) mean(is.na(x))) # % di NA per ogni colonna


# Semplifichiamo i caratteri ----------------------------------------------

# alcune colonne possono essere semplificate per fare grafici e colonne

head(dat_new$gender)

dat_new$gender_s <- ifelse(dat_new$gender == "Female", "f", "m")
dat_new$socioeconomic_class <- case_when(
    dat_new$socioeconomic_class == 1 ~ "low",
    dat_new$socioeconomic_class == 2 ~ "low-medium",
    dat_new$socioeconomic_class == 3 ~ "medium",
    dat_new$socioeconomic_class == 4 ~ "high",
    TRUE ~ "crazy"
)

# Scoring -----------------------------------------------------------------

# facciamo lo scoring del questionario environmental concern e progressive
# taxation
# environmental concern to reverse 2, 4, 6, 8, 10, 12, 14
# progressive taxation to reverse 3, 4
