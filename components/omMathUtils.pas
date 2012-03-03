{ ______________________________________________________________________________

  <H5>Copyright</H5>
  File: omMathUtils.pas

  Copyright (C) 2002 ObjectMastery Pty Limited

  Conditions for use, copying, modification and distribution of this software
  are contained in the appropriate licence, which can be found in the webRAD
  readme file included or at http://webrad.sourceforge.net/license.htm

  To see the modification history of this file please refer to the project's
  CVS repository on the SourceForge. www.sourceforge.net/projects/webrad
________________________________________________________________________________
}

unit omMathUtils;

interface

uses
  SysUtils
  ;

type
  //__________________________________________________________________________
  (** 'Currying' a function which takes N parameters in a single real number
    parameter function which returns a real number. N.B. It is expected to have
    other attributes.
   *)
  IomFunctionWrapper = interface
    function Evaluate(const Variable: Double): Double;
  end;

  //___________________________________________________________________________
  (** Fixing all the parameters of the FutureValue() function
    except the Rate.
  *)
  TomFutureValueFunc = class(TInterfacedObject, IomFunctionWrapper)
  private
    FInitialDeposit: Double;
    FRegularDeposit: Double;
    FPeriods: Integer;
    FIndexationRate: Double;
    FIndexationPeriod: Integer;

  public
    constructor Create(
      InitialDeposit: Double;
      RegularDeposit: Double;
      Periods: Integer;
      IndexationRate: Double = 0;
      IndexationPeriod: Integer = 1);

    function Evaluate(const Rate: Double): Double;
  end;

  // Whether the boundaries of Between function are greater or greater equal / lesser or lesser equal
  TomBoundaryType = (btGreaterEqLesserEq, btGreaterLesserEq, btGreaterLesser,
    btGreaterEqLesser);

  // ____________________________________________________________________________
  // Math routines

function Equal(Val1, Val2: Double; Decimals: Integer): Boolean;
function Greater(Val1, Val2: Double; Decimals: Integer): Boolean;
function GreaterEqual(Val1, Val2: Double; Decimals: Integer): Boolean;
function Lesser(Val1, Val2: Double; Decimals: Integer): Boolean;
function LesserEqual(Val1, Val2: Double; Decimals: Integer): Boolean;
function Between(Target: Double;
  Lower: Double; Upper: Double;
  Decimals: Integer = 2;
  BoundaryType: TomBoundaryType = btGreaterEqLesserEq): Boolean;
function Limit(Target: Double; Lower: Double; Upper: Double): Double;

function Round(Value: Extended; Decimals: Integer): Double;
function IsOdd(AnInteger: Integer): Boolean;
function IsEven(AnInteger: Integer): Boolean;
function RandomRange(LowerValue: Integer; UpperValue: Integer): Integer;

function Max(FirstCandidate: Variant; SecondCandidate: Variant): Variant;
function Min(FirstCandidate: Variant; SecondCandidate: Variant): Variant;

function FutureValue(
  InitialDeposit: Double;
  RegularDeposit: Double;
  Rate: Double;
  Periods: Integer;
  IndexationRate: Double = 0;
  IndexationPeriod: Integer = 1
  ): Double;

function FindRoot_NewtonRaphson(
  Func: IomFunctionWrapper;
  const InitialGuess: Double;
  out Iterations: Integer;
  out Root: Double;
  const TargetValue: Double = 0.0;
  const MaxIterations: Integer = 50;
  const Precision: Integer = 6
  ): Boolean;


function FindRoot_BrentMethod(
  Func: IomFunctionWrapper;
  const LowerBound: Double;
  const UpperBound: Double;
  out Iterations: Integer;
  out Root: Double;
  const TargetValue: Double = 0.0;
  const MaxIterations: Integer = 50;
  const Precision: Integer = 6
  ): Boolean;

function Yield(
  Periods: Integer;
  InitialDeposit: Double;
  RegularDeposit: Double;
  Balance: Double;
  IndexationRate: Double = 0;
  IndexationPeriod: Integer = 1;
  GuessRate: Double = 0.1;
  Precision: Integer = 6
  ): Double; overload;

function Yield(
  Periods: Integer;
  InitialDeposit: array of Double;
  MonthlyDeposit: array of Double;
  MonthlyIndexationRate: array of Double;
  AnnualDeposit: array of Double;
  AnnualIndexationRate: array of Double;
  Balance: Double;
  GuessRate: Double = 0.01;
  Precision: Integer = 6
  ): Double; overload;


function RateConversion(
  OldRate: Double;
  NoOfTimeUnitsNewRateAppliesTo: Integer;
  NoOfTimeUnitsOldRateAppliesTo: Integer
  ): Double;
//function Significant(Value: Double; Places: Integer): Double;

type
  TomSignificantRounding = (srRoundNormal, srRoundDown);

function Significant(
  const Value: Extended;
  Places: Integer;
  Rounding: TomSignificantRounding = srRoundDown
  ): Extended;



implementation

uses
  TypInfo
  , Math
{$IFDEF Testing}
  , omTestMastery
  , omUtilsTestSuite
  , Dialogs
{$ENDIF}
  ;

// ____________________________________________________________________________
(**
  compares two doubles for equality within a set number of decimals.
*)

function Equal(Val1, Val2: Double; Decimals: Integer): Boolean;
var
  Tolerance: double;
  Index: Integer;
begin
  //  Result :=
  //    (System.Round(Val1 * 10000) div 100) = (System.Round(Val2 * 10000) div 100);

  Tolerance := 1;
  for Index := 1 to Decimals do
  begin
    Tolerance := Tolerance / 10;
  end;
  Result := Abs(Val1 - Val2) <= Tolerance;
