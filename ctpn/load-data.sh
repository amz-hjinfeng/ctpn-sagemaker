#!/bin/bash

rm -rf /opt/ml/code/ctpn/data*

mkdir -p /opt/ml/code/ctpn/data/pretrain_model
curl "https://cigna-demo-aws.s3-ap-southeast-1.amazonaws.com/VGG_imagenet.npy" -o "/opt/ml/code/data/pretrain_model/VGG_imagenet.npy"
curl "https://cigna-demo-aws.s3-ap-southeast-1.amazonaws.com/VOCdevkit.zip" -o "/opt/ml/input/data/VOCdevkit.zip"
unzip -n /opt/ml/input/data/VOCdevkit.zip -d /opt/ml/input/data/dat
mkdir -p /opt/ml/input/data/VOCdevkit2007
rm -rf /opt/ml/input/data/VOCdevkit.zip
cp -r /opt/ml/input/data/dat/VOCdevkit/* /opt/ml/input/data/VOCdevkit2007
ls /opt/ml/input/data/VOCdevkit2007
rm -rf /opt/ml/input/data/dat
cp /opt/ml/code/hyperparameters.json  /opt/ml/input/config/hyperparameters.json

cd /opt/ml/code/
python train




