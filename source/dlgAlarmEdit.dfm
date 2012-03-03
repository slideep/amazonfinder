object AlarmEdit: TAlarmEdit
  Left = 343
  Top = 291
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Edit Alarm'
  ClientHeight = 156
  ClientWidth = 310
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
  object cmdOK: TButton
    Left = 64
    Top = 120
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 144
    Top = 120
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = cmdCancelClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 310
    Height = 105
    Align = alTop
    Caption = ' Edit Scheduled Alarm '
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 64
      Height = 13
      Caption = 'Trigger alarm:'
    end
    object Label2: TLabel
      Left = 144
      Top = 32
      Width = 26
      Height = 13
      Caption = 'Time:'
    end
    object Label3: TLabel
      Left = 112
      Top = 52
      Width = 9
      Height = 13
      Caption = 'at'
    end
    object Label4: TLabel
      Left = 198
      Top = 51
      Width = 3
      Height = 13
      Caption = ':'
    end
    object cbTriggerAlarm: TComboBox
      Left = 16
      Top = 48
      Width = 81
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'Daily at specified time'
        'Hourly'
        'Weekly'
        'Monthly')
    end
    object cbActiveAlarm: TCheckBox
      Left = 16
      Top = 80
      Width = 65
      Height = 17
      Caption = '&Active'
      TabOrder = 1
    end
    object cbHour: TComboBox
      Left = 144
      Top = 48
      Width = 49
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23')
    end
    object cbMinutes: TComboBox
      Left = 208
      Top = 48
      Width = 49
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23'
        '24'
        '25'
        '26'
        '27'
        '28'
        '29'
        '30'
        '31'
        '32'
        '33'
        '34'
        '35'
        '36'
        '37'
        '38'
        '39'
        '40'
        '41'
        '42'
        '43'
        '44'
        '45'
        '46'
        '47'
        '48'
        '49'
        '50'
        '51'
        '52'
        '53'
        '54'
        '55'
        '56'
        '57'
        '58'
        '59')
    end
    object cb12Hour: TCheckBox
      Left = 145
      Top = 80
      Width = 97
      Height = 17
      Caption = 'AM/PM?'
      TabOrder = 4
    end
  end
  object cmdHelp: TButton
    Left = 224
    Top = 120
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
  end
end
