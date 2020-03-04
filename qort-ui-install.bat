:: Download this and execute as admin


:: Install choco .exe and add choco to PATH
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
start /wait powershell -NoProfile -ExecutionPolicy Bypass -Command  "sleep 5"
@powershell sleep 2


@powershell -NoProfile -ExecutionPolicy Bypass -Command  "choco feature enable -n allowGlobalConfirmation"
sleep 2
echo -e "FINISHING CHOCO INSTALL AND SETUP. tHEN INSTALLING DEPENDENCIES."
Sleep 2

:::: Dev tools

@powershell -NoProfile -ExecutionPolicy Bypass -Command "choco install git -fy"
sleep 10
@powershell -NoProfile -ExecutionPolicy Bypass -Command "choco install nodejs.install -fy
sleep 15
@powershell -NoProfile -ExecutionPolicy Bypass -Command "choco install yarn -fy"


::git from repos after changing to script directory

cd /D %~dp0


start /wait cmd.exe /c "git clone https://github.com/irontiga/qortal-ui" 

start /wait cmd.exe /c "git clone https://github.com/frag-crypto/frag-default-plugins" 

start /wait cmd.exe /c "git clone https://github.com/frag-crypto/frag-core" 

start /wait cmd.exe /c "git clone https://github.com/frag-crypto/frag-qortal-crypto" 

::yarn install and link files 
cd /D %~dp0
cd frag-core
::start /wait cmd.exe /c  "yarn install" 
::start /wait cmd.exe /c  "yarn link"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn install"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link"

cd /D %~dp0
cd frag-default-plugins
::start /wait cmd.exe /c "yarn install" 
::start /wait cmd.exe /c "yarn link"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn install"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link"
cd /D %~dp0
cd frag-qortal-crypto
::start /wait cmd.exe /c "yarn install" 
::start /wait cmd.exe /c "yarn link"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn install"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link"
cd /D %~dp0
cd qortal-ui
::start /wait cmd.exe /c "yarn link @frag-crypto/frag-core" 
::start /wait cmd.exe /c "yarn link @frag-crypto/frag-default-plugins"
::start /wait cmd.exe /c "yarn link @frag-crypto/frag-qortal-crypto"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link @frag-crypto/frag-core"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link @frag-crypto/frag-default-plugins"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link @frag-crypto/frag-qortal-crypto"
::start /wait cmd.exe /c "yarn run build" 
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn run build"
sleep 10
start cmd.exe /k "yarn run server"
exit

