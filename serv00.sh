#!/bin/sh

API_URL="https://api.github.com/repos/hhsw2015/alist/releases/latest"

DOWNLOAD_URL=$(curl -s $API_URL | jq -r ".assets[] | select(.name | contains(\"alist-freebsd\")) | .browser_download_url")

curl -L $DOWNLOAD_URL -o alist.tar.gz
tar -xvf alist.tar.gz

chmod +x alist

if [ -f "./data/config.json" ]; then
    echo "Alist-FreeBSD最新版本已经下载覆盖完成！"
else
    nohup ./alist server > /dev/null 2>&1 &
    clear
    echo "已生成配置文件，请修改端口！"
    echo
    echo "使用命令 cd data 进入data路径下"
    echo
    echo "再使用 vim config.json 命令，对配置文件进行编辑，按 i 进入插入模式"
    echo
    echo "将 port: 5244中的 5244 修改成你放行的端口即可"
    echo
    echo "接着按 Esc 键退出插入模式，再按 : 键进入命令模式，并输入 wq 再回车，保存并退出"
    echo
    echo "再使用命令 cd .. 回到上级目录"
    echo
fi
