# motioneye-telegram

### WORK IN PROGRESS! - Überprüfe jedes Skript bevor du es ausführst

Das Projekt basiert auf motioneye von [ccrisan - github](https://github.com/ccrisan/motioneye/wiki/Installation)
motioneye-telegram überprüft, ob sich bestimmte Geräte im WLAN befinden und sendet abhängig davon eine Nachricht an deinen Telegram-Bot, sofern sich etwas vor der Kamera bewegt.
	
### Bot-Erstellung	

##### Einen Telegram-Bot erstellen
*   suche @botfather bei Telegram und öffne den Chat
*   gib folgenden Befehl ein und lass dich vom @botfather durch die Erstellung begleiten
    ```sh
    /newbot
    ```
*   notiere dir deinen HTTP API KEY und bewahre ihn sicher auf

##### aktiviere die Privatsphäre 
*   Details zur Privatsphäreeinstellung kannst du unter folgendem [Link](https://core.telegram.org/bots#privacy-mode) nachsehen
*   verwende den folgenden Befehl in Telegram für die Privatsphäreeinstellungen 
    ```
    /setprivacy
    ```
##### weitere optionale Befehle in Telegram:
*   die Eingabe erfolgt bei Telegram
    ```
    /setdescription - ändert die bot-beschreibung
    /setabouttext - ändert die bot-about-beschreibung
    /setuserpic - ändert das profilfoto des bots
    ```
##### Bestimmung der Chat_id:
*   schreibe deinen eigenen bot bei Telegram an
*   ggf. musst die ihn auch mehrfach anschreiben (@<DEIN_BOT_USERNAME>)
*   öffne im Browser den folgenden Link mit deinem API KEY
    ```
    https://api.telegram.org/bot<HIER_API_TOKEN_KOMPLETT_EINFÜGEN>/getUpdates
    ```
*   Ausgabe im Browser:
    ```
    "message":{"message_id":1194,"from":{"id":<DEINE_CHAT-ID>,"is_bot":false,"first_name":"<DEIN_NAME>","username":"<DEIN_USERNAME>","language_code":"de"}
    ```
*   lies deine Chat-ID ab, notiere sie dir und bewahre sie sicher auf

### Installation von arping


*   Einige Geräte sind im Energiesparmodus nicht oder nur sehr schlecht ansprechbar, daher verwenden wir ARPING
*   führe den folgenden Befehl im Terminal deines RaspberryPi aus
    ```
    $ sudo apt install arping
    ```

### Installation von motioneye-telegram
*   wechsle in dein home-Verzeichnis auf dem RaspberryPi
*   lade dir die Dateien von Github herunter (manuell oder über git clone)
*   führe das Installations-Skript aus
    ```
    ./install.sh
    ```

### Herstellen der Verbindung mit motioneye

*   trage den Pfad zum Script in den Bereich "run an end command" unter "motion notification" in motioneye ein
    z.B. ```bash /home/pi/met/motion-send.sh %$ %t```
*   ```%$``` ist wichtig, weil es den Namen, der Kamera an das Skript übergibt
*   ```%t``` ist wichtig, weil es die Kamera-ID an das Skript übergibt
	
