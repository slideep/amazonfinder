{*

$Id: uShoppingCart.pas,v 1.8 2004/05/04 19:17:20 slide Exp $

Description:

Remote shopping cart for the Amazon Product Finder.

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

unit uShoppingCart;

interface

uses

  Classes, uProduct, IdURI, IdHTTP;

type

  {-------------------------------------------------------------------------}
  {- Cart operations -}
  TShoppingCartOperation = (scoAdd, scoClear, scoCreate, scoGet,
    scoModify, scoRemove);

  {-------------------------------------------------------------------------}
  {- Forward declaration -}
  TShoppingCartList = class;

  {-------------------------------------------------------------------------}
  {- Cart -}
  TShoppingCart = class(TComponent)
  private
    FCartID: integer;
    FAsin: string;
    FItems: TShoppingCartList;
    FCart: TShoppingCart;
    procedure SetList(AList: TShoppingCartList);
    procedure SetCartID(const AValue: integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IndexOf(AValue: string): integer;
  published
    property ID: integer read FCartID write SetCartID;
    property List: TShoppingCartList read FItems write SetList;
    property Cart: TShoppingCart read FCart;
    property ASIN: string read FAsin write FAsin;
  end;

  {-------------------------------------------------------------------------}
  {- ShoppingCartItem -}
  TShoppingCartItem = class(TCollectionItem)
  private
    //FProducts : TCollection;
    FProducts: TStringList;
    FCartID: string;
    FHMAC: string;
    FPurchaseURL: string;
    procedure SetProducts(AProducts: TStrings);
    procedure AddProductsToList(AProducts: TStrings);
    procedure AddProductToList(AProduct: string; AValue: integer);
  public
    procedure AddProduct(AProduct: TShoppingCartItem); virtual;
  end;

  {-------------------------------------------------------------------------}
  {- ShoppingCartList -}
  TShoppingCartList = class(TCollection)
  private
    FProductDetails: TShoppingCartItem;
    FUpdateDate: TDateTime;
    function GetProductDetails(AIndex: integer): TShoppingCartItem;
    procedure SetProductDetails(AIndex: integer; AProduct: TShoppingCartItem);
  public
    function Add(AAlias: string): TShoppingCartItem;
    function GetTotalCost: string;
    function GetItem(AValue: string): TShoppingCartItem;
    function GetNumOfItems: string;
    function IndexOf(AValue: string): integer;
    property Items[AIndex: integer]: TShoppingCartItem read GetProductDetails
    write SetProductDetails; default;
  end;

var
  Cart: TShoppingCart;

resourcestring
  SAddProductToCart = 'Add to shopping cart';
  SAddedProductToCart = 'Added %d item to your shopping cart %s';
  SAddedProductsToCart = 'Added %d items to your shopping cart %s';
  SProceedToCheckOut = 'Proceed to checkout';
  SNoItemsInCart = 'You have no items in your shopping cart';

  {-----------------------------------------------------------------------------}

implementation

{-----------------------------------------------------------------------------}
{ ShoppingCart }

{-----------------------------------------------------------------------------}
{**

}

constructor TShoppingCart.Create;
begin
  inherited;
end;

{-----------------------------------------------------------------------------}
{**

}

destructor TShoppingCart.Destroy;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AValue
}

procedure TShoppingCart.SetCartID(const AValue: integer);
begin
  FCartID := AValue;
end;

{-----------------------------------------------------------------------------}
{**

  @param AList
}

procedure TShoppingCart.SetList(AList: TShoppingCartList);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AValue
  @return
}

function TShoppingCart.IndexOf(AValue: string): integer;
begin
  //
end;

{-----------------------------------------------------------------------------}
{- ShoppingCartItem -}

{-----------------------------------------------------------------------------}
{**

  @param AProducts
}

procedure TShoppingCartItem.SetProducts(AProducts: TStrings);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AProducts
}

procedure TShoppingCartItem.AddProductsToList(AProducts: TStrings);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AProduct
  @param AValue
}

procedure TShoppingCartItem.AddProductToList(AProduct: string; AValue: integer);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AProduct
}

procedure TShoppingCartItem.AddProduct(AProduct: TShoppingCartItem);
begin
  //
end;

{-----------------------------------------------------------------------------}
{- ShoppingCartList -}

{-----------------------------------------------------------------------------}
{**

  @param AIndex
  @return
}

function TShoppingCartList.GetProductDetails(AIndex: integer):
  TShoppingCartItem;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AIndex
  @param AProduct
}

procedure TShoppingCartList.SetProductDetails(AIndex: integer; AProduct:
  TShoppingCartItem);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AAlias
  @return
}

function TShoppingCartList.Add(AAlias: string): TShoppingCartItem;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @return
}

function TShoppingCartList.GetTotalCost: string;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AValue
  @return
}

function TShoppingCartList.GetItem(AValue: string): TShoppingCartItem;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @return
}

function TShoppingCartList.GetNumOfItems: string;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

  @param AValue
  @return
}

function TShoppingCartList.IndexOf(AValue: string): integer;
begin
  //
end;

end.
