

library(ggplot2)
library(tidyverse)

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy),color="blue")

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy,color="blue"))
             

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy,size=class))

             
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy,alpha=class))

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy,shape=class))


str(mpg)
table(mpg$class)
##############################

# FACET GRAPH

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  facet_wrap(~class,nrow=2)

# 3 X 4 =12 levels of two variables
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(drv~cyl)

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(drv~.)

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(.~cyl)
#################################

# Geometric object

#Smoothing to be done after log transformation

ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ,y=hwy))


ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ,y=hwy,linetype=drv))


ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  geom_smooth(mapping = aes(x=displ,y=hwy,linetype=drv))

ggplot(data=mpg,mapping = aes(x=displ,y=hwy))+
  geom_point(mapping = aes(color=class))+
  geom_smooth()
               

ggplot(data=mpg,mapping = aes(x=displ,y=hwy))+
    geom_point(mapping = aes(color=class))+
    geom_smooth(data=filter(mpg,class=="subcompact"),se=F)

############################3
ggplot(data=diamonds)+
  stat_count(mapping = aes(x=cut))

##########################
ggplot(data=diamonds)+
  stat_summary(mapping = aes(x=cut,y=depth),
               fun.min = min,
               fun.max = max,
               fun=median
               )
######################3

ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut,colour=cut))

ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut,fill=cut))

# POSITION ADJUSTMENT
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut,fill=clarity))

# Transparency with alpha
ggplot(data=diamonds,mapping = aes(x=cut,fill=clarity))+
  geom_bar(alpha=1/5,position="identity")


ggplot(data=diamonds,mapping = aes(x=cut,colour=clarity))+
  geom_bar(fill= NA,position="identity")

ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut,fill=clarity),position="dodge")

