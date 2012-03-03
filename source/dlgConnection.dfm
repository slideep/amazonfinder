object ConnectionDialog: TConnectionDialog
  Left = 370
  Top = 220
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'New Connection'
  ClientHeight = 298
  ClientWidth = 282
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = '&Name:'
  end
  object Edit1: TEdit
    Left = 56
    Top = 4
    Width = 217
    Height = 21
    Hint = 'A name for your connection'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = Edit1Change
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 265
    Height = 209
    Caption = ' Type of Connection '
    TabOrder = 1
    object Bevel1: TBevel
      Left = 16
      Top = 144
      Width = 241
      Height = 2
    end
    object rbNetworkConnection: TRadioButton
      Left = 16
      Top = 58
      Width = 233
      Height = 17
      Hint = 'Create network connection to database'
      Caption = 'Network connection to database server'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object rbCustomConnection: TRadioButton
      Left = 16
      Top = 154
      Width = 225
      Height = 17
      Hint = 'Create network connection to your specific type'
      Caption = 'Custom definition'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 16
      Top = 176
      Width = 153
      Height = 21
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object btnBrowse: TButton
      Left = 184
      Top = 176
      Width = 75
      Height = 25
      Caption = '&Browse...'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object RadioButton1: TRadioButton
      Left = 16
      Top = 82
      Width = 209
      Height = 17
      Hint = 'Create network connection FTP directory'
      Caption = 'Network connection to FTP directory'
      TabOrder = 4
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 34
      Width = 233
      Height = 17
      Hint = 'Create network connection to database'
      Caption = 'Network connection to Amazon.com'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = True
    end
  end
  object btnAuthentication: TButton
    Left = 24
    Top = 144
    Width = 89
    Height = 25
    Hint = 'Use this to enter your username and password details'
    Caption = '&Authentication...'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnAuthenticationClick
  end
  object btnOK: TButton
    Left = 118
    Top = 256
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 198
    Top = 256
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
