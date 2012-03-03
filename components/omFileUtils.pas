{ ______________________________________________________________________________

  <H5>Copyright</H5>
  File: omFileUtils.pas

  Copyright (C) 2002 ObjectMastery Pty Limited

  Conditions for use, copying, modification and distribution of this software
  are contained in the appropriate licence, which can be found in the webRAD
  readme file included or at http://webrad.sourceforge.net/license.htm

  To see the modification history of this file please refer to the project's
  CVS repository on the SourceForge. www.sourceforge.net/projects/webrad
________________________________________________________________________________
}

unit omFileUtils;

interface
uses
  SysUtils
  , Classes
  ;

procedure StrToFile(const Filename: String; const Str: String);
procedure AppendStrToFile(const Filename: String; const Str: String);
function FileToStr(const Filename: String): String;

{ TODO -ofcp : "DuplicateFile" and "MoveFileLocation" are currently not needed
               on Linux, but will have to be ported when they are required.
}
{$IFDEF MSWINDOWS}
function DuplicateFile(
  const ExistingFilename: String; const NewFilename: String;
  const Overwrite: Boolean = True): Boolean;
function MoveFileLocation(
  const ExistingFilename: String; const NewFilename: String;
  const Overwrite: Boolean = True): Boolean;
{$ENDIF MSWINDOWS}

procedure EmptyExistingDir(const Path: String; Recurse: Boolean = False);
procedure EmptyDirectory(const PathName: String; Recurse: Boolean = False);
function MakeDirectory(const PathName: String): Boolean;
function DeleteDirectory(const PathName: String): Boolean;
function DirectorySize(const PathName: String; FileMask: TFileName = '*.*'):
  Int64;
function DirectoryFileCount(const PathName: String; FileMask: TFileName =
  '*.*'): Integer;
function FileSize(const Filename: String): Int64;
function CopyFileTo(
  const SourceFilename, DestFilename: String; Overwrite: Boolean = True):
  Boolean;
//function SameFiles(const File1: String; const File2: String): Boolean;
{$IFDEF MSWINDOWS}
procedure CopyDirectory(const FromPath: String; const ToPath: String);
{$ENDIF MSWINDOWS}

(**
  Generate a unique file name based on the supplied mask. This is done
  by 'formatting' the mask with an integer counter, starting from "StartNum",
  and going as high as "MaxNum".  If the mask does not contain a '%' then '_%d'
  is appended, otherwise it is assumed that the mask contains a single '%..d'.
  See also 'Format' in the Delphi Help for a list of applicable format strings.
  If the mask is not supplied, a filename is created for the C:\Temp directory.
*)
//function GetUniqueFile(
//  FileMask: String = ''; StartNum: Integer = 1; MaxNum: Integer = MaxInt - 1):
//  String;

(**
  Generate a unique directory name based on the supplied mask. This is done
  by 'formatting' the mask with an integer counter, starting from "StartNum",
  and going as high as "MaxNum".  If the mask does not contain a '%' then '_%d'
  is appended, otherwise it is assumed that the mask contains a single '%..d'.
  See also 'Format' in the Delphi Help for a list of applicable format strings.
*)
function GetUniqueDirectory(
  PathMask: String; StartNum: Integer = 1; MaxNum: Integer = MaxInt - 1):
  String;

function GetTempDirectoryName(
  const PathName, Prefix: String; out UniqueNumber: Integer): String;


const
  DefaultPathSeparator = '\';

type
  TomPathSeparatorType = (stWindowsPath, stUrl, stLinuxPath);

function PathSeparator(): String;

function NormalisePathSeparator(
  const Filename: String; SeparatorPathType: TomPathSeparatorType): String;


implementation
uses
  omSystem
{$IFDEF MSWINDOWS}
  , Windows
  , omWindows
{$ENDIF MSWINDOWS}
  , omStrUtils
  , omURLs
{$IFNDEF Delphi6plus}
  , FileCtrl
{$ENDIF Delphi6plus}
  ;

