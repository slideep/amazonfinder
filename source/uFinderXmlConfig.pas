{

$Id: uFinderXmlConfig.pas,v 1.13 2004/05/04 19:17:19 slide Exp $

Description:

XML settings configuration for the Amazon Product Finder.

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

unit uFinderXmlConfig;

interface

uses

  uXmlUtils, uFinderGlobals, SysUtils, XMLIntf, XMLDoc;

type

  {-------------------------------------------------------------------------}
  {- TuFinderXmlConfig -}
  TuFinderXmlConfig = class(TObject)
  private
    FUpdated,
      FFirstTime,
      FUseProxy,
      FUseAuth,
      FDefaultType,
      FUpdateStartup,
      FDisplaySplash,
      FCompressDefault,
      FExportType,
      FDeleteSearch: boolean;
    FDeleteSearchs,
      FProxyPort,
      FRemotePort: integer;
    FProxyUser,
      FProxyHost,
      FProxyPassword,
      FRemoteHost,
      FRemoteEndPoint,
      FSearchType,
      FCacheLocation,
      FImageLocation,
      FExportLocation,
      FExportFormat: string;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;
    procedure SaveAllSettings;
    property Updated: boolean read FUpdated write FUpdated default false;
    property FirstTime: boolean read FFirstTime write FFirstTime default true;
    property UseProxy: boolean read FUseProxy write FUseProxy default false;
    property UseAuth: boolean read FUseAuth write FUseAuth default false;
    property DefaulType: boolean read FDefaultType write FDefaultType;
    property DeleteSearch: boolean read FDeleteSearch write FDeleteSearch;
    property DeleteSearchs: integer read FDeleteSearchs write FDeleteSearchs;
    property UpdateStartup: boolean read FUpdateStartup write FUpdateStartup
      default true;
    property DisplaySplash: boolean read FDisplaySplash write FDisplaySplash
      default true;
    property ProxyUser: string read FProxyUser write FProxyUser;
    property ProxyHost: string read FProxyHost write FProxyHost;
    property ProxyPassword: string read FProxyPassword write FProxyPassword;
    property ProxyPort: integer read FProxyPort write FProxyPort;
    property RemoteHost: string read FRemoteHost write FRemoteHost;
    property RemotePort: integer read FRemotePort write FRemotePort;
    property RemoteEndPoint: string read FRemoteEndPoint write FRemoteEndPoint;
    property SearchType: string read FSearchType write FSearchType;
    property CacheLocation: string read FCacheLocation write FCacheLocation;
    property ImageLocation: string read FImageLocation write FImageLocation;
    property ExportLocation: string read FExportLocation write FExportLocation;
    property CompressCache: boolean read FCompressDefault write FCompressDefault
      default false;
    property ExportType: boolean read FExportType write FExportType;
    property ExportFormat: string read FExportFormat write FExportFormat;
  end;

implementation

uses
  frmMain;

{-----------------------------------------------------------------------------}
{- uFinderXmlConfig -}

{-----------------------------------------------------------------------------}
{**
  Creates a new XmlConfig or loads existing if it exists. Parses through the
  preferences and sets the attribute states accordingly.
  @param AFileName The name of the XmlConfig file.
}

constructor TuFinderXmlConfig.Create(const AFileName: string);
var
  Document: IXMLDocument;
  Node: IXMLNode;
  Root: IXMLNode;
  i: integer;
begin
  inherited create;

  Document := LoadXMLDocument(AFileName);
  Document.Options := [];
  Root := Document.DocumentElement;

  if Root = nil then
    raise Exception.Create('File ' + AFileName +
      ' does not contain an XML element!');

  for i := 0 to Root.ChildNodes.Count - 1 do
  begin
    Node := Root.ChildNodes.Nodes[i];

    { General }
    if (Node.NodeType = ntElement) and (Node.NodeName = 'General') then
    begin
      FirstTime := Node.Attributes['firstTime'];
      UseProxy := Node.Attributes['useProxy'];
      UseAuth := Node.Attributes['useAuth'];
      DisplaySplash := Node.Attributes['useSplash'];
      DefaulType := Node.Attributes['defaultType'];
      UpdateStartup := Node.Attributes['updateStart'];
      CompressCache := Node.Attributes['compressCache'];
    end;

    { Directories }
    if (Node.NodeType = ntElement) and (Node.NodeName = 'Dirs') then
    begin
      CacheLocation := Node.Attributes['cacheDir'];
      ImageLocation := Node.Attributes['imageDir'];
      ExportLocation := Node.Attributes['exportDir'];
    end;

    { Proxy }
    if UseProxy then
    begin
      if (Node.NodeType = ntElement) and (Node.NodeName = 'Proxy') then
      begin
        ProxyHost := Node.Attributes['proxyHost'];
        ProxyPort := Node.Attributes['proxyPort'];
        ProxyUser := Node.Attributes['proxyUser'];
        ProxyPassword := Node.Attributes['proxyPasswd'];
      end;

      { Remote }
      if (Node.NodeType = ntElement) and (Node.NodeName = 'Remote') then
      begin
        RemoteHost := Node.Attributes['remoteHost'];
        RemotePort := Node.Attributes['remotePort'];
        RemoteEndPoint := Node.Attributes['remoteEnd'];
      end;
    end;

    { Search }
    if (Node.NodeType = ntElement) and (Node.NodeName = 'Search') then
    begin
      SearchType := Node.Attributes['type'];
      DeleteSearchs := Node.Attributes['update'];
    end;

    { Export }
    if (Node.NodeType = ntElement) and (Node.NodeName = 'Export') then
    begin
      ExportFormat := Node.Attributes['type'];
      ExportType := Node.Attributes['defaultType'];
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Destroys the XmlConfig and saves all preferences if modified.
}

