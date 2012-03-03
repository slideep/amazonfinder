object Backup: TBackup
  Left = 300
  Top = 266
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Backup Amazon Product Finder Searches'
  ClientHeight = 248
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 183
    Width = 368
    Height = 2
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 369
    Height = 177
    Align = alTop
    Caption = ' Searches '
    TabOrder = 0
    object lbSearches: TListBox
      Left = 2
      Top = 15
      Width = 365
      Height = 160
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 128
    Top = 192
    Width = 75
    Height = 25
    Caption = '&Backup'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 208
    Top = 192
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 288
    Top = 192
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 229
    Width = 369
    Height = 19
    Panels = <>
    SimplePanel = True
  end
end
