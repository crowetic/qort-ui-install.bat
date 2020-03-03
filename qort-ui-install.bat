:: Download this and execute as admin



:: Install choco .exe and add choco to PATH
start /wait powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

sleep 10

start /wait powershell -NoProfile -ExecutionPolicy Bypass -Command  "choco feature enable -n allowGlobalConfirmation"



::install Nodejs
start /wait powershell -NoProfile -ExecutionPolicy Bypass -Command "choco install nodejs.install -fy"

::Install git 
start /wait powershell -NoProfile -ExecutionPolicy Bypass -Command "choco install git.install -fy"

::installYarn
start /wait powershell -NoProfile -ExecutionPolicy Bypass -Command "choco install yarn -fy" 

::git from repos after changing to script directory

cd /D %~dp0

::C:\> mkdir qortal-ui
::C:\> mkdir frag-default-plugins
::C:\> mkdir frag-core
::C:\> mkdir frag-qortal-crypto



git clone https://github.com/irontiga/qortal-ui 

git clone https://github.com/frag-crypto/frag-default-plugins 
git clone https://github.com/frag-crypto/frag-core 

git clone https://github.com/frag-crypto/frag-qortal-crypto 

::yarn install and link files 
cd /D %~dp0
cd frag-core
start /wait cmd.exe /c  "yarn install" 
start /wait cmd.exe /c  "yarn link"



cd /D %~dp0
cd frag-default-plugins
start /wait cmd.exe /c "yarn install" 
start /wait cmd.exe /c "yarn link"

cd /D %~dp0
cd frag-qortal-crypto
start /wait cmd.exe /c "yarn install" 
start /wait cmd.exe /c "yarn link"

cd /D %~dp0
cd qortal-ui
start /wait cmd.exe /c "yarn link @frag-crypto/frag-core" 
start /wait cmd.exe /c "yarn link @frag-crypto/frag-default-plugins"
start /wait cmd.exe /c "yarn link @frag-crypto/frag-qortal-crypto"


start /wait cmd.exe /c "yarn run build" 
sleep 10
start cmd.exe /k "yarn run server"
exit
