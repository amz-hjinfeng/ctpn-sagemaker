#!/bin/bash

curl "https://cigna-demo-aws.s3-ap-southeast-1.amazonaws.com/VGG_imagenet.npy" -o "/opt/ml/code/ctpn/data/pretrain_model/VGG_imagenet.npy" --progress
curl "https://cigna-demo-aws.s3-ap-southeast-1.amazonaws.com/VOCdevkit.zip" -o "/opt/ml/input/data/VOCdevkit.zip"
unzip -n /opt/ml/input/data/VOCdevkit.zip -d /opt/ml/input/data/dat
mkdir -p /opt/ml/input/data/VOCdevkit2007
cp -r /opt/ml/input/data/dat/VOCdevkit/VOC2007/* /opt/ml/input/data/VOCdevkit2007
rm -rf /opt/ml/input/data/dat
