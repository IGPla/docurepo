# ML

This readme will be a summary of machine learning main steps, algorithms and shortcuts. Examples and technical stuff will be written with scikit-learn.

Machine learning: learn paterns from data to derive data-driven decissions.

## Types

- Supervised learning: create a model from training data that is already labeled
  - Classification: predict new inputs class based on discrete labels (finite, known set)
  - Regression: predict continuous value
- Unsupervised learning: create a model from training data without previously known labels.
  - Clustering: exploratory technique that organize data into groups (clusters) of common/related elements.
  - Dimensionality reduction: data compression technique, that reduces the dimensionality of the given dataset
- Reinforcement learning: system that improves its performance based on interactions with environment. Perform best guessed action, check environment, evaluate result, improve.

## Concepts

- Feature: measured value. It is usually the column of your dataset
- Dimensionality of a dataset: number of features that your dataset holds
- Model: algorithm plus all hyperparameters (preset or learned) that will allow us to "model" the problem. In terms of machine learnign, model will be trained to predict something on unseen data.
- Hyperparameter: parameters to tune models
- Correlated feature: feature changes are linked directly to another feature changes. 
- Cost function: function that will represent the cost of the given step
- High bias (underfit): models suffers of high bias when it doesn't have enough data (or data is not meaningful enough) to do good predictions on training data
- High variance (overfit): models suffers of high variance when it does good predicions on training data but it does not good predictions on unseen data
- Regularization: technique that prevents overfitting by filtering noise on data. It handles collinearity between features. For regularization to work, we must ensure that features are on the same scale. It just introduces new information (bias) to penalize extreme parameter weights (that leads our model to overfit on training data)
  - L1 and L2 regularization
- Curse of dimensionality
- Precondition of linearly separable dataset: most of algorithms are based on this precondition. Most of datasets does not provide this condition. It is the reason that preprocessing data is a really important and time consuming step.

## Roadmap summary

- Identify data sources
- Preprocessing
  - Select the right data sources and features
  - Build new meaningful features derived from the existent ones
  - Scale data to the same scale (for example, normalization)
  - Dimensionality reduction (remove high correlated features)
  - Dataset division (train + evaluation sets)
- Select a predictive model and train model with training data
  - Compare different algorithms with different hyperparameters
  - Choose a metric for performance
  - Cross-validate performance
- Evaluate model/s predictions on unseen data
- Loop to preprocessing until evaluation gives the desired results

## Algorithms (main ones)

- Classification
  - Logistic regression
  - SVM (support vector machines)
  - Decission tree
  - Random forest
  - K nearest neighbors

### Classification concepts

- Multiclass classification: classification normally operates on one class. It labels the data as it seems to be of the class or not. For the majority of problems, classification must be applied on a set of classes (more than one). Then, classifiers must operate as One vs rest. This approach is simple: classifier will be ran N times (one for each class) and will classify each instance against each class.

### Logistic regression concepts

- Performs really well on linearly separable datasets

### SVM concepts

- Support vector: line between classes in dataset
- Boundary: line that defines the margin of a given class
- Maximize the margin between support vectors and boundary

### Decission tree concepts

- Feature scaling is not required

### Random forest concepts

- Ensemble of decission trees

### K nearest neighbors

- Lazy learner (memorizes training datasets instead of building a model)
- Classifies new instances based on the class that have the neares neighbors in the training dataset
- Computationally expensive
- Sensible to overfitting

### Ensemble models

Models that are composition of other models.

- Random forest

