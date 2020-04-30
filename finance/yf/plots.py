#!/usr/bin/env python
# coding: utf-8

# # Initialize Environment

# In[1]:


import matplotlib, matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties
import numpy as np
from scipy.stats import norm
from scipy.io import loadmat
import glob
import yfinance as yf
import pandas as pd
import datetime
from copy import deepcopy
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()

# Seed Random number generator for repeatability
np.random.seed(19690720)

plt.style.use('default')
matplotlib.rcParams['font.family'] = 'serif'
matplotlib.rcParams.update({'font.size': 18})


# # Load Data
# ## Vanguard

# In[2]:


tickers = [ 'VTSAX', 'VSGAX', 'VGSLX', 'VHYAX', 'VTCLX', 'VTMFX' ]

data = yf.download(  # or pdr.get_data_yahoo(...
        # tickers list or string as well
        tickers = tickers,

        # use "period" instead of start/end
        # valid periods: 1d,5d,1mo,3mo,6mo,1y,2y,5y,10y,ytd,max
        # (optional, default is '1mo')
        period = "5y",

        # fetch data by interval (including intraday if period < 60 days)
        # valid intervals: 1m,2m,5m,15m,30m,60m,90m,1h,1d,5d,1wk,1mo,3mo
        # (optional, default is '1d')
        interval = "1d",

        # group by ticker (to access via data['SPY'])
        # (optional, default is 'column')
        group_by = 'ticker',

        # adjust all OHLC automatically
        # (optional, default is False)
        auto_adjust = True,

        # download pre/post regular market hours data
        # (optional, default is False)
        prepost = False,

        # use threads for mass downloading? (True/False/Integer)
        # (optional, default is True)
        threads = True,

        # proxy URL scheme use use when downloading?
        # (optional, default is None)
        proxy = None
    )


# ## TSP

# In[3]:


import pandas_datareader.tsp as tsp
tspreader = tsp.TSPReader()
tspdata = tspreader.read()

print(type(tspdata), tspdata)
# write the data, in reversed order
#tspdata.iloc[::-1].to_csv('~/Downloads/tsp_shareprices.csv')
tspdata.iloc[::-1].to_excel('~/Downloads/tsp_shareprices.xls', sheet_name='TSP Data')


# # Derived Data

# In[4]:


print(data)
ddata = data.swaplevel(0,1,axis=1).drop(['Open', 'High', 'Low', 'Volume'], axis=1)['Close']
#print(type(data), data.columns, ddata.columns)

#print(type(tspdata), tspdata, tspdata.columns)


# # Plot Data
# ## Vanguard

# In[5]:


# Compute the drawdown of an array, in place.
def drawdown (array):
    dd=deepcopy(array)
    maxval=-1
    for i in range(len(dd)):
        idx = i
        if array[idx] > maxval: maxval = array[idx]
        dd[idx] = (array[idx]/maxval - 1.) * 100.
    return dd

# Plot the prices & drawdowns over/under
def plot_prices_dd(tickers, data, ax):
    for t in tickers:
        #print(t, data[t].columns)
        #print(t, data[t])
        close = data[t]['Close']
        #print(type(close.index), type(close.values))
        dd = drawdown(close.values)

        ax[0].plot(close.index, close.values, label=t, linewidth=2.0)
        ax[0].grid(b=True, which='major', color='#999999', linestyle='-')
        ax[0].minorticks_on()
        ax[0].grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
        ax[0].legend(fancybox=True, loc=2)

        ax[1].plot(close.index, dd, label='{} ({:.1f}%)'.format(t,dd[-1]), linewidth=2.0)
        ax[1].grid(b=True, which='major', color='#999999', linestyle='-')
        ax[1].minorticks_on()
        ax[1].grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
        ax[1].legend(fancybox=True, loc=3)
        ax[1].set_xlim([datetime.date(2017, 1, 1), datetime.date.today()])
        plt.xticks(rotation=60)
    return



