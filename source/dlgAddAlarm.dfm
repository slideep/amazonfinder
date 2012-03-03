object Alarm: TAlarm
  Left = 311
  Top = 225
  BorderStyle = bsDialog
  Caption = 'Add Alarm'
  ClientHeight = 346
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 311
    Height = 297
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Alarms'
      object Label1: TLabel
        Left = 8
        Top = 120
        Width = 68
        Height = 13
        Caption = 'Alarms In Use:'
      end
      object Bevel1: TBevel
        Left = 8
        Top = 224
        Width = 273
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
        Width = 257
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
          6365204368616E676520416C61726D00000000FFFFFFFFFFFFFFFF0000000000
          0000001053616C65732052616E6B20416C61726D00000000FFFFFFFFFFFFFFFF
          0000000000000000144176657261676520526174696E6720416C61726D}
        TabOrder = 0
        ViewStyle = vsList
      end
      object btnCategories: TButton
        Left = 223
        Top = 136
        Width = 75
        Height = 25
        Caption = '&Edit...'
        TabOrder = 1
        OnClick = btnCategoriesClick
      end
      object cbSelectCategory: TComboBox
        Left = 8
        Top = 240
        Width = 209
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'Select Alarm Category'
        Items.Strings = (
          'List Price'
          'Our Price'
          'Used Price')
      end
      object btnAdd: TButton
        Left = 223
        Top = 238
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 3
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 32
        Width = 97
        Height = 17
        Caption = '&Default Alarm'
        TabOrder = 4
      end
      object CheckBox2: TCheckBox
        Left = 160
        Top = 32
        Width = 97
        Height = 17
        Caption = '&No Alarms Set'
        TabOrder = 5
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 64
        Width = 97
        Height = 17
        Caption = '&Custom Alarm'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object CheckBox4: TCheckBox
        Left = 32
        Top = 88
        Width = 249
        Height = 17
        Caption = 'Launch Alarm When Price &Changes'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
    end
  end
  object Button1: TButton
    Left = 64
    Top = 312
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 144
    Top = 312
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
  object btnApply: TButton
    Left = 227
    Top = 312
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 3
  end
end