// ____________________________________________________________________________
(**
  returns the number of bytes in a file
*)

function FileSize(const Filename: String): Int64;
var
  FileStream: TFileStream;
  TempChar: Char;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    FileStream.Seek(-1, soFromEnd);
    FileStream.Read(TempChar, 1);
    Result := Filestream.Size;
    if TempChar = EOF then
    begin
      Result := Result - 1; // don't count the eof Char
    end
  finally
    FileStream.Free;
  end;
end;


// ____________________________________________________________________________
(**
  Copies a source file to a dest file without locking source file.
  Windows independent.
*)

function CopyFileTo(
  const SourceFilename, DestFilename: String; Overwrite: Boolean): Boolean;
var
  SourceStream: TFileStream;
  DestinationStream: TFileStream;
begin
  if (FileExists(DestFilename) and not Overwrite) then
  begin
    Result := False;
  end
  else
  begin
    SourceStream := TFileStream.Create(SourceFilename, fmOpenRead or
      fmShareDenyNone);
    try
      DestinationStream := TFileStream.Create(DestFilename, fmCreate);
      try
        DestinationStream.CopyFrom(SourceStream, 0);
      finally
        DestinationStream.Free;
      end;
    finally
      SourceStream.free;
    end;
    Result := True;
  end;
end;

// ____________________________________________________________________________
(**
  creates the specified subdirectory including any parent directories.
*)

function MakeDirectory(const PathName: String): Boolean;
var
  Buffer: String;
  Index: integer;
  NextChar: Char;
  Path: String;
  StartPos: Integer;

begin
  if PathName = '' then
  begin
    Result := False;
    Exit;
  end;

  Path := AppendSlash(PathName);