###########################################    
fig, ax  = plt.subplots(nrows=2, ncols=1,
                        sharex=True, sharey=False,
                        figsize=(12,8*2))

plot_prices_dd(tickers, data, ax)



#plt.show()
fig.savefig('vg_shareprices.pdf', bbox_inches='tight')


# ## TSP

# In[6]:


# Plot the prices & drawdowns over/under
def plot_tsp_prices_dd(tspdata, ax):
    for c in tspdata.columns:
        if not c: continue
        close = tspdata[c]
        #print(type(close.index), type(close.values))
        #print(close)
        dd = drawdown(close.values)

        ax[0].plot(close.index, close.values, label=c, linewidth=2.0)
        ax[0].grid(b=True, which='major', color='#999999', linestyle='-')
        ax[0].minorticks_on()
        ax[0].grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
        ax[0].legend(fancybox=True, loc=2)

        if 'G Fund' in c: continue
        ax[1].plot(close.index, dd, label='{} ({:.1f}%)'.format(c,dd[-1]), linewidth=2.0)
        ax[1].grid(b=True, which='major', color='#999999', linestyle='-')
        ax[1].minorticks_on()
        ax[1].grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
        ax[1].legend(fancybox=True, loc=3)
        ax[1].set_xlim([datetime.date(2017, 1, 1), datetime.date.today()])
        plt.xticks(rotation=60)
    return



###########################################    
fig, ax  = plt.subplots(nrows=2, ncols=1,
                        sharex=True, sharey=False,
                        figsize=(12,8*2))

plot_tsp_prices_dd(tspdata, ax)
fig.savefig('tsp_shareprices.pdf', bbox_inches='tight')


# # Correlations
# ## Vanguard

# In[7]:


import seaborn as sns

sns.set(style="white")

corr = ddata.corr()

# Generate a mask for the upper triangle
mask = np.triu(np.ones_like(corr, dtype=np.bool))

# Set up the matplotlib figure
f, ax = plt.subplots(figsize=(10, 10))

# Generate a custom diverging colormap
cmap = sns.diverging_palette(220, 10, as_cmap=True)

# Draw the heatmap with the mask and correct aspect ratio
sns.heatmap(corr, mask=None, center=0, vmin=-1, vmax=1, cmap=cmap, annot=True,
            square=True, linewidths=.5, cbar_kws={"shrink": 0.5, "orientation": "horizontal"})

ax.set_xlabel(None)
ax.set_ylabel(None)
#ax.set_yticklabels([ item.get_text().strip('Close-') for item in ax.get_yticklabels() ])
ax.set_yticklabels(
    ax.get_yticklabels(),
    rotation=0,
    verticalalignment='center')
ax.set_xticklabels(
    ax.get_yticklabels(),
    rotation=45,
    horizontalalignment='right')
(bottom, top) = ax.get_ylim()
ax.set_ylim(bottom + 0.5, top - 0.5)


# ## TSP

# In[8]:


corr = tspdata.corr()

# Generate a mask for the upper triangle
mask = np.triu(np.ones_like(corr, dtype=np.bool))

# Set up the matplotlib figure
f, ax = plt.subplots(figsize=(10, 10))

# Generate a custom diverging colormap
cmap = sns.diverging_palette(220, 10, as_cmap=True)

# Draw the heatmap with the mask and correct aspect ratio
sns.heatmap(corr, mask=None, center=0., vmin=-1, vmax=1, cmap=cmap, annot=True,
            square=True, linewidths=.5, cbar_kws={"shrink": 0.5, "orientation": "horizontal"})


ax.set_xlabel(None)
ax.set_ylabel(None)
#ax.set_yticklabels([ item.get_text().strip('Close-') for item in ax.get_yticklabels() ])
ax.set_yticklabels(
    ax.get_yticklabels(),
    verticalalignment='center')
ax.set_xticklabels(
    ax.get_yticklabels(),
    rotation=45,
    horizontalalignment='right')
(bottom, top) = ax.get_ylim()
ax.set_ylim(bottom + 0.5, top - 0.5)


# In[ ]:




