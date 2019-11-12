FROM tensorflow/tensorflow:1.3.0-py3
  
RUN apt-get update && apt-get install -y --no-install-recommends nginx curl
RUN echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list
RUN curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add -
RUN apt-get update && apt-get install tensorflow-model-server
RUN pip install pyyaml
RUN pip install numpy scipy matplotlib pillow
RUN pip install easydict opencv-python keras h5py PyYAML
RUN pip install cython==0.24

RUN mkdir -P /opt/ml/input/data
RUN mkdir -P /opt/ml/output
RUN mkdir -P /opt/ml/input/config
RUN mkdir -P /opt/ml/model
RUN mkdir -P /opt/ml/input/data/VOCdevkit2007/VOC2007/ImageSets/Main



ENV PATH="/opt/ml/code:${PATH}"
WORKDIR /opt/ml/code

COPY ./ctpn/* /opt/ml/code/
RUN chmod +x ./ctpn/lib/utils/make_cpu.sh
RUN ./ctpn/lib/utils/ && ./make_cpu.sh

