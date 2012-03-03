object Preferences: TPreferences
  Left = 327
  Top = 198
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Amazon Product Finder Preferences'
  ClientHeight = 405
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label20: TLabel
    Left = 12
    Top = 24
    Width = 31
    Height = 13
    Caption = 'Server'
  end
  object Bevel6: TBevel
    Left = 72
    Top = 31
    Width = 257
    Height = 2
  end
  object btnOK: TButton
    Left = 96
    Top = 368
    Width = 77
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 180
    Top = 368
    Width = 77
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 347
    Height = 361
    ActivePage = TabSheet2
    Align = alTop
    TabOrder = 2
    object TabSheet2: TTabSheet
      Caption = 'General'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 339
        Height = 333
        Align = alClient
        Caption = ' Miscellaneous Settings '
        TabOrder = 0
        object Label5: TLabel
          Left = 12
          Top = 48
          Width = 60
          Height = 13
          Caption = 'Search type:'
        end
        object Label8: TLabel
          Left = 200
          Top = 112
          Width = 120
          Height = 13
          Caption = '&days after being updated.'
        end
        object Bevel2: TBevel
          Left = 72
          Top = 150
          Width = 257
          Height = 2
        end
        object Label9: TLabel
          Left = 12
          Top = 144
          Width = 39
          Height = 13
          Caption = 'Program'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Bevel3: TBevel
          Left = 72
          Top = 247
          Width = 257
          Height = 2
        end
        object Label10: TLabel
          Left = 12
          Top = 240
          Width = 50
          Height = 13
          Caption = 'Directories'
        end
        object Label11: TLabel
          Left = 12
          Top = 272
          Width = 110
          Height = 13
          Caption = 'Default &cache location:'
        end
        object btnSelectDirectory: TSpeedButton
          Left = 305
          Top = 270
          Width = 23
          Height = 21
          Caption = '...'
          OnClick = btnSelectDirectoryClick
        end
        object Label12: TLabel
          Left = 12
          Top = 24
          Width = 34
          Height = 13
          Caption = 'Search'
        end
        object Bevel4: TBevel
          Left = 72
          Top = 31
          Width = 257
          Height = 2
        end
        object Label13: TLabel
          Left = 12
          Top = 304
          Width = 109
          Height = 13
          Caption = 'Default export location:'
        end
        object btnSelectExportLocation: TSpeedButton
          Left = 305
          Top = 302
          Width = 23
          Height = 21
          Caption = '...'
          OnClick = btnSelectExportLocationClick
        end
        object Label15: TLabel
          Left = 12
          Top = 80
          Width = 80
          Height = 13
          Caption = 'Results returned:'
        end
        object Label16: TLabel
          Left = 200
          Top = 80
          Width = 33
          Height = 13
          Caption = 'Pages:'
        end
        object cbSearchType: TComboBox
          Left = 120
          Top = 48
          Width = 73
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Lite'
            'Heavy')
        end
        object UpDown1: TUpDown
          Left = 153
          Top = 108
          Width = 16
          Height = 21
          Associate = UpdateDelay
          Enabled = False
          Position = 7
          TabOrder = 1
        end
        object UpdateDelay: TEdit
          Left = 120
          Top = 108
          Width = 33
          Height = 21
          Enabled = False
          TabOrder = 2
          Text = '7'
        end
        object cbDeleteSearches: TCheckBox
          Left = 12
          Top = 112
          Width = 97
          Height = 17
          Caption = 'Delete searches'
          TabOrder = 3
          OnClick = cbDeleteSearchesClick
        end
        object cbDefaultType: TCheckBox
          Left = 200
          Top = 48
          Width = 81
          Height = 17
          Caption = '&Default type'
          TabOrder = 4
        end
        object cbUpdateStartup: TCheckBox
          Left = 12
          Top = 176
          Width = 181
          Height = 17
          Caption = '&Update searches during startup'
          TabOrder = 5
        end
        object cbDisplaySplash: TCheckBox
          Left = 196
          Top = 176
          Width = 133
          Height = 17
          Caption = 'Display &splash screen'
          TabOrder = 6
        end
        object cbCacheLocation: TComboBox
          Left = 136
          Top = 270
          Width = 169
          Height = 21
          ItemHeight = 13
          TabOrder = 7
        end
        object cbExportLocation: TComboBox
          Left = 136
          Top = 302
          Width = 169
          Height = 21
          ItemHeight = 13
          TabOrder = 8
        end
        object txtResults: TEdit
          Left = 120
          Top = 76
          Width = 33
          Height = 21
          TabOrder = 9
          Text = '10'
        end
        object UpDown2: TUpDown
          Left = 153
          Top = 76
          Width = 16
          Height = 21
          Associate = txtResults
          Position = 10
          TabOrder = 10
        end
        object txtPages: TEdit
          Left = 240
          Top = 76
          Width = 33
          Height = 21
          TabOrder = 11
          Text = '1'
        end
        object UpDown3: TUpDown
          Left = 273
          Top = 76
          Width = 16
          Height = 21
          Associate = txtPages
          Position = 1
          TabOrder = 12
        end
        object CheckBox4: TCheckBox
          Left = 12
          Top = 208
          Width = 173
          Height = 17
          Caption = 'Com&press cache by default'
          TabOrder = 13
        end
        object CheckBox2: TCheckBox
          Left = 196
          Top = 208
          Width = 133
          Height = 17
          Caption = 'Display &tips at startup'
          TabOrder = 14
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'E-mail'
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 339
        Height = 333
        Align = alClient
        Caption = ' E-mail Settings '
        TabOrder = 0
        object Label14: TLabel
          Left = 12
          Top = 24
          Width = 31
          Height = 13
          Caption = 'Server'
        end
        object Bevel5: TBevel
          Left = 72
          Top = 31
          Width = 257
          Height = 2
        end
        object Label17: TLabel
          Left = 12
          Top = 54
          Width = 63
          Height = 13
          Caption = 'Server name:'
        end
        object Label18: TLabel
          Left = 240
          Top = 54
          Width = 22
          Height = 13
          Caption = 'Port:'
        end
        object Label19: TLabel
          Left = 12
          Top = 80
          Width = 54
          Height = 13
          Caption = 'User name:'
        end
        object Label21: TLabel
          Left = 12
          Top = 272
          Width = 36
          Height = 13
          Caption = 'Options'
        end
        object Bevel7: TBevel
          Left = 72
          Top = 279
          Width = 257
          Height = 2
        end
        object Label22: TLabel
          Left = 12
          Top = 152
          Width = 57
          Height = 13
          Caption = 'User Details'
        end
        object Bevel8: TBevel
          Left = 80
          Top = 159
          Width = 249
          Height = 2
        end
        object Label23: TLabel
          Left = 12
          Top = 184
          Width = 51
          Height = 13
          Caption = 'First name:'
        end
        object Label24: TLabel
          Left = 12
          Top = 216
          Width = 52
          Height = 13
          Caption = 'Last name:'
        end
        object Label25: TLabel
          Left = 12
          Top = 248
          Width = 71
          Height = 13
          Caption = 'E-mail address:'
        end
        object Label26: TLabel
          Left = 12
          Top = 112
          Width = 49
          Height = 13
          Caption = 'Password:'
        end
        object txtServerAddr: TEdit
          Left = 96
          Top = 50
          Width = 129
          Height = 21
          TabOrder = 0
        end
        object txtServerPort: TEdit
          Left = 280
          Top = 50
          Width = 49
          Height = 21
          TabOrder = 1
          Text = '25'
        end
        object txtUserName: TEdit
          Left = 96
          Top = 80
          Width = 233
          Height = 21
          TabOrder = 2
        end
        object CheckBox5: TCheckBox
          Left = 12
          Top = 304
          Width = 117
          Height = 17
          Caption = 'Request receipt?'
          TabOrder = 3
        end
        object txtFirstName: TEdit
          Left = 96
          Top = 180
          Width = 233
          Height = 21
          TabOrder = 4
        end
        object txtLastName: TEdit
          Left = 96
          Top = 212
          Width = 233
          Height = 21
          TabOrder = 5
        end
        object txtEmailAddr: TEdit
          Left = 96
          Top = 244
          Width = 233
          Height = 21
          TabOrder = 6
        end
        object Edit1: TEdit
          Left = 96
          Top = 112
          Width = 233
          Height = 21
          PasswordChar = '*'
          TabOrder = 7
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Proxy'
      object Label7: TLabel
        Left = 12
        Top = 88
        Width = 129
        Height = 13
        Caption = 'HTTP Proxy Authentication'
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 339
        Height = 333
        Align = alClient
        Caption = ' Proxy Settings '
        TabOrder = 0
        object Label1: TLabel
          Left = 12
          Top = 80
          Width = 41
          Height = 13
          Caption = 'Address:'
          Enabled = False
        end
        object Label2: TLabel
          Left = 192
          Top = 80
          Width = 22
          Height = 13
          Caption = '&Port:'
          Enabled = False
        end
        object Label3: TLabel
          Left = 12
          Top = 160
          Width = 56
          Height = 13
          Caption = 'User Name:'
          Enabled = False
        end
        object Label4: TLabel
          Left = 184
          Top = 160
          Width = 40
          Height = 13
          Caption = 'Passwd:'
          Enabled = False
        end
        object Label6: TLabel
          Left = 12
          Top = 112
          Width = 129
          Height = 13
          Caption = 'HTTP Proxy Authentication'
        end
        object Bevel1: TBevel
          Left = 148
          Top = 118
          Width = 181
          Height = 2
        end
        object txtHTTPProxy: TEdit
          Left = 80
          Top = 80
          Width = 89
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object txtHTTPPort: TEdit
          Left = 240
          Top = 80
          Width = 73
          Height = 21
          Enabled = False
          TabOrder = 1
        end
        object txtUserID: TEdit
          Left = 80
          Top = 160
          Width = 89
          Height = 21
          Enabled = False
          TabOrder = 2
        end
        object txtUserPasswd: TMaskEdit
          Left = 240
          Top = 160
          Width = 73
          Height = 21
          Enabled = False
          TabOrder = 3
        end
        object cbUseProxy: TCheckBox
          Left = 12
          Top = 56
          Width = 117
          Height = 17
          Caption = '&Use proxy server'
          TabOrder = 4
          OnClick = cbUseProxyClick
        end
        object CheckBox1: TCheckBox
          Left = 12
          Top = 136
          Width = 173
          Height = 17
          Caption = 'Use proxy &authentication'
          TabOrder = 5
          OnClick = CheckBox1Click
        end
        object CheckBox3: TCheckBox
          Left = 12
          Top = 28
          Width = 301
          Height = 17
          Caption = 'Use &default proxy settings of the computer'
          TabOrder = 6
        end
      end
    end
  end
  object cmdHelp: TButton
    Left = 264
    Top = 368
    Width = 77
    Height = 25
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
