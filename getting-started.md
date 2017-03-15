**IMPORTANT**
Before you run first time the SyncServer you have to execute "psshutdown.exe" and agree with the license. It's located in "SyncServer/PsTools/psshutdown.exe"

In order to get a positive result you should before grabbing informations with Syncserver, put in each movie-folder following informations cover, backdrop & nfo. Please consider that the filename-pattern has to be entered in movingpictures settings!

# Configuration window

### Settings tab

http://img339.imageshack.us/img339/2960/settingsoverlay.jpg

The settings tab gives you options to customize your SyncServer.

### The clients section

As first you have to enter your clients one by one. For this you have to put the computername of the client into the "PC-Name" field. By clicking the "Get IP/MAC" button SyncServer gets automatically the additional informations for you. For remote shutdown of the Client you will have to enter the network password and username. Now you can press the "ADD" button.

You will get an overview of the entered clients in the list under the "ADD" button. The red/green Sign flag on the left side shows if the Client is off-/Online. If the client is checked, it will get synchronized. With the "Rescan Now" Button you force a rescan of the clients to check if they are on-/offline, otherwise it gets refreshed automatically. With the button "Shutdown/Wakeup selected" you can test the remote wakeup and shutdown function. The "auto refresh IP's" checkbox is needed, if you run a DHCP server in your network, and the IPs of the clients change by time. If you check the "auto refresh IP's" box, SyncServer searchs automatically for new IPs by computername of the various clients If the IP of one client has changed, it should automatically get changed in list, too.

### The network adapters section

Here you should get listed all the network devices of your computer. With the checkbox you have the choice to choose the right adapter that is connected to your home network.

### The section for standby options

There is also the possibility to let SyncServer control the sleepevents of your Server. If you check the box under StandBy options, SyncServer will keep your Server online, till the last client went offline. If the box is unchecked, the server will use the power settings of windows.

### Update/Sync database section

At Last you have to check which plugin databases should be updated automatically. For the music database you can also change the interval for updates to a specific value in days.

Available grabbing operations on update process are:

* Grabbing infos of new movies (using MovingPictures)
* Grabbing infos of new Tv-Series (using TV-Series)
* Make a update of the Music-Database (using Musicdatabase Update of Mediaportal)
* Grabbing Web-EPG (using XML-TV of TV-Server)
* After finishing it will wake up the different checked clients in the List on top by using a Wake on LAN "Magic Packet" (you have to enable this in Windows on every Client). And it will also shut them down after they have synced with the new files of the Server.

## Path tab

http://img193.imageshack.us/img193/9582/paths.jpg

### Program paths section

Here you have to set up the different paths to the executives.

### Syncback Profiles section

What you have to add, are the profiles of Syncback, that you like to run on update proces. With the button "load profiles from Syncback" it is possible to autmatically grab all profiles of your SyncBack's settings.

You will only need this if you want not to synchronize with the server directly. (e.g. You would like to run grabbing jobs by the server, but would like to save the data onto a Nas, becaus it wakes up faster as the server does)

## LOG tab

This tab should show you every error and activity. It gets also saved as .txt in you SyncServer directory. Please post it if you are reporting any errors/bugs.
