#!/bin/bash

echo -E "
########  ####  ######   #### ########  ##     ##  ######  ##    ## ##    ## 
##     ##  ##  ##    ##   ##  ##     ## ##     ## ##    ## ##   ##   ##  ##  
##     ##  ##  ##         ##  ##     ## ##     ## ##       ##  ##     ####   
##     ##  ##  ##   ####  ##  ##     ## ##     ## ##       #####       ##    
##     ##  ##  ##    ##   ##  ##     ## ##     ## ##       ##  ##      ##    
##     ##  ##  ##    ##   ##  ##     ## ##     ## ##    ## ##   ##     ##    
########  ####  ######   #### ########   #######   ######  ##    ##    ##    
"

Tool1=`find / -type d -name 'duck2spark-py3-patch' 2>/dev/null`
Tool2=`find / -type d -name 'DuckToolkit-master' 2>/dev/null`
Tool3=`find / -type f -name 'arduino-cli' 2>/dev/null`

if [ "$1" = "--help" -o "$1" = "-h" ]; then
    echo "======================================================================"
    echo "[*] A Bash script that will convert a DuckyScript file into an arduino file, compile it and load it on a Digispark Attiny 85."
    echo "Recommended use : ./Duckydigi -i "
    echo -e "\t-h, --help          This will display this message"
    echo -e "\t-i, --interactive   The classic way to launch the script"
    echo -e "\t-u, --update       This will update the different project "
    echo -e "\t-r, --remove        This will remove all projects that were necessary for the program to function properly"
    echo "======================================================================"

