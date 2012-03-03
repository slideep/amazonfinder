{*

$Id: uXmlUtils.pas,v 1.11 2004/05/05 22:22:26 slide Exp $

Description:

XML helper functions for the Amazon Product Finder.

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

*}

unit uXmlUtils;

interface

uses

  Classes, SysUtils, XMLIntf, XMLDoc, MSXML2_TLB;

function ReadAttr(ANode: IXMLNode; const AAttr: WideString): WideString;
function GetChild(ANode: IXMLNode; AChildName: WideString): IXMLNode;
function GetErrMsg(ANode: IXMLNode; AChildName: WideString): boolean;
function GetTotalResults(ANode: IXMLNode): WideString;
function GetTrackCount(ANode: IXMLNode): WideString;
function GetTotalPages(ANode: IXMLNode): WideString;
function GetPrice(ANode: IXMLNode): WideString;
function GetPriceChange(AOldNode, ANewNode: IXMLNode): WideString;
function GetSalesRank(ANode: IXMLNode): WideString;
function GetSalesRankChange(AOldNode, ANewNode: IXMLNode): WideString;
function ExportResults(const AXmlFile, AXslFile, ADir: WideString): boolean;

implementation

{-----------------------------------------------------------------------------}
{- uXmlUtils -}

{-----------------------------------------------------------------------------}
{**

  @param ANode
  @param AAttr
  @return WideString
}

function ReadAttr(ANode: IXMLNode; const AAttr: WideString): WideString;
var
  AttrMap: IXMLNodeList;
  AttrNode: IXMLNode;
begin
  result := '';
  if not Assigned(ANode) then
    exit;
  if Assigned(ANode) then
  begin
    AttrMap := ANode.AttributeNodes;
    if AttrMap.Count > 0 then
    begin
      AttrNode := AttrMap.FindNode(AAttr);
      if Assigned(AttrNode) then
        result := AttrNode.text;
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param
  @param
  @return IXMLNode
}

function GetChild(ANode: IXMLNode; AChildName: WideString): IXMLNode;
var
  i: integer;
begin
  if not Assigned(ANode) then
    exit;
  result := nil;
  for i := 0 to ANode.ChildNodes.Count - 1 do
    if ANode.ChildNodes.Get(i).NodeName = AChildName then
    begin
      result := ANode.ChildNodes.Get(i);
      break;
    end;
end;

{-----------------------------------------------------------------------------}
{**

  @param
  @param
  @return Boolean
}

function GetErrMsg(ANode: IXMLNode; AChildName: WideString): boolean;
var
  ErrorNode: IXMLNode;
begin
  if not Assigned(ANode) then
    exit
  else
  begin
    ErrorNode := GetChild(ANode, AChildName);
    if Assigned(ErrorNode) then
      result := true
    else
      result := false;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param
  @return WideString
}

function GetTotalResults(ANode: IXMLNode): WideString;
var
  ResultsNode: IXMLNode;
begin
  if not Assigned(ANode) then
    exit
  else
  begin
    ResultsNode := GetChild(ANode, 'TotalResults');
    result := ResultsNode.Text;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param
  @return WideString
}

function GetTrackCount(ANode: IXMLNode): WideString;
var
  TrackNode: IXMLNode;
begin
  if not Assigned(ANode) then
    exit
  else
  begin
    TrackNode := GetChild(ANode, 'Tracks');
    result := IntToStr(TrackNode.ChildNodes.Count);
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param
  @return WideString
}

function GetTotalPages(ANode: IXMLNode): WideString;
var
  PagesNode: IXMLNode;
begin
  if not Assigned(ANode) then
    exit
  else
  begin
    PagesNode := GetChild(ANode, 'TotalPages');
    result := PagesNode.Text;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param
  @return WideString
}

function GetPrice(ANode: IXMLNode): WideString;
var
  PriceNode: IXMLNode;
begin
  if not Assigned(ANode) then
  	exit
  else
  begin
  	PriceNode := GetChild(ANode, 'OurPrice');
  	result := PriceNode.Text;
  end;	
end;

{-----------------------------------------------------------------------------}
{**

  @param AOldNode
  @param ANewNode
  @return WideString
}

function GetPriceChange(AOldNode, ANewNode: IXMLNode): WideString;
var  
  OldPriceNode,
  NewPriceNode: IXMLNode;    
  OldPrice, 
  NewPrice: double;  
begin
  if not Assigned(AOldNode) then
  	exit
  else
  begin  	
  	OldPriceNode := GetChild(AOldNode, 'OurPrice');
  	NewPriceNode := GetChild(ANewNode, 'OurPrice');
	  OldPrice := StrToFloat(GetPrice(OldPriceNode));
 	  NewPrice := StrToFloat(GetPrice(NewPriceNode));
    if NewPrice < OldPrice then
      result := NewPriceNode.Text
    else
      result := OldPriceNode.Text;
  end;  	
end;

{-----------------------------------------------------------------------------}
{**

  @param ANode
  @return WideString
}

function GetSalesRank(ANode: IXMLNode): WideString;
var
  PriceNode: IXMLNode;
begin
  if not Assigned(ANode) then
  	exit
  else
  begin
  	PriceNode := GetChild(ANode, 'OurPrice');
  	result := PriceNode.Text;
  end;	
end;

{-----------------------------------------------------------------------------}
{**

  @param AOldNode
  @param ANewNode
  @return WideString
}

function GetSalesRankChange(AOldNode, ANewNode: IXMLNode): WideString;
var  
  OldRankNode,
  NewRankNode: IXMLNode;
  OldRank,
  NewRank: integer;  
begin
  if not Assigned(AOldNode) then
  	exit
  else
  begin
  	OldRankNode := GetChild(AOldNode, 'SalesRank');
  	NewRankNode := GetChild(ANewNode, 'SalesRank');
	  OldRank := StrToInt(GetSalesRank(OldRankNode));
 	  NewRank := StrToInt(GetSalesRank(NewRankNode));
    if NewRank > OldRank then
      result := NewRankNode.Text
    else
      result := OldRankNode.Text;
  end;  	
end;

{-----------------------------------------------------------------------------}
{**

  @param AXmlFile
  @param AXslFile
  @param ADir
  @return Boolean
}

function ExportResults(const AXmlFile, AXslFile, ADir: WideString): boolean;
var
  XmlDoc: IXMLDOMDocument;
  XslDoc: IXMLDOMDocument;
  Template: IXSLTemplate;
  Processor: IXSLProcessor;
  Results: TStringList;
  Output: WideString;
begin
  try
    Results := TStringList.Create;
    XmlDoc := CoFreeThreadedDOMDocument30.Create;
    XslDoc := CoFreeThreadedDOMDocument30.Create;
    XmlDoc.load(AXmlFile);
    XslDoc.load(AXslFile);
    XslDoc.async := false;
    Template := CoXSLTemplate30.Create;
    try
      Template.stylesheet := XslDoc;
    except
      on E: Exception do
        result := false;
    end;
    Processor := Template.createProcessor;
    Processor.input := XmlDoc;
    if Processor.transform then
      result := true
    else
      result := false;
    Output := Processor.output;
    Results.Text := Output;
    Results.SaveToFile(ADir);
  finally
    Output := '';
    XmlDoc := nil;
    XslDoc := nil;
    Results.Free;
  end;
end;

end.
