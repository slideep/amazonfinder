object Thumbnails: TThumbnails
  Left = 242
  Top = 121
  BorderStyle = bsDialog
  Caption = 'Select Search Result'
  ClientHeight = 476
  ClientWidth = 402
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 457
    Width = 402
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 402
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 154
      Height = 13
      Caption = 'Select the local search result for:'
    end
    object Label3: TLabel
      Left = 8
      Top = 32
      Width = 79
      Height = 13
      Caption = 'lblSearchTitle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 352
    Width = 402
    Height = 105
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 28
      Width = 79
      Height = 13
      Caption = '&Search filename:'
    end
    object btnApply: TButton
      Left = 160
      Top = 48
      Width = 75
      Height = 25
      Caption = '&Load'
      TabOrder = 0
      OnClick = btnApplyClick
    end
    object btnCancel: TButton
      Left = 238
      Top = 48
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object Edit1: TEdit
      Left = 160
      Top = 24
      Width = 209
      Height = 21
      TabOrder = 2
    end
    object cbOnlyWhenSearches: TCheckBox
      Left = 8
      Top = 80
      Width = 345
      Height = 17
      Caption = 'Only show this dialog when &multiple searches available.'
      TabOrder = 3
    end
    object btnSelectFile: TButton
      Left = 370
      Top = 23
      Width = 22
      Height = 22
      Caption = '...'
      TabOrder = 4
      OnClick = btnSelectFileClick
    end
    object btnHelp: TButton
      Left = 317
      Top = 48
      Width = 75
      Height = 25
      Caption = '&Help'
      TabOrder = 5
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 65
    Width = 9
    Height = 287
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel4: TPanel
    Left = 393
    Top = 65
    Width = 9
    Height = 287
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
  end
  object Panel5: TPanel
    Left = 9
    Top = 65
    Width = 384
    Height = 287
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 5
    object dbgImages: TDBCtrlGrid
      Left = 1
      Top = 1
      Width = 382
      Height = 285
      Align = alClient
      Color = clWhite
      PanelBorder = gbNone
      PanelHeight = 95
      PanelWidth = 366
      ParentColor = False
      TabOrder = 0
      object dblTitle: TDBText
        Left = 105
        Top = 8
        Width = 65
        Height = 17
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dblArtistAuthor: TDBText
        Left = 105
        Top = 24
        Width = 89
        Height = 17
      end
      object Shape1: TShape
        Left = 8
        Top = 8
        Width = 89
        Height = 81
      end
      object imgProduct: TImage
        Left = 8
        Top = 8
        Width = 89
        Height = 81
      end
      object dblSearchResults: TDBText
        Left = 105
        Top = 56
        Width = 161
        Height = 17
      end
    end
  end
end
