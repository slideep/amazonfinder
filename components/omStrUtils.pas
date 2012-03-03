{ ______________________________________________________________________________

  <H5>Copyright</H5>
  File: omStrUtils.pas

  Copyright (C) 2002 ObjectMastery Pty Limited

  Conditions for use, copying, modification and distribution of this software
  are contained in the appropriate licence, which can be found in the webRAD
  readme file included or at http://webrad.sourceforge.net/license.htm

  To see the modification history of this file please refer to the project's
  CVS repository on the SourceForge. www.sourceforge.net/projects/webrad
________________________________________________________________________________
}
unit omStrUtils;

{$I DelphiVersion.inc}

interface

uses
  SysUtils
  ;

const
  // ASCII symbols
  NUL = #0;
  SOH = #1;
  STX = #2;
  ETX = #3;
  EOT = #4;
  ENQ = #5;
  ACK = #6;
  BEL = #7;
  BS = #8;
  TAB = #9;
  LF = #10;
  VT = #11;
  FF = #12;
  CR = #13;
  SO = #14;
  SI = #15;

  DLE = #16;
  DC1 = #17;
  DC2 = #18;
  DC3 = #19;
  DC4 = #20;
  NAK = #21;
  SYN = #22;
  ETB = #23;
  CAN = #24;
  EM = #25;
  SUB = #26;
  ESC = #27;
  FS = #28;
  GS = #29;
  RS = #30;
  US = #3;

  // other special valuse
{$IF DEFINED(LINUX)}
  NL = CR;
{$ELSE}
  NL = CR + LF;
{$IFEND}
  EOF = #26; // ^Z

  PoundSign = Chr(163);
  DollarSign = '$';


  (*
  kSpace                = ' '; // use ' '
 kTab							    = #9;  // deprecated; // use ASCII symbol
 kFormFeed							= #12; // deprecated; // use ASCII symbol
 kCarriageReturn       = #13; // deprecated; // use ASCII symbol
  kLineFeed							= #10; // deprecated; // use ASCII symbol

 kNewLine							= #13 + #10; // deprecated; // use NL
 kTwoLines							= kNewLine + kNewLine;  // your joking, right?
  // kThreeLines...     // now you've got me doing it!

  kEOF                  = #26;  // deprecated; // use EOF
  *)

type
  TCharset = set of char;

function StrPatternCmp(
  Source: String;
  Pattern: String;
  IsCaseInsensitive: Boolean = False
  ): Boolean;

function FindChar(
  const Text: String;
  const Chars: TCharSet
  ): Integer;

function FindText(
  Substr: string;
  Str: string
  ): Integer;

function DeleteTextRange(
  const FromString, ToString: string;
  var Str: string
  ): Integer;

procedure SubstituteText(
  const FromString, ToString: string;
  const NewStr: string;
  var Str: string;
  All: Boolean = False
  ); overload;

procedure SubstituteText(
  const OldSubStr: string;
  const NewSubStr: string;
  var Str: string;
  All: Boolean = False
  ); overload;

function StrTimeTaken(const StartTime: TDateTime; const EndTime: TDateTime):
  String;
function LeftStr(AString: String; LengthWanted: Integer): String;
function RightStr(AString: String; LengthWanted: Integer): String;
function Replicate(AString: String; NumTimes: Integer): String;
function Space(NumSpaces: Integer): String;
function PadLeft(AString: String; StringLen: Integer; FillChar: String): String;
function PadRight(AString: String; StringLen: Integer; FillChar: String):
  String;
function PadAndCentre(AString: String; StringLen: Integer; FillChar: String):
  String;
function Occurs(StrToFind: String; StrToChk: String): Integer;
function TextPos(const StrToFind: String; const StrToChk: String): Integer;
function StringPos(const StrToFind: String; const StrToChk: String; const
  Occurrence: Word): Integer;
function PosWithStart(const StrToFind: String; const StrToChk: String;
  const StartPos: Word): Integer;
function StrTran(const StrToFind: String; const StrToChk: String; const RepStr:
  String): String;
function StripQuotes(const AString: String): String;
deprecated; // use TrimChar(aString, '"', false);
function AddQuotes(AString: String): String;
function CompareInitial(AString: String; BString: String): Integer;
deprecated; // use CompareText(AString, Copy(BString, 1, Length(AString)));
function CompareInitialStr(AString: String; BString: String): Integer;
deprecated; // use CompareStr(AString, Copy(BString, 1, Length(AString)));
function VariantToStr(const AVariant: Variant): String;

function SafeStrToInt(AString: String): Integer;
deprecated; // use StrToIntDef
function SafeStrToFloat(AString: String): Double;
deprecated; // StrToFloatDef(AString, 0);
function SafeStrToDate(AString: String): TDateTime;
deprecated; // use StrToDateDef(AString, 0);

// function StrToFloatDef(AString: String; Default: Double): Double; -- in SysUtils
// function StrToDateDef(AString: String; Default: TDatetime): TDatetime; -- in SysUtils
// function StrToTimeDef(AString: String; Default: TDatetime): TDatetime; -- in SysUtils
// function StrToDateTimeDef(AString: String; Default: TDatetime): TDatetime; -- in SysUtils

type
  TomWantDecimals = (wdNoDecimals, wdWantDecimals);
  TomWantRightAlignPadding = (wrNoRightAlignPadding, wrWantRightAlignPadding);
  TomWantCurrencySign = (wdNoCurrencySign, wdWantCurrencySign);

function Commas(
  Value: Double;
  Places: Integer;
  StrLength: Integer = 0;
  AlignPadding: TomWantRightAlignPadding = wrNoRightAlignPadding
  ): String;
function CurrencyStr(
  Value: Double;
  CurrencySymbol: String = '';
  StrLength: Integer = 0;
  Decimals: TomWantDecimals = wdWantDecimals;
  AlignPadding: TomWantRightAlignPadding = wrNoRightAlignPadding
  ): String;
function DollarStr(Value: Double; StrLength: Integer): String;
function SterlingStr(
  Value: Double;
  StrLength: Integer = 0;
  Decimals: TomWantDecimals = wdNoDecimals;
  AlignPadding: TomWantRightAlignPadding = wrNoRightAlignPadding;
  AddCurrencySign: TomWantCurrencySign = wdWantCurrencySign
  ): String;
function PercentageStr(
  Value: Double;
  StrLength: Integer = 0;
  Decimals: Integer = 0;
  NegativeBrackets: Boolean = false
  ): String;
function FormattedStrToDouble(Str: String): Double;
function FormattedStrToInt(Str: String): Integer;
function FilterChars(Str: String; CharSet: TCharSet): String;
function BankCurrencyStr(Value: Double): String;
function ValueAsWords(Value: Integer): String;
function AsFlexIndexStr(AValue: Variant): String;

function IsAlpha(AString: String): Boolean;
function HasAlpha(AString: String): Boolean;
function IsDigit(AString: String): Boolean;
function IsNumeric(AString: String): Boolean;
function GetFileExtension(FileString: String): String;
(*
function GetFileName(FileString: String): String;
deprecated // use ExtractFileName
function GetFullFileName(FileString: String): String; deprecated;
*)
function _GetPath(FileString: String): String;
deprecated; // use ExtractFilePath

function TrimLeftChar(
  const Str: String;
  CharSet: TCharset;
  All: Boolean = True
  ): string;
function TrimRightChar(
  const Str: String;
  CharSet: TCharset;
  All: Boolean = True
  ): string;
function TrimChar(
  const Str: String;
  CharSet: TCharSet;
  All: Boolean = True
  ): string;

function TrimSlash(const Str: String): String;
deprecated; // use ExcludeTrailingPathDelimiter
function TrimLeftSlash(const Str: String): String;
deprecated; // use ExcludeTrailingPathDelimiter
function TrimRightSlash(const Str: String): String;
deprecated; // use ExcludeTrailingPathDelimiter

function Empty(Str: string): Boolean; overload;
deprecated; //use Trim(Str) = '';

function RightJustify(Buffer: String; Size: Integer): String;
function LeftJustify(Buffer: String; Size: Integer): String;

function ExtractDelimitedString(Str: string; Index: Integer; Delim: string):
  string;
function BoolStr(
  Exp: Boolean;
  TrueStr: String = 'True';
  FalseStr: String = 'False'
  ): string;
function VarRecToStr(VarRec: TVarRec): String;
function SplitName(Str1, Str2: String): String;

function DecodeURL(Str: string): string;
function EncodeURL(Str: string): string;

function FirstLine(Text: String): String; // this is too specific to be in here!


implementation

uses
  omMathUtils
{$IFDEF Delphi6plus}
  , Variants
{$ENDIF}

{$IFDEF Testing}
  , omTestMastery
  , omDateUtils
  , omUtilsTestSuite
{$ENDIF}
  ;

// _____________________________________________________________________________
(**
  Checks that the source string comforms to the pattern.
*)

function StrPatternCmp(Source, Pattern: String; IsCaseInsensitive: Boolean):
  Boolean;
