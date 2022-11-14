# -*- coding:utf-8 -*-
import gzip
import re
import http.cookiejar
import urllib.request
import urllib.parse
def get_version():
    def ungzip(data):
        return gzip.decompress(data)
    def getOpener(head):
        # deal with coookie
        cj = http.cookiejar.CookieJar()
        pro = urllib.request.HTTPCookieProcessor(cj)
        opener = urllib.request.build_opener(pro)
        header = []
        for key, value in head.items():
            elem = (key, value)
            header.append(elem)
        opener.addheaders = header
        return opener
    header = {
        'Connection': 'Keep-Alive',
        'Accept': 'text/html, application/xhtml+xml, */*',
        'Accept-Language': 'en-US,en;q=0.8,zh-Hans-CN;q=0.5,zh-Hans;q=0.3',
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko',
        'Accept-Encoding': 'gzip, deflate',
        'DNT': '1'
    }
    url = 'https://forums.kleientertainment.com/game-updates/dst/'
    opener = getOpener(header)
    data = opener.open(url).read()
    data = ungzip(data)
    # print(data)
    temp = re.compile('<a href=\'https://forums.kleientertainment.com/game-updates/dst/(.*?)-r\d', re.S)
    ver_list = []
    try:
        for x in temp.findall(data.decode()):
            ver_list.append(x)
    except IndexError:
        return -1
    # print(str(x))
#    ver_list.sort(reverse=True)
    return ver_list[0]
print(get_version())
