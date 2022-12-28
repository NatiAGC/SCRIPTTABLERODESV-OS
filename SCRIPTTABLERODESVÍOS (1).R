library(readxl)
library (writexl)
library(tidyverse)
library (dplyr)
library(stringr)


SUACIOCT2022 <- read.csv ("C:/Users/natva/OneDrive/Escritorio/AGC_DATOS/Exportaciones/SUACI_NOV22.csv")

SUACIOCT2022 <- SUACIOCT2022 %>%
  rename ( 'FECHA' = "Fecha.de.inicio")

SUACIOCT2022 <- SUACIOCT2022 %>%
  separate(FECHA, 
         into = c("DATE", "HORA"), 
         sep = " ")

write_xlsx(x=SUACIOCT2022, path = "C:/Users/natva/OneDrive/Escritorio/AGC_DATOS/Exportaciones/SUACI_NOV22.xlsx")

SUACIOCT2022 <- SUACIOCT2022 %>%
  Filter ( DATE > "01/10/2022")


PlanillaOCT <- read_xlsx ("C:/Users/natva/OneDrive/Escritorio/AGC_DATOS/Exportaciones/AnalistaNOV.xlsx")

AREAS <- read_xlsx("C:/Users/natva/OneDrive/Escritorio/AGC_DATOS/RESULTADOS_CONTROLES/CARGAS051222.xlsx")


#AREAS <- AREAS %>%
#  select ("N Denuncia", "SGO a la que fue planificada")%>%
#  rename ('NSUACI' = "N Denuncia")%>%
#  rename ('AREA' = "SGO a la que fue planificada")

AREAS <- AREAS %>%
  select ("NSUACI", "SGO")

PlanillaOCT$NSUACI <- gsub(" |\r\n|\n|\r|", "", PlanillaOCT$NSUACI)

AREAS$NSUACI <- gsub(" |\r\n|\n|\r|", "", AREAS$NSUACI)

PlanillaFinal <- left_join(PlanillaOCT, AREAS, BY= NSUACI)


PlanillaFinal <- PlanillaFinal %>%
  rename ('AREA' ="SGO")

PlanillaFinal <- PlanillaFinal %>%
  separate(AREA, 
           into = c("DG", "SGO"), 
           sep = "-")


write_xlsx(x=PlanillaFinal, path = "C:/Users/natva/OneDrive/Escritorio/AGC_DATOS/Exportaciones/PlanillaOCT.xlsx")

