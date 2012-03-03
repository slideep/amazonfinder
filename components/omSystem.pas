{ ______________________________________________________________________________

  <H5>Copyright</H5>
  File: omSystem.pas

  Copyright (C) 2002 ObjectMastery Pty Limited

  Conditions for use, copying, modification and distribution of this software
  are contained in the appropriate licence, which can be found in the webRAD
  readme file included or at http://webrad.sourceforge.net/license.htm

  To see the modification history of this file please refer to the project's
  CVS repository on the SourceForge. www.sourceforge.net/projects/webrad
________________________________________________________________________________
}

unit omSystem;

interface

{$IFDEF VER120}
procedure FreeAndNil(Obj: TObject);
function SameText(const String1, String2: string): Boolean; assembler;
{$ENDIF}


implementation

uses
  SysUtils
  ;

{$IFDEF VER120}

procedure FreeAndNil(Obj: TObject);
var
  TempObj: TObject;
begin
  TempObj := TObject(Obj);
  TObject(Obj) := nil; // clear the reference before destroying the object
  TempObj.Free;
end;

function SameText(const String1, String2: string): Boolean;
begin
  Result := CompareText(S1, S2) = 0;
end;

{$ENDIF}

end.
