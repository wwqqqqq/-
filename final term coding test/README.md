# 试题
-----
汇编程序设计上机考试题目

一、注意事项
1. 考试时间：2：30～5：00。
2. 严禁抄袭！若代码比对，发现有很高比例雷同，考试成绩都将按0分处理！
3. 考试材料下载FTP站点：？？？，包括上机考试题目(Test.txt)和测试样本(Sample.txt)。
4. 考试结果压缩后上传FTP站点：？？？，包含汇编源程序(1.asm和2.asm)、可执行程序(1.exe和2.exe)和注释文件(3.txt)，命名为：学号_姓名_序号.zip(序号可选)。其中注释文件说明所使用的软件工具环境，以及考试完成情况。

二、考试题目
1.设计汇编程序，实现从键盘输入1位数字(3～9)和1个其他字母或符号，然后在屏幕上输出由该字母或符号构成的三角图案，以及两个镜像三角形的叠加图案。
例如，若输入`3*`，则显示：
1.1 三角图案
```
*
**
***
```
1.2 两个镜像三角图案的叠加
```
  *
 ***
*****
```
2.设计汇编程序，实现将存储在测试样本文件(Sample.txt)中的多个三十六进制数转换为四进制数输出到屏幕上。该文件中每一行文本模拟从键盘输入一个三十六进制数，其中数字0～9和字母A～Z或a～z表示数的一位(字母A或a表示10，字母B或b表示11，依此类推，字母Z或z表示35)，减号-表示退格(删除一数位)，回车表示一个数结束(无数位输入的行表示全部数结束)，忽略其他符号。假设test.txt文件内容最大1024字节，三十六进制数限定最多6位(忽略超出的数位)。要求：
2.1 显示Sample.txt文件的内容，例如：
```
ZZZZZZ
2Bits
2$Bits?
3-2Bts+ - -its
ZZZZZZ123
ZZZZZZ123 - - - - - - -7
2Bits - - - - - -
```

2.2 逐行转换数据,并显示等效的三十六进制数及其转换的四进制数(去除前导零)，例如：
```
ZZZZZZ = 2001233300333333
2Bits = 32313120100
2Bits = 32313120100
2Bits = 32313120100
ZZZZZZ = 2001233300333333
7 = 13
```


# 实现
-------
## 软件工具环境
emu8086 version 4.08

## 实验一
可执行文件为1.exe，源代码见1.asm  
输入输出示例：  
输入：`3*`  
输出：
```
*
**
***

  *
 ***
*****
```

输入：`4m`  
输出：  
```
m
mm
mmm
mmmm

   m
  mmm
 mmmmm
mmmmmmm
```

## 实验2
可执行文件为2.com，源代码见2.asm  
测试时，请将测试文件Sample.txt放在2.exe相同目录下  

输入文件：
```
ZZZZZZ
2Bits
2$Bits?
3-2Bts+ - -its
ZZZZZZ123
ZZZZZZ123 - - - --- - - -7
2Bits - - - - - -
```

输出：  
```
ZZZZZZ
2Bits
2$Bits?
3-2Bts+ - -its
ZZZZZZ123
ZZZZZZ123 - - - --- - - -7
2Bits - - - - - -

ZZZZZZ = 2001233300333333
2Bits = 32313120100
2Bits = 32313120100
2Bits = 32313120100
ZZZZZZ = 2001233300333333
7 = 13
```
