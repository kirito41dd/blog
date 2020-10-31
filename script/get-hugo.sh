# 此脚本安装hugo到脚本所在位置的../bin目录
CURDIR=$(cd $(dirname $0); pwd)
cd $CURDIR
echo "执行目录 `pwd`"


# 判断环境是mac还是linux,决定hugo版本
if [ $(uname -s) = 'Darwin' ];then
    echo '当前环境为Darwin'
    HUGOURL='https://github.com/gohugoio/hugo/releases/download/v0.77.0/hugo_extended_0.77.0_macOS-64bit.tar.gz'
else
    echo '当前环境为Linux'
    HUGOURL='https://github.com/gohugoio/hugo/releases/download/v0.77.0/hugo_extended_0.77.0_Linux-64bit.tar.gz'
fi
echo "hugo 获取地址:$HUGOURL"

echo '开始下载'
curl -sSL -o hugo.tar.gz $HUGOURL
if [ $? -ne 0 ];then
    echo '下载失败'
    exit 1
fi

# 解压文件
BINDIR="$CURDIR/../bin"
if [ ! -d "$BINDIR" ];then
    mkdir $CURDIR/../bin
fi
echo "解压到 $BINDIR"
tar -xzf ./hugo.tar.gz -C $CURDIR/../bin
rm ./hugo.tar.gz

# 验证下解压安装成功
echo 'success'
$BINDIR/hugo version
