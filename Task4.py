## Task 4
# Describe the relationship between type of store and number of reviews. Your answer must include a visualization to demonstrate the relationship.

#Answer

## The scatter plot will allow you to demonstrate the relationship between the type of store and the number of reviews, providing insights into how the number of reviews varies across different types of stores.

import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv("coffee_csv.csv")
df=pd.DataFrame(df)
# Assuming df is your DataFrame containing the data
# If 'Reviews' is not already in numeric format, convert it to numeric

df['Reviews'] = pd.to_numeric(df['Reviews'], errors='coerce')

# Step 1: Create a scatter plot to visualize the relationship

plt.figure(figsize=(10, 6))

plt.scatter(df['place_type'], df['Reviews'], color='skyblue')

plt.xlabel('Place Type')

plt.ylabel('Number of Reviews')

plt.title('Relationship between Place Type and Number of Reviews')

plt.xticks(rotation=45, ha='right')

plt.tight_layout()

plt.show()

# Interpreting the Visualization:
# The scatter plot will display individual data points, where each point represents a place with its corresponding number of reviews.
# The x-axis represents the different types of stores (place_type), and the y-axis represents the number of reviews for each place.

# Based on the visualization:
# You can observe the distribution of reviews for each type of store.
# Look for patterns, trends, or any differences in the number of reviews among different types of stores.