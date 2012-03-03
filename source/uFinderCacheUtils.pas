{

$Id: uFinderCacheUtils.pas,v 1.6 2004/05/04 19:17:19 slide Exp $

Description:

Cache procedures and functions for the Amazon Product Finder.

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

unit uFinderCacheUtils;

interface

uses
  Classes, XMLIntf, XMLDoc, SysUtils, uFinderGlobals;

const

  MaxAge = 1; // TODO: mikäs tämä oli?

procedure LoadSearch(const AXmlDocument: IXMLDocument; const ACacheDir,
  AFileName: string; AExpireTime: integer);
procedure DeleteOldSearches(AExpireTime: integer);
procedure AddFile(const AFileName: string; const AFiles: TStrings);
procedure AddDirectory(ADirName: string; ADirs: TStrings);
function AddSearchToHistory(ASearchFile: string; const AHistory: TStrings):
  boolean;
function RemoveSearchFromHistory(ASearchFile: string; const AHistory: TStrings):
  boolean;
function FileIsExpired(const AFileName: string; AExpireTime: integer): boolean;
procedure DeleteOldImages(AExpireTime: integer);
function CountFilesInDir(const ADirectory: string): integer;

// TODO: use JvZlibMultiple for handling compressing/decompressing the search files

var

  DefaultCacheDir: string;
  DefaultImageDir: string;
  DefaultDataDir: string;

implementation

uses
  frmMain; // TODO: bad way

{-----------------------------------------------------------------------------}
{- uFinderCacheUtils -}

{-----------------------------------------------------------------------------}
{**
  Loads a cached search file from the specified directory location if not
  expired to checked time value.
  @param AXmlDocument
  @param ACacheDir
  @param AFileName
  @param AExpireTime
}

procedure LoadSearch(const AXmlDocument: IXMLDocument;
  const ACacheDir, AFileName: string; AExpireTime: integer);
begin
  if not Assigned(AXmlDocument) then
    exit;
  if FileExists(ACacheDir + AFileName) then
  begin
    if not FileIsExpired(ACacheDir + AFileName, AExpireTime) then
    begin
      AXmlDocument.LoadFromFile(ACacheDir + AFileName);
      // TODO:
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Recursively add specified directory with XML- and JPG-files to a list.
  @param ADirName
  @param ADirs
}

procedure AddDirectory(ADirName: string; ADirs: TStrings);
var
  SearchRec: TSearchRec;
  Dir: string;
begin
  if FindFirst(ADirName + '*', faDirectory, SearchRec) = 0 then
    while FindNext(SearchRec) <> 0 do
    begin
      Dir := SearchRec.Name;
      if ((SearchRec.Attr and faDirectory) <> 0) and (ADirName[1] <> '.') then
        AddDirectory(ADirName + Dir, ADirs)
      else if LowerCase(ExtractFileExt(Dir)) = '.xml' then // or '.jpg'
        AddFile(ADirName + Dir, ADirs);
    end;
  FindClose(SearchRec);
end;

{-----------------------------------------------------------------------------}
{**
  Add a given file to the list.
  @param AFileName
  @param AFiles
}

procedure AddFile(const AFileName: string; const AFiles: TStrings);
begin
  AFiles.Add(ExpandFilename(AFileName));
end;

{-----------------------------------------------------------------------------}
{**
  Add a freshly made search file to the search history.
  @param ASearchFile
  @param AHistory
  @return result
}

function AddSearchToHistory(ASearchFile: string; const AHistory: TStrings):
  boolean;
var
  iTempPos: integer;
begin
  iTempPos := AHistory.IndexOf(ASearchFile);
  if (iTempPos < 0) then
  begin
    AHistory.Add(ASearchFile);
    result := true;
  end
  else
    result := false;
end;

{-----------------------------------------------------------------------------}
{**
  Remove a search file from the search history.
  @param ASearchFile
  @param AHistory
  @return result
}

function RemoveSearchFromHistory(ASearchFile: string; const AHistory: TStrings):
  boolean;
var
  iTempPos: integer;
begin
  iTempPos := AHistory.IndexOf(ASearchFile);
  if (iTempPos > -1) then
  begin
    AHistory.Delete(iTempPos);
    result := true;
  end
  else
    Result := false;
end;

{-----------------------------------------------------------------------------}
{**
  Checks whether given search file is expired and should be removed from the
  cache.
  @param AFileName
  @param AExpireTime
  @return result
}

function FileIsExpired(const AFileName: string; AExpireTime: integer): boolean;
var
  fHandle: integer;
  fDate: TDateTime;
  fFileTime: TTimeStamp;
  CurrentTime: TTimeStamp;
  DeltaTime: integer;
begin
  fHandle := FileOpen(AFileName, fmOpenRead);
  if fHandle > 0 then
  begin
    try
      fDate := FileDateToDateTime(FileGetDate(fHandle));
      fFileTime := DateTimeToTimeStamp(fDate);
      CurrentTime := DateTimeToTimeStamp(Now);
      DeltaTime := Round((CurrentTime.Time - fFileTime.Time) / 60000); // TODO:
      if (DeltaTime > AExpireTime) then
        result := true
      else
        result := false;
    finally
      FileClose(fHandle);
    end;
  end
  else
    exit;
end;

{-----------------------------------------------------------------------------}
{**
  Deletes recursively every expired search file from the cache.
  @param AExpireTime
}

procedure DeleteOldSearches(AExpireTime: integer);
var
  SearchRec: TSearchRec;
begin
  if FindFirst(MainForm.AppPath + CacheDir + '*.xml', faAnyFile,
    SearchRec) = 0 then
  begin
    while FindNext(SearchRec) <> 0 do
    begin
      if (SearchRec.Attr and faDirectory = 0) then
        if FileIsExpired(MainForm.AppPath + CacheDir + SearchRec.Name,
          AExpireTime) then
          DeleteFile(MainForm.AppPath + CacheDir + SearchRec.Name);
    end;
    FindClose(SearchRec);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Deletes recursively every expired cached product image.
  @param AExpireTime
}

procedure DeleteOldImages(AExpireTime: integer);
var
  SearchRec: TSearchRec;
begin
  if FindFirst(MainForm.AppPath + CacheDir + '*.jpg',
    faAnyFile, SearchRec) = 0 then
  begin
    while FindNext(SearchRec) <> 0 do
    begin
      if (SearchRec.Attr and faDirectory = 0) then
        if FileIsExpired(MainForm.AppPath + CacheDir + SearchRec.Name,
          AExpireTime) then
          DeleteFile(MainForm.AppPath + CacheDir + SearchRec.Name);
    end;
    FindClose(SearchRec);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Counts the files in given directory with the specified extension.
  @param ADirectory The directory which to count
  @param AFileSpec The file extension
  @return File count in the directory
}

function CountFilesInDir(const ADirectory: string): integer;
var
  SearchRec: TSearchRec;
  iRC: longint;
  iFileCount: integer;
begin
  iFileCount := 0;
  try
    if FindFirst(MainForm.AppPath + CacheDir + '*.xml', faAnyFile, SearchRec) = 0
      then
      while (iRC = 0) do
      begin
        Inc(iFileCount);
        iRC := FindNext(SearchRec);
      end;
  except
    iFileCount := 0;
  end;
  FindClose(SearchRec);
  result := iFileCount;
end;

initialization

  DefaultCacheDir := CacheDir;
  DefaultImageDir := ImageDir;
  DefaultDataDir := DataDir;

end.
