{ ______________________________________________________________________________

  <H5>Copyright</H5>
  File: omWindows.pas

  Copyright (C) 2002 ObjectMastery Pty Limited

  Conditions for use, copying, modification and distribution of this software
  are contained in the appropriate licence, which can be found in the webRAD
  readme file included or at http://webrad.sourceforge.net/license.htm

  To see the modification history of this file please refer to the project's
  CVS repository on the SourceForge. www.sourceforge.net/projects/webrad
________________________________________________________________________________
}
unit omWindows;

{$I DelphiVersion.inc}

{$IFDEF Delphi6plus}
{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

interface

uses
  Classes
  , omSystem
  , omURLs
  ;

type
  TomWindows = class(TObject)
  public
    class function WindowsDirectory: TomFileName;
    class function SystemDirectory: TomFileName;
    class function TemporaryDirectory: TomFileName;
    class function CurrentDirectory: TomFileName;
    class function UserName: String;
    class function GetEnvVar(const EnvVar: string): string;
    class procedure SetEnvVar(const EnvVar: string; const Value: string);
    class function HostName: String;
  end;

function WindowsDirectory: TomFileName;
function SystemDirectory: TomFileName;
function TemporaryDirectory: TomFileName;
function CurrentDirectory: TomFileName;
function UserName: String;
function GetEnvVar(const EnvVar: string): string;
procedure SetEnvVar(const EnvVar: string; const Value: string);
function HostName: String;


implementation

uses
  Windows
  , WinSock
  , SysUtils
  , Dialogs
{$IFDEF Testing}
  , omTestMastery
  , omUtilsTestSuite
  , omLogMastery
{$ENDIF}
  ;

(** get the value of environment variables. *)

// =============================================================================
// TomWindows class Methods
// =============================================================================


// _____________________________________________________________________________
{**
  The GetWindowsDirectory function retrieves the path of the Windows directory.]
  The Windows directory contains such files as Windows-based applications,
  initialization files, and Help files.<P>

  If the user is running a shared version of Windows, the Windows directory is
  guaranteed to be private for each user.<P>

  If an application creates other files that it wants to store on a per-user
  basis, it should place them in the directory specified by the HOMEPATH
  environment variable. This directory will be different for each user, if so
  specified by an administrator, via the User Manager administrative tool.
  HOMEPATH always specifies either the user's home directory, which is
  guaranteed to be private for each user, or a default directory
  (for example, C:\USERS\DEFAULT) where the user will have all access.<P>

  param  Result  Returns the Windows Directory
}

class function TomWindows.WindowsDirectory: TomFileName;
begin
  Result := omWindows.WindowsDirectory;
end;

function WindowsDirectory: TomFileName;
var
  Buffer: String;
  Size: Integer;

begin
  Size := MAX_PATH;
  SetLength(Buffer, Size);
  Size := GetWindowsDirectory(PChar(Buffer), Size);
  SetLength(Buffer, Size);
  Result := TomFileName.Create;
  Result.Directory := Buffer;
end; { WindowsDirectory }


// _____________________________________________________________________________
{**
  The SystemDirectory function retrieves the path of the Windows system
  directory. The system directory contains such files as Windows libraries,
  drivers, and font files.<P>

  Applications should not create files in the system directory. If the user is
  running a shared version of Windows, the application does not have write
  access to the system directory. Applications should create files only in the
  directory returned by the GetWindowsDirectory function.

  param  Result  Returns the Windows System Directory
}

class function TomWindows.SystemDirectory: TomFileName;
begin
  Result := omWindows.SystemDirectory;
end;

function SystemDirectory: TomFileName;
var
  Buffer: String;
  Size: DWORD;

begin
  Size := MAX_PATH;
  SetLength(Buffer, Size);
  Size := GetSystemDirectory(PChar(Buffer), Size);
  SetLength(Buffer, Size);
  Result := TomFileName.Create;
  Result.Directory := Buffer;
end; { SystemDirectory }


// _____________________________________________________________________________
{**
  The TemporaryDirectory function retrieves the path of the directory designated
  for temporary files.<P>

  The TemporaryDirectory function gets the temporary file path as follows:
  <OL>
    <LI>The path specified by the TMP environment variable.</LI>
    <LI>The path specified by the TEMP environment variable,
        if TMP is not defined.</LI>
    <LI>The current directory, if both TMP and TEMP are not defined.</LI>
  </OL>

  param  Result  Returns the Windows Temporary Directory
}

class function TomWindows.TemporaryDirectory: TomFileName;
begin
  Result := omWindows.TemporaryDirectory;
end;

function TemporaryDirectory: TomFileName;
var
  Buffer: String;
  Size: DWORD;

begin
  Size := MAX_PATH;
  SetLength(Buffer, Size);
  Size := GetTempPath(Size, PChar(Buffer));
  SetLength(Buffer, Size);
  Result := TomFileName.Create;
  Assert(Result <> nil);
  Result.Path := Buffer;
end; { TemporaryDirectory }


