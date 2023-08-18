## Task 4
# Describe the relationship between type of store and number of reviews. Your answer must include a visualization to demonstrate the relationship.

#Answer


import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv("coffee_csv.csv")
df=pd.DataFrame(df)

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

