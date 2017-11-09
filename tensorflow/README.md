# Tensorflow

## Install

pip3 install --upgrade tensorflow

## Basic concepts

- tensor: an array
- tensor rank: dimensions tensor 
- computational graph: graph of nodes that must be defined and then ran into tensorflow
- node: single graph node
- session: this is the object that will run the computational graph
- tensorboard: graphical representation of computational graph

## Base import

```
import tensorflow as tf
```

## Simple example

```
n1 = tf.constant(3.0)
n2 = tf.constant(4.0)
n3 = tf.add(n1, n2)
session = tf.Session()
session.run([n3])
```

## Placeholders

Placeholders are variables defined when session starts to run the graph

```
a = tf.placeholder(tf.float32)
b = tf.placeholder(tf.float32)
n4 = a+b // shortcut for tf.add(a, b)
session.run(n4, {'a': 1, 'b': 5})
session.run(n4, {'a': [4,5], 'b': [1,1]})
```

## Variables

Used for trainable variables (such as weights and biases) for a given model

```
W = tf.Variable([.3], dtype=tf.float32)
b = tf.Variable([-.3], dtype=tf.float32)
x = tf.placeholder(tf.float32)
linear_model = W*x + b
```

