{

$Id: dlgAlarmAdd.pas,v 1.6 2004/05/05 22:22:25 slide Exp $

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

unit dlgAlarmAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, dlgAlarmEdit;

type

  {-------------------------------------------------------------------------}
  {- TAlarmAdd -}
  TAlarmAdd = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel4: TBevel;
    lvAlarms: TListView;
    cmdEdit: TButton;
    cbSelectCategory: TComboBox;
    cmdAdd: TButton;
    cbDefaultAlarm: TCheckBox;
    cbNoAlarms: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    cmdApply: TButton;
    procedure cmdEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lvAlarmsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
    FSelectedAlarm: TListItem;
  public
    { Public declarations }
    property SelectedAlarm: TListItem read FSelectedAlarm;
  end;

var
  AlarmAdd: TAlarmAdd;
  EditAlarm: TAlarmEdit;

implementation

uses
  frmMain, DbugIntf;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- AlarmAdd -}

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TAlarmAdd.cmdEditClick(Sender: TObject);
begin
  if not Assigned(EditAlarm) then
    EditAlarm := TAlarmEdit.Create(nil);
  EditAlarm.ShowModal;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Key The pressed key.
}

procedure TAlarmAdd.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then // TODO: CR
  begin
    Key := #0;
    Close;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Item The item selected.
  @param Selected True/false checked.
}

procedure TAlarmAdd.lvAlarmsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i: integer;
begin
  if not Assigned(Item) or not Selected then
    exit;
  with lvAlarms.Items do
  begin
    for i := 0 to Count - 1 do
      case i of
        0: // AvgRating - ProductAlarms.Alarms[0]
          if Item[0].Checked and (Selected) then
          begin
            SendDebugEx('Alarm - AvgRating selected', mtInformation);

          end;
        1: // SalesRank
          if Item[1].Checked and (Selected) then
          begin
            SendDebugEx('Alarm - SalesRank selected', mtInformation);

          end;
        2: // PriceChange
          if Item[2].Checked and (Selected) then
          begin
            SendDebugEx('Alarm - PriceChange', mtInformation);
            
          end;
      end;
  end;
end;

end.
