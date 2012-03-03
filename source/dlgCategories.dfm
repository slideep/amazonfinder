object Categories: TCategories
  Left = 301
  Top = 198
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Add Result Category '
  ClientHeight = 346
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
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
      Caption = 'Categories'
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 84
        Height = 13
        Caption = 'Categories in use:'
      end
      object Bevel1: TBevel
        Left = 8
        Top = 224
        Width = 289
        Height = 2
      end
      object lvCategories: TListView
        Left = 8
        Top = 40
        Width = 201
        Height = 169
        Checkboxes = True
        Columns = <>
        TabOrder = 0
        ViewStyle = vsList
        OnSelectItem = lvCategoriesSelectItem
      end
      object btnCategories: TButton
        Left = 223
        Top = 40
        Width = 75
        Height = 25
        Caption = '&Categories...'
        TabOrder = 1
        OnClick = btnCategoriesClick
      end
      object cbSelectCategory: TComboBox
        Left = 8
        Top = 240
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'Select category'
        OnSelect = cbSelectCategorySelect
        Items.Strings = (
          'ASIN'
          'Authors'
          'Release Date'
          'Manufacturer'
          'Product Image'
          'List Price'
          'Our Price'
          'Used Price')
      end
      object btnAdd: TButton
        Left = 223
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 3
        OnClick = btnAddClick
      end
    end
  end
  object btnOK: TButton
    Left = 67
    Top = 312
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 147
    Top = 312
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnApply: TButton
    Left = 227
    Top = 312
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 3
    OnClick = btnApplyClick
  end
end
