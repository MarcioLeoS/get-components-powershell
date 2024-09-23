# Script para obtener información del sistema y guardarla en un archivo
$info = Get-ComputerInfo | Select-Object CsName, WindowsVersion, CsModel, CsProcessors, CsTotalPhysicalMemory
$cpu = Get-WmiObject Win32_Processor | Select-Object Name, NumberOfCores, MaxClockSpeed
$ram = Get-WmiObject Win32_PhysicalMemory | Measure-Object Capacity -Sum
$hdd = Get-WmiObject Win32_DiskDrive | Select-Object Model, Size
$gpu = Get-WmiObject Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion

# Crear un reporte
$reporte = "Reporte de Sistema:`n"
$reporte += "`nInformación Básica:`n" + ($info | Out-String)
$reporte += "`nCPU:`n" + ($cpu | Out-String)
$reporte += "`nRAM Total (GB):`n" + [math]::round($ram.Sum / 1GB, 2)
$reporte += "`nDiscos:`n" + ($hdd | Out-String)
$reporte += "`nGPU:`n" + ($gpu | Out-String)

# Guardar en el archivo
$reporte | Out-File "$env:USERPROFILE\Documents\reporte_pc_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
