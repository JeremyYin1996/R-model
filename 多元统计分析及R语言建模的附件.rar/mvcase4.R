#*******************************************
#*******  R语言多元统计分析案例分析 ********
#*******  数据来自: mvcase4.xls"    ********
#*******  王斌会:   2016.1.1        ********
#*******************************************
##########【输出设置】##########
rm(list=ls())                 #清理内存
options(digits=4)             #输出结果位数
par(mar=c(4,4,2,1)+0.1,cex=0.8)#图形修饰
load('mvstats.RData')
##########【案例1 多元数据的基本统计分析】##########
#mvcase4.xls"的表单Case1中选择数据并复制
Case1=read.table("clipboard",header=T)
head(Case1)
summary(Case1)
attach(Case1)  #绑定数据
 T1=table(地区);T1
 barplot(T1)
 f=hist(月收入);f  #月收入直方图
 boxplot(月收入~性别)
 t.test(月收入~性别)
 T2=table(性别,观点);T2
 barplot(T2,beside=T)
 T3=ftable(性别,教育程度,观点);T3
 barplot(T3,beside=T,col=3:4)
 T4=ftable(教育程度,性别,观点);T4
detach(Case1) #解除绑定

##########【案例2 区域城市现代化水平的直观分析】##########
#在mvcase4.xls"的表单Case2中选择数据并复制
Case2=read.table("clipboard",header=T);Case2
summary(Case2)
RM=rowMeans(Case2);RM
barplot(RM,las=3)#按行做均值图
CM=colMeans(Case2);
CM
barplot(CM)#按列做均值图
boxplot(Case2)
stars(Case2,key.loc=c(8,1.6))
stars(Case2,draw.segments=T,key.loc=c(8,1.6))
library(aplpack)  
faces(Case2)
library(mvstats) #load('mvstats.RData')
plot.andrews(Case2)      

##########【案例3 财政收入的相关与回归分析】##########
Case3=read.table("clipboard",header=T)
cor(Case3)   #相关分析
plot(Case3)  #矩阵散点图
corr.test(Case3)
fm=lm(y~.,data=Case3)  #线性回归
summary(fm)
y=Case3$y
yhat=fm$fit
resid=fm$resid
cbind(y,yhat,resid,rerror=resid/yhat*100)
t=1978:1998
plot(t,y)
lines(t,yhat)

########## 【案例4 广义线性模型及其应用】 ##########
Case4=read.table("clipboard",header=T)
head(Case4)
fm=glm(y~sex+age,family=binomial,data=Case4)
fm
summary(fm)
attach(Case4)
 Pr=predict(fm,data.frame(list(sex,age)))#预测
 p=exp(Pr)/(1+exp(Pr))
 cbind(sex,age,y,p)
 plot(age,Pr)
detach(Case4)

########## 【案例5 企业财务状况的判别分析】 ##########
Case5=read.table("clipboard",header=T)
head(Case5,30)
plot(Case5[,2:5],gap=0)
library(MASS)
ld=lda(G~.,data=Case5);ld  #线性判别
plot(ld)
Zld=predict(ld)
data.frame(Case5$G,Zld$class,round(Zld$x,3))
addmargins(table(Case5$G,Zld$class))

qd=qda(G~.,data=Case5);qd  #二次判别
Zqd=predict(qd)
#data.frame(Case5$G,Zqd$class,round(Zqd$post,3)*100)
addmargins(table(Case5$G,Zqd$class))

########## 【案例6 全国区域经济的聚类分析】 ##########
Case6=read.table("clipboard",header=T);Case6
summary(Case6)
#系统聚类法
Z=scale(Case6)                 #数据标准化
hc=hclust(dist(Z))             
plot(hc);rect.hclust(hc,2);cutree(hc,2)#分2类
plot(hc);rect.hclust(hc,3);cutree(hc,3)#分3类
plot(hc);rect.hclust(hc,4);cutree(hc,4)#分4类
plot(hc);rect.hclust(hc,5);cutree(hc,5)#分5类
# kmenas聚类法
kmeans(Z,2)$cluster   #分2类
kmeans(Z,3)$cluster   #分3类
kmeans(Z,4)$cluster   #分4类
kmeans(Z,5)$cluster   #分5类

