'''
Sitong Ju
ITP 449 Homework 4
1/28/2019
sitongju@usc.edu
'''

import os
import pandas
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import numpy as np

from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()

# Read the file
os.chdir('/Users/TONG/Desktop/ITP 449/PythonProjects')
os.getcwd()
theFile = pandas.read_csv("avocado.csv", header = 0)

# Build the dataFrame
C = pandas.Index(["Date", "AveragePrice", "Total Volume","4046","4225","4770","total Bags","Small Bags","Large Bags","XLarge Bags","type","year","reagion"], name="columns")
df = pandas.DataFrame(data = theFile, columns = C)

# build a new column
# sort the dataframe group by date
# new AveragePrice
df["TotalPrice"] = df["AveragePrice"]* df["Total Volume"]
df1 = df.groupby(by = "Date").sum()
df1["NewAveragePrice"]=df1['TotalPrice']/df1['Total Volume']

# Plot the price of avocados over time
df1["NewAveragePrice"].plot()
plt.title('The Price of Avocados Over Time')
plt.show()

# Plot the total volume of avocados sold along with the price over time
fig, fg1 = plt.subplots()
fg1.plot(df1["NewAveragePrice"],color = "b")
fg1.set_ylabel("Price", color="b")

fg2 = fg1.twinx()
fg2.plot(df1["Total Volume"],color = "r")
fg2.set_ylabel("Total Volume", color="r")
plt.title("Total Volume of Avocados Sold Along with the Price over Time")
plt.show(block = True)

# perform smoothing on both plots
plt.plot(df1["NewAveragePrice"].rolling(12).mean(), color="b")
plt.title('The Price of Avocados Over Time(Smoothing)')
plt.show(block = True)

fig, ax1 = plt.subplots()
ax1.plot(df1["NewAveragePrice"].rolling(12).mean(), color="b")
ax1.set_ylabel("Price", color="b")

ax2 = ax1.twinx()
ax2.plot(df1["Total Volume"].rolling(12).mean(),color = "r")
ax2.set_ylabel("Total Volume",color="r")
plt.title("Total Volume of Avocados Sold Along with the Price over Time(Smoothing)")
plt.show(block = True)

# What are the overall trends in price over the entire range of time (2015-2018)?
# answer: according to the graphs, the price goes up and down during these years. Generally the price gradually goes up.

# What are the overall trends in total volume over the entire range of time (2015-2018)?
# answer: according to the graphs, the total volume goes up and down seaonally during these years, but generally is going up.

# What are the yearly trends in price?
# answer: the price is generally low in 2015 and 2016. The price reaches a peak in 2017, and then goes down in 2018
df2 = df.groupby(by="year").sum()
df2["NewAveragePrice"] = df2["TotalPrice"]/df2["Total Volume"]
df2["NewAveragePrice"].plot()
plt.title("Price by Year")
plt.show(block = True)

# What are the yearly trends in total volume?
# answer: from 2015 to 2017, the volume keep increasing in a small rate. The volume drops dramatically from 2017 to 2018.
df2["Total Volume"].plot()
plt.title("Total Volume by year")
plt.show(block = True)

# What is the relationship between price and total volume?
# answer: we can see from the graph that price and total vlume are negatively correlated
x = df1["NewAveragePrice"]
y = df1["Total Volume"]
model = LinearRegression(fit_intercept = True)
X = x[:,np.newaxis]
model.fit(X,y)
xfit = np.linspace(0.5,2,num = 2000)
Xfit = xfit[:,np.newaxis]
yfit = model.predict(Xfit)

plt.scatter(df1["NewAveragePrice"],df1["Total Volume"])
plt.plot(xfit,yfit)
plt.title("Price and Total Volume")
plt.xlabel("Price")
plt.ylabel("Volume")

plt.show(block = True)
















