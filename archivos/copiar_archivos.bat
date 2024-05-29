@echo off
set "source_folder=C:\ruta\a\tus\archivos\a\copiar"
set "destination_folder=E:\ruta\a\la\unidad\usb"

xcopy "%source_folder%\*" "%destination_folder%\" /E /C /I /H /Y
