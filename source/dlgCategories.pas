{

$Id: dlgCategories.pas,v 1.9 2004/05/04 19:17:19 slide Exp $

Description:

Details category dialog for the Amazon Product Finder.

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

unit dlgCategories;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, strutils, XMLDoc, XMLIntf;

type

  {-------------------------------------------------------------------------}
  {- TCategories -}
  TCategories = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Bevel1: TBevel;
    lvCategories: TListView;
    btnCategories: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    cbSelectCategory: TComboBox;
    btnAdd: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCategoriesClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure lvCategoriesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cbSelectCategorySelect(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FCategoriesLoaded: boolean;
    FFileName: string;
    FCategoryList: TStringList;
    procedure LoadCategories(AFileName: string);
    procedure AddCategory(AValue: string);
    procedure RemoveCategory(AValue: string);
  public
    { Public declarations }
    property CategoriesLoaded: boolean read FCategoriesLoaded write
      FCategoriesLoaded;
  end;

var
  Categories: TCategories;

implementation

uses

  uFinderGlobals;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- Categories -}

{-----------------------------------------------------------------------------}
{**

  @param AFileName
}

procedure TCategories.LoadCategories(AFileName: string);
var
  i: integer;
  Document: IXMLDocument;
  ParentNode: IXMLNode;
  Node: IXMLNode;
  CategoryItem: TListItem;
begin
  Document := LoadXMLDocument(AFileName);
  Document.Options := [];
  ParentNode := Document.DocumentElement;
  if ParentNode = nil then
    raise Exception.Create('File ' + AFileName +
      ' doesn''t contain an XML element!');
  for i := 0 to ParentNode.ChildNodes.Count - 1 do
  begin
    Node := ParentNode.ChildNodes.Nodes[i];
    CategoryItem := lvCategories.Items.AddItem(nil);
    CategoryItem.Caption := Node.Attributes['id'];
    FCategoryList.Add(Node.Attributes['id']);
    CategoryItem.Checked := true;
    if Node.Attributes['description'] = '' then
      continue;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param AValue
}

procedure TCategories.AddCategory(AValue: string);
var
  i: integer;
begin
  i := FCategoryList.IndexOf(AValue);
  if (i < 0) then
    FCategoryList.Add(AValue);
end;

{-----------------------------------------------------------------------------}
{**

  @param AValue
}

procedure TCategories.RemoveCategory(AValue: string);
var
  i: integer;
begin
  i := FCategoryList.IndexOf(AValue);
  if (i > -1) then
    FCategoryList.Delete(i);
  { TODO: delete node with given id -> AValue and finally save to disk }
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.FormCreate(Sender: TObject);
begin
  FCategoryList := TStringList.Create;
  if not CategoriesLoaded then
    LoadCategories(ExtractFilePath(Application.ExeName) + DefaultCategories);
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.btnCategoriesClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Title := 'Load Category File';
    OpenDialog.Filter := 'Amazon Product Finder Category Files (*.xml)|*.xml';
    if OpenDialog.Execute then
      FFileName := OpenDialog.FileName;
  finally
    OpenDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.btnAddClick(Sender: TObject);
begin
  {
    if CompareStr(btnAdd.Caption, 'Add') <> 0 then
    begin
      if lvCategories.Selected then
        RemoveCategory(lvCategories.Selected.Caption)
      else
        ShowErrorMessage('Please select category from the list first!');
    end
    else
      AddCategory(cbSelectCategory.Text);
  }
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Item The selected item.
  @param Selected The selected state flag.
}

procedure TCategories.lvCategoriesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected = true then
    btnAdd.Caption := '&Remove';
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.cbSelectCategorySelect(Sender: TObject);
begin
  btnAdd.Caption := '&Add';
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.btnOKClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.btnCancelClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.btnApplyClick(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TCategories.FormDestroy(Sender: TObject);
begin
  FCategoryList.Free;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Key
}

procedure TCategories.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
