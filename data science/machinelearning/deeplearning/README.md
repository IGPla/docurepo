# Deep learning

## Useful concepts

- RELU (Rectified Linear Unit): is a simple activation function. This is used usually as a replacement of a sigmoid function, allowing gradient descent to converge much faster. y is 0 for x less than or equal to 0 and y = x otherwise
- X: features matrix (each X(i) will be a feature vector, a single sample input)
- m: number of training samples
- y: output (each y(i) will be a single value, beign the output provided for the input sample X(i))
- Nx: number of features
- Deep learning (neural networks) is suited for supervised learning problems

## Usage

- Representation for inputing (and output) of a neural network will be [X(1), X(2), ... , X(m)], stacked in columns (so each X(i) will be a column of the input matrix) (Nx by m). y output will be a row vector (1 by m)

## Computational graph

The computational graph is the graph of actions to be taken to satisfy a function

Let's take an example:

f(a, b, c) = 3 (a + bc)

So computational graph will be

```
a---------
          + -> a + bc--
b--
  * -> bc--
c--
                      * -> 3 (a + bc)
3----------------------
```

It organizes the forward path of the function. It will be an useful step to compute the backwards propagation, calculating derivatives, using the graph in inverse order
 