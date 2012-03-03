object Form2: TForm2
  Left = 194
  Top = 251
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 227
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 41
    Width = 643
    Height = 186
    Align = alClient
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'Name'
        Width = 253
      end
      item
        Caption = 'Our Price'
        Width = 60
      end
      item
        Caption = 'List Price'
        Width = 60
      end
      item
        Caption = 'Used Price'
        Width = 70
      end
      item
        Caption = 'Seller'
        Width = 200
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object MediaPlayer1: TMediaPlayer
    Left = 384
    Top = 104
    Width = 29
    Height = 30
    ColoredButtons = [btPlay]
    EnabledButtons = [btPlay]
    VisibleButtons = [btPlay]
    Visible = False
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 643
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 106
      Height = 13
      Caption = 'Alarm triggered for the:'
    end
    object lblAlarmName: TLabel
      Left = 136
      Top = 16
      Width = 64
      Height = 13
      Caption = 'lblAlarmName'
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 416
    Top = 104
  end
end
