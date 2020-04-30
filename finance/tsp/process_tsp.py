#!/usr/bin/env python2

import csv, sys
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties
from datetime import date
from copy import deepcopy
from lxml import html
import requests

sharefile="./shareprices.csv"

today = date.toordinal(date.today())

allfunds= {};

fund_names = {
    'L Income' : 1,
    'L 2020'   : 2,
    'L 2030'   : 3,
    'L 2040'   : 4,
    'L 2050'   : 5,
    'G Fund'   : 6,
    'F Fund'   : 7,
    'C Fund'   : 8,
    'S Fund'   : 9,
    'I Fund'   : 10,
}

months = {
    'Jan' : 1,
    'Feb' : 2,
    'Mar' : 3,
    'Apr' : 4,
    'May' : 5,
    'Jun' : 6,
    'Jul' : 7,
    'Aug' : 8,
    'Sep' : 9,
    'Oct' : 10,
    'Nov' : 11,
    'Dec' : 12
}


class FundHistory:
    """TSP Fund History"""

    def __init__(self,fname):
        self.name = fname;
        self.history = {};
        self.daysago = np.ndarray(0,dtype=np.int32)
        self.values  = np.ndarray(0)



    def set_date(self, datestamp, value):
        if ("-" in datestamp):
            datestamp=datestamp.split("-")
            daysago = today - date.toordinal(date(int(datestamp[0]),
                                                  int(datestamp[1]),
                                                  int(datestamp[2])))
        elif ("," in datestamp):
            datestamp=datestamp.split()
            year=datestamp[2]
            month=months[datestamp[0]]
            day=datestamp[1].strip(",")
            daysago =  today - date.toordinal(date(int(year),
                                                   int(month),
                                                   int(day)))
        else:
            print "I don\'t understand this datestamp", datestamp

        self.history[daysago] = value;
        #print self.name, daysago, self.history[daysago]



    def describe(self):
        # print self.name,
        # for k,v in self.history.iteritems():
        #     print k, ':', v
        print self.name, ':', self.daysago, self.values



    def history_to_arrays(self):
        #print self.name, self.history
        numvals = len(self.history)
        self.daysago.resize(numvals)
        self.values.resize(numvals)

        idx=0
        for k,v in self.history.iteritems():
            #print self.name, k, v
            self.daysago[idx] = k
            self.values[idx]  = v
            idx += 1



for k,v in fund_names.iteritems():
    allfunds[k] = FundHistory(k);



# Cpmpute the moving average of an array, in place.
def moveavg ( array, num ):
    avg=deepcopy(array[0:-num])
    avg /= num; # divide now, not after the sum, to avoid overflow
    for i in range(len(avg)):
        avg[i] = sum(avg[i:i+num])

    return avg

# Compute the drawdown of an array, in place.
def drawdown (array):
    dd=deepcopy(array)
    maxval=-1
    for i in range(len(dd)):
        idx = len(dd)-i-1
        if array[idx] > maxval: maxval = array[idx]
        dd[idx] = (array[idx]/maxval - 1.) * 100.

    return dd


def plotshares ( d ):

