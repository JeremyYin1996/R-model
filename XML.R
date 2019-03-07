library(RCurl)
library(XML)

##下载表格 **win系统下中文会乱码
url="http://data.earthquake.cn/sjfw/dzfwindex.html?PAGEID=qgwjall"
wp = getURL(url)
doc = htmlParse(wp,asText =  TRUE)
tables = readHTMLTable(doc,header = F)
tables

### XPath
# / 作为路径内部的分隔符
# / : 表示选择根节点
# // : 表示选择任意位置的某个节点
# @ ：表示选择某个属性
# * ：表示匹配任何元素节点
# @* ：表示匹配任何属性值
# node() : 表示匹配任何类型的节点

url="http://www.w3school.com.cn/example/xmle/books.xml"
doc = xmlParse(url)
getNodeSet(doc,'/bookstore/book[position()<3]')#抓取前两本书的信息
getNodeSet(doc,'//title[@lang]')#抓取所有书的书名 
getNodeSet(doc,'//book/price')#抓取所有书的价格 
getNodeSet(doc,'//title[@lang]|//book/price')#抓取所有书的书名和价格

#爬链家网上南京租房房价
myheader = c(
  "User-Agent" = "Mozilla/5.0 (windows ; U ; Windows NT 5.1 ; zh-CN ; rv:1.9.1.6) ",
  "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*,q=0.8",
  "Accept-Language"="en-us",
  "Connection" = "keep-alive",
  "Accept-Charset" = "GB2312,utf-8;q=0.7,*,q=0.7"
)
temp=getURL("https://nj.lianjia.com/zufang/rs%E5%8D%97%E4%BA%AC/",httpheader=myheader,encoding="UTF-8")
write.table(temp,"temp.txt" )
k=htmlParse(temp)
getNodeSet(k,'//div[@class="content__list--item--main"]')
zufang=sapply(getNodeSet(k,'//div[@class="content__list--item--main"]'),xmlValue)
zufang

urllist=0
zufang=0
page=1:48
urllist[page]=paste("https://nj.lianjia.com/zufang/pg",page,"rs%E5%8D%97%E4%BA%AC/#contentList",sep='')

for (url in urllist) {
  temp=getURL(url,httpheader=myheader,encoding="UTF-8")
  k=htmlParse(temp)
  zufang[url]=sapply(getNodeSet(k,'//div[@class="content__list--item--main"]'),xmlValue)
  #files[url] = strsplit(zufang[url],"\n") 
  #cat(url,"\n")
}
files

