# VM Starter und Logon Redirector

# tl;dr
Diese Web-App startet eine beliebige VM in Azure und redirected dann auf die HTML5-Loginscreen (Myrtille) der VM. Der Benutzer kann sich dann per Browser über HTML5 auf der Oberfläche der VM anmelden. 



# Einführung
Microsoft stellt zwei Services für die Remote-Arbeitsplätze zu Verfügung. Azure Virtual Desktop und Windows 365. Beide Services sind funktionsmäßig sehr umfangreich. Daher für den einen oder anderen Use-Case sicher zu teuer und zu komplex in der Einrichtung. 

Diese Web-App stellt eine sehr rudimentäre Oberfläche bereit, um eine VM, die als Remote-Arbeitsplatz dient, zu starten. Ist die VM gestartet so wird die App den Browser auf die Login-Seite der VM redirecten. Die Login-Seite wird von Myrtille bereitgestellt. Myrtille ist eine Open Source Software, um eine RDP-Session über HTML5 aufzubauen. 

Vorteil ist, dass diese Lösung ein Minimal-Case ist. Es fallen nur minimale Kosten an. Azure Virtual Desktop erfordert einen Domänenkontroller, eine funktionierede User-Synchronisierung und vieles mehr, damit es funktioniert. Also zu teuer und zu komplex. Der Preismodel von Windows 365 ist ein fixer Betrag pro Monat pro User. Ob die Lösung nun genutzt wird oder nicht. 

Diese Lösung kostet (bis auf den belegten Speicher) im Leerlaufbetrieb nichts. Auch wird keine Domäne benötigt.

Diese Lösung ist gedacht für den Einsatz in Non-Profi Organisationen, die die kostenfreien Non-Profi Angebote der Microsoft nutzen können.

# Anwendung
Besuche die Webseite der App mit einem HTML5 fähigen Browser. Melde Dich mit Deinem Account am Azure AD Tenant an. Klicke auf die VM, zu der Du eine Verbindung herstellen möchtest. 


# Deployment

1. Zuerst muss die Infrastruktur für die App deployed werden. Clone das Repo auf Deinen Rechner und führe das Script deploy.ps1 aus. 
2. Dann muss die Anwendung in die Infrastruktur deployed werden. Das machen wir mit Guthub Actions. Immer wenn Du eine Änderung an der Anwendung machst, dann wird Github Actions die neue Version auf die Infrastruktur deployen.
 

1. Clone das Repo in ein eigenes Github Repo
2. Clone dann dieses Repo auf Deinen Rechner
3. Erstelle einen Repository Token in Github
4. Führe Deploy.ps1 aus
5. Füge das Publish Profile für das Deployment der Function App in dein Github Repo ein
6. Ändere im Github workflow für die Function den namen der Function App
7. Passe den Source Path im Workflow der Static App an
8. Anpassen der API Url in der index.html in der Javascript App
9. Committe die geänderten Files in dein Repo

# Einstellungen



