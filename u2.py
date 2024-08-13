def filter_lines(input_file, substrings_file, output_file):
    with open(substrings_file, 'r') as substr_file:
        substrings = {line.strip() for line in substr_file if line.strip()}

    with open(output_file, 'w') as out_file:
        with open(input_file, 'r') as in_file:
            for line in in_file:
                if not any(substring in line for substring in substrings):
                    out_file.write(line)

# Example usage
filter_lines('l3.txt', 'substrings.txt', 'filtered_output.txt')
