{$DEFINE BADCOMPILER}

{$IFNDEF CONSOLE }
  {$DEFINE GUI }
{$ENDIF }

{$IFDEF VER80}            { Delphi 1.0 }
{$ENDIF}

{$IFDEF VER90}            { Delphi 2.0 }
{$ENDIF}

{$IFDEF VER100}           { Delphi 3.0 }
  {$DEFINE Delphi3}
  {$DEFINE Delphi3plus}
  {$DEFINE MSWINDOWS}
  {$UNDEF  BADCOMPILER}
{$ENDIF}

{$IFDEF VER120}           { Delphi 4.0 }
  {$DEFINE Delphi4}
  {$DEFINE Delphi3plus}
  {$DEFINE Delphi4plus}
  {$DEFINE MSWINDOWS}
  {$UNDEF  BADCOMPILER}
{$ENDIF}

{$IFDEF VER130}           { Delphi 5.0 }
  {$DEFINE Delphi5}
  {$DEFINE Delphi3plus}
  {$DEFINE Delphi4plus}
  {$DEFINE Delphi5plus}
  {$DEFINE MSWINDOWS}
  {$UNDEF  BADCOMPILER}
{$ENDIF}

{$IFDEF VER140}           { Delphi 6.0 / Kylix}
  {$DEFINE Delphi6}
  {$DEFINE Delphi3plus}
  {$DEFINE Delphi4plus}
  {$DEFINE Delphi5plus}
  {$DEFINE Delphi6plus}
  {$UNDEF  BADCOMPILER}
{$ENDIF}

{$IFDEF VER150}           { Delphi 7.0 / Kylix}
  {$DEFINE Delphi7}
  {$DEFINE Delphi3plus}
  {$DEFINE Delphi4plus}
  {$DEFINE Delphi5plus}
  {$DEFINE Delphi6plus}
  {$DEFINE Delphi7plus}
  {$UNDEF  BADCOMPILER}
{$ENDIF}


{$IFDEF VER110}           { Builder 3 }
  {$DEFINE Delphi4plus}
  {$DEFINE Builder3}
  {$DEFINE Builder3plus}
  {$DEFINE MSWINDOWS}
  {$UNDEF  BADCOMPILER}
{$ENDIF}

{$IFDEF VER125}           { Builder 4 }
  {$DEFINE Delphi4plus}
  {$DEFINE Builder4}
  {$DEFINE Builder3plus}
  {$DEFINE Builder4plus}
  {$DEFINE MSWINDOWS}
  {$UNDEF  BADCOMPILER}
{$ENDIF}
