object Form1: TForm1
  Left = 323
  Top = 274
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'User Authentication'
  ClientHeight = 257
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 152
    Top = 224
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 232
    Top = 224
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 314
    Height = 209
    Align = alTop
    Caption = ' User Authentication Details '
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 63
      Height = 13
      Caption = 'Server name:'
    end
    object Label2: TLabel
      Left = 8
      Top = 142
      Width = 56
      Height = 13
      Caption = 'User Name:'
      Enabled = False
    end
    object Label3: TLabel
      Left = 8
      Top = 168
      Width = 74
      Height = 13
      Caption = 'User Password:'
    end
    object Label4: TLabel
      Left = 8
      Top = 58
      Width = 70
      Height = 13
      Caption = 'User Directory:'
      Enabled = False
    end
    object Label5: TLabel
      Left = 8
      Top = 116
      Width = 56
      Height = 13
      Caption = 'User E-mail:'
    end
    object Bevel1: TBevel
      Left = 40
      Top = 92
      Width = 257
      Height = 2
    end
    object Label6: TLabel
      Left = 8
      Top = 87
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object cbServerName: TComboBox
      Left = 96
      Top = 28
      Width = 201
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object txtUserName: TEdit
      Left = 96
      Top = 138
      Width = 201
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object txtUserPasswd: TMaskEdit
      Left = 96
      Top = 164
      Width = 201
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
    object cbUserDirectory: TComboBox
      Left = 96
      Top = 54
      Width = 201
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 96
      Top = 112
      Width = 201
      Height = 21
      TabOrder = 4
    end
  end
  object Button1: TButton
    Left = 72
    Top = 224
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
  end
end