elif  [ "$1" = "--update" -o "$1" = "-u" ]; then

    echo "======================================================================"
    echo "[*] Now we will update all the different projects :" 
    rm -rf $Tool1
    rm -rf $Tool2
    rm -rf /home/${USER}/.arduino15
    rm -rf ${Tool3%/*}
    echo "[!] Updating of the duck2spark project"
    wget -q https://github.com/0x48piraj/duck2spark/archive/refs/heads/py3-patch.zip 
    unzip py3-patch.zip >/dev/null
    rm py3-patch.zip
    Tool1=`find / -type d -name 'duck2spark-py3-patch' 2>/dev/null`
    echo "[!] Updating of the DuckToolkit project"
    wget -q https://github.com/kevthehermit/DuckToolkit/archive/refs/heads/master.zip 
    unzip master.zip >/dev/null
    rm master.zip
    echo "[!] Updating of the arduino-cli project"
    wget -qO - https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh > /dev/null
    Tool3=`find / -type f -name 'arduino-cli' 2>/dev/null`
    $Tool3 config init > /dev/null
    $Tool3 core update-index > /dev/null
    $Tool3 core update-index --additional-urls http://digistump.com/package_digistump_index.json > /dev/null
    $Tool3 core install digistump:avr  --additional-urls http://digistump.com/package_digistump_index.json > /dev/null
    echo "[+] All the project are updated"
    echo "======================================================================"

elif  [ "$1" = "--remove" -o "$1" = "-r" ]; then

    echo "======================================================================"
    echo "[*] Now we will remove all the different projects :" 
    rm -rf $Tool1
    echo "[!] The duck2spark project is removed :" 
    rm -rf $Tool2
    echo "[!] The DuckToolkit project is removed :" 
    rm -rf /home/${USER}/.arduino15
    rm -rf ${Tool3%/*}
    echo "[!] All the arduino components are removed:" 
    echo "[+] All the components are removed :" 
    echo "======================================================================"


elif  [ "$1" = "--interactive" -o "$1" = "-i" ]; then

    echo "======================================================================"
    echo "[*] Now we verify if you have the necessary tools :" 
    if [ -z "$Tool1" ]; then
        echo "[!] You don't have the duck2spark project"
        echo
        wget -q https://github.com/0x48piraj/duck2spark/archive/refs/heads/py3-patch.zip --show-progress
        unzip py3-patch.zip >/dev/null
        rm py3-patch.zip
        Tool1=`find / -type d -name 'duck2spark-py3-patch' 2>/dev/null`
        echo "======================================================================"
    fi
        
    if [ -z "$Tool2" ]; then
        echo "[!] You don't have the DuckToolkit project"
        echo
        wget -q https://github.com/kevthehermit/DuckToolkit/archive/refs/heads/master.zip --show-progress
        unzip master.zip >/dev/null
        rm master.zip
        Tool2=`find / -type d -name 'DuckToolkit-master' 2>/dev/null`
        echo "======================================================================"
    fi

    if [ -z "$Tool3" ]; then
        echo "[!] You don't have arduino-cli"
        echo
        wget -qO - https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
        Tool3=`find / -type f -name 'arduino-cli' 2>/dev/null`
        $Tool3 config init > /dev/null
        $Tool3 core update-index > /dev/null
        $Tool3 core update-index --additional-urls http://digistump.com/package_digistump_index.json > /dev/null
        $Tool3 core install digistump:avr  --additional-urls http://digistump.com/package_digistump_index.json > /dev/null
        echo
    fi   
    echo "[+] Nice ! You have the tools, we can now go to the next part"
    echo "======================================================================"
    read -p "The path for your DuckyScript file:  " Duckyscript_txt_path
    while [ ! -f $Duckyscript_txt_path ] || [ -z $Duckyscript_txt_path ]; do 
        read -p "Give an existing file:  " Duckyscript_txt_path
    done
    read -p "The path for your Encoded DuckyScript Binary (By default ${Duckyscript_txt_path%%.*}.bin) :  " Duckyscript_binary_path
    Duckyscript_binary_path=${Duckyscript_binary_path:-${Duckyscript_txt_path%%.*}.bin}
    read -p "The path for your DuckyScript Arduino File (By default ${Duckyscript_txt_path%%.*}/$(echo ${Duckyscript_txt_path%%.*}| rev | cut -d '/' -f 1 | rev).ino):  " Duckyscript_arduino_path
    Duckyscript_arduino_path=${Duckyscript_arduino_path:-${Duckyscript_txt_path%%.*}/$(echo ${Duckyscript_txt_path%%.*}| rev | cut -d '/' -f 1 | rev).ino}
    read -p "The keyboard layout :  " Duckyscript_keyboard_Layout
    read -p "The delay in milliseconds that will be implemented before the code is launched (By default 1000 Milliseconds) : " Duckyscript_delay
    Duckyscript_delay=${Duckyscript_delay:-1000}
    read -p "The number of times the program will be run (By default 1 Time) :  " Duckyscript_loop
    Duckyscript_loop=${Duckyscript_loop:-1}
    echo "======================================================================"
    echo "[*] Now we will create the following commands :" 
    echo "python3 $Tool2/ducktools.py -e -l $Duckyscript_keyboard_Layout $Duckyscript_txt_path $Duckyscript_binary_path"
    echo "python3  $Tool1/duck2spark.py -i $Duckyscript_binary_path -l $Duckyscript_loop -f $Duckyscript_delay -o $Duckyscript_arduino_path"
    echo "$Tool3 compile -b digistump:avr:digispark-tiny $Duckyscript_arduino_path"
    echo "$Tool3 upload -b digistump:avr:digispark-tiny $Duckyscript_arduino_path"
    rm -rf ${Duckyscript_txt_path%%.*}
    mkdir  ${Duckyscript_txt_path%%.*}
    VarDuckyBinary=`python3 $Tool2/ducktools.py -e -l $Duckyscript_keyboard_Layout $Duckyscript_txt_path $Duckyscript_binary_path`
    VarDuckyArduino=`python3  $Tool1/duck2spark.py -i $Duckyscript_binary_path -l $Duckyscript_loop -f $Duckyscript_delay -o  $Duckyscript_arduino_path`
    echo
    echo
    $Tool3 compile -b digistump:avr:digispark-tiny $Duckyscript_arduino_path
    $Tool3 upload -b digistump:avr:digispark-tiny $Duckyscript_arduino_path
else
    echo "======================================================================"
    echo "[!] There is a problem with your syntax"
    echo "[!] If you need help type 'script.sh -h' or 'script.sh --help' "
    echo "======================================================================"
    
fi
