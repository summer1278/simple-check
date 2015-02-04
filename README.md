simple-check
============

A simple source and translation check builder

Current version for Seitokai no Ichizon Lv.2 PSP Game (JP to CN) Translation only

Require UTF-8 txt files as input! 

Tested on Windows 7 64-bit English(UK)

*03/02/15 

update on functions in translations to:

* check japnese characters left(JPN) 
* lines(CHECK1) 
* characters for each line(CHECK2)

![screenshot](http://i.imgur.com/T6LsPZJ.jpg "Screenshot")


Attentions in Chinese!
============

在使用前务必将txt文件全部转码为utf-8

================================================

1. source为原文文件夹目录
2. translation为译文文件夹目录
3. output为输出整合版的目录

然后submit就行了，如果没有填满3个目录会报错！
1和2没有txt文件的话会生成空的csv文件。

================================================

生成的data.csv文件
人物 | 原文 | 译文 with checksum | 出处

================================================

开发目的：找关键词方便，可以直接用Excel的搜索功能。

目前只适用于学生会的一己之见Lv.2 PSP汉化！

================================================

由于开发平台为Ubuntu 12.04 64-bit English，
软件可能还有兼容问题或编码问题！

装包与测试的平台为Windows 7 64-bit English。

编程语言为Ruby，完全开源~现学现卖！

10/08/14

================================================

更新有关校对中确认翻译中的日文假名（JPN），行数（CHECK1），字符数（CHECK2）的功能。

03/02/15