########## 【案例7 地区电信业发展情况的主成分分析】 ##########
Case7=read.table("clipboard",header=T);Case7
library(mvstats)
H.clust(scale(Case7))
PC=princomp(Case7,cor=T)
summary(PC)
m=2
PC$loadings[,1:m]
princomp.rank(PC,m)
princomp.rank(PC,m,plot=T)

########## 【案例8 因子分析在上市公司经营业绩评价中的应用】 ##########
Case8=read.table("clipboard",header=T);Case8
(FA0=factanal(Case8,4,rotation="none")) #因子不旋转  
pairs(FA0$loadings)
(FA1=factanal(Case8,4,rot="varimax")) #varimax法旋转
pairs(FA1$loadings)
(FA1=factanal(Case8,4,rot="varimax",scores="reg"))
factanal.rank(FA1,plot=T) #因子得分作图与排名
biplot(FA1$scores,FA1$loadings) #前2个因子信息重叠图

########## 【案例9 对应分析在市场细分和产品定位中的应用】 ##########
Case9=read.table("clipboard",header=T);Case9
CA=corresp(Case9,2);CA
summary(CA)
biplot(CA)
abline(v=0,h=0,lty=3)#添加轴线

########## 【案例10 农村居民收入和支出的典型相关分析】 ##########
Case10=read.table("clipboard",header=T);
Case10
Z=scale(Case10)
ca=cancor(Z[,1:4],Z[,5:9]);ca
library(mvstats)
cancor.test(Z[,1:4],Z[,5:9],plot=T)

########## 【案例11 国内各地区工资水平的多维标度分析】 ##########
Case11=read.table("clipboard",header=T);
Case11
D=dist(Case11)
mds=isoMDS(D,k=2);mds
plot(mds$points);abline(h=0,v=0,lty=3)
text(mds$points,row.names(Case11),cex=0.7)

##########【案例12 区域自主创新能力的层次分析】##########
### 权重计算
A=c(1,3,3,1,1/3,1,2,1/3,1/3,1/2,1,1/3,1,3,3,1)
(A_W=weight(A))   #A的权重
B1=c(1,1,1,2,1,1,1,1,1,1,1/2,2,1,2,1,1,1,1/2,1,
     2,2,1/2,2,2,1,1,1,1,1,1/2,1,1,1,2,2,1,1,
     1/2,1,1/2,1,2,1,1/2,1/2,1,1/2,1/2,1)
(B1_W=weight(B1)) #B1的权重
B2=c(1,1,1,2,1,1,1,1,1,1/2,2,1,1,1,1,1,1,2,
     1/2,2,1,1,1,1,1,1/2,1,1,1,2,1,1,1/2,1,1/2,1)
(B2_W=weight(B2)) #B2的权重
B3=c(1,1,2,2,1,1,1,1,2,2,1/2,1,1,1/2,1/2,
     1/2,1/2,2,1,1/3,1,1/2,2,3,1)
(B3_W=weight(B3)) #B3的权重
B4=c(1,1/2,1,1,1,1/2,2,1,1,1,1,1,1,1,1,1,1,1,
     1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1)
(B4_W=weight(B4)) #B4的权重
### 综合评价---层次分析
Case12=read.table("clipboard",header=T)
Z=z_data(Case12)
S1=S_rank(Z[,1:7],B1_W)
S2=S_rank(Z[,8:13],B2_W)
S3=S_rank(Z[,14:18],B3_W)
S4=S_rank(Z[,19:24],B4_W)
S=data.frame(S1$Si,S2$Si,S3$Si,S4$Si);S
S_rank(S,A_W)

