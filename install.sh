#!/bin/bash

## den pfade setzen
var_scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
var_logfile="$var_scriptDir/motion-send.log"
var_metConf="$var_scriptDir/met.conf"

function func_loadMetConf () {
	source $var_metConf
}


function func_sendTestMessage () {
	curl -s -X POST \
		 -H 'Content-Type: application/json' \
		 -d '{"chat_id": '$var_chatID', "text": "test", "disable_notification": true}' \
		 https://api.telegram.org/bot$var_apiKey/sendMessage > /dev/null
}


function func_clearScreen () {
	func_writeLog "Bildschirm loeschen."
	clear
}


function func_writeLog () {
	printf '%s\n' "$1" | tee -a $var_logfile
}


function func_isVarEmpty () {
## erster parameter --> variable (z.B. $var_chatID)

	[ -z "$1" ]
}

function func_setVarByUserInput () {
## erster parameter --> name der variable (z.B. var_chatID)
## zweiter parameter --> variablenname

	printf -v $1 "$2"

}


function func_isArrayEmpty () {
	
	myArray=("$@")
	[ ${#myArray[@]} -eq 0 ]
}


function func_setConfVar () {
	while true
	do
		echo ""; read -p "$1" userinput
		if func_isVarEmpty $userinput
		then
			func_isVarEmpty $3 && echo "Fehler" || break
		else
			func_setVarByUserInput $2 $userinput
			break
		fi
	done
}

function func_setConfArray () {
	while true
	do
		echo ""; read -p "Gib deinen IP-Adresse ein (Aktuell: ${var_pingDeviceArray[*]}): " userinput
		if func_isVarEmpty $userinput
		then
			if func_isArrayEmpty "${var_pingDeviceArray[@]}" 
			then 
				echo "Fehler!"
			else 
				break
			fi
		else
			var_pingDeviceArray+=("$userinput")
			func_writeLog "IP-Adresse: <$userinput> "
		fi
	done
}



func_loadMetConf

func_clearScreen

func_writeLog ""
func_writeLog "################################################################################################"
func_writeLog "################################################################################################"
func_writeLog ""

## setze den apiKey
func_setConfVar "Gib deinen Api Key ein (Aktuell: $var_apiKey): " var_apiKey $var_apiKey
func_writeLog "apiKey: <$var_apiKey> "


## setze die chatId
func_setConfVar "Gib deine Chat_id ein (Aktuell: $var_chatID): " var_chatID $var_chatID
func_writeLog "chatId: <$var_chatID> "


## setze die IP-Adressen
func_setConfArray 
func_writeLog "IP-Adressen: <${var_pingDeviceArray[*]}>"

func_writeLog ""
func_writeLog "Sende Test-Nachricht"
func_sendTestMessage
func_writeLog "Test-Nachricht sollte angekommen sein"
func_writeLog ""


## sollen variablen in met.config gespeichert werden
var_defaultSave="y"
read -p "Sollen die Werte in die met.conf gespeichern werden? [Y/n]: " var_confSave
: ${var_confSave:=$var_defaultSave}

case $var_confSave in 
	[yY] | [yY][eE][sS] )
		func_writeLog "Beginne mit Speichern."
		sed -i "s/var_apiKey=.*$/var_apiKey='$var_apiKey'/" $var_metConf
		sed -i "s/var_chatID=.*$/var_chatID='$var_chatID'/" $var_metConf
		sed -i "s/var_pingDeviceArray=.*$/var_pingDeviceArray=(${var_pingDeviceArray[*]})/" $var_metConf
		func_writeLog "Speichern abgeschlossen."
		;;
	
	[nN] | [nN][oO] )
		func_writeLog "Daten werden nicht gespeichert."
		;;
	
	*)	func_writeLog "Ein falscher Wert wurde eingetragen. Die Installation wird abgebrochen."
		;;
esac


func_writeLog ""
func_writeLog "################################################################################################"
func_writeLog "################################################################################################"
func_writeLog ""

exit 0