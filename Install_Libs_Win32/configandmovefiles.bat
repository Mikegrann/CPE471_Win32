@echo off
echo "Installing GL"

if "%VS110COMNTOOLS%" NEQ "" (
   echo "Visual Studio 2012 Found - Configuring"
   CALL "%VS110COMNTOOLS%VsDevCmd.bat" 
   if %ERRORLEVEL% GEQ 1 GOTO error_failure
) else ( 
   echo "Visual Studio 2013 Found - Configuring"
   if "%VS120COMNTOOLS%" NEQ "" ( 
      CALL "%VS120COMNTOOLS%VsDevCmd.bat" 
      if %ERRORLEVEL% GEQ 1 GOTO error_failure
   ) 
   else (
      echo "Visual Studio installation not found"
      if %ERRORLEVEL% GEQ 1 GOTO error_failure
   )
)

PUSHD %~dp0

echo "Copying include files"
XCOPY "include\*" "%VSINSTALLDIR%VC\include" /S /I
if %ERRORLEVEL% GEQ 1 GOTO error_failure
echo "Copying GLAD lib files"
XCOPY "glad\lib\*" "%VSINSTALLDIR%VC\lib" /S /I
if %ERRORLEVEL% GEQ 1 GOTO error_failure
echo "Copying GLEW lib files"
XCOPY "glew\lib\*" "%VSINSTALLDIR%VC\lib" /S /I
if %ERRORLEVEL% GEQ 1 GOTO error_failure
echo "Copying GLEW dll files to System32"
XCOPY "glew\bin\*" "%SystemRoot%\System32" /S /I
if %ERRORLEVEL% GEQ 1 GOTO error_failure

if exist "%SystemRoot%\SYSWOW64" (
   echo "Copying GLEW dll files to SYSWOW64"
   XCOPY "glew\bin\*" "%SystemRoot%\SYSWOW64" /S /I
   if %ERRORLEVEL% GEQ 1 GOTO error_failure
)

if "%VS110COMNTOOLS%" NEQ "" (
   echo "Copying GLFW lib files"
   XCOPY "glfw\vc2012\lib\*" "%VSINSTALLDIR%VC\lib" /S /I 
   if %ERRORLEVEL% GEQ 1 GOTO error_failure   
   echo "Copying GLFW dll files to System32"
   XCOPY "glfw\vc2012\bin\*" "%SystemRoot%\System32" /S /I
   if %ERRORLEVEL% GEQ 1 GOTO error_failure
   
   if exist "%SystemRoot%\SYSWOW64" (
      echo "Copying GLFW dll files to SYSWOW64"
      XCOPY "glfw\vc2012\bin\*" "%SystemRoot%\SYSWOW64" /S /I
      if %ERRORLEVEL% GEQ 1 GOTO error_failure
   )
) else ( 
   if "%VS120COMNTOOLS%" NEQ "" ( 
      echo "Copying GLFW lib files"
      XCOPY "glfw\vc2013\lib\*" "%VSINSTALLDIR%VC\lib" /S /I  
      if %ERRORLEVEL% GEQ 1 GOTO error_failure
      echo "Copying GLFW dll files to System32"
      XCOPY "glfw\vc2013\bin\*" "%SystemRoot%\System32" /S /I
      if %ERRORLEVEL% GEQ 1 GOTO error_failure
	  
      if exist "%SystemRoot%\SYSWOW64" (
         echo "Copying GLFW dll files to SYSWOW64"
         XCOPY "glfw\vc2013\bin\*" "%SystemRoot%\SYSWOW64" /S /I
         if %ERRORLEVEL% GEQ 1 GOTO error_failure
      )
   ) 
)

echo "Installing RPavlik Module"
cmake -P installmodules.cmake
if %ERRORLEVEL% GEQ 1 GOTO error_failure

echo "Files copied successfully"
goto end

:error_failure
echo "ERROR DETECTED: ABORTING"
goto end

:end
PAUSE