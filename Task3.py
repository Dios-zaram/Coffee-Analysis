## Task 3
#Describe the distribution of all of the number of reviews. Your answer must include a visualization that shows the distribution.

#Answer

import pandas as pd

import matplotlib.pyplot as plt

df = pd.read_csv("coffee_csv.csv")
df=pd.DataFrame(df)

df['Reviews'] = df['Reviews'].astype(int)

# Step 1: Create a histogram to visualize the distribution of reviews

plt.figure(figsize=(8, 6))

plt.hist(df['Reviews'], bins=30, color='grey', edgecolor='black')

plt.xlabel('Number of Reviews')

plt.ylabel('Frequency')

plt.title('Distribution of Number of Reviews')

plt.grid(True)

plt.show()

# Step 2: Describe the distribution based on the histogram

max_reviews = df['Reviews'].max()

mean_reviews = df['Reviews'].mean()

median_reviews = df['Reviews'].median()

print(f"Maximum number of reviews: {max_reviews}")

print(f"Mean number of reviews: {mean_reviews:.2f}")

print(f"Median number of reviews: {median_reviews:.2f}")

# In this code, I first ensure that the "Reviews" column have the right data type,in other to plot the histogram correctly. Then I created a histogram with 30 bins to visualize the distribution of the number of reviews. The histogram shows me the frequency of reviews for different ranges of values.

# After plotting the histogram, I described the distribution based on the visualization: The histogram shows the frequency of places based on the number of reviews they have received. Most places will likely have fewer reviews, as indicated by the peak of the histogram on the left side. The distribution is right-skewed, meaning there are a few places with a significantly higher number of reviews, leading to the long tail on the right side. Outliers with very high numbers of reviews are uncommon, as mentioned in the example solution.

