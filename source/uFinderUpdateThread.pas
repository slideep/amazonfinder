{

$Id: uFinderUpdateThread.pas,v 1.9 2004/05/05 22:22:26 slide Exp $

Description:

Search update thread for the Amazon Product Finder.

The initial developer of the original code is slide@users.sourceforge.net.

This program is free software; you can redistriqbute it and/or
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

unit uFinderUpdateThread;

interface

uses
  Classes, SysUtils, Forms, SyncObjs, uProduct, uFinderCacheUtils;

type

  {-------------------------------------------------------------------------}
  {- TuFinderUpdateThread -}
  TuFinderUpdateThread = class(TThread)
  private
    { Private declarations }
    FCache,
      FUpdating: boolean;
    FSearchID: integer;
    FCurrentProduct: TProductDetails;
    FProductDetails: TProductDetailsList;
    FOnTerminate: TNotifyEvent;
    FOwnerForm: TForm;
    procedure OnFinished;
    procedure OnTerminateUpdate(Sender: TObject);
  protected
    procedure Execute; override;
  public
    { public declarations }
    constructor Create(AOwnerForm: TForm);
    destructor Destroy; override;
    procedure UpdateSearch(const ASearchID: integer);
    procedure UpdateAllSearches;
    procedure CancelUpdate;
    procedure OnShowMessage;
    procedure OnUpdateProgress;
    procedure OnTerminateThread;
    property OnTerminate: TNotifyEvent read FOnTerminate write FOnTerminate;
    property Updating: boolean read FUpdating write FUpdating;
    property Cache: boolean read FCache write FCache;
    property SearchID: integer read FSearchID write FSearchID;
  end;

var
  UpdateThread: TuFinderUpdateThread;

implementation

uses
  frmMain, uFinderGlobals, uFinderResources;

{-----------------------------------------------------------------------------}
{- UpdateThread -}

{-----------------------------------------------------------------------------}
{**
  Initializes the product update thread and sets the owner of this spawning
  thread to the given form.
  @param AOwnerForm The owner of this thread.
}

constructor TuFinderUpdateThread.Create(AOwnerForm: TForm);
begin
  inherited Create(false);
  Cache := true;
  FreeOnTerminate := true;
  FOwnerForm := AOwnerForm;
end;

{-----------------------------------------------------------------------------}
{**
  Un-initializes this thread and frees the critical section lock. Does a
  cleanup if necessary.
}

destructor TuFinderUpdateThread.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{**
  Executes this spawning thread and starts updating the product details in the
  given list of searches. Each search has a set of details or products that
  need to be checked for any new fresh information. Searches are located in the
  cache that needs to be iterated into the product details list if not already
  done in the main program.

  If a new search is performed then a corresponding product details class is
  created (TProductDetails) with the necessary details added to the class'
  structure. For now the program just populates the UI and doesn't perform
  any collection related functions.

  -> Search for product(s)
    -> Populate UI with parsed XML
  -> Create TProductDetails
    -> Set details for the create class with parsed XML
  -> Add class as a collection item to the TProductDetailsList
}

procedure TuFinderUpdateThread.Execute;
var
  i: integer;
begin
  try
    Updating := true;
    while (not Terminated) do
    begin
      Application.ProcessMessages;
    end;
  finally
    Updating := false;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Cancels the update process for this spawning thread.
}

procedure TuFinderUpdateThread.CancelUpdate;
begin
  if not (Terminated) and (Updating) then
    UpdateThread.Terminate;
  UpdateThread.Updating := false;
end;

{-----------------------------------------------------------------------------}
{**
  Updates the given search with ID provided that is located in the
  product details list.
  @param ASearchID The unique ID for this search.
}

procedure TuFinderUpdateThread.UpdateSearch(const ASearchID: integer);
begin
  if not (Updating) then
  begin
    Updating := true;
  end
  else
    Updating := false;
end;

{-----------------------------------------------------------------------------}
{**
  Updates all searches in the cache.
}

procedure TuFinderUpdateThread.UpdateAllSearches;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TuFinderUpdateThread.OnUpdateProgress;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TuFinderUpdateThread.OnShowMessage;
begin
  //
end;

{-----------------------------------------------------------------------------}

procedure TuFinderUpdateThread.OnFinished;
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TuFinderUpdateThread.OnTerminateUpdate(Sender: TObject);
begin
  //
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TuFinderUpdateThread.OnTerminateThread;
begin
  if Assigned(FOnTerminate) then
    FOnTerminate(Self);
  FreeAndNil(Self);
end;

end.
