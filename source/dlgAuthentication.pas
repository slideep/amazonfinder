{

$Id: dlgAuthentication.pas,v 1.7 2004/05/04 19:17:19 slide Exp $

Description:

Authentication dialog for the Amazon Product Finder.

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

unit dlgAuthentication;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls;

type
  TForm1 = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbServerName: TComboBox;
    txtUserName: TEdit;
    txtUserPasswd: TMaskEdit;
    cbUserDirectory: TComboBox;
    Edit1: TEdit;
    Button1: TButton;
    Bevel1: TBevel;
    Label6: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{-----------------------------------------------------------------------------}
{**

}

procedure TForm1.btnOKClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TForm1.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
