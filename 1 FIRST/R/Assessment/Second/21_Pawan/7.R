

# dataset
aq <- airquality
head(aq)
str(aq)
View(aq)
1.
# gof test for temp variable 
# test normality 
# using confirmative test : kolmogorov-smirov test for sample size 153
ks.test(aq$Temp,'pnorm')

2.
library(caret)
leveneTest(Temp~factor(Month),data = aq)

?Tukey

3. 
#Since the p-value is less than 0.05 , we need to use post-hoc test. 

4.
#The best independent sample statistical test for the data is TukeyHSD test

TukeyHSD(aov(Temp~factor(Month),data = aq))

?leveneTest()
