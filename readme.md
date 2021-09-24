# VM Starter und Logon Redirector

!UNDER CONSTRUCTION!

# tl;dr
Diese Web-App startet eine beliebige VM (Virtuelle Maschine) in Azure und redirected dann auf den HTML5-Loginscreen (Myrtille) der VM. Der Benutzer kann sich dann auf dem Desktop der VM anmelden.


# Einführung
Microsoft stellt zwei Services für Remote-Arbeitsplätze (VM) zu Verfügung. 1. Azure Virtual Desktop und 2. Windows 365. Beide Services sind funktionsmäßig sehr umfangreich. Daher für den einen oder anderen Use-Case sicher zu teuer und zu komplex in der Einrichtung. Gerade bei gemeinnützigen Organisationen.

Diese Web-App stellt eine sehr rudimentäre Oberfläche bereit, um eine VM, die als Remote-Arbeitsplatz dient, zu starten. Ist die VM gestartet so wird die App den Browser auf die Login-Seite der VM redirecten. Die Login-Seite wird von Myrtille bereitgestellt. Myrtille ist eine Open Source Software, um eine RDP-Session über HTML5 aufzubauen.

Damit kann also eine Vereinsverwaltung zentral und sicher in der Cloud bereitgestellt werden.

Vorteil dieser Lösung, es fallen nur minimale Kosten an. Azure Virtual Desktop erfordert einen Domänenkontroller, eine funktionierede User-Synchronisierung und vieles mehr, damit es funktioniert. Also zu teuer und zu komplex. Der Preismodel von Windows 365 ist ein fixer Betrag pro Monat pro User. Ob die Lösung genutzt wird oder nicht. 

Diese Lösung kostet (bis auf den belegten Speicher) im Leerlaufbetrieb nichts.

Diese Lösung ist gedacht für den Einsatz in Non-Profi Organisationen, die die kostenfreien Non-Profi Angebote der Microsoft nutzen können und wollen.


# Anwendung
Besuche die Webseite der App mit einem HTML5 fähigen Browser. Melde Dich mit Deinem Account am Azure AD Tenant an. Klicke auf die VM, zu der Du eine Verbindung herstellen möchtest. 


# Deployment der Wap-App


## Grober Überblick
1. Zuerst muss die Infrastruktur für die App deployed werden. Clone das Repo auf Deinen Rechner und führe das Script deploy.ps1 aus. 
2. Dann muss die Anwendung in die Infrastruktur deployed werden. Das machen wir mit Guthub Actions. Immer wenn Du eine Änderung an der Anwendung machst, dann wird Github Actions die neue Version auf die Infrastruktur deployen.

Damit kannst Du ständig Änderungen an Deiner App machen. Diese werden
 
## Detaillierte Anleitung
1. Clone das Repo in ein eigenes Github Repo
2. Clone dann dieses Repo auf Deinen Rechner
3. Erstelle einen Repository Token (PAT) in Github. Dieser benötigt rechte auf Repo und Workflows.
4. Führe Deploy.ps1 aus mit dem Repository Token (PAT), Einer Repository Url und einer Function APP Namen als Parameter. Dies deployed eine Function. Eine managed Identity. Einen Storage Account. Und eine Static Web App. Die Static Web App erzeugt automatisch einen workflow. 
5. Füge das Publish Profile für das Deployment der Function App in dein Github Repo ein.
6. Ändere im Github workflow für die Function den namen der Function App
7. Füge den Management Token der Static Web APP als Secret in Guthub ein. 
8. Füge den Master Key der Function der Url hinzu, die zur Function führt.
1. Committe die geänderten Files in dein Repo. Dann startet das Deployment der App auf der Infrastruktur.

# Einstellungen