#    try:

    fontP = FontProperties()
    fontP.set_size('small')
    fontP.set_family('monospace')

    colors= {}
    colors["C Fund"] = "C0";
    colors["S Fund"] = "C1";
    colors["I Fund"] = "C2";
    colors["F Fund"] = "C3";

    for k,v in d.iteritems():

        ydata = v.values[0:-2] / v.values[0];
        xdata = v.daysago[0:ydata.shape[0]];
        ydata2 = 1. / ydata;

        #print k, xdata.shape, ydata.shape
        #print k, xdata, ydata
        ls="-"

        if (True):
            if "L " in k:
                ls="--"

                ##############################################
                plt.figure(1)
                plt.subplot(3,2,1)
                plt.plot(xdata/365., ydata, label=k, linewidth=2.0)
                plt.ylabel('Relative Share Price')
                plt.xlabel('Years Ago')
                plt.axis([0, 15, 0, 1.2])
                plt.gca().invert_xaxis()
                plt.grid(True)
                plt.legend(fancybox=True, prop=fontP, loc=3)

                plt.subplot(3,2,3)
                plt.plot(xdata/365., ydata, label=k, linewidth=2.0)
                plt.ylabel('Relative Share Price')
                plt.xlabel('Years Ago')
                plt.axis([0, 5, 1/2, 1.1])
                plt.gca().invert_xaxis()
                plt.grid(True)

                plt.subplot(3,2,5)
                plt.plot(xdata/30., ydata, label=k, linewidth=2.0)
                plt.ylabel('Relative Share Price')
                plt.xlabel('Months Ago')
                plt.axis([0, 12, 1/1.25, 1.1])
                plt.gca().invert_xaxis()
                plt.grid(True)

                ##############################################
                plt.figure(2)
                plt.subplot(3,2,1)
                plt.plot(xdata/365., ydata2, label=k, linewidth=2.0)
                plt.ylabel('Growth Factor')
                plt.xlabel('Years Ago')
                plt.axis([0, 15, 0, 4])
                plt.gca().invert_xaxis()
                plt.grid(True)
                plt.legend(fancybox=True, prop=fontP, loc=4)

                plt.subplot(3,2,3)
                plt.plot(xdata/365., ydata2, label=k, linewidth=2.0)
                plt.ylabel('Growth Factor')
                plt.xlabel('Years Ago')
                plt.axis([0, 5, 0.5, 2])
                plt.gca().invert_xaxis()
                plt.grid(True)

                plt.subplot(3,2,5)
                plt.plot(xdata/30., ydata2, label=k, linewidth=2.0)
                plt.ylabel('Growth Factor')
                plt.xlabel('Months Ago')
                plt.axis([0, 12, .8, 1.2])
                plt.gca().invert_xaxis()
                plt.grid(True)

            else:
                ##############################################
                plt.figure(1)
                plt.subplot(3,2,2)
                plt.plot(xdata/365., ydata, label=k, linewidth=2.0)
                plt.xlabel('Years Ago')
                plt.axis([0, 15, 0, 1.2])
                plt.gca().invert_xaxis()
                plt.grid(True)
                plt.legend(fancybox=True, prop=fontP, loc=4)

                plt.subplot(3,2,4)
                plt.plot(xdata/365., ydata, label=k, linewidth=2.0)
                plt.xlabel('Years Ago')
                plt.axis([0, 5, 1/2, 1.1])
                plt.gca().invert_xaxis()
                plt.grid(True)

                plt.subplot(3,2,6)
                plt.plot(xdata/30., ydata, label=k, linewidth=2.0)
                plt.xlabel('Months Ago')
                plt.axis([0, 12, 1/1.25, 1.1])
                plt.gca().invert_xaxis()
                plt.grid(True)

                ##############################################
                plt.figure(2)
                plt.subplot(3,2,2)
                plt.plot(xdata/365., ydata2, label=k, linewidth=2.0)
                plt.xlabel('Years Ago')
                plt.axis([0, 15, 0, 4])
                plt.gca().invert_xaxis()
                plt.grid(True)
                plt.legend(fancybox=True, prop=fontP, loc=4)

                plt.subplot(3,2,4)
                plt.plot(xdata/365., ydata2, label=k, linewidth=2.0)
                plt.xlabel('Years Ago')
                plt.axis([0, 5, 0.5 , 2])
                plt.gca().invert_xaxis()
                plt.grid(True)

                plt.subplot(3,2,6)
                plt.plot(xdata/30., ydata2, label=k, linewidth=2.0)
                plt.xlabel('Months Ago')
                plt.axis([0, 12, .8, 1.2])
                plt.gca().invert_xaxis()
                plt.grid(True)

        if (k in colors):
            ##############################################
            plt.figure(3)

            avg_window=200
            yarray = v.values[0:365*6]
            xarray = v.daysago[0:yarray.shape[0]]/365.;
            yavg   = moveavg(yarray,avg_window)
            xavg   = v.daysago[0:yavg.shape[0]]/365.;
            yavg2  = moveavg(yarray,avg_window/2)
            xavg2  = v.daysago[0:yavg2.shape[0]]/365.;
            pdiff_long  = 100.*(yarray[0] -  yavg[0])/yavg[0];
            pdiff_short = 100.*(yarray[0] - yavg2[0])/yavg2[0];

            plt.subplot(1,2,1)
            plt.plot(xarray*12, yarray, label=k+", ${:.4f}, ({:+.2f}%, {:+.2f}%)".format(yarray[0], pdiff_short, pdiff_long), linewidth=3.0, linestyle="-", color=colors[k])
            plt.plot(xavg*12,   yavg,   linewidth=2.0, linestyle="--", color=colors[k])

            plt.plot(xavg2*12,  yavg2,  linewidth=1.0, linestyle="-.", color=colors[k])


            plt.ylabel('Share Price')
            plt.xlabel('Months Ago')
            plt.title('Share Prices and ' + "({}, {})-day Moving Averages".format(avg_window/2,avg_window))
            plt.xlim([0,36])
            plt.ylim([15,55])
            plt.gca().invert_xaxis()
            plt.grid(True)
            plt.legend(fancybox=True, prop=fontP,loc=2)

            plt.subplot(1,2,2)
            xarray = v.daysago[0:yarray.shape[0]]
            xavg   = v.daysago[0:yavg.shape[0]]
            xavg2  = v.daysago[0:yavg2.shape[0]]
            plt.plot(xarray, yarray, linewidth=3.0, linestyle="-",  color=colors[k])
            plt.plot(xavg,   yavg,   linewidth=2.0, linestyle="--", color=colors[k])
            plt.plot(xavg2,  yavg2,  linewidth=1.0, linestyle="-.", color=colors[k])
            plt.ylabel('Share Price')
            plt.xlabel('Days Ago')
            plt.xlim([0,180])
            plt.ylim([25,55])
            plt.gca().invert_xaxis()
            plt.grid(True)


            ##############################################
            if 'C Fund' in k or 'S Fund' in k or 'I Fund' in k or 'F Fund' in k:
                plt.figure(4)
                yarray = drawdown(v.values[0:-1])
                xarray = v.daysago[0:yarray.shape[0]]/365.;

                plt.subplot(2,1,1)
                plt.plot(xarray, yarray, label=k + ' ({:.2f}%)'.format(yarray[0]), linewidth=3.0, linestyle="-", color=colors[k])


                plt.ylabel('Drawdown (%)')
                plt.xlabel('Years Ago')
                plt.title('Drawdowns')
                plt.xlim([0,12])
                plt.gca().invert_xaxis()
                plt.grid(True)

                plt.subplot(2,1,2)
                xarray = v.daysago[0:yarray.shape[0]]
                plt.plot(xarray, yarray, label=k + ' ({:.2f}%)'.format(yarray[0]), linewidth=3.0, linestyle="-",  color=colors[k])
                plt.ylabel('Drawdowns')
                plt.xlabel('Days Ago')
                plt.xlim([-1,365])
                plt.gca().invert_xaxis()
                plt.grid(True)
                plt.legend(fancybox=True, prop=fontP,loc=3)


        # if (False):
        #     plt.figure(4)
        #     plt.plot(xdata/365., ydata, label=k, linewidth=2.0, linestyle=ls)
        #     plt.ylabel('Relative Share Price')
        #     plt.xlabel('Years Ago')
        #     plt.axis([0, 15, 0, 1.2])
        #     plt.gca().invert_xaxis()
        #     plt.grid(True)
        #     plt.legend(fancybox=True, prop=fontP,loc=3)



    # len = 400;
    # l2050     = d['L 2050'][0:len];
    # linc      = d['L Income'][0:len];
    # mix1      = d['Mix Growth'][0:len];
    # mix2      = d['Mix Conserv'][0:len];
    # ydata     = l2050 / linc;
    # ydata     = ydata / ydata[0];
    # ydata_inv = 1. / ydata;
    # xdata     = d['yearsago'][0:ydata.shape[0]]
    # plt.figure(5)
    # plt.plot(xdata*12, ydata,     label=r'$P_{2050}/P_{inc}$', linewidth=2.0, linestyle=ls)
    # plt.plot(xdata*12, ydata_inv, label=r'$P_{inc}/P_{2050}$', linewidth=2.0, linestyle=ls)
    # plt.ylabel(r'Price Ratio')
    # plt.xlabel('Months Ago')
    # plt.title(r'Maximixe, $N_{inc}=N_{2050}\frac{P_{2050}}{P_{inc}}$, $N_{2050}=N_{inc}\frac{P_{inc}}{P_{2050}}$')
    # plt.gca().invert_xaxis()
    # plt.grid(True)
    # plt.legend(prop=fontP,loc=3)

    plt.show()
