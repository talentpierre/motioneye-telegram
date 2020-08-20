# motioneye-telegram - WORK IN PROGRESS! Überprüfe jedes Skript bevor du es ausführst

	das projekt basiert auf motioneye - https://github.com/ccrisan/motioneye/wiki/Installation
	es überprüft, ob sich bestimmte ip adressen im wlan befinden
	abhängig davon, sendet es eine benachrichtigung an deinen telegram bot, wenn sich etwas vor der kamera bewegt

### Neuen Bot erstellen

	suche @botfather bei telegram und öffne den chat
	der botfather führt dich durch die erstellung eines neuen bots
	
	/newbot

	notiere dir deinen http api key

#### Privacy aktivieren (https://core.telegram.org/bots#privacy-mode)
    
	/setprivacy

### Optionale Befehle:
    
	/setdescription - ändert die bot-beschreibung
	/setabouttext - ändert die bot-about-beschreibung
	/setuserpic - ändert das profilfoto des bots

### Chat_id herausfinden:
	
	schreibe deinen eigenen bot in telegram an(@username) ggf. auch zweimal
	öffne im browser den folgenden link mit deinem api key

	[https://api.telegram.org/bot<hier api token komplett einfügen>/getUpdates](https://api.telegram.org/bot%3Chier%20api%20token%20komplett%20einf%C3%BCgen%3E/getUpdates) aufrufen

#### Ausgabe im Browser:
	
	"message":{"message_id":1194,"from":{"id":## HIER STEHT DIE CHAT_ID ##,"is_bot":false,"first_name":"## hier steht der name ##","username":"## hier steht der username ##","language_code":"de"}
	lies deine chat-id ab und notiere sie dir
	
### Installation von arping

	notwendig, um die anwesenheit von geräten, die sich im energiesparmodus befinden, sicherzustellen
	
	$ sudo apt install arping


### Jetzt auf dem pi install-tg.sh ausführen

### Verknüpfung mit motioneye

	trage den pfad zum script in den bereich "run an end command" unter "motion notification" ein
	z.b. <bash /home/pi/met/motion-send.sh %$ %t>
	das "%$" ist wichtig, weil es den namen, der kamera an das skript übergibt
	das "%t" ist wichtig, weil es die kamera-id an das skript übergibt
	
