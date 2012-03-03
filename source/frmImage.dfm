object ProductImage: TProductImage
  Left = 370
  Top = 238
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'ProductImage'
  ClientHeight = 249
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 231
    Height = 249
    Align = alClient
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 72
    Top = 96
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 104
    Top = 96
  end
  object ClosingTimer: TTimer
    Left = 136
    Top = 96
  end
end
