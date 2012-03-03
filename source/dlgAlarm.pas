{

$Id: dlgAlarm.pas,v 1.7 2004/05/05 22:22:25 slide Exp $

Description:

Main form for the Amazon Product Finder.

The initial developer of the original code is slide@users.sourceforge.net.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General public License for more details.

You should have received a copy of the GNU General public
License along with this program; if not, write to the Free
Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA  02111-1307, USA.

}

unit dlgAlarm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, MPlayer, StdCtrls;

type

  // TODO: rename this unit!

  {-------------------------------------------------------------------------}
  {- TForm2 -}
  TForm2 = class(TForm)
    ListView1: TListView;
    Timer1: TTimer;
    MediaPlayer1: TMediaPlayer;
    Panel1: TPanel;
    Label1: TLabel;
    lblAlarmName: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FAlarmSet: boolean;
  public
    { Public declarations }
    procedure InitAlarmItems(const AName, AOurPrice, AListPrice, AUsedPrice,
      ASeller: string);
    property AlarmSet: boolean read FAlarmSet write FAlarmSet;
  end;

var
  Form2: TForm2;

implementation

uses
  uFinderGlobals, uFinderResources;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- Alarm -}

{-----------------------------------------------------------------------------}
{**

}

procedure TForm2.FormCreate(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, Top, Left, Width, Height, SWP_NOACTIVATE or
    SWP_NOMOVE or SWP_NOSIZE);
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TForm2.InitAlarmItems(const AName, AOurPrice, AListPrice, AUsedPrice,
  ASeller: string);
begin
  with ListView1.Items.Add do
  begin
    Caption := AName;
    SubItems.Add(AOurPrice);
    SubItems.Add(AListPrice);
    SubItems.Add(AUsedPrice);
    SubItems.Add(ASeller);
  end;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
