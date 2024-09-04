library(ggplot2)


# OLD approach
ggplot()+
  layer(data=diamonds,mapping = aes(x=carat,y=price),
        geom="point",stat="identity",position="identity")+
  scale_y_continuous()+
  scale_x_continuous()+
  coord_cartesian()



# GG plot using ggplot
ggplot(diamonds,aes(carat,price))+
  geom_point()+
  scale_y_continuous()+
  scale_x_continuous()

# GG plot
ggplot(diamonds,aes(carat,price))+
  geom_point()
#################

ggplot(diamonds,aes(carat,price))+
  geom_point()+
  stat_smooth(method = lm)+
  scale_y_log10()+
  scale_x_log10()


qplot(carat, price, data = diamonds,
      geom = c("point", "smooth"),
      method = "lm", log = "xy"
)
##########################33

ggplot(data=diamonds,mapping = aes(price))+
  (geom_histogram(stat="bin",position = "identity"))

#    OR

ggplot(diamonds,aes(x=price))+
         geom_histogram()

#      OR

qplot(price,data=diamonds,geom = "histogram")


#############################

ggplot(diamonds,aes(x="",fill=clarity))+
  geom_bar(width = 1)+
  coord_polar(theta="y")+
  theme_void()


###################

plot_troops <- ggplot(troops, aes(long, lat)) +
  geom_path(aes(size = survivors, color = direction,
                group = group))
plot_both <- troops_plot +
  geom_text(aes(label = city), size = 4, data = cities)
plot_polished <- both +
  scale_size(to = c(1, 10),
             breaks = c(1, 2, 3) * 10^5,
             labels = comma(c(1, 2, 3) * 10^5)) +
  scale_color_manual(values = c("grey50","red")) +
  xlab(NULL) +
  ylab(NULL)

####################
## LGG (Layered Grammar of Graphics) approach

# Layer1: Data 
ggplot(data=mpg,
       
#Layer2 : Aesthetic mapping
aes(x=displ,y=hwy))+
  
# Layer3: Geometric point
geom_point()+
  
#Layer 4
stat_smooth(method = "lm",se=F)



cor(mpg$displ,mpg$hwy)     #High degree of linear negative correlation, now needs to test using t-test

######################3

# Layer1: Data 
ggplot(data=diamonds,
       
       #Layer2 : Aesthetic mapping
       aes(x=carat,y=price))+
  
  # Layer3: Geometric point
  geom_point()+
  
  #Layer 4
  stat_smooth(method = "lm",se=F)

cor(diamonds$carat,diamonds$price)
#T-TEST
cor.test(diamonds$carat,diamonds$price)