end;


// return true if Val1 > Val2

function Greater(Val1, Val2: Double; Decimals: Integer): Boolean;
var
  Tolerance: Double;
begin
  Tolerance := Power(0.1, Decimals);

  Result := (Val1 - Val2) > Tolerance;
end;


// return true if Val1 >= Val2

function GreaterEqual(Val1, Val2: Double; Decimals: Integer): Boolean;
var
  Tolerance: Double;
begin
  Tolerance := Power(0.1, Decimals);

  // (Val1 > Val2    or   Abs(Val1 - Val2) < Tolerance)
  Result := ((Val1 - Val2) > -Tolerance);
end;


// return true if Val1 < Val2

function Lesser(Val1, Val2: Double; Decimals: Integer): Boolean;
var
  Tolerance: Double;
begin
  Tolerance := Power(0.1, Decimals);

  Result := (Val2 - Val1) > Tolerance;
end;


// return true if Val1 <= Val2

function LesserEqual(Val1, Val2: Double; Decimals: Integer): Boolean;
var
  Tolerance: Double;
begin
  Tolerance := Power(0.1, Decimals);

  // (Val1 < Val2    or   Abs(Val1 - Val2) < Tolerance)
  Result := ((Val2 - Val1) > -Tolerance);
end;

// ____________________________________________________________________________
(**
  return a number rounded to the requested number of decimal places.
*)

function Round(Value: Extended; Decimals: Integer): Double;
var
  AFloat: Extended;
  RoundCtr: Integer;

begin
  AFloat := Value;
  for RoundCtr := 1 to Decimals do
  begin
    AFloat := AFloat * 10;
  end;

  if AFloat > 0 then
  begin
    AFloat := AFloat + 0.5
  end
  else
  begin
    AFloat := AFloat - 0.5;
  end;

  try
    AFloat := Trunc(AFloat);
  except //	the exception handler is needed when the
    on EInvalidOp do
    begin //	Integer value reaches about 20 million (or real small! - mdc)
      AFloat := StrToFloat(FloatToStr(AFloat));
    end;
    //	else
    //		raise;
  end;

  for RoundCtr := 1 to Decimals do
  begin
    AFloat := (AFloat / 10);
  end;

  Result := AFloat;
end;

// ____________________________________________________________________________
(**
  determines whether the passed in value is odd.
*)

function IsOdd(AnInteger: Integer): Boolean;
begin
  Result := not IsEven(AnInteger);
end;

// ____________________________________________________________________________
(**
  determines whether the passed in value is even.
*)

function IsEven(AnInteger: Integer): Boolean;
begin
  Result := (AnInteger and 1) = 0;
end;

// ____________________________________________________________________________
(**
  return a random number allowing a lower value to be set. Call Randomize to
  seed the algorithm.
*)

function RandomRange(LowerValue: Integer; UpperValue: Integer): Integer;
begin
  Result := Random(UpperValue - LowerValue + 1) + LowerValue;
end;

// ____________________________________________________________________________
(**
  generic max function.
  @result Variant - the larrger of the two numbers
*)

function Max(FirstCandidate: Variant; SecondCandidate: Variant): Variant;
begin
  if FirstCandidate > SecondCandidate then
  begin
    Result := FirstCandidate;
  end
  else
  begin
    Result := SecondCandidate;
  end;
  //	Result:= iif(FirstCandidate > SecondCandidate, FirstCandidate, SecondCandidate);
end;

// ____________________________________________________________________________
(**
  generic min function.
  @result Variant - the smaller of the two numbers
*)

function Min(FirstCandidate: Variant; SecondCandidate: Variant): Variant;
begin
  if FirstCandidate < SecondCandidate then
  begin
    Result := FirstCandidate;
  end
  else
  begin
    Result := SecondCandidate;
  end;
  //	Result:= iif(FirstCandidate < SecondCandidate, FirstCandidate, SecondCandidate);
end;


// ____________________________________________________________________________
(**
  FoxPro like between() function.
  @result boolean - True if the target is between lower limit and upper limit.
*)

function Between(Target: Double;
  Lower: Double;
  Upper: Double;
  Decimals: Integer = 2;
  BoundaryType: TomBoundaryType = btGreaterEqLesserEq): Boolean;
begin
  case BoundaryType of
    btGreaterEqLesserEq:
      begin
        Result := GreaterEqual(Target, Lower, Decimals) and LesserEqual(Target,
          Upper, Decimals);
      end;
    btGreaterLesserEq:
      begin
        Result := Greater(Target, Lower, Decimals) and LesserEqual(Target,
          Upper, Decimals);
      end;
    btGreaterLesser:
      begin
        Result := Greater(Target, Lower, Decimals) and Lesser(Target, Upper,
          Decimals);
      end;
    btGreaterEqLesser:
      begin
        Result := GreaterEqual(Target, Lower, Decimals) and Lesser(Target,
          Upper, Decimals);
      end;
  else
    begin
      Result := GreaterEqual(Target, Lower, Decimals) and LesserEqual(Target,
        Upper, Decimals);
    end;
  end;
  Result := Result;
end;

// ____________________________________________________________________________
(**
  Limit - ensures a target number is between an upper and lower limit.
  @result boolean - True if the target is between lower limit and upper limit.
*)

function Limit(Target: Double; Lower: Double; Upper: Double): Double;
begin
  if Target < Lower then
  begin
    Result := Lower;
  end
  else if Target > Upper then
  begin
    Result := Upper;
  end
  else
  begin
    Result := Target;
  end;
end;


// ____________________________________________________________________________

function RateConversion(
  OldRate: Double;
  NoOfTimeUnitsNewRateAppliesTo: Integer;
  NoOfTimeUnitsOldRateAppliesTo: Integer
  ): Double;
