{

$Id: dlgAlarmEdit.pas,v 1.7 2004/05/05 22:22:25 slide Exp $

Description:

Main form for the Amazon Product Finder.

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

}

unit dlgAlarmEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DbugIntf;

type

  {-------------------------------------------------------------------------}
  {- TAlarmEdit -}
  TAlarmEdit = class(TForm)
    cmdOK: TButton;
    cmdCancel: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbTriggerAlarm: TComboBox;
    Label2: TLabel;
    cbActiveAlarm: TCheckBox;
    cbHour: TComboBox;
    cbMinutes: TComboBox;
    cb12Hour: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    cmdHelp: TButton;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AlarmEdit: TAlarmEdit;

implementation

uses
  frmMain, uFinderResources;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- AlarmEdit -}

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAlarmEdit.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAlarmEdit.cmdOKClick(Sender: TObject);
var
  i: integer;
begin

  if not MainForm.ProductAlarms.Active then
  begin
    for i := 0 to MainForm.ProductAlarms.Alarms.Count - 1 do
    begin
      with MainForm.ProductAlarms.Alarms.Items[i] do
      begin
        if Name = SAlarmPrice then
          Enabled := false
        else
        if Name = SAlarmSales then
          Enabled := true
        else                               
        if Name = SAlarmAverage then
          Enabled := true;
      end;
    end;

    MainForm.Alarm.Hour := StrToInt(cbHour.Text);
    MainForm.Alarm.Minute := StrToInt(cbMinutes.Text);

    SendDebugEx('Alarm time is: ' + cbHour.Text + ':' + cbMinutes.Text, mtInformation);

    if cbActiveAlarm.Checked then
      MainForm.ProductAlarms.Active := true
    else
      MainForm.ProductAlarms.Active := false;

  end;
  Close;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object
  @param Key The pressed key.
}

procedure TAlarmEdit.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
