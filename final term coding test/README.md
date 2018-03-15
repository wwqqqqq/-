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