var
  SourceArray: array[0..255] of Char;
  pPattern: array[0..255] of Char;

  function MatchPattern(Element, Pattern: PChar): Boolean;

    function IsPatternWild(Pattern: PChar): Boolean;
    begin
      Result := StrScan(Pattern, '*') <> nil;
      if not Result then
      begin
        Result := StrScan(Pattern, '?') <> nil;
      end;
    end; { IsPatternWild }

  begin
    if (StrComp(Pattern, '*') = 0) then
    begin
      Result := True;
    end
    else if (Element^ = Chr(0)) and (Pattern^ <> Chr(0)) then
    begin
      Result := False;
    end
    else if Element^ = Chr(0) then
    begin
      Result := True;
    end
    else
    begin
      case Pattern^ of
        '*':
          if MatchPattern(Element, PChar(@Pattern[1])) then
          begin
            Result := True;
          end
          else
          begin
            Result := MatchPattern(PChar(@Element[1]), Pattern);
          end;

        '?': Result := MatchPattern(PChar(@Element[1]), PChar(@Pattern[1]));

      else
        if IsCaseInsensitive then
        begin
          Result := Uppercase(Element^) = Uppercase(Pattern^);
        end
        else
        begin
          Result := Element^ = Pattern^;
        end;

        if Result then
        begin
          Result := MatchPattern(PChar(@Element[1]), PChar(@Pattern[1]));
        end
        else
        begin
          Result := False;
        end;
      end; { case }
    end; { if Strcmp.. }
  end; { MatchPattern }

begin
  StrPCopy(SourceArray, Source);
  StrPCopy(pPattern, Pattern);
  Result := MatchPattern(SourceArray, pPattern);
end; { StrPatternCmp }

// _____________________________________________________________________________
(**
Returns the (one-based) index of the first instance of any of a given set of chars
in a String.  Case Sensitive of course.
*)

function FindChar(
  const Text: String;
  const Chars: TCharSet
  ): Integer;
var
  Index: Integer;
begin
  for Index := 1 to Length(Text) do
  begin
    if Text[Index] in Chars then
    begin
      Result := Index;
      Exit;
    end;
  end;
  Result := 0;
end;

// _____________________________________________________________________________
(**
Same as 'Pos', but case insensitive.
*)

function FindText(
  Substr: string;
  Str: string
  ): Integer;
begin
  Substr := Uppercase(Substr);
  Str := Uppercase(Str);
  Result := Pos(Substr, Str);
end;

// _____________________________________________________________________________
(**
Deletes from a string to a string, including the strings.

@Returns the index of where it was deleted from
  (which is where replacement text should be inserted).
*)

function DeleteTextRange(
  const FromString, ToString: string;
  var Str: string
  ): Integer;
var
  TempStr: string;
  TempFromString: string;
  TempToString: string;
  StartIndex: Integer;
  FinalIndex: Integer;
begin
  TempStr := Uppercase(Str);
  TempFromString := Uppercase(FromString);
  TempToString := Uppercase(ToString);

  StartIndex := Pos(TempFromString, TempStr);
  FinalIndex := Pos(TempToString, Copy(TempStr, StartIndex + Length(FromString),
    Maxint));
  if (StartIndex <> 0) and (FinalIndex <> 0) then
  begin
    FinalIndex := FinalIndex + StartIndex + Length(FromString);
    Delete(Str, StartIndex, FinalIndex - StartIndex + Length(ToString) - 1);
  end;
  Result := StartIndex;
end;

// _____________________________________________________________________________
(**
Removes the text between 'FromString' and 'ToString' and inserts NewString.
(Originally designed for replacing the contents of a tag in html.)
*)

procedure SubstituteText(
  const FromString, ToString: string;
  const NewStr: string;
  var Str: string;
  All: Boolean
  );
var
  StartIndex: Integer;
  StuckPos: Integer;
begin
  StuckPos := -1;
  repeat
    StartIndex := DeleteTextRange(FromString, ToString, Str);
    if StartIndex <> 0 then
    begin
      Insert(ToString, Str, StartIndex);
      Insert(NewStr, Str, StartIndex);
      Insert(FromString, Str, StartIndex);
    end;
    if StartIndex <= StuckPos then
    begin
      raise Exception.Create('SubstituteText stuck in a loop!');
    end;
    StuckPos := StartIndex;
  until (not All) or (StartIndex = 0);
end;

// _____________________________________________________________________________
(**
Removes the text 'OldSubStr' and inserts NewString.
*)

procedure SubstituteText(
  const OldSubStr: string;
  const NewSubStr: string;
  var Str: string;
  All: Boolean
  );
var
  TempStr: string;
  TempOldSubStr: string;
  StartIndex: Integer;
begin
  TempOldSubStr := Uppercase(OldSubStr);
  repeat
    TempStr := Uppercase(Str);
    StartIndex := Pos(TempOldSubStr, TempStr);
    if (StartIndex <> 0) then
    begin
      Delete(Str, StartIndex, Length(OldSubStr));
      Insert(NewSubStr, Str, StartIndex);
    end;
  until (not All) or (StartIndex = 0);
end;

// ____________________________________________________________________________
(**
  returns a string of the difference in seconds between StartTime and EndTime.
*)

function StrTimeTaken(const StartTime: TDateTime; const EndTime: TDateTime):
  String;
const
  C_SecondsInDay = (24 * 60 * 60);
var
  TimeInfo: String;

begin
  TimeInfo := FormatFloat('##,###.###', (EndTime - StartTime) * C_SecondsInDay);

  if Empty(TimeInfo) then
  begin
    TimeInfo := '0.0';
  end
  else if Copy(TimeInfo, 1, 1) = '.' then
  begin
    TimeInfo := '0' + TimeInfo;
  end;

  Result := TimeInfo + ' seconds'
end;

// ____________________________________________________________________________
(**
  return the 'leftmost' substring of Length NumChar.
*)

function LeftStr(AString: String; LengthWanted: Integer): String;
begin
  Result := Copy(AString, 1, LengthWanted);
end;

// ____________________________________________________________________________
(**
  return the 'rightmost' substring of Length NumChar.
*)

function RightStr(AString: String; LengthWanted: Integer): String;
var
  StartPos: Integer;
begin
  StartPos := Length(AString) - LengthWanted + 1;

  if StartPos <= 0 then
  begin
    StartPos := 1;
  end;

  Result := Copy(AString, StartPos, LengthWanted);
end;

// ____________________________________________________________________________
(**
  return AString concatenated as many times as required by NumTimes.
*)

function Replicate(AString: String; NumTimes: Integer): String;
var
  Ctr: Integer;

begin
  Result := '';

  for Ctr := 1 to NumTimes do
  begin
    Result := Result + AString;
  end; {for}
end;

// ____________________________________________________________________________
(**
  return an empty string of Length NumSpaces.
*)

function Space(NumSpaces: Integer): String;
begin
  Result := Replicate(' ', NumSpaces);
end;

// ____________________________________________________________________________
(**
  pad a string with spaces on the left to Length StringLen.
  *)

function PadLeft(AString: String; StringLen: Integer; FillChar: String): String;

begin

  if (Length(AString) <> StringLen) then

  begin
    if FillChar = '' then
    begin
      FillChar := ' ';
    end;

    if Length(AString) > StringLen then
    begin
      {Length is smaller than string, so cut string to fit}
      Result := Copy(AString, 1, StringLen);
    end
    else
    begin
      {Length is bigger than string, so add spaces}
      Result := Replicate(FillChar, StringLen - Length(AString)) + AString
    end; {if}

  end

    {the string is already the appropriate Length}
  else
  begin

    Result := AString;

  end; {if}

end;

// ____________________________________________________________________________
(**
  pad a string with spaces on the right to Length StringLen.
*)

function PadRight(AString: String; StringLen: Integer; FillChar: String):
  String;
begin

  if (Length(AString) <> StringLen) then

  begin
    if FillChar = '' then
    begin
      FillChar := ' ';
    end;

    if Length(AString) > StringLen then
    begin
      {Length is smaller than string, so cut string to fit}
      Result := Copy(AString, 1, StringLen);
    end
    else
    begin
      {Length is bigger than string, so add spaces}
      Result := AString + Replicate(FillChar, StringLen - Length(AString))
    end; {if}

  end

    {the string is already the appropriate Length}
  else
  begin

    Result := AString;

  end; {if}

end;

// ____________________________________________________________________________
(**
  return a string, if necessary padded at both ends, of Length StringLen.
*)

function PadAndCentre(AString: String; StringLen: Integer; FillChar: String):
  String;
var
  AtLeft, AtRight: Integer;

begin

  if (Length(AString) <> StringLen) then

  begin
    if FillChar = '' then
    begin
      FillChar := ' ';
    end;

    if Length(AString) > StringLen then
    begin
      {Length is smaller than string, so cut string to fit}
      Result := Copy(AString, 1, StringLen);
    end
    else
    begin
      {Length is bigger than string, so add spaces}
      AtRight := (StringLen - Length(AString)) div 2;
      AtLeft := (StringLen - Length(AString)) - AtRight;
      Result := Replicate(FillChar, AtLeft) + AString + Replicate(FillChar,
        AtRight);
    end; {if}

  end

    {the string is already the appropriate Length}
  else
  begin

    Result := AString;

  end; {if}

end; {function}

// ____________________________________________________________________________
(**
  returns the number of times a string occurs in another string.
*)

function Occurs(StrToFind: String; StrToChk: String): Integer;
var
  TimesFound: Integer;

