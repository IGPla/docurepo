# Machine learning

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
- Regularization: technique that prevents overfitting by filtering noise on data. It handles collinearity between features. For regularization to work, we must ensure that features are on the same scale. It just introduces new information (bias) to penalize extreme parameter weights (that leads our model to overfit on training data). It's just a way to simply the model.
  - L1 and L2 regularization
- Curse of dimensionality
- Precondition of linearly separable dataset: most of algorithms are based on this precondition. Most of datasets does not provide this condition. It is the reason that preprocessing data is a really important and time consuming step.

## Roadmap summary

- Identify data sources
- Preprocessing
  - Select the right data sources and features 
  - Build new meaningful features derived from the existent ones (feature engineering)
  - Scale data to the same scale (for example, normalization)
  - Dimensionality reduction (remove high correlated features)
  - Dataset division (train + evaluation sets)
- Select a predictive model and train model with training data
  - Compare different algorithms with different hyperparameters
  - Choose a metric for performance
  - Cross-validate performance
- Evaluate model/s predictions on unseen data
- Loop to preprocessing until evaluation gives the desired results

## Feature engineering

Maybe, the hardest, non automatable and most important step in machine learning process. This step involves domain knowledge to identify or create the most meaningful features to allow our model to perform as good as it can. There are not a silver bullet process to approach this work, and it depends deeply on every problem. However, following is the summary of the common steps to organize your feature engineering work.

- Brainstorming of testing features
- Deciding what features to create
- Create features
- Check how features work with your model
- Improve your features if needed
- Back to brainstorming until model behaves as expected

There are some methods for the so called "Feature learning": an intent to automate this approach (feature engineering), mostly used in deep learning.

A simple but powerful example of feature engineering is the "One hot encoding". It creates N new features from a nominal variable (with N different values). Each feature will be a boolean indicating if that sample has or has not that value active.

## Algorithms (main ones)

- Classification
  - Logistic regression
  - SVM (support vector machines)
  - Decission tree
  - Random forest
  - K nearest neighbors
- Regression
  - Linear regression
  - RANSAC
  - Ridge regression
  - LASSO regression
  - Elastic Net
  - Polynomial regression
  - Random forest regression
- Clustering
  - K-means
  - Fuzzy C-means
  
### Clustering concepts

- Allows  to discover hidden structures in unlabeled data
- Hard clustering: each sample is assigned exactly to one cluster
  - K-means
- Soft clustering: each sample is assigned to one or more clusters
  - Fuzzy C-means
- Prototype base clustering: each cluster is represented as a protoype (a centroid usually)
- Hierarchical clustering: it does not require to specify the number of clusters upfront. It allows to plot dendograms
  - Agglomerative: (**AgglomerativeClustering**) Starts with each sample as an individiual cluster and keep merging closest clusters until one cluster remains
  - DBSCAN: (**DBSCAN**) density is the number of points within specified radius. Useful for non-spherical shaped clusters
- Single linkage: compute the distance between the most similar members for each pair of clusters for which the distance between the most similar members is smallest
- Complete linkage: compare the most dissimilar members to perform the merge. It merges pair of clusters for which the distance between the most dissimilar members is smallest
- Average linkage: merge the cluster parise based on the minimum average distances between all group members in both clusters
- Ward's linkage: merge the two clusters that lead to minimum increase of total within-cluster SSE
  
#### K-means concepts

- Prototype base clustering method
- Easy to implement
- Computationally efficient
- Number of clusters must be defined previously
- It can lead to bad clustering if initial centroids are chosen poorly
- **KMeans**
- Exists a k-means++ variant of this algorithm, that places initial centroids far away from each other

#### Fuzzy C-means

- Prototype base clustering method
- Each sample is assigned to each cluster with a probability

### Regression concepts

- Univariate (relationship between single feature and continuous valued response (target))
  - y = w0 + w1 * x
- Multivariate
  - y = w0 + w1 * x1 + ... + wn * xn = sum(wi * xi) = w^T * x
- Regularization is also applicable here

#### Linear regression concepts

- Can be heavily impacted by the presence of outliers

#### RANSAC (Random Sample Consensus) concepts

- Good cjoice against outliers

#### Ridge regression concepts

- Regression method with L2 regularization

#### LASSO regression concepts

- Regression method with L1 regularization
- It selects at most N variables

#### Elastic Net concepts

- A compromis between Ridge and Lasso
  - L1 penalty to generate sparsity 
  - L2 penalty to overcome the limitations of LASSO
  
#### Polynomial regression concepts

- A way to account for violation of linearity assumption
- Adding more polynomial increases the complexity of model, and can lead to overfitting

#### Random forest regression concepts

- Made of decission tree regressors

### Classification concepts

- Multiclass classification: classification normally operates on one class. It labels the data as it seems to be of the class or not. For the majority of problems, classification must be applied on a set of classes (more than one). Then, classifiers must operate as One vs rest. This approach is simple: classifier will be ran N times (one for each class) and will classify each instance against each class.

#### Logistic regression concepts

- Performs really well on linearly separable datasets

#### SVM concepts

- Support vector: line between classes in dataset
- Boundary: line that defines the margin of a given class
- Maximize the margin between support vectors and boundary

#### Decission tree concepts

- Feature scaling is not required

#### Random forest concepts

- Ensemble of decission trees

#### K nearest neighbors

- Lazy learner (memorizes training datasets instead of building a model)
- Classifies new instances based on the class that have the neares neighbors in the training dataset
- Computationally expensive
- Sensible to overfitting

