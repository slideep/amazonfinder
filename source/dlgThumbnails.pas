{

$Id: dlgThumbnails.pas,v 1.4 2004/04/27 13:10:26 slide Exp $

Description:

Thumbnails dialog for the Amazon Product Finder.

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

unit dlgThumbnails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, dbcgrids, DBCtrls;

type
  TThumbnails = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    cbOnlyWhenSearches: TCheckBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    btnSelectFile: TButton;
    dbgImages: TDBCtrlGrid;
    dblTitle: TDBText;
    dblArtistAuthor: TDBText;
    Shape1: TShape;
    imgProduct: TImage;
    dblSearchResults: TDBText;
    btnHelp: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnSelectFileClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Thumbnails: TThumbnails;

implementation

uses
  ShellAPI, ShlObj, uFinderGlobals;

{$R *.dfm}
{-----------------------------------------------------------------------------}
{- Thumbnails -}

{-----------------------------------------------------------------------------}
{**

}

procedure TThumbnails.btnCancelClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TThumbnails.btnApplyClick(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TThumbnails.btnSelectFileClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  with SaveDialog do
  try
    InitialDir := CacheDir;
    Title := 'Select Search File';
    Filter := 'Amazon Product Finder Search Files (*.xml)|*.xml';
    Execute;
    Edit1.Text := FileName;
  finally
    SaveDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TThumbnails.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
