#!/bin/bash


var_cameraName=$1
var_cameraId=$2

## pfade setzen
var_scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
var_mediaDir="$(dirname $(grep target_dir /etc/motioneye/camera-$var_cameraId.conf | cut -d ' ' -f 2))"
var_mediaCameraDir="$var_mediaDir/$var_cameraName"
var_metConf="$var_scriptDir/met.conf"


echo $var_mediaDir
echo $var_mediaCameraDir



func_loadMetConf () {
	source $var_metConf
}


func_deviceAvailable () {
	var_TEMPdeviceFound=false
	for pingDevice in "${var_pingDeviceArray[@]}"
		do
			if func_arpingDeviceSuccessful $pingDevice
			then
				var_TEMPdeviceFound=true
				return 0
			fi
	done
	
	return 1
	
}


func_arpingDeviceSuccessful () {
	arping -c 6 $1 >> $var_logfile #/dev/null 
}


func_writeLog () {
	printf '%s\n' "$1" >> $var_logfile
}


func_loadMetConf

func_writeLog "=========================================================" 
func_writeLog "$(date) - Bewegung erkannt."
func_writeLog ""

if func_deviceAvailable 
then
	func_writeLog "$(date) - SMARTPHONE verfuegbar, skript beenden."
	func_writeLog "========================================================="
	func_writeLog ""

else
	func_writeLog "$(date) - SMARTPHONE NICHT verfuegbar, skript starten." 
	func_writeLog ""

	var_lastsnap=$(tree -ftri $var_mediaCameraDir | grep .jpg | head -n1)
	var_lastvideo=$(tree -ftri $var_mediaCameraDir | grep -v thumb | grep .mp4 | head -n1)

	func_writeLog "$(date) - \$var_lastsnap is $var_lastsnap"
	func_writeLog "$(date) - \$var_lastvideo is $var_lastvideo"
	func_writeLog""
	
	func_writeLog "$(date) - BEGINNE tg-sendphoto.py:"
	$var_scriptDir/tg-sendPhoto.py $var_apiKey $var_chatID $var_lastsnap "$var_cameraName - ${var_lastsnap: -23:19}" >> $var_logfile
	func_writeLog "$(date) - BEENDE tg-sendphoto.py."
	func_writeLog ""
	
	func_writeLog "$(date) - BEGINNE tg-sendvideo.py:"
	$var_scriptDir/tg-sendVideo.py $var_apiKey $var_chatID $var_lastvideo "$var_cameraName - ${var_lastvideo: -23:19}" >> $var_logfile
	func_writeLog "$(date) - BEENDE tg-sendvideo.py."
	func_writeLog "========================================================="
	func_writeLog ""
	
fi

echo Ende