// _____________________________________________________________________________
{**
  The CurrentDirectory function retrieves the current directory for the current
  process.<P>

  param  Result  Returns the Current Directory
}

class function TomWindows.CurrentDirectory: TomFileName;
begin
  Result := omWindows.CurrentDirectory;
end;

function CurrentDirectory: TomFileName;
var
  Buffer: String;
  Size: DWORD;

begin
  Size := MAX_PATH;
  SetLength(Buffer, Size);
  Size := GetCurrentDirectory(Size, PChar(Buffer));
  SetLength(Buffer, Size);
  Result := TomFileName.Create;
  Result.Directory := Buffer;
end; { CurrentDirectory }


// _____________________________________________________________________________
(**
  The GetUserName function retrieves the user name of the current thread. This
  is the name of the user currently logged onto the system.<P>

  param  Result  Returns the User Login Name
*)

class function TomWindows.UserName: String;
begin
  Result := omWindows.UserName;
end;

function UserName: String;
var
  LogonName: array[0..255] of Char;
  Size: DWORD;

begin
  Size := SizeOf(LogonName);
  Win32Check(Windows.GetUserName(@LogonName[0], Size));
  Result := String(LogonName);
end; { GetUserName }

// _____________________________________________________________________________
(*
  return contents of environment variable "Env" or
 an empty string if variable does not exist

  e.g.
  var
  Command: String;
  begin
     Command:= GetEnvVar('COMSPEC')+#0;
     WinExec(@Command[1], sw_Normal);
  end;
*)

class function TomWindows.GetEnvVar(const EnvVar: String): String;
begin
  Result := omWindows.GetEnvVar(EnvVar);
end;

function GetEnvVar(const EnvVar: String): String;

var
  DOSEnvironment: PChar;
  StrCtr: Word;
  EnvVarValue: String;

begin
  Result := '';
  DOSEnvironment := GetEnvironmentStrings;

  while DOSEnvironment[0] <> #0 do
  begin
    EnvVarValue := StrPas(DOSEnvironment);

    if (Pos(UpperCase(EnvVar), UpperCase(EnvVarValue)) = 1) then
    begin
      StrCtr := Pos('=', EnvVarValue);

      if StrCtr = 0 then
      begin
        StrCtr := Pos(#32, EnvVarValue);
      end;

      Delete(EnvVarValue, 1, StrCtr);
      Result := EnvVarValue;
      Exit;
    end;

    while (DOSEnvironment[0] <> #0) do
    begin
      Inc(DOSEnvironment); { goto end of current }
    end;

    Inc(DOSEnvironment); { point to next }
  end;

  //	FreeMem(DOSEnvironment);
end;

// _____________________________________________________________________________

class procedure TomWindows.SetEnvVar(const EnvVar, Value: string);
begin
  omWindows.SetEnvVar(EnvVar, Value);
end;

procedure SetEnvVar(const EnvVar, Value: string);
begin
  SetEnvironmentVariable(PChar(EnvVar), PChar(Value));
end;

// _____________________________________________________________________________

class function TomWindows.HostName: String;
begin
  Result := omWindows.HostName;
end;

function HostName: String;
var
  WSAData: TWSAData;
  Buffer: array[0..255] of char;

begin
  if WSAStartup(2, WSAData) = 0 then
  begin
    WinSock.GetHostName(Buffer, SizeOf(Buffer));
    Result := Buffer;
  end
  else
  begin
    Result := '<unknown>';
  end;
end;


// ============================================================================

{$IFDEF Testing}

type
  TomTestSuiteWindows = class(TomTestSuite)
  published
    procedure Test_Environment;
    procedure Test_MachineDependentStuff;
  end;


procedure TomTestSuiteWindows.Test_Environment;
begin
  TomWindows.SetEnvVar('SnargleWhopp', 'Zoorfwhangle');
  Assert(TomWindows.GetEnvVar('SnargleWhopp') = 'Zoorfwhangle');
end;

procedure TomTestSuiteWindows.Test_MachineDependentStuff;

  procedure CheckFilename(Message: String; FileName: TomFilename);
  begin
    Assert(Assigned(FileName));
    Assert(FileName.Full <> '');
    Log.Debug(Message + Filename.Full);
    FreeAndNil(FileName);
  end;

begin
  CheckFileName('  Windows Directory: ', TomWindows.WindowsDirectory);
  CheckFileName('  SystemDirectory = ', TomWindows.SystemDirectory);
  CheckFileName('  TemporaryDirectory = ', TomWindows.TemporaryDirectory);
  CheckFileName('  CurrentDirectory = ', TomWindows.CurrentDirectory);

  Assert(TomWindows.UserName <> '');
  Log.Debug('  UserName = ' + TomWindows.UserName);

  Assert(TomWindows.Hostname <> '');
  Log.Debug('  Hostname = ' + TomWindows.Hostname);

end;

{$ENDIF}

initialization
{$IFDEF Testing}
  TomTestMastery.RegisterTestSuite(TomTestSuiteWindows,
    TomTestSuiteUtils_Unit_Tests);
{$ENDIF}

end.
