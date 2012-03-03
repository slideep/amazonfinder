{

$Id: frmSplash.pas,v 1.9 2004/05/04 19:17:19 slide Exp $

Description:

Splash form for the Amazon Product Finder.

The initial developer of the original code is slide@users.sourceforge.net.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public
License along with this program; if not, write to the Free
Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA  02111-1307, USA.

}

unit frmSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, jpeg;

resourcestring
  SLoadingConfiguration = 'Loading Amazon Product Finder Configuration...';
  SLoadingSearchHistory = 'Loading Amazon Product Finder Search History...';
  SLoadFinished = 'Loading Finished.';
  SLoadFailed = 'Loading Failed.';
  SUpdatingSearchHistory = 'Updating Search History...';
  SUpdateFinished = 'Update Finished.';
  SUpdateFailed = 'Update Failed.';

type
  TSplashScreen = class(TForm)
    FlatPanel1: TPanel;
    LoadProgress: TProgressBar;
    Image2: TImage;
    lblFinderStatus: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashScreen: TSplashScreen;

implementation

uses

  uFinderGlobals, uFinderXmlHistory;

{-----------------------------------------------------------------------------}
{- SplashScreen -}

{$R *.dfm}

{-----------------------------------------------------------------------------}
{**
  Shows the splash screen and updates the status labels with version info and
  status messages.
}

procedure TSplashScreen.FormShow(Sender: TObject);
begin
  lblFinderStatus.Caption := 'Version ' + GetVersionString(Application.ExeName,
    'FileVersion');
  ShowWindow(Application.Handle, SW_HIDE);
end;

{-----------------------------------------------------------------------------}
{**
  Creates the splash screen and keeps on top of windows until everything has
  been loaded and updated.
}

procedure TSplashScreen.FormCreate(Sender: TObject);
begin
  Self.FormStyle := fsStayOnTop;
end;

end.
