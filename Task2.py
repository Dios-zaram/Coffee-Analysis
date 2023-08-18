## Task 2
#1) Create a visualization that shows which is the most common type of coffee store. Use the visualization to:
#2) State which category of the variable place type the most observations
#3) Explain whether the observations are balanced across categories

#Answer

import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("coffee_csv.csv")
df=pd.DataFrame(df)
df['Place type'] = df['Place type'].astype(str)

# Step 2: Count occurrences of each category

category_counts = df['Place type'].value_counts()

# Step 3: Create a bar plot to visualize the frequency of each category

plt.figure(figsize=(8, 6))

bars = category_counts.plot(kind='bar', color='grey', edgecolor='black')

plt.xlabel('Place Type')

plt.ylabel('Frequency')

plt.title('Frequency of Each Place Type')

plt.xticks(rotation=45, ha='right')

plt.tight_layout()

plt.show()

# Step 4: Determine the category with the most observations

most_common_category = category_counts.idxmax()

# Step 5: Analyze whether the observations are balanced across categories

total_observations = len(df)

balance_ratio = category_counts / total_observations

print(f"Most common place type: {most_common_category}")

print(f"Balance ratio across categories:")

print(balance_ratio)