### Ensemble models

Models that are compositions of other models. The new meta-classifier is a combination of weak learners (other models that have weaker prediction power) that has better generalization performance than each individual classifier alone.

Combination approaches

- Majority vote: the solution with more votes is the selected one
- Bagging (bootstrap aggregating): similar to majority vote. Instead of using the same training set to fit the individual clasifiers, select random samples with replacement (bootstrap samples) from the initial training set
  - Improves accuracy of unstable models
  - Decrease the degree of overfitting
  - Effective to reduce the variance of a model
  - Not effective in reducing model bias
- Boosting: focus on training samples that are hard to classify (missclassified instances) to let weak learners subsequently learn from them. 

- Random forest
  - Bagging algorithm
- AdaBoost (adaptive boosting)
  - Boosting algorithm

## Data preprocessing

- Missing data: 
  - First approach: remove NaN data (either by removing full row or full column)
  - Second approach: input missing values. There are several techniques here to fill them (interpolation like mean, max, min, mode, constant values...)
- Categorical data:
  - Ordinal: categorical, sortable (M < L < XL)
    - Just map them to values (M -> 1, L -> 2, XL -> 3) **LabelEncoder**
  - Nominal: categorical, no order (Black, Blue, Red)
    - Create new dummy features for each unique value **OneHotEncoder**
- Split data into training / test datasets **train\_test\_split**
- Feature scaling
  - Normalization: all features to range [0-1] **MinMaxScaler**
  - Standardization: apply standardization (mean 0, standard deviation 1) to variable distribution **StandardScaler**
- Solve overfitting problems
  - Regularization
  - Feature selection: selects a subset of original features, the most meaningful
  - Feature extraction: derive information to construct a new feature space
  - Random forest: measure feature importance

## Dimensionality reduction

Data compression methods. Drop non meaningful or redundant features, or build a new smaller feature subspace with the most important data

### Feature extraction

Projects data onto new feature space (in dimensionality reduction, a smaller one)

- Linearly separable problems
  - PCA (principal component analysis): find the direction of maximum variance (principal components) in high dimensional data and projects it into new subspace with equal or fewer dimensions than original one.
    - Unsupervised method
    - Highly sensitive to data scaling (need to standardize features)
  - LDA (linear discrimination analysis): similar to PCA in concept. Looks for feature subspace that optimizes class separability
    - Supervised method
    - Needs normally distributed data, independence among features and identical covariance matrices on classes
- Nonlinear separable problems
  - Kernel PCA: usable when data is not linearly separable (basic assumption in many cases). Transforms the data onto a new, lower-dimensional subspace, suitable for linear classifiers
    - Usable for non-linear mappings
    - Kernel: from non linear problems, it maps onto higher dimensional feature space and it becomes linearly separable (kernel) and then, applies PCA to reduce them, outputing a less-dimension space, linearly separable
    - Most common kernels: Polynomial kernel, Hyperbolic tangent (sigmoid), Radial basis function (RBF, or gaussian)

## Model evaluation and hyperparameter tuning

It's a must to have right tools to evaluate model performance and be able to tune hyperparameters to look for the best performance it can handle

- Cross validation: split available training data into 3 datasets (training, test, validation). 
  - Steps
	- Create model with training set
	- Check performance with validation set
	- Once model is selected, test it against test set
  - K-fold cross validation: repeat cross validation through k subsets to find the best combination 
    - Divide training data into k folds
	- During k iterations, k-1 folds are used for training, and 1 fold is used for model evaluation
	- Each combination of training folds + test fold generates an estimator
- Debugging algorithms: diagnose if a learning algorithm has a problem with overfitting or underfitting 
  - Learning curves: plot training and test accuracies
  - Validation curves: similar approach as above, but it varies the values of the model parameters

To address underfitting: increase number of features, decrease degree of regularization
To address overfitting: collect more training data, reduce the complexity of the model (decrease number of features / increase regularization)

- Fine-tuning
  - Grid search: brute-force method to compute N models. Each model will have a preset variation of hyperparameters. Computationally expensive.
  
- Model selection
  - ROC (Receiver Operator Characteristic): useful tool for selecting models for classification. It plots TPR against FPR
  
### Performance evaluation metrics

- Classification
  - Confusion matrix: create a matrix with all posibilities between actual class and predicted class. Fill each position with the number of occurrences of each one.
	- TP (True positive)
	- FN (False negative)
	- FP (False positive)
	- TN (True negative)
  - Prediction error (ERR): (FP+FN) / (FP+FN+TP+TN)
  - Accuracy error (ACC): 1 - ERR
  - True positive rate (TPR) (also called "Recall" (REC)): TP/P = TP/(FN+TP)
  - False positive rate (FPR): FP/N = FP/(TN+FP)
  - Precision (PRE): TP/(TP+FP)
- Regression
  - SSE (Sum of Squared Errors): sum((yi - f(xi))^2)
  - MSE (Mean Square Error): average of SSE
  - Coefficient of determination (R^2): standardized version of MSE
  
## Best practices

- Streamline workflows with pipelines
  - Common pipelines have the following steps: scaling, dimensionality reduction, model building (learning), model evaluation (prediction)
- Once the model is training and validated, is a good approach to serialize it to make it portable (deserialize model when/where you need it again)

## Utils

- EDA (exploratory data analysis): important first step prior to the training of a model
  - Scatterplot matrix to visualize pair-wise correlations between features
  - Heatmap
