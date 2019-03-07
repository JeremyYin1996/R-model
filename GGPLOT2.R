library(ggplot2)

#数据集
mtcars

#散点图--描述两组变量的关系情况
ggplot(mtcars,aes(wt,mpg))+geom_point()

#线图
ggplot(mtcars,aes(wt,mpg))+geom_line()+geom_point()

#柱状图--查看变量的频数分布情况
ggplot(mtcars,aes(factor(cyl),fill=factor(am)))+geom_bar(position="fill")
          #fill=factor(am)让数据根据am的值进行分类
          #position="fill"百分比显示   "dodge"并排排列

class(mtcars$cyl)#cyl是"numeric"数值型变量，需要转换成因子，转换成分类变量

#直方图--查看变量分布情况
ggplot(mtcars,aes(mpg))+geom_histogram()

#密度图--查看变量频率分布情况
ggplot(mtcars,aes(mpg,color=factor(vs)))+geom_density(alpha=0.5)
          #color是以线条对数据边缘进行描绘，fill是填充图形的内部
          #alpha是透明度

#箱线图--查看变量的统计值分布情况
ggplot(mtcars,aes(factor(vs),mpg))+geom_boxplot()                                                                                                       

#分组作图 
ggplot(mtcars,aes(wt,mpg,color=qsec))+geom_point()
ggplot(mtcars,aes(wt,mpg,color=factor(vs)))+geom_point()
          #改变整个图层的颜色，将color写在aes外面
          #若是想用颜色进行分组，将color写在aes里面

#分面作图 facet_grid()
#1.轴刻度一致
#单变量作图
ggplot(mtcars,aes(wt,mpg))+geom_point()+facet_grid(vs~.)#根据y轴切分 根据x轴切分.~vs
  
#双变量作图
ggplot(mtcars,aes(wt,mpg))+geom_point()+facet_grid(am~vs)

#2.轴刻度不一致
#不同纵轴刻度
ggplot(mtcars,aes(wt,mpg))+geom_point()+facet_grid(vs~.,scales = "free")

#不同横轴刻度
ggplot(mtcars,aes(wt,mpg))+geom_point()+facet_grid(.~vs,scales = "free")


ggplot(mtcars,aes(wt,mpg,color=factor(vs)))+geom_point(shape=1,size=4)+
  annotate("text",x=4,y=20,label="yes")+labs(title = "hello",x="xxx",y="yyy")+
  geom_vline(xintercept = 3)+geom_hline(yintercept = 20)+
  scale_x_continuous(breaks = c(3.00,3.25,3.50,3.75,4.00),labels=c("a","b","c","d","e"))
#gemo_XXX(shape= ,size= )shape形状，size大小
#annotate("xxx",x= ,y= ，label= ) 在图像中添加注释 “XXX”注释类型x，y为在图中坐标,label为文本内容
#geom_vline(xintercept =  )添加横线  geom_hline(yintercept = )添加竖线
#scale_x_continuous(breaks = c( ),labels=c( ))修改x轴图例
#labs(title = "hello",x="xxx",y="yyy"  title图表名称
#xlim( a,b) 限制x轴显示范围在(a,b)