{$I+}
  // GLK: Had to take 'turn off I/O checking' out. It interfered
  //   with subsequent WriteLn's in CONSOLE mode.
{$IFDEF MSWINDOWS}
  Buffer := '';
  StartPos := 1;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  Path := StringReplace(Path, '\', '/', [rfReplaceAll]);
  Assert(Path[1] = '/');
  Buffer := '/';
  StartPos := 2;
{$ENDIF LINUX}

  for Index := StartPos to Length(Path) do
  begin
    NextChar := Path[Index];
    if (NextChar = '/') or (NextChar = '\') then
    begin
      if not DirectoryExists(Buffer) then
      begin
        Mkdir(Buffer);
      end;
    end;
    Buffer := Buffer + NextChar;
  end;

  Result := DirectoryExists(Path);
end;


// ____________________________________________________________________________
(**
  Deletes the specified directory, along with all files and subdirectories.
*)

function DeleteDirectory(const PathName: String): Boolean;
begin
  EmptyDirectory(PathName, True);
  RemoveDir(Pathname);
  Result := Not DirectoryExists(PathName);
end;


// ____________________________________________________________________________
(**
  deletes all the files in a directory
  @deprecated use EmptyDirectory
*)

procedure EmptyExistingDir(const Path: String; Recurse: Boolean = False);
begin
  EmptyDirectory(Path, Recurse);
end;


// ____________________________________________________________________________
(**
  deletes all the files in a directory
*)

procedure EmptyDirectory(const PathName: String; Recurse: Boolean = False);
var
  SearchRecord: TSearchRec;
  FileMask: TFileName;
  Path: String;
begin
  if (PathName = '') then
  begin
    raise Exception.Create(
      'Cannot delete contents of directory. ' +
      'Directory path must not be an empty string.'
      );
  end;

  Path := AppendSlash(PathName);
  FileMask := Path + '*.*';
  if FindFirst(FileMask, faAnyFile, SearchRecord) = 0 then
  begin
    if faDirectory and SearchRecord.Attr > 0 then
    begin
      if SearchRecord.Name[1] <> '.' then
      begin
        if Recurse then
        begin
          EmptyDirectory(Path + SearchRecord.Name, Recurse);
          RemoveDir(Path + SearchRecord.Name);
        end;
      end;
    end
    else if (not SysUtils.DeleteFile(Path + SearchRecord.Name)) then
    begin
      raise Exception.CreateFmt(
        'Could not delete file "%s".', [Path + SearchRecord.Name]
        );
    end;
    while FindNext(SearchRecord) = 0 do
    begin
      if faDirectory and SearchRecord.Attr > 0 then
      begin
        if SearchRecord.Name[1] <> '.' then
        begin
          if Recurse then
          begin
            EmptyDirectory(Path + SearchRecord.Name, Recurse);
            RemoveDir(Path + SearchRecord.Name);
          end;
        end;
      end
      else if (not SysUtils.DeleteFile(Path + SearchRecord.Name)) then
      begin
        raise Exception.CreateFmt(
          'Could not delete file "%s".', [Path + SearchRecord.Name]
          );
      end;
    end;
  end;
  SysUtils.FindClose(SearchRecord);
end;

{ TODO -ofcp : "SystemErrorMessageParam" is currently not needed
               on Linux, but will have to be ported when required.
}
{$IFDEF MSWINDOWS}
// _____________________________________________________________________________
{**
  Displays text of the last system error formated (if necessary) with Param.
  Jvr - 18/12/2001 11:23:17 - Copied from DBIUtils.<P>

  @param Param string that represents array for formating
}
function SystemErrorMessageParam(ErrorCode: Integer; Param: String): String;
var
  Len: Integer;
  Buffer: array[0..255] of Char;
  ArgArray: array[1..1] of PChar;

begin
  ArgArray[1] := PChar(Param);
  Len := Windows.FormatMessage(
    Format_Message_From_System or Format_Message_Argument_Array,
    nil, ErrorCode, 0, Buffer, SizeOf(Buffer), @ArgArray);

  while (Len > 0) and (Buffer[Len - 1] in [#0..#32, '.']) do
  begin
    Dec(Len);
  end; { while }

  SetString(Result, Buffer, Len);
end; { SystemErrorMessageParam }
{$ENDIF MSWINDOWS}


// ____________________________________________________________________________
{**
  writes a String to the named file.

  Jvr - 18/12/2001 11:24:14 - Added exception handling for the file create<P>
}

procedure StrToFile(const Filename: String; const Str: String);
var
  Stream: TFileStream;
  TempFileName: TomFilename;
begin
  if Str = '' then
  begin
    Exit;
  end;

  TempFileName := TomFilename.Create;
  try
    TempFileName.Full := FileName;
    TempFilename.MakeDirectory;

    try
      Stream := TFileStream.Create(TempFileName.Full, fmCreate);
    except
      on E: Exception do
      begin
        raise Exception.Create(
          E.Message
{$IFDEF MSWINDOWS}
           + '. ' +
          SystemErrorMessageParam(GetLastError, ExtractFileName(ParamStr(0)))
{$ENDIF MSWINDOWS}
          );
      end;
    end;

    try
      Stream.Write(Str[1], Length(Str));
    finally
      Stream.Free;
    end;

  finally
    TempFilename.Free;
  end;
end;


// ____________________________________________________________________________

procedure AppendStrToFile(const Filename: String; const Str: String);
var
  Stream: TFileStream;
begin
  if Str = '' then
  begin
    Exit;
  end;

  try
    Stream := TFileStream.Create(Filename, fmOpenReadWrite);
  except
    on E: Exception do
    begin
      raise Exception.Create(
        E.Message
{$IFDEF MSWINDOWS}
           + '. ' +
          SystemErrorMessageParam(GetLastError, ExtractFileName(ParamStr(0)))
{$ENDIF MSWINDOWS}
        );
    end;
  end;

  try
    Stream.Seek(0, soFromEnd);
    Stream.Write(Str[1], Length(Str));
  finally
    Stream.Free;
  end;

end;


// ____________________________________________________________________________
(**
  Read a named file into a String.
*)

function FileToStr(const Filename: String): String;
var
  StringList: TStringList;
begin
  Result := '';
  try
    StringList := TStringList.Create;
    StringList.LoadFromFile(Filename);
    Result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;


// ____________________________________________________________________________
(**
  calculate the size of a directory
*)

function DirectorySize(const PathName: String; FileMask: TFileName = '*.*'):
  Int64;
var
  SearchRecord: TSearchRec;
  Path: String;
begin
  Result := 0;
  Path := AppendSlash(PathName);
  FileMask := Path + FileMask;
  if FindFirst(FileMask, faAnyFile, SearchRecord) = 0 then
  begin
    if faDirectory and SearchRecord.Attr > 0 then
    begin
      if SearchRecord.Name[1] <> '.' then
      begin
        Result := Result + DirectorySize(Path + SearchRecord.Name);
      end;
    end;
    Result := Result + SearchRecord.Size;
    while FindNext(SearchRecord) = 0 do
    begin
      if faDirectory and SearchRecord.Attr > 0 then
      begin
        if SearchRecord.Name[1] <> '.' then
        begin
          Result := Result + DirectorySize(Path + SearchRecord.Name);
        end;
      end;
      Result := Result + SearchRecord.Size;
    end;
  end;
  SysUtils.FindClose(SearchRecord);
end;


function DirectoryFileCount(const PathName: String; FileMask: TFileName =
  '*.*'): Integer;
var
  SearchRecord: TSearchRec;
  Path: String;
begin
  Result := 0;
  Path := AppendSlash(PathName);
  FileMask := Path + FileMask;
  if FindFirst(FileMask, faAnyFile, SearchRecord) = 0 then
  begin
    if SearchRecord.Name[1] <> '.' then
    begin
      Inc(Result);
    end;
    while FindNext(SearchRecord) = 0 do
    begin
      if SearchRecord.Name[1] <> '.' then
      begin
        Inc(Result);
      end;
    end;
  end;
  SysUtils.FindClose(SearchRecord);
end;


{$IFDEF MSWINDOWS}
//_____________________________________________________________________________

function DuplicateFile(const ExistingFilename: String; const NewFilename:
  String;
  const Overwrite: Boolean = True): Boolean;
begin
  Result := True;
  try
    if (not CopyFile(PChar(ExistingFilename), PChar(NewFilename), not Overwrite))
      then
    begin
      Result := False;
    end;
  except
    if Overwrite then
    begin
      raise;
    end
    else
    begin
      Result := False;
    end;
  end;
end;


function MoveFileLocation(const ExistingFilename: String; const NewFilename:
  String;
  const Overwrite: Boolean = True): Boolean;
begin
  //  MoveFileEx is not supported by the dos based versions of Windows ie 95,98,ME
  //  DME 29/05/2001
  //  Result := MoveFileEx(PChar(ExistingFilename), PChar(NewFilename),
  //    MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH or MOVEFILE_COPY_ALLOWED);

  Result := MoveFile(PChar(ExistingFilename), PChar(NewFilename));
end;
{$ENDIF MSWINDOWS}

function GetUniqueDirectory(
  PathMask: String; StartNum: Integer; MaxNum: Integer): String;
var
  Counter: Integer;

begin
  if Pos('%', PathMask) = 0 then
  begin
    PathMask := PathMask + '_%d';
  end;

  Counter := StartNum;
  while (True) do
  begin
    if (Counter > MaxNum) then
    begin
      raise Exception.CreateFmt(
        'Could not create a unique directory with mask "%s" and counter start %d. ' +
        'Counter has gone past MaxNum = %d.',
        [PathMask, StartNum, MaxNum]
        );
    end;
    Result := Format(PathMask, [Counter]);
    if (not DirectoryExists(Result)) then
    begin
      Break;
    end;
    Inc(Counter);
  end;
end;

// _____________________________________________________________________________
{**
  Creates a unique directory name.  Useful for generating a unique working
  directory name.<P>

  This function will return a unique directory name based on a given path, a
  prefix (used in MasterSystem_II as user initials) and a number from which the
  unique directory name would be based on.  The number is then incrementally
  increased by 1.  The newly created directory name will be checked for
  the existence and, if so, the number will be incremented, a new name generated
  and checked until a totally new and unique name is achieved.<P>

  @param  PathName      Path of the directory in which the new directory sits
  @param  Prefix        User defined prefix in the directory name
  @param  UniqueNumber  The unique number used in the directory number
  @param  Result        The actual directory name
}

function GetTempDirectoryName(
  const PathName, Prefix: String; out UniqueNumber: Integer): String;
var
  BaseDirectory: String;
  DirectoryName: String;
  NumString: String;
  ShortPrefix: array[0..3] of Char;
  Index: Integer;
begin
  // See if we need to append a '\' to the end of the path
  if (PathName[Length(PathName)] = '\') then
  begin
    BaseDirectory := PathName;
  end
  else
  begin
    BaseDirectory := PathName + '\';
  end;

  UniqueNumber := 0;
  // Look for a directory name that matches the criteria but doesnt exist.
  repeat
    // increments the number and concatenate it to make new directory name.
    UniqueNumber := UniqueNumber + 1;
    NumString := IntToStr(UniqueNumber);

    if UniqueNumber < 10000 then
    begin
      for Index := 1 to (5 - Length(NumString)) do
        NumString := '0' + NumString;
    end;

    // Make sure that the directory name isn't more than 8 Char - we're using
    // word perfect for dos to print the reports...
    StrLCopy(ShortPrefix, PChar(Prefix), SizeOf(ShortPrefix) - 1);
    DirectoryName := BaseDirectory + ShortPrefix + NumString;
  until (not DirectoryExists(DirectoryName));

  Result := DirectoryName;
end;

// _____________________________________________________________________________

function PathSeparator(): String;
begin
{$IFDEF MSWINDOWS}
  Result := '\';
{$ELSE}
  Result := '/';
{$ENDIF}
end;


// _____________________________________________________________________________
{**
  Jvr - 18/01/2001 16:56:03 - Convert slashes to the specified type<P>
}

function NormalisePathSeparator(
  const Filename: String;
  SeparatorPathType: TomPathSeparatorType
  ): String;
begin
  if (SeparatorPathType = stUrl) or (SeparatorPathType = stLinuxPath) then
  begin
    Result := StringReplace(FileName, '\', '/', [rfReplaceAll]);
  end
  else
  begin
    Result := StringReplace(FileName, '/', '\', [rfReplaceAll]);
  end;
end; { NormalisePathSeparator }


{$IFDEF MSWINDOWS}

procedure CopyDirectory(const FromPath: String; const ToPath: String);
var
  FromFilename: TomFilename;
  ToFilename: TomFilename;
  SearchRec: TSearchRec;

  procedure DoCopy;
  begin
    FromFilename.Partial := SearchRec.Name;
    ToFilename.Partial := SearchRec.Name;
    if (not CopyFile(PChar(FromFilename.Full), PChar(ToFilename.Full), False))
      then
    begin
      raise Exception.CreateFmt(
        'Could not copy file "%s" to "%s".', [FromFilename.Full, ToFilename.Full]
        );
    end;
  end;

begin
  FromFilename := nil;
  ToFilename := nil;
  try
    ForceDirectories(ToPath);

    FromFilename := TomFilename.Create;
    ToFilename := TomFilename.Create;

    FromFilename.Path := FromPath;
    ToFilename.Path := ToPath;

    if FindFirst(FromPath + '*.*', 0, SearchRec) = 0 then
    begin
      DoCopy;
      while FindNext(SearchRec) = 0 do
      begin
        DoCopy;
      end;
      SysUtils.FindClose(SearchRec);
    end;
  finally
    FreeAndNil(FromFilename);
    FreeAndNil(ToFilename);
  end;
end;
{$ENDIF MSWINDOWS}

end.
