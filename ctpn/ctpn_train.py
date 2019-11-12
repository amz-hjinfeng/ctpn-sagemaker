import argparse
import os
import yaml
import pprint

from lib.fast_rcnn.config import cfg_from_file, get_output_dir, get_log_dir
from lib.datasets.factory import get_imdb
from lib.networks.factory import get_network
from lib.fast_rcnn.train import get_training_roidb
from lib.fast_rcnn.config import cfg
from lib.lib.fast_rcnn.train import train_net

def train_main(data_dir,model_dir,train_steps,input_yaml):
      cfg_from_file(input_yaml)
      print('Using config:')
      pprint.pprint(cfg)
    
      imdb = get_imdb('voc_2007_trainval')
      print('Loaded dataset `{:s}` for training'.format(imdb.name))
      roidb = get_training_roidb(imdb)

      output_dir = get_output_dir(imdb, None)
      log_dir = get_log_dir(imdb)
      print('Output will be saved to `{:s}`'.format(output_dir))
      print('Logs will be saved to `{:s}`'.format(log_dir))
      device_name = '/gpu:0'
      print(device_name)

      network = get_network('VGGnet_train')

      train_net(network, imdb, roidb,
              output_dir=output_dir,
              log_dir=log_dir,
              pretrained_model='data/pretrain_model/VGG_imagenet.npy',
              max_iters=int(cfg.TRAIN.max_steps),
              restore=bool(int(cfg.TRAIN.restore)))


if __name__ == '__main__':

    args_parser = argparse.ArgumentParser()
    args_parser.add_argument(
        '--data-dir',
        default='/opt/ml/input/data/training',
        type=str,
        help='The directory where the CIFAR-10 input data is stored. Default: /opt/ml/input/data/training. This '
             'directory corresponds to the SageMaker channel named \'training\', which was specified when creating '
             'our training job on SageMaker')

    # For more information:
    # https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-inference-code.html
    args_parser.add_argument(
        '--model-dir',
        default='/opt/ml/model',
        type=str,
        help='The directory where the model will be stored. Default: /opt/ml/model. This directory should contain all '
             'final model artifacts as Amazon SageMaker copies all data within this directory as a single object in '
             'compressed tar format.')

    args_parser.add_argument(
        '--train-steps',
        type=int,
        default=100,
        help='The number of steps to use for training.')

    args_parser.add_argument(
        '--input-yaml',
        type=str,
        default='/opt/ml/input/config/text.yaml'
    )

    

    args = args_parser.parse_args()
    train_main(**vars(args))



