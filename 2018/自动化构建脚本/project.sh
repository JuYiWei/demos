#!/bin/bash

export LC_ALL=zh_CN.GB2312;
export LANG=zh_CN.GB2312

# jenkins 下，默认是项目文件夹，也是默认参数（此处用以本机测试）
WORKSPACE=~/Desktop/test

# 项目路径
PROJECT_NAME="test"
TARGET_NAME="test"
PROJECT_PATH=${WORKSPACE}/$PROJECT_NAME.xcodeproj

# 输出配置
# EXPORT_OPTIONS_PLIST 的 plist 就是打包来的 ExportOptions.plist，修改了名字
EXPORT_OPTIONS_PLIST=${WORKSPACE}/export/export_ad_hot.plist
RES_DIR=~/Desktop/${TARGET_NAME}pack
RES_ARCHIVE_PATH=${RES_DIR}/ach.xcarchive
RES_IPA_DIR=${RES_DIR}/ipa
RES_IPA_PATH=${RES_IPA_DIR}/${TARGET_NAME}.ipa


# clean
xcodebuild OTHER_CFLAGS="-fembed-bitcode" clean -project $PROJECT_PATH -scheme $TARGET_NAME

# archive
xcodebuild OTHER_CFLAGS="-fembed-bitcode" archive -archivePath $RES_ARCHIVE_PATH  -project $PROJECT_PATH -scheme $TARGET_NAME

# export
xcodebuild OTHER_CFLAGS="-fembed-bitcode" -exportArchive -archivePath $RES_ARCHIVE_PATH -exportPath $RES_IPA_DIR -exportOptionsPlist $EXPORT_OPTIONS_PLIST

echo "打包成功：${RES_IPA_PATH}"



export LANG=en_US
export LC_ALL=en_US

path=$RES_IPA_PATH
pgyerApikey=742cd3ecae1032adc45a6ce59d759c7f
MSG="QA 测试包-正式环境"

a=$(curl -F "file=@$path" -F "_api_key=742cd3ecae1032adc45a6ce59d759c7f" -F "buildUpdateDescription=${MSG}" https://www.pgyer.com/apiv2/app/upload)

echo "QRCode:$a" | sed "s/\\\\/""/g"
echo "\n打包上传更新成功！"


# 构建后操作：补充个二维码下载链接
# set build description
# "appQRCodeURL":"(.*)"
# <img src='\1' width=144 height=144> <a href='\1'>二维码</a>
