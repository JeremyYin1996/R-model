#多元相关与回归分析及R使用
#案例分析
#财政收入的多元相关与回归析
data2 = read.table("clipboard",header=T);data2  

#相关分析
cor(data2)
plot(data2)#矩阵散点图
