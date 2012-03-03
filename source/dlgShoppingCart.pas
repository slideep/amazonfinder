{

$Id: dlgShoppingCart.pas,v 1.5 2004/04/27 13:10:26 slide Exp $

Description:

Shopping cart dialog for the Amazon Product Finder.

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

unit dlgShoppingCart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, ImgList, uShoppingCart,
  uProduct;

type
  TfrmShoppingCart = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SaveforLater1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    ProceedtoCheckout1: TMenuItem;
    Panel2: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Label2: TLabel;
    Update1: TMenuItem;
    ImageList1: TImageList;
    lbl: TLabel;
    Label4: TLabel;
    N3: TMenuItem;
    Bevel1: TBevel;
    Label5: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    Label1: TLabel;
    lblSubTotal: TLabel;
    lblCurrency: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure SaveforLater1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure ProceedtoCheckout1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddItem(const AProduct, APrice, ACount: WideString);
    procedure RemoveItem(AItem: TListItem);

  end;

var
  frmShoppingCart: TfrmShoppingCart;

implementation

uses
  uFinderGlobals;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- frmShoppingCart -}

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.btnCancelClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.btnOKClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.SaveforLater1Click(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.Delete1Click(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.ProceedtoCheckout1Click(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.AddItem(const AProduct, APrice, ACount: WideString);
begin
  with ListView1.Items.Add do
  begin
    Caption := AProduct;
    SubItems.Add(APrice);
    SubItems.Add(ACount);
  end;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.RemoveItem(AItem: TListItem);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.FormCreate(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TfrmShoppingCart.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
