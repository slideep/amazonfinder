{

$Id: uFinderTreeviewUtils.pas,v 1.1 2004/05/04 19:17:20 slide Exp $

Description:

Treeview helper procedures and functions for the Amazon Product Finder.

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

unit uFinderTreeviewUtils;

interface

uses
  ComCtrls, Classes, XMLIntf;

procedure InitSearchFolders(ATreeView: TTreeView; ATreeNode: TTreeNode;
  ANode: IXMLNode);
function FindNode(ATreeView: TTreeView; AParentNode: TTreeNode;
  AValue: string): TTreeNode;
procedure LoadSearchFolderNodes(ATreeView: TTreeView; ATreeNode: TTreeNode;
  ADirectory, AFileType: string);
procedure UpdateSearchFolder(ATreeView: TTreeView; ASearchFolder,
  ASearchFolderName: string);
procedure AddSearchFolder(ATreeView: TTreeView; ASearchFolderName: string);

implementation

uses
  SysUtils, uFinderGlobals;

{-----------------------------------------------------------------------------}
{- uFinderTreeviewUtils -}

{-----------------------------------------------------------------------------}
{**
 
  @param ATreeView
  @param ATreeNode
  @param ANode
}

procedure InitSearchFolders(ATreeView: TTreeView; ATreeNode: TTreeNode; 
  ANode: IXMLNode);
var
  i,
  Items: integer;
  TempNode,
  NewNode: TTreeNode;
begin
  // TODO:
end;

{-----------------------------------------------------------------------------}
{**
  Finds the named tree node item from the treeview.
  @param ATreeView
  @param AParentNode Nillable
  @param AValue The name of the node
  @return TTreeNode The match for the value.
}

function FindNode(ATreeView: TTreeView; AParentNode: TTreeNode;
  AValue: string): TTreeNode;
var
  i: integer;
begin
  result := nil;
  if not Assigned(AParentNode) then
  begin
    for i := 0 to ATreeView.Items.Count - 1 do
      if CompareText(ATreeView.Items.Item[i].Text, AValue) = 0 then
      begin
        result := ATreeView.Items.Item[i];
        break;
      end;
  end
  else
    for i := 0 to AParentNode.Count - 1 do
      if CompareText(AParentNode.Item[i].Text, AValue) = 0 then
      begin
        result := AParentNode.Item[i];
        break;
      end;
end;

{-----------------------------------------------------------------------------}
{**
 
  @param ATreeView
  @param ATreeNode
  @param ADirectory
}

procedure LoadSearchFolderNodes(ATreeView: TTreeView; ATreeNode: TTreeNode;
  ADirectory, AFileType: string);
var
  SearchRec: TSearchRec;
  Path: string;
begin
  if Length(ADirectory) = 0 then
    exit;
  Path := ADirectory + '\';
  if FindFirst(Path + AFileType, 0, SearchRec) = 0 then
  begin
    while FindNext(SearchRec) <> 0 do
    begin
      ATreeView.items.AddChild(ATreeNode, GetFileName(SearchRec.Name));
    end;
    FindClose(SearchRec);
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param ATreeView
  @param ASearchFolder
  @param ASearchFolderName
}

procedure UpdateSearchFolder(ATreeView: TTreeView; ASearchFolder,
  ASearchFolderName: string);
var
  Node: TTreeNode;
begin
  Node := ATreeView.Items.Add(nil, ASearchFolder);
  ATreeView.Items.Item[0].ImageIndex := 1;
  ATreeView.Items.AddChild(Node, ASearchFolderName).ImageIndex := 1;
  ATreeView.Update;
end;

{-----------------------------------------------------------------------------}
{**

  @param ATreeView
  @param ASearchFolderName
}

procedure AddSearchFolder(ATreeView: TTreeView; ASearchFolderName: string);
var
  Node: TTreeNode;
begin
  Node := ATreeView.Items.Add(ATreeView.TopItem, ASearchFolderName);
  Node.ImageIndex := 59; // TODO: hardcoded
  Node.SelectedIndex := 60; // TODO: hardcoded
  ATreeView.Update;  
end;

end.
