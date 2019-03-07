##########数据获取,数据清洗##########
#加载所需的包：
library("xml2")
library("rvest")
library("dplyr")
#stringr字符串工具集
library("stringr")
#tidy数据分割处理separate
library("tidyr")

#对爬取页数进行设定并创建数据框：
I <- 1:10
house_inf <- data.frame()

#利用for循环封装爬虫代码，进行批量抓取：
for (i in 1:10){
  
  #发现url规律，利用字符串函数进行url拼接并规定编码：
  web <- read_html(str_c("https://nj.lianjia.com/zufang/pg", i,"/#contentList"), encoding = "UTF-8")
  
  #提取房名信息：
  house_name <- web%>%html_nodes(".houseInfo a")%>%html_text()
  
  #提取房名基本信息并消除空格
  house_basic_inf <- web%>%html_nodes(".houseInfo")%>%html_text()
  house_basic_inf <- str_replace_all(house_basic_inf," ","")
  
  #提取租房地址信息
  house_address <- web%>%html_nodes(".positionInfo a")%>%html_text()
  
  #提取租房总价信息
  house_totalprice <- web%>%html_nodes(".totalPrice")%>%html_text()
  
  #提取租房单价信息
  house_unitprice <- web%>%html_nodes(".unitPrice span")%>%html_text()
  #将 单价****元/平米 切割为 ****
  house_unitprice <- gsub(".*单价","",house_unitprice)
  house_unitprice <- gsub("元/平米","",house_unitprice)
  
  #创建数据框存储以上信息
  House<-data.frame(house_name,house_basic_inf,house_address,house_totalprice,house_unitprice)
  house_inf <- rbind(house_inf,House)
  
}

#df是数据集，col是按那一列进行划分，into是划分为新数据集的列名称
#将house_basic_inf分开
house_inf <- separate(data = house_inf, col = house_basic_inf,into = c("name", "house_style", "house_size","house_direction","house_decorate","house_lift"), sep = "\\|")

#将数据写入csv文档
write.csv(house_inf, file="housezf_inf.csv")

#对于有些错误信息进行删除筛选
data1=read.table("clipboard",header = T)
data1

##########数据分析##########
library(ggplot2)
library(mvstats)

house1 <- data.frame(data1$house_name,data1$house_unitprice)
summary(house1)

H.clust(house1,"euclidean","complete",plot=T)
cl=kmeans(house1,10)

ggplot()






