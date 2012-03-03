{

$Id: uFinderEuroConv.pas,v 1.1 2004/05/04 19:17:20 slide Exp $

Description:

Euro conversion procedures and helper functions for the Amazon Product Finder.

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

unit uFinderEuroConv;

interface

uses

  ConvUtils, Math;

var

  cbEuro: TConvFamily; { Euro conversion family }
  euEUR: TConvType;    { EU euro }
  euUSD: TConvType;    { US dollars }
  euGBP: TConvType;    { British pounds }
  euJPY: TConvType;    { Japanese yens }

var

  USDToEUR: double = 1.2192;
  GBPToEUR: double = 0.67040;
  JPYToEUR: double = 135.50;

  USDSubUnit: integer = -2;
  GBPSubUnit: integer = -2;
  JPYSubUnit: integer = -2;

//-------------------------------------------------------------------------
function RegisterEuroConversionType(const AFamily: TConvFamily;
  const ADescription: string; const AFactor: double;
  const ARound: TRoundToRange): TConvType; overload;

//-------------------------------------------------------------------------
function RegisterEuroConversionType(const AFamily: TConvFamily;
  const ADescription: string; const AToCommonProc,
  AFromCommonProc: TConversionProc): TConvType; overload;

type

  {-------------------------------------------------------------------------}
  {- TConvTypeEuroFactor -}
  TConvTypeEuroFactor = class(TConvTypeFactor)
  private
    FRound: TRoundToRange;
  public
    constructor Create(const AConvFamily: TConvFamily;
      const ADescription: string; const AFactor: double;
      const ARound: TRoundToRange);
    function ToCommon(const AValue: double): double; override;
    function FromCommon(const AValue: double): double; override;
  end;

implementation

resourcestring

  SEuroDescription = 'Euro';
  SUSDDescription  = 'USDollars';
  SGBPDescription  = 'BritishPounds';
  SJPYDescription  = 'JapaneseYens';

{-----------------------------------------------------------------------------}
{- TConvTypeEuroFactor -}

{-----------------------------------------------------------------------------}
{**
  
  @param AConvFamily
  @param ADescription
  @param AFactor
  @param ARound
}

constructor TConvTypeEuroFactor.Create(const AConvFamily: TConvFamily;
  const ADescription: string; const AFactor: double;
  const ARound: TRoundToRange);
begin
  inherited Create(AConvFamily, ADescription, AFactor);
  FRound := ARound;
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}  

function TConvTypeEuroFactor.FromCommon(const AValue: double): double;
begin
  result := SimpleRoundTo(AValue * Factor, FRound);
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}

function TConvTypeEuroFactor.ToCommon(const AValue: double): double;
begin
  result := AValue / Factor;
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AFamily
  @param ADescription
  @param AFactor
  @param ARound
  @return TConvType
}

function RegisterEuroConversionType(const AFamily: TConvFamily;
  const ADescription: string; const AFactor: double;
  const ARound: TRoundToRange): TConvType;
var
  LInfo: TConvTypeInfo;
begin
  LInfo := TConvTypeEuroFactor.Create(AFamily, ADescription, AFactor, ARound);
  if not RegisterConversionType(LInfo, result) then
  begin
    LInfo.Free;
    RaiseConversionRegError(AFamily, ADescription);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AFamily
  @param ADescription
  @param AToCommonProc
  @param AFromCommonProc
  @return TConvType
}
    
function RegisterEuroConversionType(const AFamily: TConvFamily;
  const ADescription: string; const AToCommonProc,
  AFromCommonProc: TConversionProc): TConvType;
begin
  result := RegisterConversionType(AFamily, ADescription,
    AToCommonProc, AFromCommonProc);
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}

function ConvertUSDToEUR(const AValue: double): double;
begin
  result := AValue * USDToEUR;
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}

function ConvertEURToUSD(const AValue: double): double;
begin
  result := SimpleRoundTo(AValue / USDToEUR, USDSubUnit);
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}

function ConvertGBPToEUR(const AValue: double): double;
begin
  result := AValue * GBPToEUR;
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}

function ConvertEURToGBP(const AValue: double): double;
begin
  result := SimpleRoundTo(AValue / GBPToEUR, GBPSubUnit);
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}

function ConvertJPYToEUR(const AValue: double): double;
begin
  result := AValue * JPYToEUR;
end;

{-----------------------------------------------------------------------------}
{**
  
  @param AValue
  @return double
}

function ConvertEURToJPY(const AValue: double): double;
begin
  result := SimpleRoundTo(AValue / JPYToEUR, JPYSubUnit);
end;

initialization
  cbEuro := RegisterConversionFamily(SEuroDescription);
  euUSD := RegisterEuroConversionType(cbEuro, SUSDDescription, ConvertUSDToEUR,
    ConvertEURToUSD);
  euGBP := RegisterEuroConversionType(cbEuro, SGBPDescription, ConvertGBPToEUR,
    ConvertEURToGBP);
  euJPY := RegisterEuroConversionType(cbEuro, SJPYDescription, ConvertJPYToEUR,
    ConvertEURToJPY);

finalization
  UnregisterConversionFamily(cbEuro);

end.
