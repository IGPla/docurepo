# NLTK

## Concepts

- Collocation: sequence of words that occur together unusually often (like "red wine")
- Corpus: list of text resources
- Word stem: basic part of the word (without tense, genre...). Basic stem
- Word lemmatization: use of a vocabulary and morphological analysis of words, normally aiming to remove inflectional endings only and return the base or dictionary form of a word, kwnown as lemma

### NLP Pipeline

HTML -> ASCII -> Text -> Vocab

```
html = urlopen(url).read()
raw = nltk.clean_html(html)
raw = raw[start_raw:end_raw] # Only select the relevant data
tokens = nltk.word_tokenize(raw)
tokens = tokens[start_tokens:end_tokens]
text = nltk.Text(tokens)
words = [w.lower() for w in text]
vocab = sorted(set(words))
```

## Common functions

- Concordance: show occurrences of a given word with its context

```
text.concordance("hello")
```

- Similar words: show similar words, based on contexts

```
text.similar("hello")
```

- Common contexts: examine contexts in common among several words

```
text.common_contexts(["hello", "bye"])
```

- Dispersion plot: print a dispersion plot from words frequency in a text

```
text.dispersion_plot(["hello", "bye"])
```

- Generate random text based on previous text

```
text.generate()
```

- Frequency distribution: get the frequency distribution of a given text

```
fdist = FreqDist(text)
```

There are several functions to be used with frequency distributions. It can be indexed to get the number of ocurrences of a given word. Basically, it holds a list of pairs (word, occurrences) 

-- most\_common: print a list of most common words (word, occurrences), sorted by occurrences, and limited to the number passed to most\_common
-- max: get the item with maximum number of occurrences
-- N: total number of samples
-- tabulate: tabulate the frequency distribution
-- plot: plot the frequency distribution (accepts a keyword "cumulative", boolean. If True, it shows the cummulative frequency distribution)

- Bigrams: return all bigrams in a given text (pairs of words that occur together)

```
list(bigrams(["my", "name", "is", "Sally"]))
```

- Collocation: return a list of collocations for the given text

```
text.collocations()
```

- Tokenize a raw text

```
tokens = word_tokenize(raw_text)
```

- Convert list of tokens into NLTK text object

```
text = nltk.Text(tokens)
```

- Clean html tags

```
nltk.clean_html(html)
```

- Stemmers

```
porter = nltk.PorterStemmer()
lancaster = nltk.LancasterStemmer()
porter.stem(token)
lancaster.stem(token)
```

- Lemmatization

```
wnl = nltk.WordNetLemmatizer()
wnl.lemmatize(token)
```

## Imports

```
import nltk
```

## Resources

### Download resources

```
nltk.download()
```

### Available corpus

All under nltk.corpus

Example (gutenberg corpus):

```
from nltk.corpus import gutenberg
```

## Tips and other packages

- Use BeautifulSoup to preprocess HTML sources before inputing them into NLTK
- Use feedoarser to parse RSS feeds
- Text normalization, usually converted to lowercase, processed with stemmer (Porter or Lancaster) and lemmatization.

