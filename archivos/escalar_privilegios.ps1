if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Este script requiere privilegios de administrador para ejecutarse."
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

# Intentar escalar privilegios utilizando algunas técnicas comunes
$cred = Get-Credential
Invoke-Command -ScriptBlock { Get-ChildItem C:\ -Force } -Credential $cred

Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

Get-Content "C:\ruta\a\archivo_de_configuracion.txt" | Select-String -Pattern "password"

Invoke-WmiMethod -Class Win32_Printer -Name AddPrinterConnection -ArgumentList "\\127.0.0.1\fake_printer"
