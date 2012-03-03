{

$Id: uFinderAlarm.pas,v 1.4 2004/05/04 19:17:19 slide Exp $

Description:

Alarm scheduler component for the Amazon Product Finder.

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

unit uFinderAlarm;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Controls, Forms;

type

  {-------------------------------------------------------------------------}
  {- TuFinderAlarm -}
  TuFinderAlarm = class(TComponent)
  private
    FHour: word;
    FMinute: word;
    FSecond: word;
    FAlarmEnabled: boolean;
    FWindowHandle: HWND;
    FOnAlarm: TNotifyEvent;
    procedure UpdateTimer;
    procedure SetEnabled(AValue: boolean);
    procedure SetSeconds(AValue: word);
    procedure SetOnAlarm(AValue: TNotifyEvent);
    procedure WndProc(var Msg: TMessage);
  protected
    procedure RunAlarm; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AlarmEnabled: boolean read FAlarmEnabled write SetEnabled default
      false;
    property Hour: word read FHour write FHour;
    property Minute: word read FMinute write FMinute default 0;
    property Second: word read FSecond write SetSeconds default 0;
    property OnAlarm: TNotifyEvent read FOnAlarm write SetOnAlarm;
  end;

implementation

{-----------------------------------------------------------------------------}
{- TuFinderAlarm -}

{-----------------------------------------------------------------------------}
{**
 Initializes new alarm and sets it to the given owning window/app receiving
 the timer message.
 @param AOwner The owning window or form.
 @return No return
}

constructor TuFinderAlarm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlarmEnabled := false;
  FWindowHandle := Classes.AllocateHWnd(WndProc);
end;

{-----------------------------------------------------------------------------}
{**
 Destroys the alarm and un-attaches it from the owner window/app.
 @return No return
}

destructor TuFinderAlarm.Destroy;
begin
  if FAlarmEnabled then
    FAlarmEnabled := false;
  UpdateTimer;
  Classes.DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

{-----------------------------------------------------------------------------}
{**

 @param Msg
 @return No return
}

procedure TuFinderAlarm.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
    begin
      if FSecond > 0 then
        Dec(FSecond)
      else
      begin
        FSecond := 59;
        if FMinute > 0 then
          Dec(FMinute)
        else
        begin
          FMinute := 59;
          if FHour > 0 then
            Dec(FHour);
        end;
      end;
      if (FHour = 0) and (FMinute = 0) and (FSecond = 0) then
      try
        RunAlarm;
      except
        on E: Exception do
          Application.HandleException(Self);
      end;
    end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

{-----------------------------------------------------------------------------}
{**
 Updates the timer.
 @return No return
}

procedure TuFinderAlarm.UpdateTimer;
begin
  KillTimer(FWindowHandle, 1);
  if FAlarmEnabled and Assigned(FOnAlarm) then
    if SetTimer(FWindowHandle, 1, 1000, nil) = 0 then
    begin
    end;
end;

{-----------------------------------------------------------------------------}
{**
 Sets the alarm enabled or disabled and updates the timer.
 @param AValue True/False value
}

procedure TuFinderAlarm.SetEnabled(AValue: boolean);
begin
  FAlarmEnabled := AValue;
  UpdateTimer;
end;

{-----------------------------------------------------------------------------}
{**
 Sets the seconds value for the timer.
 @param AValue The seconds
 @return No return
}

procedure TuFinderAlarm.SetSeconds(AValue: word);
begin
  FSecond := AValue;
  FAlarmEnabled := True;
  UpdateTimer;
end;

{-----------------------------------------------------------------------------}
{**
 Sets the event what happens when the alarm is triggered.
 @param AValue The event that is triggered
}

procedure TuFinderAlarm.SetOnAlarm(AValue: TNotifyEvent);
begin
  FOnAlarm := AValue;
end;

{-----------------------------------------------------------------------------}
{**
 Runs the the alarm.
 @param No parameters
 @return No return
}

procedure TuFinderAlarm.RunAlarm;
begin
  KillTimer(FWindowHandle, 1);
  if Assigned(FOnAlarm) then
    FOnAlarm(Self);
end;

end.
