{*

$Id: uProduct.pas,v 1.9 2004/05/04 19:17:20 slide Exp $

Description:

Product details collection for the Amazon Product Finder.

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

unit uProduct;

interface

uses

  Classes, ExtCtrls, SysUtils;

type

  {-------------------------------------------------------------------------}
  {- ProductDetails -}
  TProductDetails = class(TCollectionItem)
  private
    FProducts: TStringList;
    FASIN,
      FProductName,
      FProductAlias,
      FCatalog,
      FAuthors,
      FReleaseData,
      FTheatretical,
      FManufacturer,
      FDirector,
      FMediaType,
      FBrowseNode,
      FImageURL,
      FAvailability,
      FListPrice,
      FAmazonPrice,
      FUsedPrice,
      FDirectory: string;
    FUpdateDate: TDateTime;
    procedure SetProducts(AProducts: TStringList);
    procedure AddProductsToList(AProducts: TStrings);
    procedure SaveProductImage(AProductImage: string);
    function GetProductImageDirectory: string;
  public
    procedure AddProduct(AProduct: TProductDetails); virtual;
  published
    property ProductImageDirectory: string read GetProductImageDirectory;
  end;

  {-------------------------------------------------------------------------}
  {- ProductDetailsList -}
  TProductDetailsList = class(TCollection)
  private
    FProductDetails: TProductDetails;
    FUpdateDate: TDateTime;
    function GetProductDetails(AIndex: integer): TProductDetails;
    procedure SetProductDetails(AIndex: integer; AProduct: TProductDetails);
  public
    function Add(AAlias: string): TProductDetails;
    function IndexOf(AValue: string): integer;
    property Items[AIndex: integer]: TProductDetails read GetProductDetails write
    SetProductDetails; default;
  end;

var

  ProductDetails: TProductDetails; { Product details }
  ProductDetailsList: TProductDetailsList; { Product details list }

implementation

{-----------------------------------------------------------------------------}
{- ProductDetails -}

{-----------------------------------------------------------------------------}
{**

  @param AProduct
}

procedure TProductDetails.AddProduct(AProduct: TProductDetails);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AProducts
}

procedure TProductDetails.SetProducts(AProducts: TStringList);
begin
  FProducts := AProducts;
end;

{-----------------------------------------------------------------------------}
{**

  @param AProducts
}

procedure TProductDetails.AddProductsToList(AProducts: TStrings);
var
  i: integer;
begin
  i := 0;
  while i < AProducts.Count do
  begin
    FProducts.Add(AProducts[i]);
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param AProductImage
}

procedure TProductDetails.SaveProductImage(AProductImage: string);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @return
}

function TProductDetails.GetProductImageDirectory: string;
begin
  Result := ProductDetails.FDirectory;
end;

{-----------------------------------------------------------------------------}
{- ProductDetailsList -}

{-----------------------------------------------------------------------------}
{**

  @param AValue
  @return
}

function TProductDetailsList.IndexOf(AValue: string): integer;
var
  i: integer;
begin
  i := 0;
  Result := -1;
  while i < count do
  begin
    if Items[i].FProductAlias = AValue then
    begin
      Result := i;
      Break;
    end;
    Inc(i);
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param AIndex
  @param AProduct
}

procedure TProductDetailsList.SetProductDetails(AIndex: integer; AProduct:
  TProductDetails);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AIndex
}

function TProductDetailsList.GetProductDetails(AIndex: integer):
  TProductDetails;
begin
  Result := TProductDetails(inherited GetItem(AIndex));
end;

{-----------------------------------------------------------------------------}
{**

  @param AAlias
  @return
}

function TProductDetailsList.Add(AAlias: string): TProductDetails;
begin
  if IndexOf(AAlias) >= 0 then
    raise Exception.Create('Product alias exists!');
  Result := TProductDetails(inherited Add);
  Result.FProductAlias := AAlias;
end;

end.
