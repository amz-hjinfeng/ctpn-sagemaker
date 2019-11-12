FROM tensorflow/tensorflow:1.3.0-py3
  
RUN apt-get update && apt-get install -y --no-install-recommends nginx curl
RUN echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list
RUN curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add -
RUN apt-get update && apt-get install tensorflow-model-server
RUN pip install pyyaml
RUN pip install scipy matplotlib pillow
RUN pip install easydict opencv-python keras h5py PyYAML
RUN pip install cython==0.24
RUN pip install numpy==1.16.2

RUN mkdir -p /opt/ml/input/data
RUN mkdir -p /opt/ml/output
RUN mkdir -p /opt/ml/input/config
RUN mkdir -p /opt/ml/model
RUN mkdir -p /opt/ml/input/data/VOCdevkit2007/VOC2007/ImageSets/Main
RUN mkdir -p /opt/ml/code/ctpn/data/pretrain_model


ENV PATH="/opt/ml/code:${PATH}"
WORKDIR /opt/ml/code
COPY ./ctpn/* /opt/ml/code/

RUN chmod +x ./ctpn/lib/utils/make_cpu.sh
RUN ./ctpn/lib/utils/ && ./make_cpu.sh

CMD curl "https://cigna-demo-aws.s3-ap-southeast-1.amazonaws.com/VGG_imagenet.npy" -o "/opt/ml/code/ctpn/data/pretrain_model/VGG_imagenet.npy" --progress 

