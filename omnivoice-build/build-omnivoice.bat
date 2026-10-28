@echo off
chcp 65001 >nul
rem Bangun omnivoice-tts.exe di PC sendiri. Butuh: Git, CMake, Visual Studio Build Tools (beban kerja "Desktop development with C++").
rem Pakai argumen "vulkan" untuk GPU AMD/Intel (butuh Vulkan SDK): build-omnivoice.bat vulkan
cd /d "%~dp0"
where git >nul 2>nul || (echo Git belum terpasang: https://git-scm.com & pause & exit /b 1)
where cmake >nul 2>nul || (echo CMake belum terpasang: https://cmake.org/download & pause & exit /b 1)
set "VC=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
if not exist "%VC%" set "VC=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
if not exist "%VC%" (echo Visual Studio Build Tools 2022 ^(C++^) belum terpasang. & pause & exit /b 1)
call "%VC%"
set FLAGS=
if /i "%1"=="vulkan" set FLAGS=-DGGML_VULKAN=ON
if not exist src\CMakeLists.txt git clone --recurse-submodules https://github.com/ServeurpersoCom/omnivoice.cpp.git src || goto :err
cd src
git checkout 886fc079838ca7400cb2b42b36e2a65aa1daabe8 || goto :err
git submodule update --init --recursive || goto :err
cmake -B build %FLAGS% || goto :err
cmake --build build --config Release -j %NUMBER_OF_PROCESSORS% || goto :err
set OUTDIR=
for /r build %%f in (omnivoice-tts.exe) do if exist "%%f" set "OUTDIR=%%~dpf"
if "%OUTDIR%"=="" (echo omnivoice-tts.exe tidak ditemukan setelah build. & goto :err)
if not exist "..\..\bin" mkdir "..\..\bin"
copy /y "%OUTDIR%omnivoice-tts.exe" "..\..\bin\" >nul
copy /y "%OUTDIR%*.dll" "..\..\bin\" >nul 2>nul
echo.
echo Selesai. Berkas ada di folder bin proyek ini.
pause & exit /b 0
:err
echo Terjadi kesalahan, lihat pesan di atas.
pause & exit /b 1