begin
  Result := Power(
    OldRate + 1,
    (NoOfTimeUnitsNewRateAppliesTo / NoOfTimeUnitsOldRateAppliesTo)
    ) - 1;
end;


// ____________________________________________________________________________
(**
  @Params InitialDepost - deposit made at start of period 1
  @Params RegularDeposit - deposit made at start of period 2..Periods
  @Parmas Rate - Rate per period
  @Params Periods - number of periods
*)

function FutureValue(
  InitialDeposit: Double;
  RegularDeposit: Double;
  Rate: Double;
  Periods: Integer;
  IndexationRate: Double = 0;
  IndexationPeriod: Integer = 1
  ): Double;
var
  Period: Integer;
begin
  // check our parameters
  if IndexationPeriod = 0 then
  begin
    raise
      Exception.Create('Indexation period must not be zero. Set the rate to zero instead.');
  end;

  if Rate = 0 then
  begin
    Result := InitialDeposit + RegularDeposit * (Periods - 1);
  end
  else
  begin
    //    Result:=
    //        InitialDeposit *  Power((1 + Rate),(Periods))
    //      + RegularDeposit * (Power((1 + Rate),(Periods-1)) - 1) / Rate
    //      ;
        // period 1
    Result := InitialDeposit * (1 + Rate);

    // period 2..n
    for Period := 1 to Periods - 1 do
    begin
      if (Period mod IndexationPeriod) = 0 then
      begin
        RegularDeposit := RegularDeposit * (1 + IndexationRate);
      end;
      Result := (Result + RegularDeposit) * (1 + Rate);
    end;
  end;
end;


//_____________________________________________________________________________

function Yield(
  Periods: Integer;
  InitialDeposit: Double;
  RegularDeposit: Double;
  Balance: Double;
  IndexationRate: Double = 0;
  IndexationPeriod: Integer = 1;
  GuessRate: Double = 0.1;
  Precision: Integer = 6
  ): Double;
var
  Iteration: Integer;
  TestBalance: Double;
  Change: Double;
  Upwards: Boolean;
begin
  Change := GuessRate / 2;
  Upwards := True;
  for Iteration := 0 to 1000 do
  begin
    TestBalance :=
      FutureValue(
      InitialDeposit,
      RegularDeposit,
      GuessRate,
      Periods,
      IndexationRate,
      IndexationPeriod
      );

    if Equal(TestBalance, Balance, Precision) then
    begin
      Result := Round(GuessRate, Precision);
      Exit;
    end;

    // determine what to do to get nearer to the target yield
    if TestBalance > Balance then
    begin // yield is too high
      if Upwards then
      begin
        Change := Change / 2;
      end;
      GuessRate := GuessRate - Change;
      Upwards := False;
    end
    else
    begin // yield is too low
      if not Upwards then
      begin
        Change := Change / 2;
      end;
      GuessRate := GuessRate + Change;
      Upwards := True;
    end;
  end;
  raise Exception.Create('Yield Calculation did not converge');
end;

//_____________________________________________________________________________

function Yield(
  Periods: Integer;
  InitialDeposit: array of Double;
  MonthlyDeposit: array of Double;
  MonthlyIndexationRate: array of Double;
  AnnualDeposit: array of Double;
  AnnualIndexationRate: array of Double;
  Balance: Double;
  GuessRate: Double = 0.01;
  Precision: Integer = 6
  ): Double; overload;
var
  Iteration: Integer;
  TestBalance: Double;
  Change: Double;
  Upwards: Boolean;
  Index: Integer;
begin
  Change := GuessRate / 2;
  Upwards := True;
  for Iteration := 0 to 1000 do
  begin

    TestBalance := 0;

    for Index := Low(InitialDeposit) to High(InitialDeposit) do
    begin
      TestBalance := TestBalance +
        FutureValue(
        InitialDeposit[Index],
        0,
        GuessRate,
        Periods
        );
    end;

    for Index := Low(MonthlyDeposit) to High(MonthlyDeposit) do
    begin
      TestBalance := TestBalance +
        FutureValue(
        MonthlyDeposit[Index],
        MonthlyDeposit[Index],
        GuessRate,
        Periods - 1,
        MonthlyIndexationRate[Index],
        1
        );
    end;

    for Index := Low(AnnualDeposit) to high(AnnualDeposit) do
    begin
      TestBalance := TestBalance +
        FutureValue(
        AnnualDeposit[Index],
        AnnualDeposit[Index],
        GuessRate,
        Periods - 1,
        AnnualIndexationRate[Index],
        12
        );
    end;

    if Equal(TestBalance, Balance, Precision) then
    begin
      Result := Round(GuessRate, Precision);
      Exit;
    end;

    // determine what to do to get nearer to the target yield
    if TestBalance > Balance then
    begin // yield is too high
      if TestBalance < (Balance * 2) then
      begin
        if Upwards then
        begin
          Change := Change / 2;
        end;
      end;
      GuessRate := GuessRate - Change;
      Upwards := False;
    end
    else
    begin // yield is too low
      if TestBalance > Balance / 2 then
      begin
        if not Upwards then
        begin
          Change := Change / 2;
        end;
      end;
      GuessRate := GuessRate + Change;
      Upwards := True;
    end;
  end;
  raise Exception.Create('Yield Calculation did not converge');
end;



// _____________________________________________________________________________
{**
  Jvr - 18/07/2000 14:32:43.<BR>
  Jvr - 26/02/2001 14:32:38 - New method of calculating significant digits<P>
}

function Significant(
  const Value: Extended;
  Places: Integer;
  Rounding: TomSignificantRounding
  ): Extended;
