library(RCurl)

url.exists("https://www.baidu.com/")#测试地址是否存在

d=debugGatherer()

temp = getURL("http://www.dataguru.cn/",debugfunction = d$update ,verbose = TRUE )
cat(d$value()[3])#提交给服务器的头信息
cat(d$value()[1])#服务器地址以及端口号
cat(d$value()[2])#服务器端返回的头信息

#查看服务端返回头信息
###字符串形式
headers = basicTextGatherer()
txt=getURL("http://www.dataguru.cn/",headerfunction = headers$update )
names(headers$value())#说明是字符串形式
headers$value()

###列表形式
h = basicHeaderGatherer()
txtt=getURL("http://www.dataguru.cn/",headerfunction = h$update )
names(h$value())
h$value()

#查看curl请求的访问信息
curl = getCurlHandle()
d = getURL("http://www.dataguru.cn/",curl=curl )
getCurlInfo(curl)$response.code #返回值为状态码  200为请求成功
getCurlInfo(curl)

#伪装自己的header
myheader = c(
  "User-Agent" = "Mozilla/5.0 (windows ; U ; Windows NT 5.1 ; zh-CN ; rv:1.9.1.6) ",
  "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*,q=0.8",
  "Accept-Language"="en-us",
  "Connection" = "keep-alive",
  "Accept-Charset" = "GB2312,utf-8;q=0.7,*,q=0.7"
)
d=debugGatherer()
temp1=getURL("http://www.baidu.com",httpheader=myheader,debugfunction=d$update,verbose =TRUE)
cat(d$value()[2])#服务器端返回的头信息

character= c("https://www.baidu.com/s?wd=RCurl&rsv_spt=1&rsv_iqid=0xf3875de400025bbf&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&rqlang=cn&tn=baiduhome_pg&rsv_enter=1&inputT=3342&rsv_t=9dc3ObNIt65FZhHtKwtP9Oxy%2Fv65c5fzaZ%2FgmIkK3e0aDnPWRebrqw6ZVUqhvTmjtwrB&oq=useragent&rsv_pq=88015abe0002433d&rsv_sug3=10&rsv_sug1=10&rsv_sug7=100&rsv_sug2=0&rsv_sug4=3342")
getFormParams(character) 

#修改wd中的值，可以达到在百度搜索框输入的效果
url=getForm("http://www.baidu.com/s", wd="dianying", rsv_spt = "1", rsv_iqid="0xf3875de400025bbf" , issp="1",f="8",rsv_bp= "1",rsv_idx="2",ie= "utf-8",rqlang= "cn", tn="baiduhome_pg",rsv_enter = "1",inputT="3342",rsv_t="9dc3ObNIt65FZhHtKwtP9Oxy%2Fv65c5fzaZ%2FgmIkK3e0aDnPWRebrqw6ZVUqhvTmjtwrB" ,oq= "useragent",rsv_pq ="88015abe0002433d",  rsv_sug3 = "10", rsv_sug1= "10", rsv_sug7= "100" , rsv_sug2 = "0", rsv_sug4 = "3342" )

#将抓取的信息存在文本文档中
write.table(url,"url.txt" )

#############
# curl部分参数设置
# verbose：输出访问的交互信息
# httpheader：设置放文信息报头
# .enconding="UTF-8" "GBK"
# debugfunction,headerfunction,curl
# .params:提交的参数组
# dirlistonly:仅读取目录
# followlocation：支持重定向
# maxredirs：最大重定向次数 
#############

########getBinaryURL下载文件
#url=""
temp = getBinaryURL(url)
note = file("hellodata.xls",open="wb")
writeBin(temp,note)
close(note)

########批量下载文件
#strsplit(as.character(Sys.time()),' ')分割系统时间
#unlist(strsplit(as.character(Sys.time()),' '))[2]将需要的时间提取出来
html = getURL("https://rfunction.com/code/1202/") #提取网页
temp = strsplit(html,"<li><a href=\"")[[1]] #分割url
files = strsplit(temp,"\"") 
files = lapply(files,function(x)(x[1]))
files = unlist(files)
files = files[-(1:2)]
i=1
base="https://rfunction.com/code/1202/"
for (i in 1:length(files)) {
  url=paste(base,files[i],sep = '')
  temp = getBinaryURL(url)
  note = file(paste("1202",files[i],sep=''),open="wb")
  writeBin(temp,note)
  close(note)
  Sys.sleep(2) #设置睡眠时间，防止被网站拉入黑名单
}

      