#    except:
#        return
#    return




# 1) read archive data from 'sharefile'
with open(sharefile, 'rb') as csvfile:
    filereader = csv.reader(csvfile)
    for row in filereader:

        if row:
            # Special processing for the header row
            if (row[0] == "date"):
                headers = row
                for c, column in enumerate(headers):
                    column = column.strip()
                    if column:
                        headers[c] = column
                #print headers
                continue

            for c, column in enumerate(row):
                column = column.strip()
                if column:
                    #print c, column
                    if c == 0:
                        continue
                    else:
                        #print c, headers[c], column
                        if (float(column) > 0):
                            allfunds[headers[c]].set_date(row[0].strip(),float(column))


#print d
#list2array(d)
#plotshares(d)

# 2) append latest info from TSP site
try:
    page = requests.get('https://www.tsp.gov/InvestmentFunds/FundPerformance/index.html')
    tree = html.fromstring(page.content)
except:
    page = None
    tree = None

#print tree
#print page.text
#print '\n\n****************************************************************************\n\n'

#print tree.xpath('//table[@class="tspStandard"]/tr')

if tree:
    headers =  tree.xpath('//table[@class="tspStandard"]/tr/th/text()')
    #print headers

    for row in tree.xpath('//table[@class="tspStandard"]/tr'):
        thisrow = row.xpath('./td/text()')
        #print thisrow, "\n"
        for c, value in enumerate(thisrow):
            value = value.strip()
            label = headers[c].strip()
            if (label in allfunds):
                #print allfunds[label].name, ':', value
                allfunds[label].set_date(thisrow[0].strip(),value)


#print len(allfunds)
for k,v in allfunds.iteritems():
    v.history_to_arrays()
    v.describe()


plotshares(allfunds)