var
  FloatAsString: String;
  Index: Integer;
  StartPos: Integer;

begin
  if (Rounding <> srRoundDown) then
  begin
    raise Exception.CreateFmt(
      'Rounding of type "%s" is currently not supported!',
      [GetEnumName(TypeInfo(TomSignificantRounding), Ord(Rounding))]
      );
  end;

  FloatAsString := FloatToStr(Value);
  Assert(Length(FloatAsString) > 0);

  //ignore leading zero's eg 0.000054
  StartPos := 1;
  while StartPos <= Length(FloatAsString) do
  begin
    if (FloatAsString[StartPos] in ['1'..'9']) then
    begin
      Break;
    end;
    Inc(StartPos);
  end;

  for Index := StartPos to Length(FloatAsString) do
  begin
    if (Places > 0) then
    begin
      if (FloatAsString[Index] in ['0'..'9']) then
      begin
        Dec(Places);
      end;
    end
    else
    begin
      if (FloatAsString[Index] in ['0'..'9']) then
      begin
        FloatAsString[Index] := '0';
      end;
    end;
  end; { for }

  Result := StrToFloat(FloatAsString);
end; { Significant }


{//##JVR Old Code for Significant
var
 AdjustedValue: Double;
 BeforeDecimal: Integer;
 RoundingIndex: Integer;
 Delta: Integer;
 NeedsNoDecimals: Boolean;

begin
  // determine how many digits we have before the decimal point
  AdjustedValue := Value;
  BeforeDecimal := 0;

  while Abs(AdjustedValue) > 1 do begin
    AdjustedValue := AdjustedValue / 10;
    Inc(BeforeDecimal);
  end;

  // reset to the base value
  AdjustedValue:= Value;

  // do we need to involve any of the digits after the decimal point?
  NeedsNoDecimals := (BeforeDecimal >= Places);

  if NeedsNoDecimals then begin
    Delta := BeforeDecimal - Places;
  end
  else begin
    Delta := Places - BeforeDecimal;
  end;

  // massage the input until we've got a decimal place where we can round it
  for RoundingIndex := 1 to Delta do begin
    if NeedsNoDecimals then begin
      AdjustedValue := AdjustedValue / 10;
    end
    else begin
      AdjustedValue := AdjustedValue * 10;
    end;
  end;

  // now round it
  if (Rounding = srRoundNormal) then begin
    AdjustedValue := System.Round(AdjustedValue);
  end
  else if (Rounding = srRoundDown) then begin
    AdjustedValue := System.Trunc(AdjustedValue);
  end
  else begin
    raise Exception.Create('Unknown rounding type');
  end;

  // and, finally, put back the places we chopped out
  for RoundingIndex := 1 to Delta do begin
    if NeedsNoDecimals then begin
      AdjustedValue := AdjustedValue * 10;
    end
    else begin
      AdjustedValue := AdjustedValue / 10;
    end;
  end;

  Result := AdjustedValue;
end;
}


