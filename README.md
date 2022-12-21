# DigiDucky
A Bash script that will convert a DuckyScript payload file into an arduino file, compile it and load it on a Digispark Attiny 85.

To do this, this program will download the three projects that will be necessary for its proper functioning
* [DuckToolkit](https://github.com/kevthehermit/DuckToolkit), which was used to convert the duckyscript file into a binary file.
* [duck2spark](https://github.com/0x48piraj/duck2spark/tree/py3-patch), which was used to convert the binary file into an Arduino file
* [arduino-cli](https://arduino.github.io/arduino-cli/0.29/), which was used to compile and upload the Arduino file to the DigiSpark.

## Requirements

### Hardware Requirements
* A Digispark Attiny 85
* A Duckyscript payload file 

### Software Requirements

Since the script will already install the different projects needed, you do not need to install the different projects yourself.

Otherwise, to upload programs on your digispark, you must install "libusb-dev".

On Ubuntu/Debian :
```
$ sudo apt-get install libusb-dev
```
### Hardware Requirements
* A Digispark Attiny 85
* A Duckyscript file 

## Different options of DigiDucky

This program has 4 options :
```
$ ./DigiDucky.sh --help
########  ####  ######   #### ########  ##     ##  ######  ##    ## ##    ## 
##     ##  ##  ##    ##   ##  ##     ## ##     ## ##    ## ##   ##   ##  ##  
##     ##  ##  ##         ##  ##     ## ##     ## ##       ##  ##     ####   
##     ##  ##  ##   ####  ##  ##     ## ##     ## ##       #####       ##    
##     ##  ##  ##    ##   ##  ##     ## ##     ## ##       ##  ##      ##    
##     ##  ##  ##    ##   ##  ##     ## ##     ## ##    ## ##   ##     ##    
########  ####  ######   #### ########   #######   ######  ##    ##    ##    

======================================================================
[*] A Bash script that will convert a DuckyScript file into an arduino file, compile it and load it on a Digispark Attiny 85.
Recommended use : ./Duckydigi -i 
        -h, --help          This will display this message
        -i, --interactive   The classic way to launch the script
        -u, --update        This will update the different project 
        -r, --remove        This will remove all projects that were necessary for the program to function properly
======================================================================
```
