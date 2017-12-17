# Matplotlib

## Installation

pip install matplotlib

## Basic steps

- Import package (usually with numpy)

```
import matplotlib.pyplot as plt
from matplotlib import style
import numpy as np
```

- Fill plot, add properties

```
plt.plot(x, y, label="mylabel")
plt.legent()
...
```

- Show it

```
plt.show()
```

## Anatomy

- Figure: overall window where it draws. You can have several figuresnin the same plot
- Axes: area on which data is plotted (can have ticks, labels...)

## Main properties / functions to be used

- plt.title('my title'): set 'my title' as window main title
- plt.ylabel('my label'): set 'my label' as Y axes title
- plt.xlabel('my label') set 'my label' as X axes title
- plt.show(): show all previously configured content
- plt.legend(): presents legend for every variable in the plot
- plt.grid(True, color='k'): when plot is showed, it will be on a grid

- style.use("ggplot"): customize plot styles with "ggplot"

## Main plots

- plt.plot(x, y): line plot
- plt.pie(x): pie chart
- plt.bar(x, y): bar chart
- plt.scatter(x, y): scatter plot
- plt.text(xpos, ypos, "mytext"): introduces a text in xpos, ypos coordinates into the plot
- plt.axis([20, 40, 0, 0.5]): restricts axis. X axis from 20 to 40, y axis from 0 to 0.5
- plt.annotate("mytext", xy=(2,2), xytext=(3,3)): annotate text in the chart. Text will be positioned in 3,3 and will point to 2,2

## Common plot options

- color='g': color green
- align='center': center chart
- label='my label': label a chart. It is shown in legend
- linewidth=5: change linewidth

### Example

```
plt.scatter(x, y, color='g', align='center')
```

## Working with multiple figures

```
import matplotlib.pyplot as plt
plt.figure(1)                # the first figure
plt.subplot(211)             # the first subplot in the first figure
plt.plot([1, 2, 3])
plt.subplot(212)             # the second subplot in the first figure
plt.plot([4, 5, 6])


plt.figure(2)                # a second figure
plt.plot([4, 5, 6])          # creates a subplot(111) by default

plt.figure(1)                # figure 1 current; subplot(212) still current
plt.subplot(211)             # make subplot(211) in figure1 current
plt.title('Easy as 1, 2, 3') # subplot 211 title
```

The previous example creates 2 figures (2 windows); first one, will have 2 subplots and second one just one plot.
subplot is indexed by 3 digits: numrows, numcols and fignum. As you can see, first subplot will be positioned in a grid of 2 rows and 1 col, in the first position. 2nd subplot will be positioned in the second row.


## API reference

https://matplotlib.org/api/pyplot_summary.html
