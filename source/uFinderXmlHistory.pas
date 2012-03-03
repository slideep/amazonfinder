{

$Id: uFinderXmlHistory.pas,v 1.10 2004/05/04 19:17:20 slide Exp $

Description:

XML history configuration for the Amazon Product Finder.

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

unit uFinderXmlHistory;

interface

uses
  uXmlUtils, uFinderGlobals, uFinderXmlConfig, SysUtils, XMLIntf, XMLDoc;

type

  {-------------------------------------------------------------------------}
  {- TuFinderXmlHistory -}
  TuFinderXmlHistory = class(TObject)
  private
    FXMLDocument: IXMLDocument;
    FSearchUpdated: boolean;
    FSearchID,
      FSearchCategory,
      FSearchType,
      FUpdated,
      FSearchResults,
      FSearchPages,
      FKeywords: WideString;
  public
    constructor Create(const AFileName: WideString);
    destructor Destroy; override;
    procedure SaveHistory;
    procedure UpdateHistory;
    procedure ActivateHistory;
    function GetHistory(ADocument: IXMLDocument): IXMLDocument;
    property Updated: boolean read FSearchUpdated write FSearchUpdated;
    property SearchID: WideString read FSearchID write FSearchID;
    property SearchType: WideString read FSearchType write FSearchType;
    property SearchCategory: WideString read FSearchCategory write
      FSearchCategory;
    property SearchUpdated: WideString read FUpdated write FUpdated;
    property SearchResults: WideString read FSearchResults write FSearchResults;
    property SearchPages: WideString read FSearchPages write FSearchPages;
    property SearchKeywords: WideString read FKeywords write FKeywords;
  end;

resourcestring
  SHistoryRoot = 'SearchHistory';
  SSearchNode = 'Search';
  SSearchIDAttr = 'id';
  SSearchCategoryAttr = 'category';
  SSearchModeAttr = 'mode';
  SSearchUpdatedAttr = 'updated';
  SSearchPagesAttr = 'pages';
  SSearchResultsAttr = 'results';

implementation

uses
  frmMain;

{-----------------------------------------------------------------------------}
{- TuFinderXmlHistory -}

{-----------------------------------------------------------------------------}
{**
  Creates a new XmlHistory or loads existing if it exists. The history will
  be populated to the search history listview. Double-clicking the selected
  row will load the local saved search file.
  // TODO: dblclickicking at selected row will call the load, parse and
  populate process for the specified search file.
  @param AFileName The name of the XML history file.
}

constructor TuFinderXmlHistory.Create(const AFileName: WideString);
var
  i: integer;
  Document: IXMLDocument;
  Root: IXMLNode;
  Node: IXMLNode;
begin
  inherited Create;
  Document := LoadXMLDocument(AFileName);
  if Document.IsEmptyDoc then
    Document := NewXMLDocument;
  FXMLDocument := Document;
  Document.Options := [doAttrNull, doNodeAutoCreate, doAutoSave,
    doNodeAutoIndent];
  FXMLDocument.Active := true;
  Root := Document.DocumentElement;
  if Root = nil then
    raise Exception.Create('File ' + AFileName +
      ' does not contain an XML element!');
  if Root.HasChildNodes then
    for i := 0 to Root.ChildNodes.Count - 1 do
    begin
      Node := Root.ChildNodes.Nodes[i];
      if (Node.NodeType = ntElement) and (Node.NodeName = SSearchNode) then
      begin
        SearchID := ReadAttr(Node, SSearchIDAttr);
        SearchCategory := ReadAttr(Node, SSearchCategoryAttr);
        SearchType := ReadAttr(Node, SSearchModeAttr);
        SearchUpdated := ReadAttr(Node, SSearchUpdatedAttr);
        SearchPages := ReadAttr(Node, SSearchPagesAttr);
        SearchResults := ReadAttr(Node, SSearchResultsAttr);
        SearchKeywords := Node.Text;
        MainForm.InitSearchNodes(SearchKeywords, SearchType, SearchUpdated,
          SearchPages, SearchResults, SearchCategory);
      end;
    end;
end;

{-----------------------------------------------------------------------------}
{**
  Destroys the XmlHistory and saves it if modified.
}

destructor TuFinderXmlHistory.Destroy;
begin
  SaveHistory;
  inherited Destroy;
end;

{-----------------------------------------------------------------------------}
{**
  Updates the XmlHistory if it's active.
}

procedure TuFinderXmlHistory.UpdateHistory;
begin
  if (FXMLDocument.Active) and (Updated) then
  begin
    FXMLDocument.Active := false;
    SaveHistory;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Activates the XmlHistory if it's not in active state
}

procedure TuFinderXmlHistory.ActivateHistory;
begin
  if not FXMLDocument.Active then
    FXMLDocument.Active := true;
end;

{-----------------------------------------------------------------------------}
{**
  Retrieves the handle for the XmlHistory IXMLDocument.
  @param ADocument The XML history document.
  @return IXMLDocument The instance XML document.
}

function TuFinderXmlHistory.GetHistory(ADocument: IXMLDocument): IXMLDocument;
begin
  result := ADocument.GetDocBinding(SHistoryRoot, TXMLDocument) as
    IXMLDocument;
end;

{-----------------------------------------------------------------------------}
{**
  Saves the XmlHistory if it has been modified or updated. History is
  activated if it's not in that state already.
}

procedure TuFinderXmlHistory.SaveHistory;
var
  i: Integer;
  Document: IXMLDocument;
  Root, Node: IXMLNode;
begin
  if Updated then
  begin
    try
      Document := FXMLDocument;
      Document.Options := [doNodeAutoCreate, doAutoSave, doNodeAutoIndent];
      if not Document.Active then
        ActivateHistory;
      Root := Document.CreateNode(SHistoryRoot, ntElement);
      Document.DocumentElement := Root;
      for i := 0 to MainForm.Searches.Items.Count - 1 do
      begin
        Node := Root.AddChild(SSearchNode);
        Node.Attributes[SSearchIDAttr] := i;
        Node.Text := MainForm.Searches.Items.Item[i].Caption;
        Node.Attributes[SSearchCategoryAttr] :=
          MainForm.Searches.Items.Item[i].SubItems.Text;
        Node.Attributes[SSearchModeAttr] :=
          MainForm.Searches.Items.Item[i].SubItems.Text;
        Node.Attributes[SSearchUpdatedAttr] :=
          MainForm.Searches.Items.Item[i].SubItems.Text;
        Node.Attributes[SSearchPagesAttr] :=
          MainForm.Searches.Items.Item[i].SubItems.Text;
        Node.Attributes[SSearchResultsAttr] :=
          MainForm.Searches.Items.Item[i].SubItems.Text;
      end;
      Document.SaveToFile(MainForm.AppPath + DefaultHistory);
      DumpLog('Search history saved to ' + MainForm.AppPath + DefaultHistory);
      Document.Active := False;
    except
      on e: Exception do
        MainForm.DumpException(Self, e);
    end;
  end;
end;

end.