destructor TuFinderXmlConfig.Destroy;
begin
  SaveAllSettings;
  inherited Destroy;
end;

{-----------------------------------------------------------------------------}
{**
  Saves all settings in preferences if updated or is a first time using the
  program.
}

procedure TuFinderXmlConfig.SaveAllSettings;
var
  Document: IXMLDocument;
  Root, Node: IXMLNode;
begin
  if Updated or FirstTime then
  begin
    Document := NewXMLDocument;
    Document.Options := [doNodeAutoCreate, doNodeAutoIndent];
    Document.Active := True;
    Root := Document.CreateNode('Configuration', ntElement);
    Document.DocumentElement := Root;
    Node := Root.AddChild('General');
    Node.Attributes['firstTime'] := FirstTime;
    Node.Attributes['useProxy'] := UseProxy;
    Node.Attributes['useAuth'] := UseAuth;
    Node.Attributes['useSplash'] := DisplaySplash;
    Node.Attributes['defaultType'] := DefaulType;
    Node.Attributes['updateStart'] := UpdateStartup;
    Node.Attributes['compressCache'] := CompressCache;
    Node := Root.AddChild('Dirs');
    Node.Attributes['cacheDir'] := CacheLocation;
    Node.Attributes['imageDir'] := ImageLocation;
    Node.Attributes['exportDir'] := ExportLocation;
    Node := Root.AddChild('Proxy');
    Node.Attributes['proxyHost'] := ProxyHost;
    Node.Attributes['proxyPort'] := ProxyPort;
    Node.Attributes['proxyUser'] := ProxyUser;
    Node.Attributes['proxyPasswd'] := ProxyPassword;
    Node := Root.AddChild('Remote');
    Node.Attributes['remoteHost'] := RemoteHost;
    Node.Attributes['remotePort'] := RemotePort;
    Node.Attributes['remoteEnd'] := RemoteEndPoint;
    Node := Root.AddChild('Search');
    Node.Attributes['type'] := SearchType;
    Node.Attributes['update'] := DeleteSearchs;
    Node := Root.AddChild('Export');
    Node.Attributes['type'] := ExportFormat;
    Node.Attributes['defaultType'] := ExportType;
    Document.SaveToFile(MainForm.AppPath + DefaultConfig);
    Document.Active := False;
  end;
end;

end.
