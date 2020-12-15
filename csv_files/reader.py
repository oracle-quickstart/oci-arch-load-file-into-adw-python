import csv
import json
with open("file1.csv") as infile:
    reader = csv.reader(infile) 
    for row in reader:
        print("INFO - inserting:")
        print("INFO - " + json.dumps(row))
