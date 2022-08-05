#!/usr/bin/env python3
#
# Train a simple Convolutional Neural Network to classify CIFAR images.

import argparse
import os
import sys
import time

import numpy as np
import tensorflow as tf


def get_command_arguments():
    """ Read input variables and parse command-line arguments """

    parser = argparse.ArgumentParser(
        description='Train a simple Convolutional Neural Network to classify CIFAR images.',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    parser.add_argument('-c', '--classes', type=int, default=10, choices=[10, 20, 100], help='number of classes in dataset')
    parser.add_argument('-p', '--precision', type=str, default='fp32', choices=['bf16', 'fp16', 'fp32', 'fp64'], help='floating-point precision')
    parser.add_argument('-e', '--epochs', type=int, default=42, help='number of training epochs')
    parser.add_argument('-b', '--batch_size', type=int, default=256, help='batch size')

    args = parser.parse_args()
    return args


def create_datasets(classes, dtype):
    """ Create CIFAR training and test datasets """

    # Download training and test image datasets
    if classes == 100:
        (x_train, y_train), (x_test, y_test) = tf.keras.datasets.cifar100.load_data(label_mode='fine')
    elif classes == 20:
        (x_train, y_train), (x_test, y_test) = tf.keras.datasets.cifar100.load_data(label_mode='coarse')
    else: # classes == 10
        (x_train, y_train), (x_test, y_test) = tf.keras.datasets.cifar10.load_data()

    # Verify training and test image dataset sizes
    assert x_train.shape == (50000, 32, 32, 3)
    assert y_train.shape == (50000, 1)
    assert x_test.shape == (10000, 32, 32, 3)
    assert y_test.shape == (10000, 1)

    # Normalize the 8-bit (3-channel) RGB image pixel data between 0.0 
    # and 1.0; also converts datatype from numpy.uint8 to numpy.float64
    x_train = x_train / 255.0
    x_test = x_test / 255.0

    # Convert from NumPy arrays to TensorFlow tensors
    x_train = tf.convert_to_tensor(value=x_train, dtype=dtype, name='x_train')
    y_train = tf.convert_to_tensor(value=y_train, dtype=tf.uint8, name='y_train')
    x_test = tf.convert_to_tensor(value=x_test, dtype=dtype, name='x_test')
    y_test = tf.convert_to_tensor(value=y_test, dtype=tf.uint8, name='y_test')

    # Construct TensorFlow datasets
    train_dataset = tf.data.Dataset.from_tensor_slices((x_train, y_train))
    test_dataset = tf.data.Dataset.from_tensor_slices((x_test, y_test))

    return train_dataset, test_dataset


def create_model(classes):
    """ Specify and compile the CNN model """

    model = tf.keras.Sequential([
        tf.keras.layers.InputLayer(input_shape=(32, 32, 3)),
        tf.keras.layers.Conv2D(32, (3, 3), activation='relu'),
        tf.keras.layers.MaxPooling2D((2, 2)),
        tf.keras.layers.Conv2D(64, (3, 3), activation='relu'),
        tf.keras.layers.MaxPooling2D((2, 2)),
        tf.keras.layers.Conv2D(64, (3, 3), activation='relu'),
        tf.keras.layers.Flatten(),
        tf.keras.layers.Dense(64, activation='relu'),
        tf.keras.layers.Dense(classes),
    ])

    model.compile(
        optimizer=tf.keras.optimizers.Adam(),
        loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
        metrics=['accuracy'],
    )

    return model


def main():
    """ Train CNN on CIFAR """

    # Read input variables and parse command-line arguments
    args = get_command_arguments()

    # Set internal variables from input variables and command-line arguments
    classes = args.classes
    if args.precision == 'bf16':
        tf_float = tf.bfloat16
    elif args.precision == 'fp16':
        tf_float = tf.float16
    elif args.precision == 'fp64':
        tf_float = tf.float64
    else: # args.precision == 'fp32'
        tf_float = tf.float32
    epochs = args.epochs
    batch_size = args.batch_size

    # Create training and test datasets
    train_dataset, test_dataset = create_datasets(classes, dtype=tf_float)

    # Prepare the datasets for training and evaluation
    train_dataset = train_dataset.cache().shuffle(buffer_size=50000, reshuffle_each_iteration=True).batch(batch_size)
    test_dataset = test_dataset.batch(batch_size)

    # Create model
    model = create_model(classes)

    # Print summary of the model's network architecture
    model.summary()

    # Train the model on the dataset
    model.fit(x=train_dataset, epochs=epochs, verbose=2)

    # Evaluate the model and its accuracy
    model.evaluate(x=test_dataset, verbose=2)

    # Save the model
    model.save('saved_model.o'+os.environ['SLURM_JOB_ID'])

    return 0


if __name__ == '__main__':
    sys.exit(main())


# References:
# https://www.tensorflow.org/tutorials/images/cnn
# https://touren.github.io/2016/05/31/Image-Classification-CIFAR10.html
# https://towardsdatascience.com/deep-learning-with-cifar-10-image-classification-64ab92110d79
# https://www.tensorflow.org/api_docs/python/tf/keras/datasets/cifar10/load_data
# https://en.wikipedia.org/wiki/8-bit_color
# https://www.tensorflow.org/guide/keras/sequential_model
# https://www.tensorflow.org/api_docs/python/tf/keras/Model#summary
# https://www.tensorflow.org/api_docs/python/tf/keras/Sequential#compile
# https://www.tensorflow.org/guide/keras/train_and_evaluate
# https://www.tensorflow.org/api_docs/python/tf/keras/Sequential#compile
# https://www.tensorflow.org/api_docs/python/tf/keras/Sequential#fit
# https://www.tensorflow.org/api_docs/python/tf/keras/Sequential#evaluate
