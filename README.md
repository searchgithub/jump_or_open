# jump_or_open

#### 介绍
for macbook:
    "jump to" or "open" with the specified line number or "choice list number" with keyword in the current ~/.marks file.

#### 软件架构
软件架构说明


#### 安装教程

download my.sh, then "source mp.sh"

#### 使用说明
                                                                                                                                                                                                            [17:14:48]
    Usage:
    "jump to" with "j" or "open with finder/explorer" with "jo" to the specified line number or "choice list number" with keyword in the current ~/.marks file.
    "mark" current path into ~/.marks file with "jm".
    j, jo, jd, jm, show marks file list with line number
    j -h, jo -h, jd -h, jm -h, show help
    j /[SOME_PATH], jo /[SOME_PATH], "jump to" or "open" /SOME_PATH
    j [LINENUM], jo [LINENUM], "jump to" or "open" the LINENUM matched path in ~/.marks file
    j [KYEWORD], jo [KEYWORD], grep -i KEYWORD ~/.marks, list all matched record, show the "choice list number" in first column.
      You can input "choice list number" at first column to "jump to" or "open" the specified path.
      If just match one path, "jump to" or "open" it directly.
    j -, jump to previous folder
    jd [LINENUM], del related item in ~/.marks file
    jd . , delete current path in ~/.marks file
    jm . , mark current path append into ~/.marks file
    jm /[SOME_PATH], add the path to ~/.marks file
    jo . , open current path "." 



#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  可以cd到某些常用目录，输入jm添加条目，然后用j，jo进行跳转或者打开。

