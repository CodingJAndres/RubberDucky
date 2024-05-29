# Parámetros
$nombreTarea = "CopiarArchivosUSB"
$rutaScript = "E:\copiar_archivos.bat"  # Ruta completa al archivo de script
$unidadUSB = "E"  # Letra de unidad de la unidad USB

# Crear acción para ejecutar el script
$accion = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c `"$rutaScript`""

# Crear desencadenador para activar la tarea al conectar la unidad USB
$desencadenador = New-ScheduledTaskTrigger -AtStartup
$desencadenador.Subscription = "<QueryList><Query><Select Path='Win32_Volume'>*[DriveLetter='$unidadUSB']</Select></Query></QueryList>"

# Crear tarea programada
$tarea = New-ScheduledTask -Action $accion -Trigger $desencadenador -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries)

# Registrar la tarea en el Programador de tareas
Register-ScheduledTask -TaskName $nombreTarea -InputObject $tarea -Force

Write-Host "Tarea programada creada exitosamente para ejecutar $rutaScript al conectar la unidad USB $unidadUSB."
