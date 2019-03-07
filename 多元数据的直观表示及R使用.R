#多元数据的直观表示及R使用
#案例分析
#区域城市现代化水平直观分析
data1 = read.table("clipboard",header=T);data1

summary(data1)

#按行做均值图
RM=rowMeans(data1);RM
barplot(RM,las=3)

#按列做均值图
CM=colMeans(data1);CM
barplot(CM)

#箱尾图
boxplot(data1)

#星象图
stars(data1,draw.segments = T,key.loc = c(8,1.6))

#脸谱图
library(aplpack)
faces(data1)

#调和曲线图
library(mvstats)
plot.andrews(data1)
plot.andrews(data1)
plot.andrews(data1)