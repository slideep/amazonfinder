{

$Id: dlgConnection.pas,v 1.6 2004/04/27 13:10:26 slide Exp $

Description:

Network connection dialog for the Amazon Product Finder.

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

unit dlgConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TConnectionDialog = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    rbNetworkConnection: TRadioButton;
    rbCustomConnection: TRadioButton;
    Edit2: TEdit;
    btnBrowse: TButton;
    btnAuthentication: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Bevel1: TBevel;
    procedure Edit1Change(Sender: TObject);
    procedure btnAuthenticationClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConnectionDialog: TConnectionDialog;

implementation

uses

  dlgAuthentication;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{**

}

procedure TConnectionDialog.Edit1Change(Sender: TObject);
begin
  btnAuthentication.Enabled := true;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TConnectionDialog.btnAuthenticationClick(Sender: TObject);
begin
  Form1.Show;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TConnectionDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