(*
// _____________________________________________________________________________
{**
  Updated: Jvr - 18/07/2000 14:32:43<P>
}
function Significant(Value: Double; Places: Integer): Double;
var
 AdjValue: Double;
 BeforeDecimal: Integer;
 Ctr: Integer;

begin
 {determine how many digits we have before the decimal point}
 AdjValue:= Value;
 BeforeDecimal:= 0;
 while abs(AdjValue) > 1 do begin
  AdjValue:= AdjValue / 10;
  Inc(BeforeDecimal);
 end;

 {reset to the base value}
 AdjValue:= Value;

 {we don't need to involve any of the digits after the decimal point}
 if BeforeDecimal >= Places then begin
  {massage the input until we've got a decimal place where we can round it}
  for Ctr:= 1 to (BeforeDecimal - Places) do begin
   AdjValue:= Adjvalue / 10
  end;

   {now round it}
  AdjValue:= System.Round(AdjValue);

  {and, finally, put back the places we chopped out}
  for Ctr:= 1 to (BeforeDecimal - Places) do begin
   AdjValue:= Adjvalue * 10
  end;
 end
 else begin
  {we need to involve digits after the decimal point}
  AdjValue:= Round(AdjValue, Places - BeforeDecimal);
 end;

 Result:= Adjvalue;
end;  { Significant }
*)


//_____________________________________________________________________________
(** Use the Newton-Raphson method to find the root of a function
    @param  Func              The function in question
    @param  InitialGuess      The initial guess of the root
    @param  Iterations    Returns the number of iteration used to zero-in
    @param  Root              Returns the root found
    @param  TargetValue       The targeting (Y) value. It's default to 0
    @param  MaxIterations The maximum number of iterations allowed
    @param  Precision         The point of decimal points required

    @return                   Whether it successfully finds a root.
 *)

function FindRoot_NewtonRaphson(
  Func: IomFunctionWrapper;
  const InitialGuess: Double;
  out Iterations: Integer;
  out Root: Double;
  const TargetValue: Double = 0.0;
  const MaxIterations: Integer = 50;
  const Precision: Integer = 6): Boolean;
const
  DeltaX = 0.0001;
var
  Y_1, Y_2: Double;
  X_1, X_2: Double;
  Slope: Double;
begin
  Result := False;
  Root := InitialGuess;
  Iterations := 0;

  X_1 := InitialGuess;
  Y_1 := Func.Evaluate(X_1);

  //  while not Equal(Y_1, TargetValue, Precision) and (Iterations < MaxIterations)

  while (abs(Y_1 - TargetValue) > 100) and (Iterations < MaxIterations) do
  begin
    // Calculate the slope at the current point
    X_2 := X_1 + DeltaX;
    Y_2 := Func.Evaluate(X_2);
    Slope := (Y_2 - Y_1) / (X_2 - X_1);

    if Slope = 0 then
    begin
      // oops, perhaps we're at a local stationary point. Shift a little to
      // and try again.
      X_1 := X_2;
    end
    else
    begin
      // Estimate the next point based on the slope
      X_1 := ((TargetValue - Y_1) / Slope) + X_1;
    end;

    Y_1 := Func.Evaluate(X_1);

    // next iteration!
    Inc(Iterations);
  end;

  //  if Equal(Y_1, TargetValue, Precision) then begin
  if (abs(Y_1 - TargetValue) <= 100) then
  begin
    Root := X_1;
    Result := True;
  end;
end;


{ TomFutureValueFunc }
//_____________________________________________________________________________

constructor TomFutureValueFunc.Create(InitialDeposit,
  RegularDeposit: Double; Periods: Integer; IndexationRate: Double;
  IndexationPeriod: Integer);
begin
  inherited create;
  FInitialDeposit := InitialDeposit;
  FRegularDeposit := RegularDeposit;
  FPeriods := Periods;
  FIndexationRate := IndexationRate;
  FIndexationPeriod := IndexationPeriod;
end;

//_____________________________________________________________________________

function TomFutureValueFunc.Evaluate(const Rate: Double): Double;
begin
  Result := FutureValue(
    FInitialDeposit, FRegularDeposit, Rate,
    FPeriods, FIndexationRate, FIndexationPeriod);
end;

//_____________________________________________________________________________

function FindRoot_BrentMethod(
  Func: IomFunctionWrapper;
  const LowerBound: Double;
  const UpperBound: Double;
  out Iterations: Integer;
  out Root: Double;
  const TargetValue: Double = 0.0;
  const MaxIterations: Integer = 50;
  const Precision: Integer = 6): Boolean;
const
  C_MachinePrecision: Double = 1.0E-15;
var
  X_A, X_B, X_C: Double;
  F_A, F_B, F_C: Double;
  BoundingInterval, OldBoundingInterval: Double;
  Tolerance, Epsilon: Double;
  P, Q, R, S, T: Double;
  X_M: Double;
  Min1, Min2: Double;
begin
  Epsilon := Power(10, -Precision);
  Result := False;
  Iterations := 0;
  X_C := 0.0;
  OldBoundingInterval := 0.0;
  BoundingInterval := 0.0;

  X_A := LowerBound;
  X_B := UpperBound;
  F_A := Func.Evaluate(X_A) - TargetValue;
  F_B := Func.Evaluate(X_B) - TargetValue;
  F_C := F_B;

  // If the signs are not different, the root is not in the bracket.
  // This root finding method is not applicable.
  if F_A * F_B > 0.0 then
    Exit;

  while Iterations < MaxIterations do
  begin
    if F_B * F_C > 0.0 then
    begin
      X_C := X_A;
      F_C := F_A;
      BoundingInterval := X_B - X_A;
      OldBoundingInterval := BoundingInterval;
    end;

    if Abs(F_C) < Abs(F_B) then
    begin
      // Swap point X_A and point X_B
      X_A := X_B;
      X_B := X_C;
      X_C := X_A;

      F_A := F_B;
      F_B := F_C;
      F_C := F_A;
    end;

    Tolerance := (2.0 * C_MachinePrecision * Abs(X_B)) + 0.5 * Epsilon;
    X_M := 0.5 * (X_C - X_B);

    // Does it converge to our required precision?
    if (Abs(X_M) <= Tolerance) or (F_B = 0.0) then
    begin
      Root := X_B;
      Result := True;
      Exit;
    end;

    if (Abs(OldBoundingInterval) >= Tolerance) and (Abs(F_A) > Abs(F_B)) then
    begin
      // Attempt inverse quadratic interpolation
      S := F_B / F_A;
      if X_A = X_C then
      begin
        P := 2.0 * X_M * S;
        Q := 1.0 - S;
      end
      else
      begin
        T := F_A / F_C;
        R := F_B / F_C;
        P := S * (T * (T - R) * (X_C - X_B) - (R - 1.0) * (X_B - X_A));
        Q := (T - 1.0) * (R - 1.0) * (S - 1.0);
      end;

      // Check whether in bound
      if P > 0.0 then
      begin
        Q := -Q;
      end;

      P := Abs(P);

      Min1 := 3.0 * X_M * Q - Abs(Tolerance * Q);
      Min2 := Abs(OldBoundingInterval * Q);

      if ((Min1 < Min2) and (2.0 * P < Min1)) or
        ((Min1 >= Min2) and (2.0 * P < Min2)) then
      begin
        // Accept interpolation
        OldBoundingInterval := BoundingInterval;
        BoundingInterval := P / Q;
      end
      else
      begin
        // Interpolation failed, use bisection method
        BoundingInterval := X_M;
        OldBoundingInterval := BoundingInterval;
      end;

    end
    else
    begin
      // Bounds decrease too slowly, use bisection method.
      BoundingInterval := X_M;
      OldBoundingInterval := BoundingInterval;
    end; // if (Abs(OldBoundingInterval) >= Tolerance) and (Abs(F_A) > Abs(F_B))


    X_A := X_B;
    F_A := F_B;
    if Abs(BoundingInterval) > Tolerance then
    begin
      X_B := X_B + BoundingInterval;
    end
    else
    begin
      if X_M > 0 then
        X_B := X_B + Abs(Tolerance)
      else
        X_B := X_B - Abs(Tolerance);
    end;

    F_B := Func.Evaluate(X_B) - TargetValue;
    Inc(Iterations);
  end; // while
end;

// ============================================================================
{$IFDEF Testing}

type
  TomTestSuiteMathUtils = class(TomTestSuite)
  published
    procedure Test_Between;
    procedure Test_IsOddOrEven;
    procedure Test_Greater;
    procedure Test_GreaterEqual;
    procedure Test_Lesser;
    procedure Test_LesserEqual;
    procedure Test_Max;
    procedure Test_Min;
    procedure Test_Random;
    procedure Test_RoundAndEquals;
    procedure Test_FinancialFunctions;
    procedure Test_Significant;
    procedure Test_FindRoot;
    procedure Test_FindRoot_BrentMethod;
    procedure Test_Limits;
  end;

  // equals uses round and won't work if round doesn't work

procedure TomTestSuiteMathUtils.Test_RoundAndEquals;
begin
  Assert(Equal(123.456, 123.0, 0));
  Assert(Equal(123.456, 123.5, 1));
  Assert(Equal(123.456, 123.46, 2));
  Assert(Equal(123.456, 123.456, 3));
  Assert(Equal(123.456, 123.456, 4));
  Assert(Equal(-123.456, -123.5, 1));
  Assert(Equal(0.0, 0.0, 1));
  Assert(Equal(123.5, 124.0, 0));
  Assert(Equal(123.500001, 124.0, 0));
  Assert(Equal(123.499999, 123.0, 0));
end;

procedure TomTestSuiteMathUtils.Test_IsOddOrEven;
begin
  Assert(IsOdd(3));
  Assert(not IsOdd(2));
  Assert(IsOdd(1));
  Assert(not IsOdd(0));
  Assert(IsOdd(-1));
  Assert(not IsOdd(-2));
  Assert(IsOdd(-3));

  Assert(not IsEven(3));
  Assert(IsEven(2));
  Assert(not IsEven(1));
  Assert(IsEven(0));
  Assert(not IsEven(-1));
  Assert(IsEven(-2));
  Assert(not IsEven(-3));
end;



procedure TomTestSuiteMathUtils.Test_Greater;
begin
  Assert(Greater(100.001, 100.000, 3));
  Assert(not Greater(100.001, 100.000, 2));
  Assert(not Greater(100.000, 100.001, 3));
  Assert(not Greater(100.000, 100.001, 2));
  Assert(not Greater(100.001, 100.001, 3));
end;


procedure TomTestSuiteMathUtils.Test_GreaterEqual;
begin
  Assert(GreaterEqual(100.001, 100.000, 3));
  Assert(GreaterEqual(100.001, 100.000, 2));
  Assert(not GreaterEqual(100.000, 100.001, 3));
  Assert(GreaterEqual(100.000, 100.001, 2));
  Assert(GreaterEqual(100.001, 100.001, 3));
end;


procedure TomTestSuiteMathUtils.Test_Lesser;
begin
  Assert(Lesser(100.000, 100.001, 3));
  Assert(not Lesser(100.000, 100.001, 2));
  Assert(not Lesser(100.001, 100.000, 3));
  Assert(not Lesser(100.001, 100.000, 2));
  Assert(not Lesser(100.001, 100.001, 3));
end;


procedure TomTestSuiteMathUtils.Test_LesserEqual;
begin
  Assert(LesserEqual(100.000, 100.001, 3));
  Assert(LesserEqual(100.000, 100.001, 2));
  Assert(not LesserEqual(100.001, 100.000, 3));
  Assert(LesserEqual(100.001, 100.000, 2));
  Assert(LesserEqual(100.001, 100.001, 3));
end;


{$HINTS OFF}

procedure TomTestSuiteMathUtils.Test_Random;
var
  UpperValue: Integer;
  Range: Integer;
  Value: Integer;
begin
  for UpperValue := -10 to 20 do
  begin
    for range := 1 to 10 do
    begin
      Value := RandomRange(UpperValue - Range, UpperValue);
      Assert((Value >= UpperValue - Range) and (Value <= UpperValue));
    end;
  end;
end;
{$HINTS ON}

procedure TomTestSuiteMathUtils.Test_Max;
begin
  // Integers
  Assert(Max(0, 0) = 0);
  Assert(Max(1, 0) = 1);
  Assert(Max(0, 1) = 1);
  Assert(Max(1, -1) = 1);
  Assert(Max(-1, 1) = 1);
  Assert(Max(-1, -2) = -1);
  Assert(Max(Maxint, 0) = MaxInt);
  Assert(Max(-MaxInt, 0) = 0);

  // reals
  Assert(Equal(Max(0.0, 0.0), 0.0, 1));
  Assert(Equal(Max(1.0, 0.0), 1.0, 1));
  Assert(Equal(Max(0.0, 1.0), 1.0, 1));
  Assert(Equal(Max(1.0, -1.0), 1.0, 1));
  Assert(Equal(Max(-1.0, 1.0), 1.0, 1));
  Assert(Equal(Max(-1.0, -2.0), -1.0, 1));

  // mixed
  Assert(Equal(Max(0, 0.0), 0.0, 1));
  Assert(Equal(Max(1, 0.0), 1.0, 1));
  Assert(Equal(Max(0, 1.0), 1.0, 1));
  Assert(Equal(Max(1, -1.0), 1.0, 1));
  Assert(Equal(Max(-1, 1.0), 1.0, 1));
  Assert(Equal(Max(-1, -2.0), -1.0, 1));
  Assert(Equal(Max(Maxint, 0.0), MaxInt, 1));

  Assert(Equal(Max(0.0, 0), 0.0, 1));
  Assert(Equal(Max(1.0, 0), 1.0, 1));
  Assert(Equal(Max(0.0, 0), 0.0, 1));
  Assert(Equal(Max(1.0, 0), 1.0, 1));
  Assert(Equal(Max(-1.0, 0), 0.0, 1));
  Assert(Equal(Max(-MaxInt, 0.0), 0.0, 1));

  // strings?
  Assert(Max('abc', 'def') = 'def');
  Assert(Max('', 'def') = 'def');
  Assert(Max('abc', '') = 'abc');
end;

procedure TomTestSuiteMathUtils.Test_Min;
begin
  // Integers
  Assert(Min(0, 0) = 0);
  Assert(Min(1, 0) = 0);
  Assert(Min(0, 1) = 0);
  Assert(Min(1, -1) = -1);
  Assert(Min(-1, 1) = -1);
  Assert(Min(-1, -2) = -2);
  Assert(Min(Maxint, 0) = 0);
  Assert(Min(-MaxInt, 0) = -MaxInt);

  // reals
  Assert(Equal(Min(0.0, 0.0), 0.0, 1));
  Assert(Equal(Min(1.0, 0.0), 00, 1));
  Assert(Equal(Min(0.0, 1.0), 00, 1));
  Assert(Equal(Min(1.0, -1.0), -1.0, 1));
  Assert(Equal(Min(-1.0, 1.0), -1.0, 1));
  Assert(Equal(Min(-1.0, -2.0), -2.0, 1));

  // mixed
  Assert(Equal(Min(0, 0.0), 0.0, 1));
  Assert(Equal(Min(1, 0.0), 0.0, 1));
  Assert(Equal(Min(0, 1.0), 0.0, 1));
  Assert(Equal(Min(1, -1.0), -1.0, 1));
  Assert(Equal(Min(-1, 1.0), -1.0, 1));
  Assert(Equal(Min(-1, -2.0), -2.0, 1));
  Assert(Equal(Min(-MaxInt, 0.0), -MaxInt, 1));

  Assert(Equal(Min(0.0, 0), 0.0, 1));
  Assert(Equal(Min(1.0, 0), 0.0, 1));
  Assert(Equal(Min(0.0, 0), 0.0, 1));
  Assert(Equal(Min(1.0, 0), 0.0, 1));
  Assert(Equal(Min(-1.0, 0), -1.0, 1));

  // strings?
  Assert(Min('abc', 'def') = 'abc');
  Assert(Min('', 'def') = '');
  Assert(Min('abc', '') = '');
end;

procedure TomTestSuiteMathUtils.Test_Between;
begin
  Assert(Between(0, -1, 1));
  Assert(Between(-1, -1, 1));
  Assert(Between(1, -1, 1));
  Assert(Between(42, -100, 100));
end;

procedure TomTestSuiteMathUtils.Test_FinancialFunctions;
begin

  { test data from excel
  InitialDeposit    1000            0        1000        1000            1000
  RegularDeposit     100          100           0         100             100
  Rate               0.1          0.1         0.1           0               1
  Periods             10           10          10          10              10

  FutureValue	 $4,087.48		$1,593.74		$2,593.74		$2,000.00		$1,126,300.00
  }

    // test future value
  Assert(Equal(FutureValue(1000, 100, 0, 10), 1900.00, 2));
  Assert(Equal(FutureValue(1000, 100, 0.05, 10), 2786.68, 2));
  Assert(Equal(FutureValue(1000, 100, 0.10, 10), 4087.48, 2));
  Assert(Equal(FutureValue(0, 100, 0.1, 10), 1493.74, 2));
  Assert(Equal(FutureValue(1000, 0, 0.1, 10), 2593.74, 2));
  Assert(Equal(FutureValue(1000, 100, 1, 10), 1126200.00, 2));

  Assert(Equal(FutureValue(1000, 100, 0.00054553, 120), 13365.64, 2));

  Assert(Equal(Yield(120, 100, 100, 13343.89), 0.001727, 4));
  Assert(Equal(Yield(10, 1000, 100, 4087.48), 0.100000, 4));
  Assert(Equal(Yield(120, 1000, 100, 14555.71), 0.001835, 4));
  Assert(Equal(Yield(120, 1000, 100, 13365.64), 0.000546, 4));

  (*
  Annual Deposits indexation rate -----------------------------------+
  Annual Deposits -------------------------------------------+       |
  Monthly Deposits indexation rate ------------------+       |       |
  Monthly Deposits -------------------------+        |       |       |          +------------------ Balance
  Initial Deposits ----------+              |        |       |       |          |      +----------- Yield
  Periods -------------+     |              |        |       |       |          |      |        +-- Precision
                       |     |              |        |       |       |          |      |        |*)
  Assert(Equal(Yield(120, [100], [100], [0], [0], [0], 13343.89), 0.0017, 4));
  Assert(Equal(Yield(10, [1000], [100], [0], [0], [0], 4087.48), 0.1000, 4));
  Assert(Equal(Yield(120, [1000], [100], [0], [0], [0], 14555.71), 0.0018, 4));
  Assert(Equal(Yield(120, [1000], [100], [0], [0], [0], 13365.64), 0.0005, 4));

  Assert(Equal(Yield(120, [50, 50], [50, 50], [0, 0], [0], [0], 13343.89),
    0.0017, 4));
  Assert(Equal(Yield(10, [250, 750], [50, 50], [0, 0], [0], [0], 4087.48),
    0.1000, 4));
  Assert(Equal(Yield(120, [250, 750], [50, 50], [0, 0], [0], [0], 14555.71),
    0.0018, 4));
  Assert(Equal(Yield(120, [1000], [50, 50], [0, 0], [0], [0], 13365.64), 0.0005,
    4));


  Assert(Equal(RateConversion(0.06, 1, 12), 0.0049, 4));

  Assert(Equal(RateConversion(0.0049, 12, 1), 0.06, 2));
end;


// _____________________________________________________________________________
{**
  Updated: Jvr - 18/07/2000 14:38:43<P>
}

procedure TomTestSuiteMathUtils.Test_Significant;
begin
  Assert(Equal(Significant(1234, 3), 1230, 3));
  Assert(Equal(Significant(123.4, 3), 123.0, 3));
  Assert(Equal(Significant(12.34, 3), 12.30, 3));
  Assert(Equal(Significant(1.234, 3), 1.230, 3));

  Assert(Equal(Significant(0.1234, 3), 0.1230, 3));
  Assert(Equal(Significant(0.01234, 3), 0.0123, 3));


  Assert(Equal(Significant(12345678, 3), 12300000, 3));
  Assert(Equal(Significant(12345678, 4), 12340000, 4));


  // Rounding Normal
//  Assert(Equal(Significant(1236, 3, srRoundNormal), 1240, 3));
//  Assert(Equal(Significant(123.6, 3, srRoundNormal), 124.0, 3));
//  Assert(Equal(Significant(12.36, 3, srRoundNormal), 12.40, 3));
//  Assert(Equal(Significant(1.236, 3, srRoundNormal), 1.240, 3));

//  Assert(Equal(Significant(0.1236, 3, srRoundNormal), 0.1240, 3));
//  Assert(Equal(Significant(0.01236, 3, srRoundNormal), 0.0124, 3));


//  Assert(Equal(Significant(23456789, 3, srRoundNormal), 23500000, 3));
//  Assert(Equal(Significant(23456789, 4, srRoundNormal), 23460000, 4));


  // Rounding Down
  Assert(Equal(Significant(1236, 3, srRoundDown), 1230, 3));
  Assert(Equal(Significant(123.6, 3, srRoundDown), 123.0, 3));
  Assert(Equal(Significant(12.36, 3, srRoundDown), 12.30, 3));
  Assert(Equal(Significant(1.236, 3, srRoundDown), 1.230, 3));

  Assert(Equal(Significant(0.1236, 3, srRoundDown), 0.1230, 3));
  Assert(Equal(Significant(0.01236, 3, srRoundDown), 0.0123, 3));


  Assert(Equal(Significant(23456789, 3, srRoundDown), 23400000, 3));
  Assert(Equal(Significant(23456789, 4, srRoundDown), 23450000, 4));
end;


procedure TomTestSuiteMathUtils.Test_FindRoot;
const
  precision = 3;
  //GLK  precision = 6;
var
  Root: Double;
  Iterations: Integer;
begin
  Assert(
    FindRoot_NewtonRaphson(
    TomFutureValueFunc.Create(100, 100, 120), 0.01, Iterations, Root, 13343.89
    )
    );
  Assert(Equal(Root, 0.001727, precision));

  Assert(
    FindRoot_NewtonRaphson(
    TomFutureValueFunc.Create(1000, 100, 10), 0.01, Iterations, Root, 4087.48
    )
    );
  Assert(Equal(Root, 0.10, precision));

  Assert(
    FindRoot_NewtonRaphson(
    TomFutureValueFunc.Create(1000, 100, 120), 0.01, Iterations, Root, 14555.71
    )
    );
  Assert(Equal(Root, 0.001835, precision));

  Assert(
    FindRoot_NewtonRaphson(
    TomFutureValueFunc.Create(1000, 100, 120), 0.01, Iterations, Root, 13365.64
    )
    );
  Assert(Equal(Root, 0.000546, precision));

  Assert(
    FindRoot_NewtonRaphson(
    TomFutureValueFunc.Create(100, 100, 120), 0.01, Iterations, Root, 13343.89
    )
    );
  Assert(Equal(Root, 0.001727, precision));
end;

procedure TomTestSuiteMathUtils.Test_FindRoot_BrentMethod;
var
  Root: Double;
  Iterations: Integer;
begin
  Assert(
    FindRoot_BrentMethod(
    TomFutureValueFunc.Create(100, 100, 120), 0.0, 1.0, Iterations, Root,
    13343.89
    )
    );
  Assert(Equal(Root, 0.001727, 6));

  Assert(
    FindRoot_BrentMethod(
    TomFutureValueFunc.Create(1000, 100, 10), 0.0, 1.0, Iterations, Root, 4087.48
    )
    );
  Assert(Equal(Root, 0.10, 6));

  Assert(
    FindRoot_BrentMethod(
    TomFutureValueFunc.Create(1000, 100, 120), 0.0, 1.0, Iterations, Root,
    14555.71
    )
    );
  Assert(Equal(Root, 0.001835, 6));

  Assert(
    FindRoot_BrentMethod(
    TomFutureValueFunc.Create(1000, 100, 120), 0.0, 1.0, Iterations, Root,
    13365.64
    )
    );
  Assert(Equal(Root, 0.000546, 6));

  Assert(
    FindRoot_BrentMethod(
    TomFutureValueFunc.Create(100, 100, 120), 0.0, 1.0, Iterations, Root,
    13343.89
    )
    );
  Assert(Equal(Root, 0.001727, 6));
end;

procedure TomTestSuiteMathUtils.Test_Limits;
begin
  // normal
  Assert(Limit(5, 1, 10) = 5);

  // lower boundary
  Assert(Limit(1, 1, 10) = 1);
  Assert(Limit(0, 1, 10) = 1);

  // upper boundary
  Assert(Limit(10, 0, 10) = 10);
  Assert(Limit(11, 1, 10) = 10);
end;

//=============================================================================
{$ENDIF}


initialization


{$IFDEF Testing}
  TomTestMastery.RegisterTestSuite(TomTestSuiteMathUtils,
    TomTestSuiteUtils_Unit_Tests);
{$ENDIF}

end.
