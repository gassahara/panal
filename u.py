import re
 
with open('./list', 'r') as file:
    content = file.readlines()

substrings = set()  # Use a set to store unique elements

# Define the separators you want to split by (including newlines)
separators = r'[ ,|\n]+'  # This will split by spaces, commas, pipes, or newlines

# Define the array of characters to avoid at the end of strings
exclude_endings = ['.tmp', '.bak', '/']  # Add any unwanted endings here

for line in content:
    parts = re.split(separators, line)  # Split each line using the defined separators
    for part in parts:
        if part and part.startswith('$PrPWD'):  # Avoid empty strings
            # Add ".c" if the part does not contain a period
            if '.' not in part:
                part += '.c'
            # Check if the part ends with any of the unwanted endings
            if not any(part.endswith(ending) for ending in exclude_endings):
                substrings.add(part)  # Add the part to the set after all checks

# Remove strings containing more than one '$'
filtered_substrings = {s for s in substrings if s.count('$') <= 1}

# Print each element of filtered_substrings on a new line
for substring in filtered_substrings:
    print(substring)
