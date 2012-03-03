{ ______________________________________________________________________________

  <H5>Copyright</H5>
  File: omURLs.pas

  Copyright (C) 2002 ObjectMastery Pty Limited

  Conditions for use, copying, modification and distribution of this software
  are contained in the appropriate licence, which can be found in the webRAD
  readme file included or at http://webrad.sourceforge.net/license.htm

  To see the modification history of this file please refer to the project's
  CVS repository on the SourceForge. www.sourceforge.net/projects/webrad
________________________________________________________________________________
}
unit omURLs;

interface

uses
  SysUtils
  , omSystem
  , Classes
  , omStrUtils
  ;

type

  TomUrl = class
  private
    FProtocol: String;
    FSlash: char;
    function GetURL: String; virtual; abstract;
    procedure SetURL(const Value: String); virtual; abstract;
  public
    // Url Factory Method
    class function MakeURL(URL: String): TomURL; virtual;
    function FixSlash(Str: String): String;
    property Protocol: String read FProtocol;
    property URL: String read GetURL write SetURL;
  end; { TomUrl }

  TomHttp = class(TomUrl)
  private
    FDomain: String;
    FName: String;
    FDirectory: String;
    FExtension: String;
    FHost: String;
    FPort: String;
    FQueries: TStringList;
    function GetPartial: String;
    function GetPath: String;
    function GetQueries: TStringList;
    function GetQuery(Index: Integer): String;
    function GetQueryString: String;
    function GetQueryValue(Index: String): String;
    function GetServer: String;
    procedure SetDirectory(const Value: String);
    procedure SetDomain(const Value: String);
    procedure SetExtension(const Value: String);
    procedure SetHost(const Value: String);
    procedure SetHostPort(const Value: String);
    procedure SetName(const Value: String);
    procedure SetPartial(const Value: String);
    procedure SetPath(const Value: String);
    //    procedure SetProtocol(const Value: String);
    procedure SetQueries(const Value: TStringList);
    procedure SetQuery(Index: Integer; const Value: String);
    procedure SetQueryString(const Value: String);
    procedure SetServer(const Value: String);
    function GetHostPort: String;

    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

  public
    constructor Create(URL: String); overload;
    constructor Create; overload;
    destructor Destroy; override;

    procedure Clear;

    property HostPort: String read GetHostPort write SetHostPort;

    property Host: String read FHost write SetHost;
    property Domain: String read FDomain write SetDomain;
    property Directory: String read FDirectory write SetDirectory;
    property Name: String read FName write SetName;
    property Extension: String read FExtension write SetExtension;

    property Server: String read GetServer write SetServer;
    property Path: String read GetPath write SetPath;
    property Partial: String read GetPartial write SetPartial;
    property Full: String read GetURL write SetURL;
    property QueryStrings: TStringList read GetQueries write SetQueries;
    property Query[Index: integer]: String read GetQuery write SetQuery;
    property QueryValue[Index: String]: String read GetQueryValue;
    property QueryString: String read GetQueryString write SetQueryString;
  end; { TomHttp }

  TomFtp = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property Login: String read FLogin write SetLogin;
    //  property Path: String read FPath write SetPath;
    //  property Ftptype: String read FFtptype write SetFtptype;
    //  property Formcode: String read FFormcode write SetFormcode;
  end; { TomFtp }

  TomAfs = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property Cellname: String read FCellname write SetCellname;
    //  property Path: String read FPath write SetPath;
  end; { TomAfs }

  TomNews = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property Group: String read FGroup write SetGroup;
    //  property Article: String read FArticle write SetArticle;
  end; { TomNews }

  TomNntp = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property Group: String read FGroup write SetGroup;
    //  property Digits: String read FDigits write SetDigits;
  end; { TomNntp }

  TomProspero = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property Hostport: String read F write Sethostport;
    //  property Hostname: String read FHostname write SetHostname;
    //  property Version: String read FVersion write SetVersion;
    //  property Attributes: String read FAttributes write SetAttributes;
  end; { TomProspero }

  TomTelnet = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property Login: String read FLogin write SetLogin;
    //      property User: String read FUser write SetUser;
    //      property Password: String read FPassword write SetPassword;
    //      property Hostport: String read FHostport write SetHostport;
    //        property Host: String read FHost write SetHost;    // hostname or hostnumber
    //        property Host: String read FHost write SetHost;
  end; { TomTelnet }

  TomGopher = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property Hostport: String read FHostport write SetHostport;
    //  property Gtype: String read FGtype write SetGtype;
    //  property Gcommand: String read FGcommand write SetGcommand;

  end; { TomGopher }

  TomWais = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property WaisIndex: String read GetWaisIndex write SetWaisIndex;
    //      property Hostport: String read FHostport write SetHostport;
    //        property Host: String read FHost write SetHost;       // hostname or hostnumber
    //        property Port: String read FPort write SetPort;
    //      property Database: String read FDatabase write SetDatabase;
    //      property Search: String read FSearch write SetSearch;
    //  property WaisDoc: String read FWaisDoc write SetWaisDoc;
    //      property Wtype: String read Wtype write SetWtype;
    //      property Wpath: String read FWpath write SetWpath;      //[digits=path;]*
  end; { TomWais }

  TomMailto = class(TomUrl)
  private
    FHostname: String;
    FName: String;
    procedure SetHostname(const Value: String);
    procedure SetName(const Value: String);

    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

  published
    constructor Create(URL: String);
    property Name: String read FName write SetName;
    property Hostname: String read FHostname write SetHostname;
  end; { TomMailto }

  TomMid = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property AddrSpec: String read FAddrSpec write SetAddrSpec;
  end; { TomMid }

  TomCid = class(TomUrl)
  public
    constructor Create(URL: String);
    function GetURL: String; override;
    procedure SetURL(const Value: String); override;

    //  property ContentIdent: String read FContentIdent write SetContentIdent;
  end; { TomCid }

  TomFile = class(TomUrl)
  private
    FExtension: String;
    FName: String;
    FDirectory: String;
    FDrive: String;
    function GetPartial: String;
    function GetPath: String;
    procedure SetDirectory(const Value: String);
    procedure SetDrive(const Value: String);
    procedure SetName(const Value: String);
    procedure SetPartial(const Value: String);
    procedure SetPath(const Value: String);
    function GetExists: Boolean;

    function GetURL: String; override;
    procedure SetURL(const Value: String); override;
    function GetFull: String;
    procedure SetFull(const Value: String);

  public
    constructor Create(URL: String); overload;
    constructor Create; overload;
    procedure Clear;
    function MakeDirectory: Boolean;
    procedure Delete;
    procedure ChDir(NewDirectory: String);

  published
    property Drive: String read FDrive write SetDrive;
    property Directory: String read FDirectory write SetDirectory;
    property Name: String read FName write SetName;
    property Extension: String read FExtension write FExtension;

    property Path: String read GetPath write SetPath;
    property Partial: String read GetPartial write SetPartial;
    property Full: String read GetFull write SetFull;

    property Exists: Boolean read GetExists;

  end; { TomFile }

