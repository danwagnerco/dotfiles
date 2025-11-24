# PowerShell

### Unzip all zip files in a directory

```powershell
# One-liner
Get-ChildItem -Filter *.zip | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath . -Force }
```

### Unzip all zip files in a directory (with progress indicator)

```powershell
# Multi-line paste, possibly run as a script like unzip_all.ps1
$zips = Get-ChildItem -Filter *.zip
$total = $zips.Count
$current = 0

foreach ($zip in $zips) {
    $current++
    Write-Host "[$current/$total] Extracting: $($zip.Name)"
    Expand-Archive -Path $zip.FullName -DestinationPath . -Force
}
```

### Combine all CSV files in a directory and account for headers with progress indication

Make sure to edit the `$outputFile` to match what you want the combined output file to be since it will get ignored by the combination logic, otherwise you are going to recursive CSV combination hell:

```powershell
# Multi-line paste, possibly run as a script like combine_all_csvs.ps1
$outputFile = "combined-hot-chains-2024.csv"
$csvFiles = Get-ChildItem -Filter *.csv | Where-Object { $_.Name -ne $outputFile } | Sort-Object Name
$total = $csvFiles.Count

Write-Host "Combining $total CSV files..."

# Write header from first file
Get-Content $csvFiles[0].FullName -First 1 | Set-Content $outputFile
Write-Host "[1/$total] Header written from: $($csvFiles[0].Name)"

# Append all files, skipping their headers
$current = 1
foreach ($file in $csvFiles) {
    $current++
    Write-Host "[$current/$total] Appending: $($file.Name)"
    Get-Content $file.FullName | Select-Object -Skip 1 | Add-Content $outputFile
}

Write-Host "`nComplete! Combined file: $outputFile"
```

### Get the last 20000 rows from a CSV but also keep the headers

```powershell
# Run like a script for example get_last_20K_rows_from_csv.ps1

# Get the header (first line only)
$header = Get-Content .\2025-07-08-option_trades.csv -First 1 -Encoding UTF8

# Get the last 20000 lines
$lastLines = Get-Content .\2025-07-08-option_trades.csv -Tail 20000 -Encoding UTF8

# Combine header and last lines, write to output file
@($header) + $lastLines | Set-Content .\2025-07-08-option_trades_FIRST_20K_transactions.csv -Encoding UTF8
```
