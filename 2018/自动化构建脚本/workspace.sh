#!/bin/bash

# jenkins 下，默认是项目文件夹，也是默认参数（此处用以本机测试）
WORKSPACE=~/Desktop/qiakr

export LC_ALL=zh_CN.GB2312;export LANG=zh_CN.GB2312

# 项目路径
WORKSPACE_NAME="eke2.0"
TARGET_NAME="EKESell"
WORKSPACE_PATH="${WORKSPACE}/RealCloud/ekesell2.0/${WORKSPACE_NAME}.xcworkspace"

# 项目配置
BUILD_CONFIG="Release"
PRODUCT_BUNDLE_IDENTIFIER="com.yiguo.qiakr.app"
CODE_SIGN_IDENTITY="iPhone Distribution: Hangzhou Ant Kingdom Technology Co, Ltd. (4C72AXZXH7)"
PROVISIONING_PROFILE="78bf3bbf-e40b-487b-8a2c-976a4d8c105e"
ENABLE_BITCODE="YES"

# 输出配置
EXPORT_OPTIONS_PLIST=~/Desktop/ad_hot_qa.plist
RES_DIR=~/Desktop/${TARGET_NAME}-pack
RES_ARCHIVE_PATH=${RES_DIR}/ach.xcarchive
RES_IPA_DIR=${RES_DIR}/ipa
RES_IPA_PATH=${RES_IPA_DIR}/${TARGET_NAME}.ipa

# clean
xcodebuild OTHER_CFLAGS="-fembed-bitcode" clean -workspace $WORKSPACE_PATH -scheme $TARGET_NAME

# archive
xcodebuild OTHER_CFLAGS="-fembed-bitcode" archive -archivePath $RES_ARCHIVE_PATH -workspace $WORKSPACE_PATH -scheme $TARGET_NAME -configuration $BUILD_CONFIG CODE_SIGN_IDENTITY="${CODE_SIGN_IDENTITY}" PROVISIONING_PROFILE=${PROVISIONING_PROFILE} PRODUCT_BUNDLE_IDENTIFIER=${PRODUCT_BUNDLE_IDENTIFIER} ENABLE_BITCODE=${ENABLE_BITCODE}

# export
xcodebuild OTHER_CFLAGS="-fembed-bitcode" -exportArchive -archivePath $RES_ARCHIVE_PATH -exportPath $RES_IPA_DIR -exportOptionsPlist $EXPORT_OPTIONS_PLIST

echo "打包成功：${RES_IPA_PATH}"


export LANG=en_US
export LC_ALL=en_US;

#path=$RES_IPA_PATH
#pgyerUkey=1956d5a302e9d3980fd7b59849ff6d41
#pgyerApikey=7436075a04f3dcefb109032ab5b21f95
#MSG="QA 测试包-正式环境"
#
#a=$(curl -F "file=@$path" -F "uKey=$pgyerUkey" -F "_api_key=$pgyerApikey" -F "updateDescription=${MSG}" https://www.pgyer.com/apiv1/app/upload)
#
#echo "QRCode:$a" | sed "s/\\\\/""/g"
#echo "\n打包上传更新成功！"


# 构建后操作：补充个二维码下载链接
# set build description
# "appQRCodeURL":"(.*)"
# <img src='\1' width=144 height=144> <a href='\1'>二维码</a>
