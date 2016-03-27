### Merging Excel File

#deleted island species
mom5 <- read.csv("MOMv5.csv", header=TRUE) #5748 species
momT <- read.csv("MOMtrophi.csv", header=TRUE) #5756 species

#select specific columns from mom TROPHIC to merge with MOM5
momTroph <- subset(momT, select = c(binomial, Unique.ID, trophic, ref.for.trophic, habitat.mode)) #select only the columns we want to merge

#need to merge based upon not only binomial, but also continent!!
#created 2 new columns in MOM5 and MOMT: binomial, and Unique ID (which is Continent code + binomial)
new_mom <- merge(mom5, momTroph, by.x = "Unique.ID", by.y = "Unique.ID", all.x = TRUE) #match by common columns; do all.x and all.y to save all binomials
#write.table(new_mom, file = "merged_MOM.csv", sep = ",") 
#View(new_mom) #5937 species (200 sp different between two files)
#binomial.y = species in momT; binomial.x = species in mom5

merge <- read.table("merged_MOM.csv", header = TRUE, sep = ",") #5764 species 

#trying to figure out the discrepency between the two files, and why we have so many extra species
require(plyr)
mom5_Stats <- ddply(mom5, 'Genus', function(.df){ #did by continent as well
  N <- length(.df$Unique.ID)
  ret <- N
})

momT_Stats <- ddply(momT, 'Genus', function(.df){ #did by continent as well
  N <- length(.df$Unique.ID)
  ret <- N
})

Stats <- merge(mom5_Stats, momT_Stats, by.x = "Genus", by.y = "Genus", all.x = TRUE, all.y = TRUE)
View(Stats)
# found 2 extra bovidae in momT, 1 extra canidae in mom5, 4 extra equidae in momT, 1 extra mustelidae in momT, 1 extra procyonidae in momT, 1 extra pterapodidae in momT, 1 extra vespertilionidae in mom5
# 8 speices without a continent ID
# 23 species in momT, but not mom5


