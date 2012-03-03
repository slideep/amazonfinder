[Setup]
AppName=Amazon Product Finder Version 0.4.2 - (Build 35)
AppVerName=Amazon Product Finder Version 0.4.2 (Build 35)
AppVersion=0.4.2
AppPublisher=Amazon Product Finder
AppPublisherURL=http://amazonfinder.sourceforge.net/
AppSupportURL=http://amazonfinder.sourceforge.net/
AppUpdatesURL=http://amazonfinder.sourceforge.net/
DirExistsWarning=auto
DefaultDirName={pf}\Amazon Product Finder
DefaultGroupName=Amazon Product Finder
MinVersion=5.0.2195,5.0.2195
WizardImageFile=.\source\images\WizModernImg01.bmp
LicenseFile=.\doc\COPYING.txt

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"
Name: "quicklaunchicon"; Description: "Create a &Quick Launch icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Files]
Source: "AmazonFinder.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: ".\doc\COPYING.txt"; DestDir: "{app}\Documentation"; Flags: ignoreversion
Source: ".\data\FinderCategories.xml"; DestDir: "{app}\Data"; Flags: ignoreversion
Source: ".\data\FinderConfig.xml"; DestDir: "{app}\Data"; Flags: ignoreversion
Source: ".\data\FinderHistory.xml"; DestDir: "{app}\Data"; Flags: ignoreversion

[Dirs]
Name: "{app}\Cache"
Name: "{app}\Cache\Images"
Name: "{app}\Cache\Books"
Name: "{app}\Cache\DVD"
Name: "{app}\Cache\Music"
Name: "{app}\Cache\Magazines"
Name: "{app}\Cache\Videogames"
Name: "{app}\Data"
Name: "{app}\Documentation"
Name: "{app}\Help"

[Icons]
Name: "{group}\Amazon Product Finder"; Filename: "{app}\AmazonFinder.exe"; Flags:
Name: "{group}\Uninstall Amazon Product Finder"; Filename: "{uninstallexe}"
Name: "{group}\Amazon Product Finder Help"; Filename: "{app}\Help\AmazonFinder Help.chm"
Name: "{userdesktop}\Amazon Product Finder"; Filename: "{app}\AmazonFinder.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Amazon Product Finder"; Filename: "{app}\AmazonFinder.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\AmazonFinder.exe"; Description: "Launch Amazon Product Finder"; Flags: nowait postinstall skipifsilent
