{

$Id: uFinderGlobals.pas,v 1.20 2004/05/05 22:22:26 slide Exp $

Description:

Global functions, procedures, constants and resources for the Amazon Product
Finder. This unit contains code snippets that have been hanging around
long time and until I have more time the proper props will be mentioned.
Directory and file related functions are probably from syn project.

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

unit uFinderGlobals;

interface

uses
  Windows, Dialogs, Forms, StdCtrls, SysUtils, FileCtrl, IniFiles,
  Registry, ShellAPI, Classes, Messages, ShlObj;

function ExecuteFile(const AFileName, AParams, ADefaultDir: string; AShowCmd:
  integer): THandle;
function BrowseDialogCallBack
  (Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM):
  integer stdcall;
procedure ShowErrorMessage(const AValue: string);
function URLEncode(const AValue: string): string;
function ConvertAmount(AAmount: real; ARate: real): real;
function DirExists(const ADir: string): boolean;
function MakePath(APath: string): boolean;
function FileDateToTime(const AFileName: string): System.TDateTime;
function GetVersionString(AFileName: string; AVerStr: string): string;
function GetProxySettingsFromIE(var AHost: string; var APort: integer; var
  AProxyEnabled: boolean): boolean;
procedure ClearStrListObjs(AStringList: TStringList);
function BrowseDialog(const Title: string; const Flag: integer): string;
function GetResourceStream(const Name: string): TMemoryStream;
function GetResourceText(const Name: string): string;
function GetTempDir: string;
procedure DumpLog(AValue: string);
function FormatResultPage(AResultPage: integer): string;
function GetFileName(AValue: string): string;

const

  {---------------------------------------------------------------------------}
  { Search Request Default Delay }

  RequestDelay = 5000;
  UpdateDelay = 10000;

  {---------------------------------------------------------------------------}
  { Program's statusbar panels }

  MessagePanel = 0;
  SearchPanel = 1;
  InfoPanel = 2;

  {---------------------------------------------------------------------------}
  { Directory locations }

  UserDir = '.AmazonProductFinder';
  DataDir = 'Data';
  CacheDir = 'Cache\';
  ImageDir = CacheDir + 'Images\';
  ExportDir = 'Export';
  BooksCacheDir = CacheDir + 'Books\';
  DvdCacheDir = CacheDir + 'DVD\';
  MagsCacheDir = CacheDir + 'Magazines\';
  MusicCacheDir = CacheDir + 'Music\';
  GamesCacheDir = CacheDir + 'Videogames\';

  {---------------------------------------------------------------------------}
  { Registry keys }

  RegKey = 'Software\Amazon Product Finder';

  {---------------------------------------------------------------------------}
  { Configuration files }

  DefaultSearchFile = 'search.xml';
  DefaultCategories = DataDir + '\FinderCategories.xml';
  DefaultConfig = DataDir + '\FinderConfig.xml';
  DefaultHistory = DataDir + '\FinderHistory.xml';

  {---------------------------------------------------------------------------}
  { Export stylesheet configuration files }
  // TODO: use resource streams
  DefaultHtmlExport = ExportDir + '\HtmlExport.xsl';
  DefaultTextExport = ExportDir + '\TextExport.xsl';
  DefaultCsvExport = ExportDir + '\CsvExport.xsl';
  DefaultTabExport = ExportDir + '\TabExport.xsl';
  DefaultUieeExport = ExportDir + '\UieeExport.xsl';

  {---------------------------------------------------------------------------}
  { File extensions }

  XMLFileExt = '.xml';
  XSLFileExt = '.xsl';
  JPGFileExt = '.jpg';
  HBFileExt = '.txt';
  TABFileExt = '.tab';
  CSVFileExt = '.csv';
  UIEEFileExt = '.msg';
  ZIPFileExt = '.zip';

  {---------------------------------------------------------------------------}
  { Currencies - as of 08.03.2004 }
  // DONE: use uFinderCurrency
  USDInEUR = 1.2192;
  JPYInEUR = 135.50;
  GBPInEUR = 0.67040;

  {---------------------------------------------------------------------------}
  { Search update thread }

  WM_UPDATE_NEXT_FILE = WM_USER + 1;
  WM_THREAD_DONE = WM_USER + 2;
  WM_UPDATE_ABORT = WM_USER + 3;

type

  TAmazonURL = record
    SearchBy: string;
    SearchText: string;
    SearchMode: string;
  end;

type

  TSearchType = (stBooks, stDVD, stMusic, stMagazines, stVideogames);

implementation

{-----------------------------------------------------------------------------}
{- uFinderGlobals -}

uses

  frmMain;

{-----------------------------------------------------------------------------}
{**
  Executes the given file with parameters and in a directory specified.
  @param AFileName
  @param AParams
  @param ADefaultDir
  @param AShowCmd
  @return The handle for the file.
}

function ExecuteFile(const AFileName, AParams, ADefaultDir: string; AShowCmd:
  integer): THandle;
var
  n, p, d: array[0..79] of char;
begin
  Result := ShellExecute(Application.Handle, nil,
    StrPCopy(n, AFileName), StrPCopy(p, AParams),
    StrPCopy(d, ADefaultDir), AShowCmd);
end;

{-----------------------------------------------------------------------------}
{**

  @param Wnd
  @param uMsg
  @param lParam
  @param lpData
  @return
}

function BrowseDialogCallBack
  (Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM):
  integer stdcall;
var
  wa, rect: TRect;
  dialogPT: TPoint;
begin
  if uMsg = BFFM_INITIALIZED then
  begin
    wa := Screen.WorkAreaRect;
    GetWindowRect(Wnd, Rect);
    dialogPT.X := ((wa.Right - wa.Left) div 2) -
      ((rect.Right - rect.Left) div 2);
    dialogPT.Y := ((wa.Bottom - wa.Top) div 2) -
      ((rect.Bottom - rect.Top) div 2);
    MoveWindow(Wnd,
      dialogPT.X,
      dialogPT.Y,
      Rect.Right - Rect.Left,
      Rect.Bottom - Rect.Top,
      True);
  end;
  Result := 0;
end;

{-----------------------------------------------------------------------------}
{**
  Shows a error message to the user.
  @param AValue The error message.
}

procedure ShowErrorMessage(const AValue: string);
begin
  MessageDlg(AValue, mtError, [mbOK], 0);
end;

{-----------------------------------------------------------------------------}
{**
  URL encodes the parameter string.
  @param AValue the parameter
  @return Encoded parameter.
}

function URLEncode(const AValue: string): string;
var
  s: string;
  i: integer;
begin
  s := '';
  for i := 1 to Length(AValue) do
  begin
    case AValue[i] of
      '0'..'9', 'A'..'Z', 'a'..'z':
        s := s + AValue[i];
    else
      s := s + Format('%%%2.2X', [Ord(AValue[i])]);
    end;
  end;
  result := s;
end;

{-----------------------------------------------------------------------------}
{**

  @param AAmount
  @param ARate
  @return
}

function ConvertAmount(AAmount: real; ARate: real): real;
begin
  result := AAMount * ARate;
end;

{-----------------------------------------------------------------------------}
{**

  @param AFileName
  @return
}

function FileDateToTime(const AFileName: string): System.TDateTime;
begin
  result := FileDateToDateTime(FileAge(AFileName));
end;

{-----------------------------------------------------------------------------}
{**

  @param ADir
  @return
}

function DirExists(const ADir: string): boolean;
var
  h: THandle;
  wfd: TWin32FindData;
begin
  h := FindFirstFile(PChar(ADir), wfd);
  if h <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(h);
    result := ((wfd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0);
  end
  else
    result := false;
end;

{-----------------------------------------------------------------------------}
{**

  @param APath
  @return
}

function MakePath(APath: string): boolean;
begin
  result := True;
  if APath = '' then
    Exit;
  APath := ExcludeTrailingBackslash(APath);
  if (Length(APath) < 3) or DirExists(APath)
    or (ExtractFilePath(APath) = APath) then
    Exit;
  result := MakePath(ExtractFilePath(APath)) and CreateDir(APath);
end;

{-----------------------------------------------------------------------------}
{**

  @param AFileName
  @param AVerStr
  @return
}

function GetVersionString(AFileName: string; AVerStr: string): string;
var
  Size: DWORD;
  Handle: DWORD;
  Len: UINT;
  Buffer: PChar;
  Value: PChar;
  TransNo: PLongInt;
  SFInfo: string;
begin
  result := '';
  Size := GetFileVersionInfoSize(PChar(AFileName), Handle);
  if Size > 0 then
  begin
    Buffer := AllocMem(Size);
    try
      GetFileVersionInfo(PChar(AFileName), 0, Size, Buffer);
      VerQueryValue(Buffer, PChar('VarFileInfo\Translation'),
        Pointer(TransNo), Len);
      SFInfo := Format('%s%.4x%.4x%s%s%', ['StringFileInfo\',
        LoWord(TransNo^), HiWord(Transno^), '\', AVerStr]);
      if VerQueryValue(Buffer, PChar(SFInfo),
        Pointer(Value), Len) then
        result := Value;
    finally
      { always release memory }
      if Assigned(Buffer) then
        FreeMem(Buffer, Size);
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param AHost
  @param APort
  @param AProxyEnabled
  @return
}

function GetProxySettingsFromIE(var AHost: string; var APort: integer; var
  AProxyEnabled: boolean): boolean;
var
  s, sporttmp: string;
  p: integer;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    AProxyEnabled := false;
    s := '';
    OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
      True);
    if ValueExists('ProxyServer') then
      s := ReadString('ProxyServer');

    if s <> '' then
    begin
      p := pos(':', s);
      if p = 0 then
        p := length(s) + 1;
      AHost := copy(s, 1, p - 1);
      try
        APort := StrToInt(copy(s, p + 1, 999));
      except
        APort := 80;
      end;
      AProxyEnabled := true;
    end;

    if ValueExists('ProxyEnable') then
    begin
      case GetDataType('ProxyEnable') of
        rdString,
          rdExpandString:
          begin
            sPortTmp := AnsiLowerCase(ReadString('ProxyEnable'));
            AProxyEnabled := true;
            if pos(' ' + sPortTmp + ' ', ' yes true t enabled 1 ') > 0 then
              AProxyEnabled := true
            else if pos(' ' + sPortTmp + ' ', ' no false f none disabled 0 ') > 0
              then
              AProxyEnabled := false
          end;
        rdInteger:
          begin
            AProxyEnabled := ReadBool('ProxyEnable');
          end;
        rdBinary:
          begin
            AProxyEnabled := true;
            ReadBinaryData('ProxyEnable', AProxyEnabled, 1);
          end;
      end;
    end;
    Free;
  end;
  result := s <> '';
end;

{-----------------------------------------------------------------------------}
{**

  @param AStringList
}

procedure ClearStrListObjs(AStringList: TStringList);
var
  i: integer;
  o: TObject;
begin
  for i := 0 to AStringList.Count - 1 do
  begin
    if (AStringList.Objects[i] <> nil) then
    begin
      o := TObject(AStringList.Objects[i]);
      o.Free();
      AStringList.Objects[i] := nil;
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Title
  @param Flag
  @return
}

function BrowseDialog(const Title: string; const Flag: integer): string;
var
  lpItemID: PItemIDList;
  BrowseInfo: TBrowseInfo;
  DisplayName: array[0..MAX_PATH] of char;
  TempPath: array[0..MAX_PATH] of char;
begin
  Result := '';
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  with BrowseInfo do
  begin
    hwndOwner := Application.Handle;
    pszDisplayName := @DisplayName;
    lpszTitle := PChar(Title);
    ulFlags := Flag;
    lpfn := BrowseDialogCallBack;
  end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := TempPath;
    GlobalFreePtr(lpItemID);
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Name
  @return
}

function GetResourceStream(const Name: string): TMemoryStream;
var
  R, Len: integer;
  P: Pointer;
begin
  R := FindResource(HInstance, PChar(Name), RT_RCDATA);
  Assert(R <> 0, 'GetResource: ' + Name);
  Len := SizeOfResource(HInstance, R);
  R := LoadResource(HInstance, R);
  P := LockResource(R);
  Result := TMemoryStream.Create;
  Result.SetSize(Len);
  Move(P^, Result.Memory^, Len);
  UnlockResource(R);
end;

{-----------------------------------------------------------------------------}
{**

  @param Name
  @return
}

function GetResourceText(const Name: string): string;
var
  s: TMemoryStream;
begin
  s := GetResourceStream(Name);
  try
    SetLength(Result, s.Size);
    Move(s.Memory^, Result[1], s.Size);
  finally
    s.Free;
  end;
end;

{------------------------------------------------------------------------------}
{**

  @return
}

function GetTempDir: string;
var
  Buffer: array[0..MAX_PATH] of char;
begin
  GetTempPath(Sizeof(Buffer), Buffer);
  result := Buffer;
  if result[Length(result)] <> '\' then
    result := result + '\';
end;

{------------------------------------------------------------------------------}
{**

  @param AValue
}

procedure DumpLog(AValue: string);
var
  LogFile: TextFile;
  FileName: string;
begin
  FileName := ExtractFilePath(Application.ExeName) + '.log';
  AssignFile(LogFile, FileName);
  if FileExists(FileName) then
    Append(LogFile)
  else
    Rewrite(LogFile);
  Writeln(LogFile, DateTimeToStr(Now) + ' : ' + AValue);
  CloseFile(LogFile);
end;

{------------------------------------------------------------------------------}
{**
  Formats the given search result page to conform the specified filename
  structure.
  @param AResultPage The search page number.
  @return Formated name for the search result page.
}

function FormatResultPage(AResultPage: integer): string;
var
  i: integer;
begin

  Str(AResultPage: 2, Result);

  try
    for i := 0 to 2 - 1 do
    begin
      if (Result[i] <> ' ') then
        break;
      Result[i] := '0';
    end;
  finally
  end;
  Now
end;

{------------------------------------------------------------------------------}
{**

  @param AValue
  @return
}

function GetFileName(AValue: string): string;
begin
  result := ExtractFileName(AValue);
  if ExtractFileExt(AValue) <> '' then
    result := Copy(ExtractFileName(AValue), 1, Pos(ExtractFileExt(AValue),
      ExtractFileName(AValue)) - 1);
end;

end.
