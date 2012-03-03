{

$Id: dlgAbout.pas,v 1.8 2004/05/10 06:15:17 slide Exp $

Description:

About dialog for the Amazon Product Finder.

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

unit dlgAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI, jpeg;

type

  {-------------------------------------------------------------------------}
  {- TAboutBox -}
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    OKButton: TButton;
    lblProductVersion: TLabel;
    Label1: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure CopyrightClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses
  uFinderGlobals;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- AboutBox -}

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAboutBox.CopyrightClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('mailto:' + TLabel(Sender).Caption), '',
    '', SW_SHOWNORMAL);
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  lblProductVersion.Caption := 'Version ' +
    GetVersionString(Application.ExeName,
    'FileVersion');
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAboutBox.Label1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('http://amazonfinder.sourceforge.net/'),
    '',
    '', SW_SHOWNORMAL);
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAboutBox.Label1MouseEnter(Sender: TObject);
begin
  AboutBox.Cursor := crHandPoint;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Key The pressed key.
}

procedure TAboutBox.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