begin
  {assume the worst}
  TimesFound := 0;

  while Pos(StrToFind, StrToChk) > 0 do
  begin
    {we've found a(nother) occurence so increment TimesFound}
    Inc(TimesFound);

    {slice off the beginning of the string to the end of the sought after substring}
    StrToChk := RightStr(
      StrToChk,
      Length(StrToChk) - (Pos(StrToFind, StrToChk) + Length(StrToFind)) + 1);
  end;

  Occurs := TimesFound;
end;

// ____________________________________________________________________________
(**
  finds a string commencing at position 'StartPos'.
*)

function PosWithStart(const StrToFind: String; const StrToChk: String;
  const StartPos: Word): Integer;
var
  CopyStr: String;

begin
  if Length(StrToChk) >= StartPos then
  begin
    CopyStr := RightStr(StrToChk, (Length(StrToChk) - StartPos) + 1);
    if Pos(StrToFind, CopyStr) > 0 then
      if StartPos > 0 then
      begin
        Result := (Pos(StrToFind, CopyStr) + StartPos) - 1;
      end
      else
      begin
        Result := (Pos(StrToFind, CopyStr) + StartPos);
      end
        //				Result:= (Pos(StrToFind, CopyStr) + StartPos) - 1
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    Result := 0;
  end;

end;

// ____________________________________________________________________________
(**
  a la xBase, finds one type of string and replaces it with another.
*)

function StrTran(const StrToFind: String; const StrToChk: String;
  const RepStr: String): String;
var
  Place, Start: Integer;
  CopyStr: String;

begin
  if StrToFind = '' then
  begin
    Result := StrToChk;
  end
  else
  begin
    CopyStr := StrToChk;
    Start := 1;

    repeat
      Place := PosWithStart(StrToFind, CopyStr, Start);
      if Place > 0 then
      begin
        Delete(CopyStr, Place, Length(StrToFind));
        Insert(RepStr, CopyStr, Place);
        Start := Place + Length(RepStr);
      end;
    until Place = 0;

    Result := CopyStr;
  end;
end; {StrTran}

// ____________________________________________________________________________
(**
  case insensitive version of Pos().
*)

function TextPos(const StrToFind: String; const StrToChk: String): Integer;
begin
  Result := Pos(UpperCase(StrToFind), UpperCase(StrToChk));
end;

// ____________________________________________________________________________
(**
  an xBase at() like function.
*)

function StringPos(const StrToFind: String; const StrToChk: String; const
  Occurrence: Word): Integer;
var
  CopyStr: String;
  StringCtr: Word;

begin
  CopyStr := StrToChk;
  StringPos := 0;

  if Occurs(StrToFind, StrToChk) >= Occurrence then
  begin
    for StringCtr := 1 to (Occurrence - 1) do
    begin

      {slice off
       the beginning of the string
       to the end of the sought after substring}
      CopyStr := RightStr(CopyStr,
        Length(CopyStr) - (Pos(StrToFind, CopyStr) + Length(StrToFind)) + 1);

    end;

    {determine the position of the n'th occurrence by reference
    to the Length of the original and sliced up strings}
    StringPos := Length(StrToChk) - Length(CopyStr) + Pos(StrToFind, CopyStr);

  end;
end;

// ____________________________________________________________________________
(**
  strips quotes from the beginning and end of a string
    (used with comma delimited text file).
*)

function StripQuotes(const AString: String): String;
begin
  Result := TrimChar(AString, ['"'], False);
end;

// ____________________________________________________________________________
(**
  adds quotes to the beginning and end of a string (used with SQL engines).
*)

function AddQuotes(AString: String): String;
begin
  Result := '"' + AString + '"';
end;

// ____________________________________________________________________________
(**
  a case INsensitive seek which checks BString only to the Length of AString.
*)

function CompareInitial(AString: String; BString: String): Integer;
begin
  Result := CompareText(AString, Copy(BString, 1, Length(AString)));
end;

// ____________________________________________________________________________
(**
  a case Sensitive seek which checks BString only to the Length of AString.
*)

function CompareInitialStr(AString: String; BString: String): Integer;
begin
  Result := CompareStr(AString, Copy(BString, 1, Length(AString)));
end;

// ____________________________________________________________________________
(**
  converts a variant to a string.
*)

function VariantToStr(const AVariant: Variant): String;
begin
  case VarType(AVariant) of
    varEmpty: Result := '';
    varNull: Result := 'Null';
    varSmallInt: Result := IntToStr(AVariant);
    varInteger: Result := IntToStr(AVariant);
    varSingle: Result := FloatToStr(AVariant);
    varDouble: Result := FloatToStr(AVariant);
    varCurrency: Result := FloatToStr(AVariant);
    varDate: Result := DateToStr(AVariant);
    varOleStr: Result := AVariant;
    varDispatch: Result := 'Dispatch';
    varError: Result := 'Error';
    varBoolean: Result := AVariant;
    varVariant: Result := 'Variant';
    varUnknown: Result := '';
    varString: Result := AVariant;
  else
    Result := 'Error';
  end;
end;

// ____________________________________________________________________________
(**
  doesn't choke on an empty string.
  @deprecated - use StrToIntDef
*)

function SafeStrToInt(AString: String): Integer;
begin
  if Empty(AString) then
  begin
    Result := 0;
  end
  else
  begin
    Result := StrToInt(Trim(AString));
  end;
end;

// ____________________________________________________________________________
(**
  doesn't choke on an empty string.
  @deprecated - use StrToFloatDef
*)

function SafeStrToFloat(AString: String): Double;
begin
  Result := StrToFloatDef(AString, 0);
  //	if Empty(AString) or (AString[1] = '') then
  //		Result:= 0.0
  //	else begin
  //		Result:= StrToFloat(AString);
  //	end;
end;

// ____________________________________________________________________________
(**
  doesn't choke on an empty string.
  @deprecated use StrToDateDef
*)

function SafeStrToDate(AString: String): TDateTime;
begin
  Result := StrToDateDef(AString, 0);
  //	if Empty(AString) then
  //		Result:= 0
  //	else begin
  //		Result:= StrToDate(AString);
  //	end;
end;

// ____________________________________________________________________________
(**
  returns the float representation of a string or a default value if the string
  does not contain a valid number.
*)

function StrToFloatDef(AString: String; Default: Double): Double;
var
  Status: Boolean;
  Temp: Extended;
begin
  Status := TextToFloat(PChar(AString), Temp, fvExtended);
  if Status then
  begin
    Result := Temp;
  end
  else
  begin
    Result := Default;
  end;
end;

// ____________________________________________________________________________
(**
  return a number with commas inserted.
*)

function Commas(
  Value: Double;
  Places: Integer;
  StrLength: Integer = 0;
  AlignPadding: TomWantRightAlignPadding = wrNoRightAlignPadding
  ): String;
var
  IsNegative: Boolean;
  RawStr: String;
  DotPos: Integer;

  Body: String;
  Mantissa: String;
  LenBody: Integer;
  BodyCtr: Integer;
  BlockCtr: Integer;
  ReverseBody: String;
  FormatBody: String;

  RightAlignPad: String;

begin
  {if necessary, round Value to the nominated number of decimal places}
  if Places > 0 then
  begin
    Value := omMathUtils.Round(Value, Places)
  end;

  {we need to know if we've got a negative value}
  IsNegative := Lesser(Value, 0.0, 2);

  {get the value as a string}
  if Equal(Value, 0.0, 2) then
  begin
    RawStr := '0.0';
  end
  else
  begin
    RawStr := FloatToStr(Value);
  end;

  {if it's negative, strip away the minus sign}
  if RawStr[1] = '-' then
  begin
    Delete(RawStr, 1, 1);
  end;
  //	RawStr:= iif(IsNegative, RightStr(RawStr, Length(RawStr) - 1), RawStr);

   {determine where the decimal point is}
  DotPos := Pos('.', RawStr);

  Body := RawStr;
  Mantissa := '';
  if DotPos > 0 then
  begin
    Body := LeftStr(RawStr, DotPos - 1);

    if Places > 0 then
    begin
      Mantissa := Copy(RawStr, DotPos + 1, Places);
    end;
  end;

  {pad the mantissa out with the apprpriate number of 0's}
  Mantissa := PadRight(Mantissa, Places, '0');

  LenBody := Length(Body);
  ReverseBody := '';
  BlockCtr := 1;
  FormatBody := Body;
  if LenBody > 3 then
  begin

    for BodyCtr := LenBody downto 1 do
    begin
      ReverseBody := ReverseBody + Copy(Body, BodyCtr, 1);

      if (BlockCtr < LenBody) and ((BlockCtr mod 3) = 0) then
      begin
        ReverseBody := ReverseBody + ',';
      end;

      Inc(BlockCtr);
    end;

    {read the reversed string back into the correct order}
    FormatBody := '';
    for BodyCtr := Length(ReverseBody) downto 1 do
    begin
      FormatBody := FormatBody + Copy(ReverseBody, BodyCtr, 1);
    end;

  end;

  //	RawStr:= FormatBody + iif(not Empty(Mantissa), '.' + Mantissa, Mantissa);
  if Mantissa <> '' then
  begin
    RawStr := FormatBody + '.' + Mantissa;
  end
  else
  begin
    RawStr := FormatBody;
  end;

  if AlignPadding = wrNoRightAlignPadding then
  begin
    RightAlignPad := '';
  end
  else
  begin
    RightAlignPad := ' ';
  end;

  {add brackets as necessary}
  if IsNegative then
  begin
    RawStr := '(' + RawStr + ')'
  end
  else
  begin
    RawStr := RawStr + RightAlignPad;
  end;

  {pad the string to the correct Length}
  if StrLength > 0 then
  begin
    //		Result:= PadLeft(RawStr, iif(IsNegative, (StrLength + 1), StrLength), ' ')
    //    if IsNegative then begin
    //      Inc(StrLength{,2???});
    //    end;
    if StrLength >= Length(RawStr) then
    begin
      Result := PadLeft(RawStr, StrLength, ' ');
    end
    else
    begin
      Result := PadLeft('', StrLength - Length(RightAlignPad), '#') +
        RightAlignPad;
    end;
  end
  else
  begin
    Result := RawStr;
  end;
end;

// ____________________________________________________________________________
(**
  return a monetary amount in the form $23.72 or ($76,772.04).
*)

function CurrencyStr(
  Value: Double;
  CurrencySymbol: String = '';
  StrLength: Integer = 0;
  Decimals: TomWantDecimals = wdWantDecimals;
  AlignPadding: TomWantRightAlignPadding = wrNoRightAlignPadding
  ): String;
begin
  if Decimals = wdWantDecimals then
  begin
    Result := Commas(Value, 2, 0);
  end
  else
  begin
    Result := Commas(Value, 0, 0);
  end;
  if GreaterEqual(Value, 0.0, 2) then
  begin
    if StrLength > 0 then
    begin
      Result := PadLeft(CurrencySymbol + Result, StrLength, ' ');
    end
    else
    begin
      Result := CurrencySymbol + Result;
    end;
  end
  else
  begin
    if StrLength > 0 then
    begin
      Result := PadLeft(LeftStr(Result, 1) + CurrencySymbol + RightStr(Result,
        Length(Result) - 1), StrLength, ' ');
    end
    else
    begin
      Result := LeftStr(Result, 1) + CurrencySymbol + RightStr(Result,
        Length(Result) - 1);
    end;
  end;
end;

// ____________________________________________________________________________
(**
  return a monetary amount in the form $23 or ($76,772).
*)

function DollarStr(Value: Double; StrLength: Integer): String;
var
  TempStr: String;

begin
  TempStr := CurrencyStr(Value, '$', 0);
  if GreaterEqual(Value, 0.0, 2) then
  begin
    if StrLength > 0 then
    begin
      Result := PadLeft(LeftStr(TempStr, Length(TempStr) - 3), StrLength, '');
    end
    else
    begin
      Result := LeftStr(TempStr, Length(TempStr) - 3);
    end;
  end
  else
  begin
    TempStr := Copy(TempStr, 1, Length(TempStr) - 4);

    if StrLength > 0 then
    begin
      Result := PadLeft(TempStr + ')', Length(TempStr) - 3, '');
    end
    else
    begin
      Result := TempStr + ')';
    end
  end;
end;

// ____________________________________________________________________________
(**
  return a monetary amount in the form £23 or (£76,772).
*)

function SterlingStr(
  Value: Double;
  StrLength: Integer = 0;
  Decimals: TomWantDecimals = wdNoDecimals;
  AlignPadding: TomWantRightAlignPadding = wrNoRightAlignPadding;
  AddCurrencySign: TomWantCurrencySign = wdWantCurrencySign
  ): String;
var
  CurrencySign: String;

begin
  if (AddCurrencySign = wdWantCurrencySign) then
  begin
    CurrencySign := PoundSign;
  end
  else
  begin
    CurrencySign := '';
  end;

  Result := CurrencyStr(Value, CurrencySign, 0, Decimals);
  if GreaterEqual(Value, 0.0, 2) then
  begin
    if StrLength > 0 then
    begin
      Result := PadLeft(Result, StrLength, '');
    end
  end
  else
  begin
    // it's negative

    // are these two lines necessary???
    Result := TrimChar(Result, ['(', ')', ' ']);
    Result := '(' + Result + ')';

    if StrLength > 0 then
    begin
      Result := PadLeft(Result, StrLength, ' ');
    end;
  end;
end;

// ____________________________________________________________________________
(**
  return a percentage in the form '12.345%' for the imput 0.12345.
*)

function PercentageStr(
  Value: Double;
  StrLength: Integer = 0;
  Decimals: Integer = 0;
  NegativeBrackets: Boolean = false
  ): String;
var
  TempFormat: String;
begin
  if StrLength > 0 then
  begin
    // leave room  for the '%'
    Dec(StrLength);
  end;
  if GreaterEqual(Value, 0.0, Decimals + 1) or not NegativeBrackets then
  begin
    TempFormat := Format('%%%d.%df%%%%', [StrLength, Decimals]);
    Result := Format(TempFormat, [Value * 100]);
  end
  else
  begin
    // it's negative
    TempFormat := Format('(%%%d.%df%%%%)', [StrLength, Decimals]);
    Result := Format(TempFormat, [Value * (-100)]);
  end;
end;

// ____________________________________________________________________________
(**
  convert a value into a 'bank cheque' string.
*)

function BankCurrencyStr(Value: Double): String;
var
  Tmp, IntegerPortion, DecimalPortion: String;
  Dollars, Cents: Integer;
  NegValue: Boolean;

begin
  if Lesser(Value, 0.0, 2) then
  begin
    NegValue := True;
  end
  else
  begin
    NegValue := False;
  end;

  Value := Abs(Value);

  Tmp := FormatFloat('#########0.00', Value); {Format Value to 2 DP}
  IntegerPortion := LeftStr(Tmp, Length(Tmp) - 3); {Strip Integer portion}
  DecimalPortion := RightStr(Tmp, 3); {Fractional portion}

  Dollars := StrToInt(IntegerPortion);
  Cents := StrToInt(RightStr(DecimalPortion, 2));

  Tmp := ValueAsWords(Dollars) + ' Dollars'; {Form Name from Integer portion}

  if Cents > 0 then
  begin {Form Name from fractional portion}
    Tmp := Tmp + ' and ' + ValueAsWords(Cents) + ' Cents';
  end;

  if NegValue then
  begin {Add parentheses if negative marker set}
    Tmp := '(' + Tmp + ')';
  end;

  Result := Tmp;
end;

// ____________________________________________________________________________
(**
  convert a variant into an 'TomFlex index compatible' string.
*)

function AsFlexIndexStr(AValue: Variant): String;
begin
  case VarType(AValue) of
    varInteger: Result := PadLeft(IntToStr(AValue), 12, ' ');
    varDouble: Result := PadLeft(FloatToStr(AValue), 18, ' ');
    //    varDate:  	 Result:= DateStrAsIndexStr(AValue);
  else
    raise Exception.Create('Index1 cannot convert the type passed in');
  end;
end;

// ____________________________________________________________________________
(**
convert a value into its 'word' representation.
*)

function ValueAsWords(Value: Integer): String;
const
  Name09: array[0..9] of String[5] =
  ('Zero', 'One', 'Two', 'Three', 'Four', 'Five',
    'Six', 'Seven', 'Eight', 'Nine');

  Name10s: array[2..9] of String[7] =
  ('Twenty', 'Thirty', 'Forty', 'Fifty',
    'Sixty', 'Seventy', 'Eighty', 'Ninety');

  NameTeens: array[0..9] of String[9] =
  ('Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen',
    'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen');

  Name100: String[9] = ' Hundred';
  Name1000: String[9] = ' Thousand';
  NameMillion: String[9] = ' Million';
  NameBig: String[9] = 'Too big';

  {-----------------------------------------}

  procedure Convert1000s(var Str: String; Value: Integer);
  var
    Work: Integer;

  begin
    if (Value >= 100) then
    begin
      Work := Value div 100;
      Str := Str + ' ' + Name09[Work] + Name100; {Hundreds}
      Value := Value mod 100;
      if Value > 0 then
      begin
        Str := Str + ' and'
      end;
    end;

    if (Value >= 20) then
    begin
      Str := Str + ' ' + Name10s[Value div 10];
      Value := Value mod 10;
    end;

    if (Value >= 10) then
    begin
      Str := Str + ' ' + NameTeens[Value - 10];
    end
    else if (Value mod 10) > 0 then
    begin
      Str := Str + ' ' + Name09[Value mod 10];
    end
    else if (Value > 0) then
    begin
      Str := Str + ' ' + Name09[Value];
    end;

  end;

  {----------------------------------------------------}

var
  NegValue: Boolean;

begin
  NegValue := False;
  if (Value = 0) then
  begin
    Result := Name09[0]; {Zero Value}
  end

  else if (Value > 999999999) then
  begin {Out of Range Value}
    Result := NameBig;
  end

  else
  begin

    Result := '';
    if Value < 0 then
    begin
      NegValue := True; {Save Negative Marker}
      Value := Abs(Value); {Make Absolute}
    end;

    {Do millions}
    if (Value >= 1000000) then
    begin
      Convert1000s(Result, Value div 1000000);
      Result := Result + NameMillion;
      Value := Value mod 1000000;

      if (Value < 100) and (Value > 0) then
      begin
        Result := Result + ' and '; {For 1000001 etc}
      end;
    end;

    {Do thousands}
    if (Value >= 1000) then
    begin
      Convert1000s(Result, Value div 1000);
      Result := Result + Name1000;
      Value := Value mod 1000;

      if (Value < 100) and (Value > 0) then
      begin
        Result := Result + ' and ';
      end;
    end;

    {do portion less than 1000}
    Convert1000s(Result, Value);

  end;

  Result := Trim(Result); {Remove blanks}
  {Add parentheses if Negative marker set}
  if NegValue = True then
  begin
    Result := '(' + Result + ')';
  end;

end;

// ____________________________________________________________________________
(**
  convert a Malmsbury to its inverse (for reverse indexing).
*)
(*
function NineComp(CompMalm: String; CompMinus: Boolean): String;
var
  LenMalm: Integer;
  TrimMalm: String;
  LenTrim: Integer;

  MinusMalm: Boolean;
  Counter: Integer;
  WorkMalm: String;
  StartMalm: Integer;

begin
  {remember the Length of the passed in Malmsbury}
  LenMalm:= Length(CompMalm);

  {determine its significant portion}
  TrimMalm:= Trim(CompMalm);

  {and the Length thereof}
  LenTrim:= Length(TrimMalm);

  {initialise the return value}
  if LeftStr(TrimMalm, 1) = '-' then
    begin
      {a negative Malmsbury}
      MinusMalm:= True;

      {since it's a negative, we fill in spaces with 0's unless CompMinus is set}
      WorkMalm:= '-' +
        RightStr(Replicate(iif(CompMinus, '9', '0'), LenMalm) +
        RightStr(TrimMalm, (LenTrim - 1)), LenMalm);

      {and remember where the significant part begins}
      StartMalm:= (LenMalm - LenTrim) + 3;
    end
  else begin
    {not a "negative" Malmsbury}
    MinusMalm:= False;

    {fill in spaces with 9's}
    WorkMalm:= ' ' +
      RightStr(Replicate('9', LenMalm) + RightStr(TrimMalm, LenTrim), LenMalm);

//    {fill in spaces with 9's}
//    WorkMalm:= '+' +
//      RightStr(Replicate('9', LenMalm) + RightStr(TrimMalm, LenTrim), LenMalm);

    {and remember where the significant part begins}
    StartMalm:= (LenMalm - LenTrim) + 2;
  end;

  {initialise the return variable with the non-significant start bit}
  Result:= LeftStr(WorkMalm, (StartMalm - 1));

  {............................................................................}

  {work through each digit in WorkMalm}
  for Counter:= StartMalm to (LenMalm + 1) do begin

    {if it's already negative, don't complement the numbers}
    if MinusMalm and not CompMinus then
      begin
        Result:= WorkMalm;
        Break;
      end
    else begin
      {add the complement of each character of WorkMalm to ReturnValu}
      if Pos(Copy(WorkMalm, Counter, 1), Chr(32) + '·0·1·2·3·4·5·6·7·8·9·') > 0 then
        {convert the next number}
        Result:= Result + Trim(IntToStr(9 - StrToInt(Copy(WorkMalm, Counter, 1))))
      else begin
        {it's not a number, don't convert it}
        Result:= Result + Copy(WorkMalm, Counter, 1)
      end;
    end;
  end;
end;
*)
// ____________________________________________________________________________
(**
  determines whether the first character of the passed in string is in a..Z.
*)

function IsAlpha(AString: String): Boolean;
begin
  Result := AString[1] in ['A'..'Z', 'a'..'z'];
end;

// ____________________________________________________________________________
(**
  determines whether the any characters of the passed in string are in a..Z.
*)

function HasAlpha(AString: String): Boolean;
var
  CharCtr: Integer;
begin
  Result := False;

  for CharCtr := 1 to Length(AString) do
  begin
    if AString[CharCtr] in ['A'..'Z', 'a'..'Z'] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

// ____________________________________________________________________________
(**
   determines whether the first character of the passed in string is in 0..9.
*)

function IsDigit(AString: String): Boolean;
begin
  Result := AString[1] in ['0'..'9'];
end;
// ____________________________________________________________________________
(**
   determines whether the contents of the passed in string is in 0..9.
*)

function IsNumeric(AString: String): Boolean;
var
  Index: integer;
begin
  Result := True;
  for Index := 1 to Length(AString) do
  begin
    if not (AString[Index] in ['0'..'9']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;
// ____________________________________________________________________________
(**
  returns the extension from path + file name.
  @deprecated
  *)

function GetFileExtension(FileString: String): String;
var
  FoundDot: Boolean;
  LenFileString, CharCtr: Integer;

begin
  raise Exception.Create('Use omURLS.TomFilename');
  LenFileString := Length(FileString);

  Result := '';
  FoundDot := False;
  for CharCtr := LenFileString downto 1 do
  begin
    if Copy(FileString, CharCtr, 1) = '.' then
    begin
      FoundDot := True;
      Break;
    end;
  end;

  if FoundDot then
  begin
    Result := Copy(FileString, CharCtr + 1, LenFileString);
  end;
end;

// ____________________________________________________________________________
(**
  returns the file name, without extension, from path + file name.
  @deprecated
*)

(*
function GetFileName(FileString: String): String;
var
  CharCtr: Integer;
  FullFileName: String;
  LenFileName: Integer;
  FoundDot: Boolean;

begin
  raise Exception.Create('Use omURLS.TomFilename');
  {determine the file name with extension}
  FullFileName := GetFullFileName(FileString);

  Result := FullFileName;
  LenFileName := Length(FullFileName);

  FoundDot := False;
  for CharCtr := LenFileName downto 1 do
  begin
    if Copy(FullFileName, CharCtr, 1) = '.' then
    begin
      FoundDot := True;
      Break;
    end;
  end;

  if FoundDot then
  begin
    Result := Copy(FullFileName, 1, CharCtr - 1);
  end;
end;
*)

// ____________________________________________________________________________
(**
  returns the file name, with extension, from path + file name.
  @deprecated
*)

(*
function GetFullFileName(FileString: String): String;
var
  FoundSlash: Boolean;
  LenFileString, CharCtr: Integer;

begin
  raise Exception.Create('Use omURLS.TomFilename');
  Result := FileString;
  LenFileString := Length(FileString);

  FoundSlash := False;
  for CharCtr := LenFileString downto 1 do
  begin
    if Copy(FileString, CharCtr, 1) = '\' then
    begin
      FoundSlash := True;
      Break;
    end;
  end;

  if FoundSlash then
  begin
    Result := Copy(FileString, CharCtr + 1, LenFileString);
  end;
end;
*)

// ____________________________________________________________________________
(**
  returns the path from a "path + file" string.
  @deprecated - use ExtractFilePath
*)

function _GetPath(FileString: String): String;
var
  FoundSlash: Boolean;
  LenFileString, CharCtr: Integer;

begin
  Result := FileString;
  LenFileString := Length(FileString);

  FoundSlash := False;
  for CharCtr := LenFileString downto 1 do
  begin
    if Copy(FileString, CharCtr, 1) = '\' then
    begin
      FoundSlash := True;
      Break;
    end;
  end;

  if FoundSlash then
  begin
    Result := Copy(FileString, 1, CharCtr);
  end;
end;

// ____________________________________________________________________________
(**
  ensures that a path has a trailing slash.
  @deprecated - use AppendSlash
*)

// _____________________________________________________________________________
{**
  removes one or more leading chars from a string

  @param Str:String The string from which to remove and leading characters
  @param CharSet Characters to be stripped
  @param All boolean false to strip one occurance; true to strip all occurances
  @Result: string The string that doesn't start with a characters
}

function TrimLeftChar(
  const Str: String;
  CharSet: TCharSet;
  All: Boolean = True
  ): string;
begin
  Result := Str;
  while (Result <> '') and (Result[1] in CharSet) do
  begin
    System.Delete(Result, 1, 1);
    if not All then
    begin
      break;
    end;
  end;
end; { StripLeadingSlash }

// _____________________________________________________________________________
{**
  removes any trailing chars from a string

  @param Str:String The string from which to remove and leading slashs
  @param CharSet Characters to be stripped
  @param All boolean false to strip one occurance; true to strip all occurances
  @param Result: string The string that doesn't start with a slash
}

function TrimRightChar(
  const Str: String;
  CharSet: TCharSet;
  All: Boolean = True
  ): string;
begin
  Result := Str;
  while (Result <> '') and (Result[Length(Result)] in CharSet) do
  begin
    SetLength(Result, Length(Result) - 1);
    if not All then
    begin
      break;
    end;
  end;
end; { StripLeadingSlash }

// _____________________________________________________________________________
{**
  removes any leading or trailing chars from a string

  @param Str:String The string from which to remove and leading slashs
  @param Result: string The string that doesn't start with a slash
}

function TrimChar(
  const Str: String;
  CharSet: TCharSet;
  All: Boolean = True
  ): string;

begin
  Result := Str;
  Result := TrimLeftChar(Result, Charset);
  Result := TrimRightChar(Result, Charset);
end;

// _____________________________________________________________________________
{**
  removes any leading or trailing slashes from a string

  @param Str:String The string from which to remove and leading slashs
  @param Result: string The string that doesn't start with a slash
}

function TrimSlash(const Str: String): String;
begin
  Result := TrimChar(Str, ['\', '/']);
end;

// _____________________________________________________________________________
{**
  removes any leading slashes from a string

  @param Str:String The string from which to remove and leading slashs
  @param Result: string The string that doesn't start with a slash
}

function TrimLeftSlash(const Str: String): String;
begin
  Result := TrimLeftChar(Str, ['\', '/']);
end;

// _____________________________________________________________________________
{**
  removes any trailing chars from a string

  @param Str:String The string from which to remove and leading slashs
  @param Result: string The string that doesn't start with a slash
}

function TrimRightSlash(const Str: String): String;
begin
  Result := TrimRightChar(Str, ['\', '/']);
end;

// _____________________________________________________________________________
{**
  returns True if a string contains nothing but whitespace.

  @param Str:String The string to check
  @param Result: Boolean True if a string contains nothing but whitespace
}

function Empty(Str: string): Boolean;
begin
  Result := Trim(Str) = '';
end;

function LeftJustify(Buffer: String; Size: Integer): String;
var
  Len: Integer;
  Delta: Integer;

begin
  Len := Length(Buffer);
  Delta := Size - Len;

  if (Len <> Size) then
  begin
    // If string in buffer is longer than Size, then truncate.
    if (Len > Size) then
    begin
      Result := Copy(Buffer, 1, Size)
    end
      // If string in buffer is shorter than Size, then pad out.
    else
    begin
      SetLength(Result, Delta);
      FillChar(PChar(Result)^, Delta, ' ');
      Result := Buffer + Result;
    end; { if }
  end
  else
  begin
    Result := Buffer;
  end; { if }
end;


function RightJustify(Buffer: String; Size: Integer): String;
var
  Len: Integer;
  Delta: Integer;

begin
  Len := Length(Buffer);
  Delta := Size - Len;

  if (Len <> Size) then
  begin
    // If string in buffer is longer than Size, then truncate.
    if (Len > Size) then
    begin
      Result := Copy(Buffer, 1, Size)
    end
      // If string in buffer is shorter than Size, then pad out.
    else
    begin
      SetLength(Result, Delta);
      FillChar(PChar(Result)^, Delta, ' ');
      Result := Result + Buffer;
    end; { if }
  end
  else
  begin
    Result := Buffer;
  end; { if }
end;

function ExtractDelimitedString(
  Str: string;
  Index: Integer;
  Delim: string
  ): string;
var
  Pos: Integer;
  Temp: Integer;
  Start, Final: Integer;
  Counter: Integer;
begin
  Temp := 1;
  Final := 0;
  Start := 1;
  for Counter := 0 to Index do
  begin
    Start := Temp;
    Pos := FindText(Delim, Copy(Str, Start, Maxint));
    if Pos <> 0 then
    begin
      Final := Start + Pos - 1;
    end
    else
    begin
      Final := Length(Str) + 1;
    end;
    if Counter <> Index then
    begin
      Temp := Final + Length(Delim);
    end;
  end;

  Result := Copy(Str, Start, Final - Start);
  Exit;
end;

function FormattedStrToDouble(Str: String): Double;
var
  TempStr: String;

begin
  TempStr := FilterChars(Str, ['0'..'9', '.', '-']);
  Result := StrToFloatDef(TempStr, 0);
end;


function FormattedStrToInt(Str: String): Integer;
var
  TempFloat: Double;
begin
  TempFloat := FormattedStrToDouble(Str);
  Result := Trunc(TempFloat);
end;


function FilterChars(Str: String; CharSet: TCharSet): String;
var
  Index: Integer;
begin
  Result := '';
  for Index := 1 to Length(Str) do
  begin
    if Str[Index] in CharSet then
    begin
      Result := Result + Str[Index];
    end;
  end;
end;


function BoolStr(
  Exp: Boolean;
  TrueStr: String = 'True';
  FalseStr: String = 'False'
  ): string;
begin
  if Exp then
  begin
    Result := TrueStr;
  end
  else
  begin
    Result := FalseStr;
  end;
end;

function VarRecToStr(VarRec: TVarRec): string;
begin
  case VarRec.VType of
    vtInteger: Result := IntToStr(VarRec.VInteger);
    vtBoolean: Result := BoolStr(VarRec.VBoolean);
    vtChar: Result := VarRec.VChar;
    vtExtended: Result := FloatToStr(VarRec.VExtended^);

    vtString: Result := VarRec.VString^;
    vtPChar: Result := VarRec.VPChar;
    vtObject: Result := '<<' + VarRec.VObject.ClassName + '>>';
    vtClass: Result := '<<' + VarRec.VClass.ClassName + '>>';
    vtAnsiString: Result := string(VarRec.VAnsiString);
    vtCurrency: Result := CurrToStr(VarRec.VCurrency^);
    vtVariant: Result := string(VarRec.VVariant^);
    vtInt64: Result := IntToStr(VarRec.VInt64^);
  end;
end;



// see http://www.blooberry.com/indexdot/html/topics/urlencoding.htm

function DecodeURL(Str: string): string;
var
  Index1: Integer;
  ESC: string[2];
  CharCode: integer;
begin
  Result := '';
  Str := StringReplace(Str, '+', ' ', [rfReplaceAll]);
  Index1 := 1;
  while Index1 <= Length(Str) do
  begin
    if Str[Index1] <> '%' then
    begin
      Result := Result + Str[Index1]
    end
    else
    begin
      Inc(Index1); // skip the % char
      ESC := Copy(Str, Index1, 2); // Copy the escape code
      Inc(Index1, 1); // Then skip it.
      try
        CharCode := StrToInt('$' + ESC);
        if (CharCode > 0) and (CharCode < 256) then
        begin
          Result := Result + Char(CharCode);
        end;
      except
        ;
      end;
    end;
    Inc(Index1);
  end;
end;

function EncodeURL(Str: string): string;
const
  UnsafeChars: set of char = [chr(0)..chr($20), '*', '#', '%', '<', '>',
  chr($80)..chr($FF)];
var
  Index1: Integer;
begin
  Result := '';
  for Index1 := 1 to Length(Str) do
  begin
    if Str[Index1] in UnsafeChars then
    begin
      Result := Result + '%' + IntToHex(Ord(Str[Index1]), 2);
    end
    else
    begin
      Result := Result + Str[Index1];
    end;
  end;
end;

(**
    SplitName produces a string that is lexigraphically between the two supplied
    parameters.  It is used for generating strings for sorting purposes.
*)

function SplitName(Str1, Str2: String): String;
var
  Difference: Integer;
  MaxLength: Integer;
  Index: Integer;
begin
  if Str1 = Str2 then
  begin
    raise Exception.Create('Can''t split names when they are equal');
  end;

  MaxLength := Min(Length(Str1), Length(Str2));
  for Index := 1 to MaxLength do
  begin
    if Str1[Index] <> Str2[Index] then
    begin
      Break;
    end;
  end;

  Difference := Ord(Str1[Index]) - Ord(Str2[Index]);
  if Difference > 0 then
  begin
    if Difference = 1 then
    begin
      Result := Copy(Str2, 1, Index) + 'm';
    end
    else
    begin
      Result := Copy(Str1, 1, Index - 1) + Chr(Ord('a') + Difference + 1);
    end;
  end
  else
  begin
    if Difference = -1 then
    begin
      Result := Copy(Str1, 1, Index) + 'm';
    end
    else
    begin
      Result := Copy(Str2, 1, Index - 1) + Chr(Ord('a') - Difference + 1);
    end;
  end;
end;

function FirstLine(Text: String): String;
var
  Index: Integer;

begin
  Index := Pos(#13, Text);
  if Index <> 0 then
  begin
    Result := Copy(Text, 1, Index - 1);
  end
  else
  begin
    Result := Text;
  end;
  if Result <> Text then
  begin
    Result := Result + ' ***';
  end;
end;

// =============================================================================
// Testing

{$IFDEF Testing}

type
  TomTestSuiteStrUtils = class(TomTestSuite)
  private
  published
    procedure Test_Commas;
    procedure Test_CurrencyStr;
    procedure Test_DeleteTextRange;
    procedure Test_FindText;
    procedure Test_StrPatternCmp;
    procedure Test_SubstituteText;
    procedure Test_Justify;
    procedure Test_SterlingStr;
    procedure Test_PercentageStr;
    procedure Test_StrConversions;
    procedure Text_ExtractDelimitedString;
    procedure Test_BoolStr;
    procedure Test_VarRecToStr;
    procedure Test_FormattedStrToDouble;
    procedure Test_EncodeURL_DecodeURL;
    procedure Test_SplitName;
    //    procedure Test_StripQuotes;
  end;

procedure TomTestSuiteStrUtils.Test_StrPatternCmp;
begin
  Assert(StrPatternCmp('', ''));
  Assert(StrPatternCmp('', '*'));
  Assert(StrPatternCmp('Text', 'Tex*'));
  Assert(not StrPatternCmp('text', 'Tex*'));
  Assert(not StrPatternCmp('ABC', 'abcdef'));
  Assert(not StrPatternCmp('abc', 'abcdef'));

  // case sensitive
  Assert(StrPatternCmp('', '', True));
  Assert(StrPatternCmp('', '*', True));
  Assert(StrPatternCmp('Text', 'Tex*', True));
  Assert(StrPatternCmp('text', 'Tex*', True));
  Assert(not StrPatternCmp('ABC', 'abcdef', True));
  Assert(not StrPatternCmp('abc', 'abcdef', True));
end;

procedure TomTestSuiteStrUtils.Test_FindText;
begin
  Assert(FindText('', '') = 0);
  Assert(FindText('', '*') = 0);
  Assert(FindText('ABC', 'abcdef') = 1);
  Assert(FindText('abc', 'abcdef') = 1);
  Assert(FindText('cde', 'abcdef') = 3);
  Assert(FindText('def', 'abcdef') = 4);
  Assert(FindText('efg', 'abcdef') = 0);
end;

procedure TomTestSuiteStrUtils.Test_DeleteTextRange;
var
  Str1: string;

begin
  Str1 := 'The brown fox jumped the lazy dog';
  Assert(DeleteTextRange('fo', 'zy ', Str1) = 11);
  Assert(Str1 = 'The brown dog');

  Str1 := 'The brown fox jumped the lazy dog';
  Assert(DeleteTextRange('fx', 'zy ', Str1) = 0);
  Assert(Str1 = 'The brown fox jumped the lazy dog');
end;

procedure TomTestSuiteStrUtils.Test_SubstituteText;
var
  Str1: string;

begin
  // first form - first occurance
  Str1 :=
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog';
  SubstituteText('wn', 'do', 'ish ', Str1);
  Assert(Str1 = 'The brownish dog. The brown fox jumped the lazy dog');

  Str1 := 'The brown fox jumped the lazy dog';
  SubstituteText('fx', 'zy ', 'dirty', Str1);
  Assert(Str1 = 'The brown fox jumped the lazy dog');

  // first form - all occurances
  Str1 :=
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog';
  try
    SubstituteText('wn', 'do', 'ish ', Str1, True);
    Assert(False, 'Loop detection failed!');
  except
    ;
  end;

  Str1 :=
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog';
  SubstituteText('fx', 'zy ', 'dirty', Str1, True);
  Assert(Str1 =
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog');

  // second form - first occurance
  Str1 :=
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog';
  SubstituteText('dog', 'cat', Str1);
  Assert(Str1 =
    'The brown fox jumped the lazy cat. The brown fox jumped the lazy dog');

  Str1 :=
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog';
  SubstituteText('frog', 'cat', Str1);
  Assert(Str1 =
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog');

  // second form - all occurance
  Str1 :=
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog';
  SubstituteText('dog', 'cat', Str1, True);
  Assert(Str1 =
    'The brown fox jumped the lazy cat. The brown fox jumped the lazy cat');

  Str1 :=
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog';
  SubstituteText('frog', 'cat', Str1, True);
  Assert(Str1 =
    'The brown fox jumped the lazy dog. The brown fox jumped the lazy dog');
end;

procedure TomTestSuiteStrUtils.Test_Justify;
begin
  Assert(RightJustify('hello', 10) = '     hello');
  Assert(RightJustify('hello', 5) = 'hello');
  Assert(RightJustify('hello', 3) = 'hel');

  Assert(LeftJustify('hello', 10) = 'hello     ');
  Assert(LeftJustify('hello', 5) = 'hello');
  Assert(LeftJustify('hello', 3) = 'hel');
end;

procedure TomTestSuiteStrUtils.Test_SterlingStr;
var
  Temp: String;
begin
  // positive, shortest string
  Temp := SterlingStr(1234.56, 0);
  Assert(Temp = PoundSign + '1,234');
  Temp := SterlingStr(1234.56, 0, wdNoDecimals);
  Assert(Temp = PoundSign + '1,234');
  Temp := SterlingStr(1234.56, 0, wdWantDecimals);
  Assert(Temp = PoundSign + '1,234.56');

  // zero, shortest string
  Temp := SterlingStr(0);
  Assert(Temp = PoundSign + '0');
  Temp := SterlingStr(0, 0);
  Assert(Temp = PoundSign + '0');
  Temp := SterlingStr(0, 0, wdNoDecimals);
  Assert(Temp = PoundSign + '0');
  Temp := SterlingStr(0, 0, wdWantDecimals);
  Assert(Temp = PoundSign + '0.00');

  // negative, shortest string
  Temp := SterlingStr(-1234.56);
  Assert(Temp = '(' + PoundSign + '1,234)');
  Temp := SterlingStr(-1234.56, 0);
  Assert(Temp = '(' + PoundSign + '1,234)');
  Temp := SterlingStr(-1234.56, 0, wdNoDecimals);
  Assert(Temp = '(' + PoundSign + '1,234)');
  Temp := SterlingStr(-1234.56, 0, wdWantDecimals);
  Assert(Temp = '(' + PoundSign + '1,234.56)');

  // positive, fixed string string
  Temp := SterlingStr(1234.56, 12);
  Assert(Temp = '      ' + PoundSign + '1,234');
  Temp := SterlingStr(1234.56, 12, wdNoDecimals);
  Assert(Temp = '      ' + PoundSign + '1,234');
  Temp := SterlingStr(1234.56, 12, wdWantDecimals);
  Assert(Temp = '   ' + PoundSign + '1,234.56');

  // zero, fixed string string
  Temp := SterlingStr(0, 12);
  Assert(Temp = '          ' + PoundSign + '0');
  Temp := SterlingStr(0, 12, wdNoDecimals);
  Assert(Temp = '          ' + PoundSign + '0');
  Temp := SterlingStr(0, 12, wdWantDecimals);
  Assert(Temp = '       ' + PoundSign + '0.00');

  // negative, fixed string string
  Temp := SterlingStr(-1234.56, 12);
  Assert(Temp = '    (' + PoundSign + '1,234)');
  Temp := SterlingStr(-1234.56, 12, wdNoDecimals);
  Assert(Temp = '    (' + PoundSign + '1,234)');
  Temp := SterlingStr(-1234.56, 12, wdWantDecimals);
  Assert(Temp = ' (' + PoundSign + '1,234.56)');

  // positive, shortest string
  Temp := SterlingStr(1234.56, 0, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = PoundSign + '1,234');
  Temp := SterlingStr(1234.56, 0, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = PoundSign + '1,234.56');

  // zero, shortest string
  Temp := SterlingStr(0, 0, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = PoundSign + '0');
  Temp := SterlingStr(0, 0, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = PoundSign + '0.00');

  // negative, shortest string
  Temp := SterlingStr(-1234.56, 0, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = '(' + PoundSign + '1,234)');
  Temp := SterlingStr(-1234.56, 0, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = '(' + PoundSign + '1,234.56)');

  // positive, fixed string string
  Temp := SterlingStr(1234.56, 12, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = '      ' + PoundSign + '1,234');
  Temp := SterlingStr(1234.56, 12, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = '   ' + PoundSign + '1,234.56');

  // zero, fixed string string
  Temp := SterlingStr(0, 12, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = '          ' + PoundSign + '0');
  Temp := SterlingStr(0, 12, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = '       ' + PoundSign + '0.00');

  // negative, fixed string string
  Temp := SterlingStr(-1234.56, 12, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = '    (' + PoundSign + '1,234)');
  Temp := SterlingStr(-1234.56, 12, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = ' (' + PoundSign + '1,234.56)');

  // very small negative numbers that are really zero
  Temp := SterlingStr(-0.00001, 12, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = '          ' + PoundSign + '0');
  Temp := SterlingStr(-0.00001, 12, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = '       ' + PoundSign + '0.00');

  // rounding off insignificant decimals
  Temp := SterlingStr(1234.00001, 12, wdNoDecimals, wrWantRightAlignPadding);
  Assert(Temp = '      ' + PoundSign + '1,234');
  Temp := SterlingStr(1234.00001, 12, wdWantDecimals, wrWantRightAlignPadding);
  Assert(Temp = '   ' + PoundSign + '1,234.00');
end;

procedure TomTestSuiteStrUtils.Test_PercentageStr;
begin
  Assert(PercentageStr(0) = '0%');
  Assert(PercentageStr(0, 0) = '0%');
  Assert(PercentageStr(0, 0, 2) = '0.00%');

  Assert(PercentageStr(0) = '0%');
  Assert(PercentageStr(0, 5) = '   0%');
  Assert(PercentageStr(0, 5, 2) = '0.00%');

  Assert(PercentageStr(0.123456789) = '12%');
  Assert(PercentageStr(0.123456789, 0, 2) = '12.35%');
  Assert(PercentageStr(12.3456789, 7, 1) = '1234.6%');
  Assert(PercentageStr(1234.56789, 9, 1) = '123456.8%');
end;

procedure TomTestSuiteStrUtils.Test_StrConversions;
begin
  // StrToFloatDef
  Assert(Equal(StrToFloatDef('0', 0), 0.0, 4));
  Assert(Equal(StrToFloatDef('1234', 0), 1234, 4));
  Assert(Equal(StrToFloatDef('0.1234', 0), 0.1234, 4));
  Assert(Equal(StrToFloatDef('', 1234.5678), 1234.5678, 4));
  Assert(Equal(StrToFloatDef('+-', 1234.5678), 1234.5678, 4));
  Assert(Equal(StrToFloatDef('++1234', 1234.5678), 1234.5678, 4));
  Assert(Equal(StrToFloatDef('*', 1234.5678), 1234.5678, 4));

  // StrToDateTime
//  Assert(False);

  // StrToTime
//  Assert(False);

  // StrToDate
//  Assert(False);
end;

procedure TomTestSuiteStrUtils.Text_ExtractDelimitedString;
begin
  Assert(ExtractDelimitedString('abc|def|ghi', 0, '|') = 'abc');
  Assert(ExtractDelimitedString('abc|def|ghi', 1, '|') = 'def');
  Assert(ExtractDelimitedString('abc|def|ghi', 2, '|') = 'ghi');
  Assert(ExtractDelimitedString('abc|def|ghi', 3, '|') = '');

  Assert(ExtractDelimitedString('abc*.*def*.*ghi', 0, '*.*') = 'abc');
  Assert(ExtractDelimitedString('abc*.*def*.*ghi', 1, '*.*') = 'def');
  Assert(ExtractDelimitedString('abc*.*def*.*ghi', 2, '*.*') = 'ghi');
  Assert(ExtractDelimitedString('abc*.*def*.*ghi', 3, '*.*') = '');

  Assert(ExtractDelimitedString('abc', 0, '*.*') = 'abc');

  Assert(ExtractDelimitedString('*.**.*ghi', 0, '*.*') = '');
  Assert(ExtractDelimitedString('*.**.*ghi', 1, '*.*') = '');
  Assert(ExtractDelimitedString('*.**.*ghi', 2, '*.*') = 'ghi');
  Assert(ExtractDelimitedString('*.**.*ghi', 3, '*.*') = '');

end;

procedure TomTestSuiteStrUtils.Test_Commas;
var
  Temp: String;
begin
  Temp := Commas(0, 0, 0);
  Assert(Temp = '0');
  Temp := Commas(0, 0, 5);
  Assert(Temp = '    0');
  Temp := Commas(0, 2, 5);
  Assert(Temp = ' 0.00');
  Temp := Commas(0, 2, 0);
  Assert(Temp = '0.00');

  Temp := Commas(123.456, 0, 0);
  Assert(Temp = '123');
  Temp := Commas(123.456, 0, 7);
  Assert(Temp = '    123');
  Temp := Commas(123.456, 2, 7);
  Assert(Temp = ' 123.46');
  Temp := Commas(123.456, 3, 6);
  Assert(Temp = '######');
  Temp := Commas(123.456, 2, 0);
  Assert(Temp = '123.46');
  Temp := Commas(123.456, 3, 0);
  Assert(Temp = '123.456');
  Temp := Commas(123.456, 4, 0);
  Assert(Temp = '123.4560');

  Temp := Commas(-123.456, 0, 0);
  Assert(Temp = '(123)');
  Temp := Commas(-123.456, 0, 5);
  Assert(Temp = '(123)');
  Temp := Commas(-123.456, 2, 5);
  Assert(Temp = '#####');
  Temp := Commas(-123.456, 2, 0);
  Assert(Temp = '(123.46)');
  Temp := Commas(-123.456, 3, 0);
  Assert(Temp = '(123.456)');
  Temp := Commas(-123.456, 4, 0);
  Assert(Temp = '(123.4560)');

  Temp := Commas(123456.789, 0, 0);
  Assert(Temp = '123,456');
  Temp := Commas(123456.789, 0, 5);
  Assert(Temp = '#####');
  Temp := Commas(123456.789, 0, 8);
  Assert(Temp = ' 123,456');
  Temp := Commas(123456.789, 0, 9);
  Assert(Temp = '  123,456');
  Temp := Commas(123456.789, 2, 12);
  Assert(Temp = '  123,456.79');
  Temp := Commas(123456.789, 2, 0);
  Assert(Temp = '123,456.79');
  Temp := Commas(123456.789, 3, 0);
  Assert(Temp = '123,456.789');
  Temp := Commas(123456.789, 4, 0);
  Assert(Temp = '123,456.7890');

  Temp := Commas(-123456.789, 0, 0);
  Assert(Temp = '(123,456)');
  Temp := Commas(-123456.789, 0, 6);
  Assert(Temp = '######');
  Temp := Commas(-123456.789, 0, 9);
  Assert(Temp = '(123,456)');
  Temp := Commas(-123456.789, 0, 10);
  Assert(Temp = ' (123,456)');
  Temp := Commas(-123456.789, 2, 13);
  Assert(Temp = ' (123,456.79)');
  Temp := Commas(-123456.789, 2, 0);
  Assert(Temp = '(123,456.79)');
  Temp := Commas(-123456.789, 3, 0);
  Assert(Temp = '(123,456.789)');
  Temp := Commas(-123456.789, 4, 0);
  Assert(Temp = '(123,456.7890)');

  Temp := Commas(0, 0, 0, wrWantRightAlignPadding);
  Assert(Temp = '0 ');
  Temp := Commas(0, 0, 5, wrWantRightAlignPadding);
  Assert(Temp = '   0 ');
  Temp := Commas(0, 2, 5, wrWantRightAlignPadding);
  Assert(Temp = '0.00 ');
  Temp := Commas(0, 2, 0, wrWantRightAlignPadding);
  Assert(Temp = '0.00 ');

  Temp := Commas(123.456, 0, 0, wrWantRightAlignPadding);
  Assert(Temp = '123 ');
  Temp := Commas(123.456, 0, 7, wrWantRightAlignPadding);
  Assert(Temp = '   123 ');
  Temp := Commas(123.456, 2, 7, wrWantRightAlignPadding);
  Assert(Temp = '123.46 ');
  Temp := Commas(123.456, 2, 6, wrWantRightAlignPadding);
  Assert(Temp = '##### ');
  Temp := Commas(123.456, 2, 0, wrWantRightAlignPadding);
  Assert(Temp = '123.46 ');
  Temp := Commas(123.456, 3, 0, wrWantRightAlignPadding);
  Assert(Temp = '123.456 ');
  Temp := Commas(123.456, 4, 0, wrWantRightAlignPadding);
  Assert(Temp = '123.4560 ');

  Temp := Commas(-123.456, 0, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123)');
  Temp := Commas(-123.456, 0, 5, wrWantRightAlignPadding);
  Assert(Temp = '(123)');
  Temp := Commas(-123.456, 2, 5, wrWantRightAlignPadding);
  Assert(Temp = '#### ');
  Temp := Commas(-123.456, 2, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123.46)');
  Temp := Commas(-123.456, 3, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123.456)');
  Temp := Commas(-123.456, 4, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123.4560)');

  Temp := Commas(123456.789, 0, 0, wrWantRightAlignPadding);
  Assert(Temp = '123,456 ');
  Temp := Commas(123456.789, 0, 5, wrWantRightAlignPadding);
  Assert(Temp = '#### ');
  Temp := Commas(123456.789, 0, 8, wrWantRightAlignPadding);
  Assert(Temp = '123,456 ');
  Temp := Commas(123456.789, 0, 9, wrWantRightAlignPadding);
  Assert(Temp = ' 123,456 ');
  Temp := Commas(123456.789, 2, 12, wrWantRightAlignPadding);
  Assert(Temp = ' 123,456.79 ');
  Temp := Commas(123456.789, 2, 0, wrWantRightAlignPadding);
  Assert(Temp = '123,456.79 ');
  Temp := Commas(123456.789, 3, 0, wrWantRightAlignPadding);
  Assert(Temp = '123,456.789 ');
  Temp := Commas(123456.789, 4, 0, wrWantRightAlignPadding);
  Assert(Temp = '123,456.7890 ');

  Temp := Commas(-123456.789, 0, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123,456)');
  Temp := Commas(-123456.789, 0, 6, wrWantRightAlignPadding);
  Assert(Temp = '##### ');
  Temp := Commas(-123456.789, 0, 9, wrWantRightAlignPadding);
  Assert(Temp = '(123,456)');
  Temp := Commas(-123456.789, 0, 10, wrWantRightAlignPadding);
  Assert(Temp = ' (123,456)');
  Temp := Commas(-123456.789, 2, 13, wrWantRightAlignPadding);
  Assert(Temp = ' (123,456.79)');
  Temp := Commas(-123456.789, 2, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123,456.79)');
  Temp := Commas(-123456.789, 3, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123,456.789)');
  Temp := Commas(-123456.789, 4, 0, wrWantRightAlignPadding);
  Assert(Temp = '(123,456.7890)');

end;

procedure TomTestSuiteStrUtils.Test_CurrencyStr;
begin

end;

procedure TomTestSuiteStrUtils.Test_FormattedStrToDouble;
begin
  Assert(FormattedStrToDouble('$1,000.00') = 1000);
  Assert(FormattedStrToDouble('') = 0);
  Assert(FormattedStrToDouble('qwer') = 0);
  Assert(FormattedStrToDouble('-1000') = -1000);
  Assert(FormattedStrToDouble('-1sdf0asdf0asdf0asdf') = -1000);
end;

procedure TomTestSuiteStrUtils.Test_BoolStr;
begin
  Assert(BoolStr(True) = 'True');
  Assert(BoolStr(True, 'True') = 'True');
  Assert(BoolStr(False, 'True') = 'False');
  Assert(BoolStr(False, 'True', 'False') = 'False');

  Assert(BoolStr(True, 'YES') = 'YES');
  Assert(BoolStr(False, 'True') = 'False');
  Assert(BoolStr(False, 'YES', 'NO') = 'NO');
end;

procedure TomTestSuiteStrUtils.Test_VarRecToStr;

  function DoTest(Variables: array of const; Str: String): Boolean;
  begin
    Result := VarRecToStr(Variables[0]) = Str;
  end;

begin
  Assert(DoTest([42], '42'));
end;

procedure TomTestSuiteStrUtils.Test_SplitName;
begin
  Assert(SplitName('abc', 'abe') = 'abd');
  Assert(SplitName('abe', 'abc') = 'abd');

  Assert(SplitName('abc', 'abd') = 'abcm');
  Assert(SplitName('abd', 'abc') = 'abcm');

  Assert(SplitName('abcasdf', 'abeqwer') = 'abd');
  Assert(SplitName('abeasdf', 'abcqwer') = 'abd');
  Assert(SplitName('abczxcv', 'abdasdf') = 'abcm');
  Assert(SplitName('abdzxcv', 'abcasdf') = 'abcm');

  try
    Assert(SplitName('abc', 'abc') = 'abd');
    Assert(False);
  except
    // ignore
  end;
end;

procedure TomTestSuiteStrUtils.Test_EncodeURL_DecodeURL;
begin
  Assert(EncodeURL('asdf asdf'#13#10) = 'asdf%20asdf%0D%0A');
  Assert(DecodeURL('asdf%20asdf%0D%0A') = 'asdf asdf'#13#10);
end;

{$ENDIF}

Initialization

{$IFDEF Testing}
  //  TomTestSuite.Create('omStrUtils', G_UtilsTestSuite);
  TomTestMastery.RegisterTestSuite(
    TomTestSuiteStrUtils
    , TomTestSuiteUtils_Unit_Tests
    );
{$ENDIF}

end.
