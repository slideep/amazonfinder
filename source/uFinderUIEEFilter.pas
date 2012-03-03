{*

$Id: uFinderUIEEFilter.pas,v 1.5 2004/05/04 19:17:19 slide Exp $

Description:

UIEE export filter for Amazon Product Finder.

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

*}

unit uFinderUIEEFilter;

interface

uses

  Classes, ExtCtrls, SysUtils, uXmlUtils, MSXML2_TLB;

type

  {-------------------------------------------------------------------------}
  {- uFinderUIEEFilter -}
  TuFinderUIEEFilter = class
  private
    FEnabled: boolean;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;

  published
    property Enable: boolean read FEnabled write FEnabled default true;
  end;

var

  UIEEFilter: TuFinderUIEEFilter;

implementation

{-----------------------------------------------------------------------------}
{- uFinderCSVFilter -}

{-----------------------------------------------------------------------------}
{**

  @param AFileName
}

constructor TuFinderUIEEFilter.Create(const AFileName: string);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

destructor TuFinderUIEEFilter.Destroy;
begin

  inherited destroy;
end;

end.