type
  // 'TomFilename' is now deprecated, only here for backward compatibility
  TomFilename = TomFile;

function AppendSlash(const Str: String; const Slash: char = '\'): String;




function ValidCharString(const Str: String; const Charset: TCharset): boolean;
function ValidNameString(const Str: String): boolean;
function ValidPartialString(const Str: String): boolean;
function ValidPathString(const Str: String): boolean;
function ValidFullString(const Str: String): boolean;
function ValidURLString(const Str: String): boolean;

const
  ValidNameChars: TCharset =
  ['a'..'z', 'A'..'Z', '0'..'9', ' ', '-', '_', '$', ' '];
  ValidPartialChars: TCharset =
  ['a'..'z', 'A'..'Z', '0'..'9', ' ', '-', '_', '$', ' ', '.'];
  ValidPathChars: TCharset =
  ['a'..'z', 'A'..'Z', '0'..'9', ' ', '-', '_', '$', ' ', '.', '\', ':', '~'];
  ValidFullChars: TCharset =
  ['a'..'z', 'A'..'Z', '0'..'9', ' ', '-', '_', '$', ' ', '.', '\', ':', '&',
    '/', '|', '%', '~'];
  ValidURLChars: TCharset =
  ['a'..'z', 'A'..'Z', '0'..'9', ' ', '-', '_', '$', ' ', '.', '\', ':', '?',
    '=', '&', '/', '%', '~'];


implementation

uses
  omFileUtils
{$IFDEF Testing}
  , omTestMastery
  , omUtilsTestSuite
{$ENDIF}
  ;



{ TomUrl }

class function TomUrl.MakeURL(URL: String): TomURL;
begin
  if CompareText('file', Copy(URL, 1, 4)) = 0 then
  begin
    Result := TomFile.Create(Copy(URL, 5, Maxint));
  end
  else if CompareText('http', Copy(URL, 1, 4)) = 0 then
  begin
    Result := TomHTTP.Create(Copy(URL, 5, Maxint));
  end
  else if CompareText('ftp', Copy(URL, 1, 3)) = 0 then
  begin
    Result := TomFTP.Create(Copy(URL, 4, Maxint));
  end
  else if CompareText('afs', Copy(URL, 1, 3)) = 0 then
  begin
    Result := TomAFS.Create(Copy(URL, 4, Maxint));
  end
  else if CompareText('news', Copy(URL, 1, 4)) = 0 then
  begin
    Result := TomNews.Create(Copy(URL, 5, Maxint));
  end
  else if CompareText('nntp', Copy(URL, 1, 4)) = 0 then
  begin
    Result := TomNNTP.Create(Copy(URL, 5, Maxint));
  end
  else if CompareText('prospero', Copy(URL, 1, 8)) = 0 then
  begin
    Result := TomProspero.Create(Copy(URL, 9, Maxint));
  end
  else if CompareText('telnet', Copy(URL, 1, 6)) = 0 then
  begin
    Result := TomTelnet.Create(Copy(URL, 7, Maxint));
  end
  else if CompareText('gopher', Copy(URL, 1, 6)) = 0 then
  begin
    Result := TomGopher.Create(Copy(URL, 7, Maxint));
  end
  else if CompareText('wais', Copy(URL, 1, 4)) = 0 then
  begin
    Result := TomWAIS.Create(Copy(URL, 5, Maxint));
  end
  else if CompareText('mailto', Copy(URL, 1, 6)) = 0 then
  begin
    Result := TomMailTo.Create(Copy(URL, 7, Maxint));
  end
  else if CompareText('mid', Copy(URL, 1, 3)) = 0 then
  begin
    Result := TomMid.Create(Copy(URL, 4, Maxint));
  end
  else if CompareText('cid', Copy(URL, 1, 3)) = 0 then
  begin
    Result := TomCid.Create(Copy(URL, 4, Maxint));
  end
  else
  begin
    Result := TomFile.Create(URL);
  end;
end;

function TomUrl.FixSlash(Str: String): String;
begin
  Result := StringReplace(Str, '\', FSlash, [rfReplaceAll]);
  Result := StringReplace(Str, '/', FSlash, [rfReplaceAll]);
end;

{ TomHttp }

constructor TomHttp.Create(URL: String);
begin
  Create;
  Full := URL;
end;

constructor TomHttp.Create;
begin
  inherited Create;
  FQueries := TStringList.Create;
  Clear;
  FProtocol := 'http://';
  FSlash := '/';
end;

procedure TomHTTP.Clear;
begin
  FHost := '';
  FDomain := '';
  FDirectory := '';
  FName := '';
  FExtension := '';
  FQueries.Clear;
end;

destructor TomHTTP.Destroy;
begin
  FreeAndNil(FQueries);
  inherited;
end;

function TomHTTP.GetQuery(Index: Integer): String;
begin
  Result := FQueries.Strings[Index];
  Result := FixSlash(Result);
end;

function TomHTTP.GetQueries: TStringList;
begin
  Result := FQueries;
end;

function TomHTTP.GetQueryValue(Index: String): String;
begin
  Result := FQueries.Values[Index];
  Result := FixSlash(Result);
end;

function TomHTTP.GetURL: String;
var
  TempStr: String;
begin
  Result :=
    FProtocol +
    Server +
    FDirectory +
    Partial;
  if FQueries.Text <> '' then
  begin
    TempStr := FQueries.Text;
    TempStr := StringReplace(FQueries.Text, #13#10, '&', [rfReplaceAll]);
    if TempStr[Length(TempStr)] = '&' then
    begin
      System.Delete(TempStr, Length(TempStr), 1);
    end;
    Result := Result + '?' + TempStr;
  end;
  Result := FixSlash(Result);
  { TODO -omdc : Format the Queries list properly }
end;

function TomHTTP.GetPartial: String;
begin
  Result :=
    FName +
    '.' +
    FExtension;
  Result := FixSlash(Result);
end;

function TomHTTP.GetPath: String;
begin
  Result :=
    FProtocol +
    Server +
    FDirectory;
  Result := FixSlash(Result);
end;

function TomHTTP.GetServer: String;
begin
  Result :=
    FHost +
    '.' +
    FDomain;
  Result := FixSlash(Result);
end;

procedure TomHTTP.SetQuery(Index: Integer; const Value: String);
begin
  FQueries.Strings[Index] := Value;
end;

procedure TomHTTP.SetQueries(const Value: TStringList);
begin
  FreeAndNil(FQueries);
  FQueries := Value;
end;

procedure TomHTTP.SetDirectory(const Value: String);
begin
  FDirectory := AppendSlash(Value);
end;

procedure TomHTTP.SetDomain(const Value: String);
begin
  if Value = '' then
  begin
    FDomain := '\';
  end
  else
  begin
    FDomain := Value;
  end;
end;

procedure TomHTTP.SetExtension(const Value: String);
begin
  FExtension := Value;
  if Value = '' then
  begin
    FExtension := '\';
  end
  else
  begin
    FExtension := Value;
  end;
end;

procedure TomHTTP.SetURL(const Value: String);
var
  Index: integer;
  Buffer: String;
  QueryString: String;
begin
  Buffer := StringReplace(Value, '/', '\', [rfReplaceAll]);
  if not ValidURLString(Buffer) then
  begin
    raise Exception.Create(
      'TomHTTP.SetURL called with an invalid name: ''' +
      Buffer +
      ''''
      );
  end;

  if CompareText('http', Copy(Buffer, 1, 4)) = 0 then
  begin
    // its probably an http URL
    if ((Buffer[5] = ':') and
      (Buffer[6] = '\') and
      (Buffer[7] = '\')) then
    begin
      FProtocol := 'http:\\';
      System.Delete(Buffer, 1, 7);
    end
    else
    begin
      raise Exception.Create('Invalid Protocol: ' + Buffer);
    end;
  end
  else if CompareText('file', Copy(Buffer, 1, 4)) = 0 then
  begin
    // its probably a file url
    if ((Buffer[5] = ':') and
      (Buffer[6] = '\') and
      (Buffer[7] = '\')) then
    begin
      FProtocol := 'file:\\';
      System.Delete(Buffer, 1, 7);
    end
    else
    begin
      raise Exception.Create('Invalid Protocol: ' + Buffer);
    end;
  end
  else
  begin
    // default to http
    FProtocol := 'http:\\';
  end;

  Index := Pos('.', Buffer);
  if Index <> 0 then
  begin
    FHost := Copy(Buffer, 1, Index - 1);
    System.Delete(Buffer, 1, Index);
  end
  else
  begin
    raise Exception.Create('Missing Host');
  end;

  Index := Pos('\', Buffer);
  if Index <> 0 then
  begin
    FDomain := Copy(Buffer, 1, Index - 1);
    System.Delete(Buffer, 1, Index);
  end
  else
  begin
    raise Exception.Create('Missing Domain');
  end;

  Index := Pos('?', Buffer);
  if Index <> 0 then
  begin
    QueryString := Copy(Buffer, Index + 1, Maxint);
    System.Delete(Buffer, Index, Maxint);
  end;

  FDirectory := ExtractFilePath(Buffer);
  //  FDirectory := StripLeadingSlash(FDirectory);
  if (FDirectory <> '') and (FDirectory[1] <> '\') then
  begin
    FDirectory := '\' + FDirectory;
  end;

  SetPartial(Buffer);

  QueryString := StringReplace(QueryString, '&', #13#10, [rfReplaceAll]);
  QueryStrings.Text := QueryString;
end;

procedure TomHTTP.SetHost(const Value: String);
begin
  FHost := Value;
end;

procedure TomHTTP.SetName(const Value: String);
begin
  if not ValidNameString(Value) then
  begin
    raise Exception.Create(
      'TomHTTP.SetName called with an invalid name: ''' +
      Value +
      ''''
      );
  end;
  if Trim(Value) = '' then
  begin
    raise
      Exception.Create('Tried to set filename to an empty String (try "Clear")');
  end;
  FName := Value;
end;

procedure TomHTTP.SetPartial(const Value: String);
var
  Index: Integer;
begin
  FName := ExtractFileName(Value);
  Index := LastDelimiter('.', FName);
  if (Index > 0) then
  begin
    SetLength(FName, Index - 1);
  end;

  FExtension := ExtractFileExt(Value);
  if (FExtension <> '') then
  begin
    if (FExtension[1] = '.') then
    begin
      System.Delete(FExtension, 1, 1);
    end;
  end;
end;

procedure TomHTTP.SetPath(const Value: String);
var
  Index: integer;
  Buffer: String;
  QueryString: String;
begin
  Buffer := StringReplace(Value, '/', '\', [rfReplaceAll]);
  if not ValidURLString(Buffer) then
  begin
    raise Exception.Create(
      'TomHTTP.SetPath called with an invalid name: ''' +
      Buffer +
      ''''
      );
  end;

  if CompareText('http', Copy(Buffer, 1, 4)) = 0 then
  begin
    // its probably an http URL
    if ((Buffer[5] = ':') and
      (Buffer[6] = '\') and
      (Buffer[7] = '\')) then
    begin
      FProtocol := 'http:\\';
      System.Delete(Buffer, 1, 7);
    end
    else
    begin
      raise Exception.Create('Invalid Protocol: ' + Buffer);
    end;
  end
  else if CompareText('file', Copy(Buffer, 1, 4)) = 0 then
  begin
    // its probably a file url
    if ((Buffer[5] = ':') and
      (Buffer[6] = '\') and
      (Buffer[7] = '\')) then
    begin
      FProtocol := 'file:\\';
      System.Delete(Buffer, 1, 7);
    end
    else
    begin
      raise Exception.Create('Invalid Protocol: ' + Buffer);
    end;
  end
  else
  begin
    // default to http
    FProtocol := 'http:\\';
  end;

  if FProtocol = 'http:\\' then
  begin
    Index := Pos('.', Buffer);
    if Index <> 0 then
    begin
      FHost := Copy(Buffer, 1, Index - 1);
      System.Delete(Buffer, 1, Index);
    end
    else
    begin
      raise Exception.Create('Missing Host');
    end;

    Index := Pos('\', Buffer);
    if Index <> 0 then
    begin
      FDomain := Copy(Buffer, 1, Index - 1);
      System.Delete(Buffer, 1, Index);
    end
    else
    begin
      raise Exception.Create('Missing Domain');
    end;

    Index := Pos('?', Buffer);
    if Index <> 0 then
    begin
      QueryString := Copy(Buffer, Index + 1, Maxint);
      System.Delete(Buffer, Index, Maxint);
    end;

    FDirectory := Buffer;
    if (FDirectory <> '') and (FDirectory[1] <> '\') then
    begin
      FDirectory := '\' + FDirectory;
    end;
    FDirectory := AppendSlash(FDirectory);
  end
  else if FProtocol = 'file:\\' then
  begin

  end;
end;

procedure TomHTTP.SetServer(const Value: String);
var
  Buffer: String;
  Index: integer;
begin
  Buffer := Value;
  Index := Pos('.', Buffer);
  if Index <> 0 then
  begin
    FHost := Copy(Buffer, 1, Index - 1);
    System.Delete(Buffer, 1, Index);
  end
  else
  begin
    raise Exception.Create('Missing Host');
  end;

  Index := Pos('\', Buffer);
  if Index <> 0 then
  begin
    FDomain := Copy(Buffer, 1, Index - 1);
    System.Delete(Buffer, 1, Index);
  end
  else
  begin
    raise Exception.Create('Missing Domain');
  end;

end;

function TomHTTP.GetQueryString: String;
begin
  Result := StringReplace(FQueries.Text, #13#10, '&', [rfReplaceAll]);
end;

procedure TomHTTP.SetQueryString(const Value: String);
begin
  FQueries.Text := StringReplace(Value, '&', #13#10, [rfReplaceAll]);
end;

procedure TomHttp.SetHostPort(const Value: String);
var
  Index: integer;
begin
  Index := Pos(':', Value);
  if Index = 0 then
  begin
    FHost := Value;
    FPort := '80';
  end
  else
  begin
    FHost := Copy(Value, 1, Index);
    FPort := Copy(Value, Index, Maxint);
  end;
end;

function TomHttp.GetHostPort: String;
begin
  Result := FHost + ':' + FPort;
end;

{ TomFtp }

constructor TomFtp.Create(URL: String);
begin
  inherited Create;
  raise Exception.Create('Not implemented yet');
  FSlash := '/';
end;

function TomFtp.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomFtp.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomAfs }

constructor TomAfs.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomAfs.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomAfs.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomNews }

constructor TomNews.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomNews.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomNews.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomNntp }

constructor TomNntp.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomNntp.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomNntp.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomProspero }

constructor TomProspero.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomProspero.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomProspero.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomTelnet }

constructor TomTelnet.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomTelnet.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomTelnet.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomGopher }

constructor TomGopher.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomGopher.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomGopher.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomWais }

constructor TomWais.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomWais.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomWais.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomMailto }

constructor TomMailto.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
end;

function TomMailto.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomMailto.SetHostname(const Value: String);
begin
  FHostname := Value;
end;

procedure TomMailto.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TomMailto.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomMid }

constructor TomMid.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomMid.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomMid.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomCid }

constructor TomCid.Create(URL: String);
begin
  inherited Create;
  FSlash := '/';
  raise Exception.Create('Not implemented yet');
end;

function TomCid.GetURL: String;
begin
  raise Exception.Create('Not implemented yet');
end;

procedure TomCid.SetURL(const Value: String);
begin
  raise Exception.Create('Not implemented yet');
end;

{ TomFile }

constructor TomFile.Create(URL: String);
begin
  Create;
  Full := URL;
end;

constructor TomFile.Create;
begin
  inherited;
  Clear;
  FProtocol := 'file://';
  FSlash := '\';
end;

procedure TomFile.Clear;
begin
  FDrive := '';
  FDirectory := '';
  FName := '';
  FExtension := '';
  FDrive := '';
end;

procedure TomFile.Delete;
begin
  if not DeleteFile(Full) then
  begin
    raise Exception.Create('Can''t delete ' + Full);
  end;
end;

function TomFile.GetExists: Boolean;
begin
  Result := FileExists(Full);
end;

function TomFile.GetURL: String;
begin
  Result :=
    FDrive +
    FDirectory +
    GetPartial;
  Result := FixSlash(Result);
end;

function TomFile.GetPartial: String;
begin
  Result := FName;
  if FExtension <> '' then
  begin
    Result := Result + '.' + FExtension;
  end;
  Result := FixSlash(Result);
end;

function TomFile.GetPath: String;
begin
  Result :=
    FDrive +
    FDirectory;
  Result := FixSlash(Result);
end;

function TomFile.GetFull: String;
begin
  if FDrive <> '' then
  begin
    // it's fully defined
    Result :=
      FDrive +
      FDirectory +
      GetPartial;
  end
  else
  begin
    // it's a relative pathname
    Result :=
      FDirectory +
      GetPartial;
  end;
  Result := FixSlash(Result);
end;

procedure TomFile.SetURL(const Value: String);
begin
  //  FURL:= FProtocol + Full;
end;

procedure TomFile.SetFULL(const Value: String);
var
  Index: integer;
  Buffer: String;
begin
  Buffer := Value;
  Buffer := FixSlash(Buffer);
  // todo - mdc, this line should appear anywhere a '/' could be
  if not ValidFullString(Buffer) then
  begin
    raise Exception.Create(
      'TomFile.SetFull called with an invalid file name: ''' +
      Buffer +
      ''''
      );
  end;

  if (Length(Buffer) > 0) and (Buffer[1] = '\') then
  begin
    // its a UNC name
    if Buffer[1] = '\' then
    begin
      if Buffer[2] = '\' then
      begin
        Index := Pos('\', Copy(Buffer, 3, Maxint));
        if Index = 0 then
        begin
          Index := Length(Buffer);
        end;
        FDrive := Copy(Buffer, 1, Index + 1);
        System.Delete(Buffer, 1, Index + 2);
      end;
    end;
  end
  else
  begin
    // its an x: name
    FDrive := ExtractFileDrive(Buffer);
    Index := Pos(':', Buffer);
    if (Index > 0) then
    begin
      System.Delete(Buffer, 1, Index);
    end;
  end;

  FDirectory := ExtractFilePath(Buffer);
  if (FDirectory <> '') and (not (FDirectory[1] in ['\', '.'])) then
  begin
    FDirectory := '\' + FDirectory;
  end;

  FName := ExtractFileName(Buffer);
  Index := LastDelimiter('.', FName);
  if (Index > 0) then
  begin
    SetLength(FName, Index - 1);
  end;

  FExtension := ExtractFileExt(Buffer);
  if (FExtension <> '') then
  begin
    if (FExtension[1] = '.') then
    begin
      System.Delete(FExtension, 1, 1);
    end;
  end;
end;

procedure TomFile.SetPartial(const Value: String);
var
  Index: Integer;
  Buffer: String;
begin
  if not ValidPartialString(Value) then
  begin
    raise Exception.Create('TomFile.SetPath called an invalid name: ''' +
      Value +
      ''''
      );
  end;

  Buffer := Value;

  FName := ExtractFileName(Buffer);
  Index := LastDelimiter('.', FName);
  if (Index > 0) then
  begin
    SetLength(FName, Index - 1);
  end;

  FExtension := ExtractFileExt(Buffer);
  if (FExtension <> '') then
  begin
    if (FExtension[1] = '.') then
    begin
      System.Delete(FExtension, 1, 1);
    end;
  end;
end;

procedure TomFile.SetPath(const Value: String);
var
  Index: Integer;
  Buffer: String;
begin
  if not ValidPathString(Value) then
  begin
    raise Exception.Create(
      'TomFile.SetPath called with an invalid name: ''' +
      Value +
      '(1)'''
      );
  end;

  if Value = '' then
  begin
    FDrive := '';
    FDirectory := '/';
    Exit;
  end;

  Buffer := Value;
  FDrive := ExtractFileDrive(Buffer);
  Index := Pos(':', Buffer);
  if (Index = 2) then
  begin
    System.Delete(Buffer, 1, Index);
  end
  else
  begin
    raise Exception.Create('TomFile.SetPath called an invalid name: ''' +
      Value +
      '(2)'''
      );
  end;

  FDirectory := AppendSlash(Buffer);
end;

procedure TomFile.ChDir(NewDirectory: String);
begin
  if (NewDirectory[1] = '.') and (NewDirectory[2] = FSlash) then
  begin
    System.Delete(NewDirectory, 1, 2);
  end;

  if NewDirectory[1] = FSlash then
  begin
    Directory := NewDirectory;
  end
  else
  begin
    while
      (NewDirectory <> '') and
      (NewDirectory[1] = '.') and
      (NewDirectory[2] = '.') do
    begin
      System.Delete(NewDirectory, 1, 2);
      if FDirectory[Length(FDirectory)] = FSlash then
      begin
        System.Delete(FDirectory, Length(FDirectory), 1);
      end;

      while FDirectory[Length(FDirectory)] <> FSlash do
      begin
        System.Delete(FDirectory, Length(FDirectory), 1);
      end;
      if (NewDirectory <> '') and (NewDirectory[1] = FSlash) then
      begin
        System.Delete(NewDirectory, 1, 1);
      end;
    end;

    AppendSlash(Directory);
    Directory := FDirectory + NewDirectory;
    AppendSlash(Directory);
  end;

end;


// _____________________________________________________________________________
{**
  MakeDirectory creates a new directory

  @param Result:boolean True if the directory now exists, false otherwise
}

function TomFile.MakeDirectory: Boolean;
begin
  Result := omFileUtils.MakeDirectory(Path);
end;

procedure TomFile.SetDrive(const Value: String);
var
  TempString: String;
  AChar: char;
begin
  // first try a UNC file name
  if Value[1] = '\' then
  begin
    if Value[2] = '\' then
    begin
      if Pos('\', Copy(Value, 3, Maxint)) <> -1 then
      begin
        FDrive := ExcludeTrailingPathDelimiter(Value);
        Exit;
      end;
    end;
  end;

  // if it's not, try a normal file name
  case Length(Value) of
    0:
      begin
        TempString := '';
      end;
    1:
      begin
        TempString := Value;
      end;
    2:
      begin
        if Value[2] = ':' then
        begin
          TempString := Value[1];
        end
        else
        begin
          // invalid
          TempString := '@';
        end;
      end;
  else
    begin
      // invalid
      TempString := '@';
    end;
  end;

  if TempString = '' then
  begin
    FDrive := '';
  end
  else
  begin
    AChar := TempString[1];
    if (((AChar >= 'A') and (AChar <= 'Z')) or
      ((AChar >= 'a') and (AChar <= 'z'))
      ) then
    begin
      FDrive := AChar + ':';
    end
    else
    begin
      raise Exception.Create(
        'TomFile.SetDrive called with an invalid drive name: '''
        + Value
        + ''''
        );
    end;
  end;
end;

procedure TomFile.SetDirectory(const Value: String);
begin
  FDirectory := AppendSlash(Value);
end;

procedure TomFile.SetName(const Value: String);
begin
  if not ValidNameString(Value) then
  begin
    raise Exception.Create(
      'TomFile.SetFull called with an invalid name: ''' +
      Value +
      ''''
      );
  end;
  if Trim(Value) = '' then
  begin
    raise
      Exception.Create('Tried to set filename to an empty String (try "Clear")');
  end;
  FName := Value;
end;

// _____________________________________________________________________________
{**
  Append a slash to a String, but only if there isn't one there already.

  @param Str:String The String to which to append the slash
  @param Result: String The String that ends in a slash
}

function AppendSlash(const Str: String; const Slash: char = '\'): String;
var
  Buffer: String;
begin
  Buffer := Str;
  if Buffer = '' then
  begin
    Buffer := Slash;
  end
  else
  begin
    if (Buffer[Length(Buffer)] <> Slash) then
    begin
      Buffer := Buffer + Slash;
    end;
  end;
  Result := Buffer;
end; { AppendSlash }

// _____________________________________________________________________________
{**
  ValidCharString returns true if the String contains only characters from a set
  @param Str:String The String to check
  @param CharSet: Set of char the allowed characters
  @param Result:boolean True if the String contains only valid characters
}

function ValidCharString(const Str: String; const Charset: TCharSet): boolean;
var
  Index: integer;
begin
  Result := True;
  for Index := 1 to Length(Str) do
  begin
    if not (Str[Index] in CharSet) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

// _____________________________________________________________________________
{**
  ValidNameString returns true if the String contains only characters
  valid in a file name

  @param Str:String The String to check
  @param Result:boolean True if the String contains only valid characters
}

function ValidNameString(const Str: String): boolean;
begin
  Result := ValidCharString(Str, ValidNameChars);
end;

// _____________________________________________________________________________
{**
  ValidPartialString returns true if the String contains only characters
  valid in a partial name (i.e. 'name.ext')

  @param Str:String The String to check
  @param Result:boolean True if the String contains only valid characters
}

function ValidPartialString(const Str: String): boolean;
begin
  Result := ValidCharString(Str, ValidPartialChars);
end;


// _____________________________________________________________________________
{**
  ValidPathString returns true if the String contains only characters
  valid in a path name (i.e. '\fred\joe\harry\')

  @param Str:String The String to check
  @param Result:boolean True if the String contains only valid characters
}

function ValidPathString(const Str: String): boolean;
begin
  Result := ValidCharString(Str, ValidPathChars);
end;


// _____________________________________________________________________________
{**
  ValidFullString returns true if the String contains only characters
  valid in a full file name (i.e. 'c:\fred\joe\harry\name.ext')

  @param Str:String The String to check
  @param Result:boolean True if the String contains only valid characters
}

function ValidFullString(const Str: String): boolean;
begin
  Result := ValidCharString(Str, ValidFullChars);
end;



// _____________________________________________________________________________
{**
  ValidURLString returns true if the String contains only characters
  valid in a full file name (i.e. 'c:\fred\joe\harry\name.ext')

  @param Str:String The String to check
  @param Result:boolean True if the String contains only valid characters
}

function ValidURLString(const Str: String): boolean;
begin
  Result := ValidCharString(Str, ValidURLChars);
end;


// ============================================================================
// Testing

{$IFDEF Testing}

type
  TomTestSuiteURLs = class(TomTestSuite)
  published
    procedure Test_DefaultFactory;
    procedure Test_FileFactory;
    procedure Test_FilenameFunctionality;
    procedure Test_HTTPFactory;
    procedure Test_HTTPFunctionality;
    procedure Test_MiscFunctionality;

  end;

  // ____________________________________________________________________________
  // Misc testing

procedure TomTestSuiteURLs.Test_MiscFunctionality;
begin

end;

// ____________________________________________________________________________
// Assert factory functionality

procedure TomTestSuiteURLs.Test_HTTPFactory;
var
  URL: TomURL;
begin
  URL := TomURL.MakeURL('http:\\www.objectmastery.com\default.html');
  Assert(URL is TomHTTP, 'MakeURL');
  Assert(URL.Protocol = 'http:\\', 'MakeURL');
  FreeAndNil(URL);
end;

procedure TomTestSuiteURLs.Test_FileFactory;
var
  URL: TomURL;
begin
  URL := TomURL.MakeURL('file:\\C:\Harry\Joe\Fred.exe');
  Assert(URL is TomFile, 'MakeURL');
  Assert(URL.Protocol = 'file://', 'MakeURL');
  FreeAndNil(URL);
end;

procedure TomTestSuiteURLs.Test_DefaultFactory;
var
  URL: TomURL;
begin
  // default (file) factory
  URL := TomURL.MakeURL('C:\Harry\Joe\Fred.exe');
  Assert(URL is TomFile, 'MakeURL');
  Assert(URL.Protocol = 'file://', 'MakeURL');
  FreeAndNil(URL);
end;

// ____________________________________________________________________________
{
     (1) Given the URL 'C:\Harry\Joe\Fred.exe':
         Mode      = nmFile
         Protocol  = 'file:\\'
         Drive     = 'C'
         Directory = '\Harry\Joe\'
         Name      = 'Fred'
         Extension = 'exe'
         Path      = 'C:\Harry\Joe\'
         Partial   = 'Fred.exe'
         Full      = 'C:\Harry\Joe\Fred.exe'
         URL       = 'file:\\C|\Harry\Joe\Fred.exe

     (2) Given the URL '\\mymachine\Harry\Joe\Fred.exe':
         Mode      = nmUNC
         Protocol  = 'file:\\'
         Server    = '\\mymachine\
         Directory = '\Harry\Joe\'
         Name      = 'Fred'
         Extension = 'exe'
         Path      = '\\mymachine\Harry\Joe\'
         Partial   = 'Fred.exe'
         Full      = '\\mymachine\Harry\Joe\Fred.exe'

     (3) Given the URL 'C:\Harry\Joe\Fred.exe':
        ChDir('Geoff')  => 'C:\Harry\Joe\Geoff\Fred.exe':
        ChDir('..')  => 'C:\Harry\Joe\Fred.exe':
        ChDir('..\Nigel')  => 'C:\Harry\Nigel\Fred.exe':
        Chdir('\') => 'C:\Fred.exe':
        Chdir('\George') => 'C:\George\Fred.exe':

}

procedure TomTestSuiteURLs.Test_FilenameFunctionality;
var
  Filename: TomFileName;
begin
  Filename := TomFileName.Create;
  try
    Filename.Full := 'C:\temp\hello.dat';
    Assert(Filename.Drive = 'C:', 'GetDrive');
    Filename.Drive := 'X';
    Assert(Filename.Full = 'X:\temp\hello.dat', 'SetDrive');
    try
      Filename.Drive := '&**^';
      Assert(False, 'SetDrive');
    except
      ;
    end;

    Filename.Full := '\\mymachine\temp\hello.dat';
    Assert(Filename.Drive = '\\mymachine', 'GetDrive');
    Filename.Drive := '\\yourmachine';

    Assert(
      Filename.Directory = '\temp\',
      'Drive returned"' + Filename.Directory + '", expecting "\temp\"'
      );

    Assert(Filename.Full = '\\yourmachine\temp\hello.dat', 'SetDrive');

    // check path and directory
    Filename.Full := 'C:\temp\hello.dat';
    Assert(Filename.Path = 'C:\temp\', 'GetPath');
    Assert(Filename.Directory = '\temp\', 'GetDirectory');

    Filename.Path := 'X:\bye\';
    Assert(Filename.Full = 'X:\bye\hello.dat', 'SetPath');

    Filename.Directory := '\goodbye\';
    Assert(Filename.Full = 'X:\goodbye\hello.dat', 'SetDirectory');

    Filename.Directory := '';
    Assert(Filename.Full = 'X:\hello.dat', 'SetDirectory');

    Filename.Full := 'C:\temp\hello.dat';
    Assert(Filename.Partial = 'hello.dat', 'GetPartial');
    Assert(Filename.Name = 'hello', 'GetName');
    Assert(Filename.Extension = 'dat', 'GetExtension');

    // Set name
    Filename.Name := 'GoodBye';
    Assert(Filename.Full = 'C:\temp\GoodBye.dat', 'SetName');
    try
      Filename.Name := '';
      Assert(False, 'SetName');
    except
      ;
    end;

    // set extension
    Filename.Extension := 'fred';
    Assert(Filename.Full = 'C:\temp\GoodBye.fred', 'SetExtension');

    Filename.Extension := '';
    Assert(Filename.Full = 'C:\temp\GoodBye', 'SetExtension');

    // set Partial
    Filename.Partial := 'aaa.bbb';
    Assert(Filename.Full = 'C:\temp\aaa.bbb', 'SetPartial');

    Filename.Partial := '';
    Assert(Filename.Full = 'C:\temp\', 'SetPartial');
    Assert(Filename.Partial = '', 'GetPartial');

    Filename.Clear;
    Assert(Filename.Full = '', 'Clear');

    // Assert absolute names
    Filename.Full := '..\temp\hello.dat';
    Assert(Filename.Drive = '', 'Absolute Drive Failed');
    Assert(Filename.Path = '..\temp\', 'Absolute Path Failed');


    Filename.Full := 'C:\Harry\Joe\Fred.exe';

    Filename.ChDir('Geoff');
    Assert(Filename.Full = 'C:\Harry\Joe\Geoff\Fred.exe');

    Filename.ChDir('..');
    Assert(Filename.Full = 'C:\Harry\Joe\Fred.exe');

    Filename.ChDir('..\Nigel');
    Assert(Filename.Full = 'C:\Harry\Nigel\Fred.exe');

    Filename.Chdir('\');
    Assert(Filename.Full = 'C:\Fred.exe');

    Filename.Chdir('\George');
    Assert(Filename.Full = 'C:\George\Fred.exe');


    Filename.Full := 'C:\Harry\Joe\A\B\C\D\Fred.exe';
    Filename.ChDir('..\..\..\..');
    Assert(Filename.Full = 'C:\Harry\Joe\Fred.exe');

    Filename.Full := 'C:\Harry\Joe\A\B\C\D\Fred.exe';
    Filename.ChDir('..\..\..\..\Peter');
    Assert(Filename.Full = 'C:\Harry\Joe\Peter\Fred.exe');


  finally
    FreeAndNil(Filename);
  end;
end;

// ____________________________________________________________________________
{   Given the URL 'http:\\www.n1.om.com\stuff\Harry.cfm?Joe=1&Fred=2':
       Protocol  = 'http:\\'
       Host      = 'www'
       Domain    = 'n1.om.com'
       Directory = '\stuff\'
       Name      = 'Harry'
       Extension = 'cfm'

       Server    = www.n1.om.com
       Path      = 'http:\\www.n1.om.com\stuff\'
       Partial   = 'Harry.cfm'
       Full      = 'http:\\www.n1.om.com\stuff\Harry.cfm?Joe=1&Fred=x%20x'
       QueryStrings = 'Joe=1&Fred=2'
       Query[0] = Joe=1
       Query[1] = Fred=x x
}

procedure TomTestSuiteURLs.Test_HTTPFunctionality;
var
  HttpName: TomHttp;
begin
  HttpName := TomHttp.Create;
  try
    HttpName.Full := 'http:\\www.n1.om.com\stuff\Harry.cfm?Joe=1&Fred=x x';
    Assert(HttpName.Protocol = 'http:\\', 'GetProtocol');
    Assert(HttpName.Host = 'www', 'GetHost');
    Assert(HttpName.Domain = 'n1.om.com', 'GetDomain');
    Assert(HttpName.Directory = '\stuff\', 'GetDirectory');
    Assert(HttpName.Name = 'Harry', 'GetName');
    Assert(HttpName.Extension = 'cfm', 'GetExtension');
    Assert(HttpName.Server = 'www.n1.om.com', 'GetServer');
    Assert(HttpName.Path = 'http:\\www.n1.om.com\stuff\', 'GetPath');
    Assert(HttpName.Partial = 'Harry.cfm', 'GetPartial');
    Assert(HttpName.QueryStrings.Text = 'Joe=1'#13#10'Fred=x x'#13#10,
      'QueryStrings');
    Assert(HttpName.Full =
      'http:\\www.n1.om.com\stuff\Harry.cfm?Joe=1&Fred=x x',
      'GetFull');
    Assert(HttpName.Query[0] = 'Joe=1', 'GetQuery');
    Assert(HttpName.Query[1] = 'Fred=x x', 'GetQuery');
  finally
    FreeAndNil(HttpName);
  end;
end;

{$ENDIF}


initialization
{$IFDEF Testing}
  //  TomTestURLs.Create('omURLs', G_UtilsTestSuite);
  TomTestMastery.RegisterTestSuite(TomTestSuiteURLs,
    TomTestSuiteUtils_Unit_Tests);
{$ENDIF}
end.
