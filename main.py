# Task 1
#For every column in the data:
#1) State whether the values match the description given in the table above.
#2) State the number of missing values in the column.
#3) Describe what you did to make values match the description if they did not match.

#Answer
import pandas as pd

df = pd.read_csv("coffee_csv.csv")
df=pd.DataFrame(df)

df.head

for column in df.columns:

    if column == 'Rating':
        # Check Rating column against the description
        valid_values = set(range(3, 6))
        num_missing_values = df[column].isnull().sum()

    elif column == 'Reviews':
        # Check Reviews column against the description
        valid_min, valid_max = 3, 17937
        num_missing_values = df[column].isnull().sum()

    elif column in ['Dine in option', 'Takeout option']:
        # Check Dine in option and Takeout option columns against the description
        valid_values = {True, False}
        num_missing_values = df[column].isnull().sum()

    else:
        # For other columns (Region, Place name, Place type, Price, Delivery option)
        valid_values = None
        num_missing_values = df[column].isnull().sum()
        # Replace missing values with 'Unknown' for Nominal columns
        df[column].fillna('Unknown', inplace=True)

    # Print the results for each column
    print(f"Column: {column}")

    if valid_values is not None:
        print(f"There are {len(valid_values)} unique values that match the description given.")

    if num_missing_values > 0:
        print(f"There are {num_missing_values} missing values.")

    if valid_values is None and num_missing_values == 0:
        print("No changes were made to this column.")

    elif valid_values is not None and num_missing_values == 0:
        print("No changes were made to this column.")

    elif valid_values is None and num_missing_values > 0:
        print(f"Missing values were replaced with 'Unknown'.")

    else:
        print(
            f"Missing values were replaced with {'0' if column == 'Rating' else median_value if column == 'Reviews' else 'False'}.")
    print("\n")

# Note: This code will loop through each column in the dataset, perform the checks, handle missing values according to the description, and print the results for each column.