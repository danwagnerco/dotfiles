# this combines all CSV files in a directory to master.csv
# and accounts for headers
awk 'FNR==1 && NR!=1{next;}{print}' *.csv > master.csv
