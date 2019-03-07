#######使用正则表达式爬取网页信息#######

#字符串处理基础
#长度、个数：nchar,length
#替换：chartr(原始字符,替换字符,字符串)
#连接：paste 参数sep,collapse
#切割：strsplit
#比较：>,<,==,!=
#并集、交集、补集：union,intersect,setdiff
#截取：substr,substring
#匹配：match，pmatch，charmatch

#正则表达式初识
# \:转义字符
# .:除了换行以外的任意字符
# ^:一行字符串的起始
# $:一行字符串的结束
# *:零个或者多个之前的字符
# +:一个或者多个之前的字符
# ?:零个或者一个之前的字符
#保留字符都需要转义字符\来转义表示
# 方括号 [ ] ，代表任意其他字符
#   - [a-z]：   a至z中任意一个小写字符
#   - [^a-z]：  非任意一个a至z小写字符的其他字符（可以是大写字符）
#   - [a-zA-Z可以匹配其中任何一个字符.而^在[]中代表“非”，-代表“之间”
#   - [qjk]：   q，j，k中任意一个字符
#   - [^qjk]：  非q，j，k的]：任意一个英文字母
#   - [a-z]+：  一个或者多个小写英文字母
# |:或者
#小括号 ( ) 与花括号 { } 配合"|"使用
# \n: 换行符
# \t: tab
# \w: 任意字母（包括下划线）或者数字 即[a-zA-Z0-9_]
# \W: \w的反义 即[^a-zA-Z0-9_]
# \d: 任意一个数字 即[0-9]
# \D: \d的反义 即[^0-9]
# \s: 任意一个空格，比如space，tab，newline等
# \S: \s的反义，任意一个非空格


###函数
# grepl：返回一个逻辑值
# grep：返回匹配的id

#正则替换：sub和gsub

# regexpr：返回一个数字，1表示匹配，-1表示不匹配，以及两个属性，匹配的长度和是否使用useBytes
# regexec：返回一个list，字符串中第一个匹配及其长度以及是否使用useBytes
# gregexpr: 返回一个list，每一个匹配及其长度以及是否使用useBytes

library(RCurl)

myheader = c(
  "User-Agent" = "Mozilla/5.0 (windows ; U ; Windows NT 5.1 ; zh-CN ; rv:1.9.1.6) ",
  "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*,q=0.8",
  "Accept-Language"="en-us",
  "Connection" = "keep-alive",
  "Accept-Charset" = "GB2312,utf-8;q=0.7,*,q=0.7"
)
temp=getURL("https://nj.lianjia.com/zufang/",httpheader=myheader,.encoding="UTF-8")
k=strsplit(temp,"\n")[[1]]

nameadr = k[grep("<p class=\"content__list--item--title twoline\">",k)+2] 
name=substring(nameadr,21,46)
name

sizeadr = k[grep("<p class=\"content__list--item--title twoline\">",k)+7] 
size=substring(sizeadr,18,30)
size





page=1:3
urllist[page]=paste("https://nj.lianjia.com/zufang/pg",page,"rs%E5%8D%97%E4%BA%AC/#contentList",sep='')

for (url in urllist) {
  temp=getURL(url,httpheader=myheader,.encoding="UTF-8")
  k=strsplit(temp,"\n")[[1]]
  for (i in  1:30 ) {
    nameadr[i+30*(page-1)] = k[grep("<p class=\"content__list--item--title twoline\">",k)+2] 
  name[i+30*(page-1)]=substring(nameadr[i+30*(page-1)],21,46)
  }
}
name

