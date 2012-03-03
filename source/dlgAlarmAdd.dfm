object AlarmAdd: TAlarmAdd
  Left = 343
  Top = 204
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Add/Edit Alarm'
  ClientHeight = 349
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 310
    Height = 297
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Alarms'
      object Label1: TLabel
        Left = 8
        Top = 120
        Width = 65
        Height = 13
        Caption = 'Alarms in use:'
      end
      object Bevel1: TBevel
        Left = 8
        Top = 224
        Width = 289
        Height = 2
      end
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 26
        Height = 13
        Caption = 'Alarm'
      end
      object Bevel4: TBevel
        Left = 46
        Top = 15
        Width = 251
        Height = 2
      end
      object lvAlarms: TListView
        Left = 8
        Top = 136
        Width = 209
        Height = 73
        Checkboxes = True
        Columns = <>
        ColumnClick = False
        Items.Data = {
          7D0000000300000000000000FFFFFFFFFFFFFFFF000000000000000012507269
          6365206368616E676520616C61726D00000000FFFFFFFFFFFFFFFF0000000000
          0000001053616C65732072616E6B20616C61726D00000000FFFFFFFFFFFFFFFF
          0000000000000000144176657261676520726174696E6720616C61726D}
        TabOrder = 0
        ViewStyle = vsList
        OnSelectItem = lvAlarmsSelectItem
      end
      object cmdEdit: TButton
        Left = 223
        Top = 136
        Width = 75
        Height = 25
        Caption = '&Edit...'
        TabOrder = 1
        OnClick = cmdEditClick
      end
      object cbSelectCategory: TComboBox
        Left = 8
        Top = 240
        Width = 209
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'Select alarm category'
        Items.Strings = (
          'List Price'
          'Our Price'
          'Used Price')
      end
      object cmdAdd: TButton
        Left = 223
        Top = 238
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 3
      end
      object cbDefaultAlarm: TCheckBox
        Left = 8
        Top = 32
        Width = 97
        Height = 17
        Caption = '&Default alarm'
        TabOrder = 4
      end
      object cbNoAlarms: TCheckBox
        Left = 160
        Top = 32
        Width = 97
        Height = 17
        Caption = '&No alarms set'
        TabOrder = 5
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 64
        Width = 97
        Height = 17
        Caption = '&Custom alarm'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 6
      end
      object CheckBox4: TCheckBox
        Left = 32
        Top = 88
        Width = 249
        Height = 17
        Caption = 'Launch alarm when price &changes'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 7
        Visible = False
      end
    end
  end
  object cmdOK: TButton
    Left = 64
    Top = 312
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 1
  end
  object cmdCancel: TButton
    Left = 144
    Top = 312
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object cmdApply: TButton
    Left = 227
    Top = 312
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 3
  end
end
