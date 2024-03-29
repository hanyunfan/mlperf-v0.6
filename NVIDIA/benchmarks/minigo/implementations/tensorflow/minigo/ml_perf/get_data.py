# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Copies & compiles the data required to start the reinforcement loop."""

import sys
sys.path.insert(0, '.')  # nopep8

import asyncio
import glob
import os

from absl import app, flags
from ml_perf import utils

N = os.environ.get('BOARD_SIZE', '19')

#flags.DEFINE_string('src_dir', 'gs://minigo-pub/ml_perf/',
flags.DEFINE_string('src_dir', 'gs://minigo-pub/ml_perf/0.6',
                    'Directory on GCS to copy source data from. Files will be '
                    'copied from subdirectories of src_dir corresponding to '
                    'the BOARD_SIZE environment variable (defaults to 19).')

flags.DEFINE_string('dst_dir', 'ml_perf/',
                    'Local directory to write to. Files will be written to '
                    'subdirectories of dst_dir corresponding to the BOARD_SIZE '
                    'environment variable (defaults to 19).')

flags.DEFINE_boolean('use_tpu', False,
                     'Set to true to generate models that can run on Cloud TPU')

FLAGS = flags.FLAGS


def freeze_graph(path, batch=0):
  utils.wait(utils.checked_run(None,
      'python', 'freeze_graph.py',
      '--model_path={}'.format(path), '--trt_batch={}'.format(batch), '--use_tpu={}'.format(FLAGS.use_tpu)))


def main(unused_argv):
  try:
    for d in ['checkpoint', 'target']:
      # Pull the required training checkpoints and models from GCS.
      #src = os.path.join(FLAGS.src_dir, d, N)
      #dst = os.path.join(FLAGS.dst_dir, d)
      #utils.ensure_dir_exists(dst)
      #utils.wait(utils.checked_run(None, 'gsutil', '-m', 'cp', '-r', src, dst))
      # Pull the required training checkpoints and models from GCS.
      src = os.path.join(FLAGS.src_dir, 'target/*')
      dst = os.path.join(FLAGS.dst_dir, 'target', N)
      utils.ensure_dir_exists(dst)
      utils.wait(utils.checked_run(None, 'gsutil', '-m', 'cp', '-r', src, dst))
      # download checkpoint files to the correct 9x9 path
      wd_src = os.path.join(FLAGS.src_dir, 'checkpoint/work_dir/work_dir')
      wd_dst = os.path.join(FLAGS.dst_dir, 'checkpoint', N)
      utils.ensure_dir_exists(wd_dst)
      utils.wait(utils.checked_run(None, 'gsutil', '-m', 'cp', '-r', wd_src, wd_dst))
      wd_src = os.path.join(FLAGS.src_dir, 'checkpoint/golden_chunks')
      wd_dst = os.path.join(FLAGS.dst_dir, 'checkpoint', N)
      utils.ensure_dir_exists(wd_dst)
      utils.wait(utils.checked_run(None, 'gsutil', '-m', 'cp', '-r', wd_src, wd_dst))

    # Freeze the target model.
    freeze_graph(os.path.join(FLAGS.dst_dir, 'target', N, 'target'), 2048)

    # Freeze the training checkpoint models.
    pattern = os.path.join(FLAGS.dst_dir, 'checkpoint', N, 'work_dir', '*.index')
    for path in glob.glob(pattern):
      freeze_graph(os.path.splitext(path)[0], 2048)

  finally:
    asyncio.get_event_loop().close()


if __name__ == '__main__':
  app.run(main)
