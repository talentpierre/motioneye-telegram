![Header Image](http://drive.google.com/uc?export=view&id=1Hr81-eWulUwr-BDpl926xbuQ4hsHvjzm)

# motioneye-telegram

### WORK IN PROGRESS! - Check every script twice

The project is based on motioneye by [ccrisan - github](https://github.com/ccrisan/motioneye/wiki/Installation)
motioneye-telegram checks whether your device is available in your wifi or not and sends a message to your telegram-bot if motion was detected.

### Features
*   send latest snapshot and video via telegram
*   presence-check (you are not at home by pinging one or more eg. smartphones)
*   no port forwardings or open ports required (443 outbound must be possible)
*   no telegram-bot installation required

### Prerequisites

For these scripts to run, you have to ensure that your environment meets the follwing prerequisites:
*   Minimum, by motioneye supported, Raspberry Pi (SBC)
*   Raspberry Pi OS Version Buster (Debian 10)
*   latest [motioneye](https://github.com/ccrisan/motioneye/wiki/Installation) installed
*   tested with motion Version 4.2.2 and motionEye Version 0.42.1
*   somehow fixed IP Adress for your smartphone(s) or other devices

----------

### Bot-Creation

##### create a new telegram-bot
*   look for [@botfather](https://t.me/botfather) in telegram and open a chat
*	enter the following command and follow the wizard for creation
    ```
    /newbot
    ```
*   write down your HTTP API KEY 

##### privacy activation 
*   details can be found [here](https://core.telegram.org/bots#privacy-mode)
*   send the following command to @botfather to use some more privacy  
    ```
    /setprivacy
    ```

##### more telegram commands:
*   you can enter these into telegram if you want to
    ```
    /setdescription - changes the bot-description
	/setabouttext - changes the bot-about-description
	/setuserpic - changes the photo in your bot-profile
    ```

##### note your chat-id:
*   send some messages to your newly created bot (@<YOUR_BOT_USERNAME>)
*   open the link with your API KEY in it (without angle brackets)
    ```
    https://api.telegram.org/bot<ENTER_YOUR_COMPLETE_API_KEY>/getUpdates
    ```
*   browser output:
	```
	"message":{"message_id":1194,"from":{"id":<YOUR_CHAT_ID>,"is_bot":false,"first_name":"<YOUT_NAME>","username":"<YOUR_USER_NAME>","language_code":"de"}
	```
*   take note of your chat-id and save it alongside your http api key

----------

### installation of motioneye-telegram
*   go to your home directory on your raspberry pi
*   download all the files from github 
    ```sh
    git clone https://github.com/DaniW42/motioneye-telegram.git
    ```
*   start the installation script
    ```sh
    cd motioneye-telegram
    ./install-tg.sh
    ```

### using motioneye-telegram as motioneye notification 

*   look for your script path and enter it in motioneye ("run an end command" in "motion notification")
	e.g. ```/home/pi/motioneye-telegram/bin/motion-send.sh %$ %t```
*   ```%$``` important because it passes the camera name to the script
*   ```%t``` important because it passes the camera id to the script
