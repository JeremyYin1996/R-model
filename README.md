关于R-model仓库内容 
====
  该仓库主要存放我在学习和使用R语言中的一些笔记和数据，在以后的学习中会不定期的进行更新和修改 
  
以下是对仓库中相关文件的说明
### GGPLOT2.R
 ggplot2是使用图层的叠加来实现画图功能，比R语言原本自带的画图功能在性能上更好，本文件以mtcars为数据集，练习了如何绘制散点图、线图、柱状图、直方图等等，同时使用了分面作图来达到对图表功能更进一步的显示。关于ggplot2包的使用可以参考[《ggplot2：数据分析与图形艺术》](https://github.com/cosname/ggplot2-translation/tree/master/Rcode)
    
### ODBC.R
 ODBC.R中是关于RODBC包的使用。RODBC包是为R语言服务操作ODBC的包，在使用RODBC包之前需要下载并配置对应ODBC数据源具体方法可见[RODBC](https://jingyan.baidu.com/article/870c6fc37e3afcb03fe4be38.html)

### RCurl.R
 使用RCurl包对网站基本信息进行抓取
 
### XML.R 
 使用XML包对网站基本信息进行抓取
 
### house_inf.csv 和 honse_inf.xlsx
 house_inf.csv是通过[南京二手房信息.R](https://github.com/JeremyYin1996/R-model/blob/master/%E5%8D%97%E4%BA%AC%E4%BA%8C%E6%89%8B%E6%88%BF%E4%BF%A1%E6%81%AF.R)获取的得到的南京二手房信息结果 和 honse_inf.xlsx 是对house_inf.csv中一些明显不符合要求的数据进行删除

### 南京二手房信息.R
 通过对链家网上的南京二手房信息进行数据获取，数据分析
 
### 南京租房信息.R
 通过对链家网上的南京租房信息进行数据获取，数据分析

### 正则表达式.R
  R语言中正则表达式的使用规则以及使用正则表达式爬取网页信息

### 多元统计分析及R语言建模的附件.rar
  《多元统计分析及R语言建模》（第四版）书中例题及课后习题数据和代码

### 多元数据的直观表示及R使用.R
  《多元统计分析及R语言建模》(第四版)第一章案例分析代码
  
### 多元相关与回归分析及R使用.R   
  《多元统计分析及R语言建模》(第四版)第二章案例分析代码
