# this combines all CSV files in a directory to master.csv
# and accounts for headers
# 
# the single quote version works on Unix-y systems, use double quotes for Windows via cmder!
awk 'FNR==1 && NR!=1{next;}{print}' *.csv > master.csv

# Windows variant (far more common all things considered) to prevent awk from repeatedly ingesting the same files
awk "FNR==1 && NR!=1{next;}{print}" *.csv > c:\data\some_other_director\master.csv
