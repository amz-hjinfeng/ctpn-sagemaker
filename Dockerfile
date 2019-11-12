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
RUN mkdir -p /opt/ml/input/data
RUN mkdir -p /opt/ml/code/data/pretrain_model

RUN apt-get install tree
RUN apt-get install unzip

ENV PATH="/opt/ml/code:${PATH}"
ADD ./* /opt/ml/code/

WORKDIR /opt/ml

RUN tree
WORKDIR /opt/ml/code/lib/utils

RUN cython bbox.pyx
RUN cython cython_nms.pyx
RUN python setup_cpu.py build_ext --inplace
RUN mv utils/* ./
RUN rm -rf build
RUN rm -rf utils


RUN cd /opt/ml/code
WORKDIR /opt/ml/code

CMD [ "sh", "load-data.sh" ]

