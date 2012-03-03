object SearchWizard: TSearchWizard
  Left = 288
  Top = 264
  ActiveControl = JvWizardInteriorPage1
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Amazon Product Finder - Power Search Builder'
  ClientHeight = 239
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 449
    Height = 239
    ActivePage = JvWizardInteriorPage1
    ButtonBarHeight = 42
    ButtonStart.NumGlyphs = 1
    ButtonStart.Width = 85
    ButtonLast.NumGlyphs = 1
    ButtonLast.Width = 85
    ButtonBack.NumGlyphs = 1
    ButtonBack.Width = 75
    ButtonNext.NumGlyphs = 1
    ButtonNext.Width = 75
    ButtonFinish.NumGlyphs = 1
    ButtonFinish.Width = 75
    ButtonCancel.NumGlyphs = 1
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.NumGlyphs = 1
    ButtonHelp.Width = 75
    ShowRouteMap = False
    OnStartButtonClick = JvWizard1StartButtonClick
    OnBackButtonClick = JvWizard1BackButtonClick
    OnNextButtonClick = JvWizard1NextButtonClick
    OnFinishButtonClick = JvWizard1FinishButtonClick
    OnCancelButtonClick = JvWizard1CancelButtonClick
    OnHelpButtonClick = JvWizard1HelpButtonClick
    DesignSize = (
      449
      239)
    object JvWizardWelcomePage1: TJvWizardWelcomePage
      Header.Title.Color = clNone
      Header.Title.Text = 'Welcome to Power Search Wizard'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 
        'Power Search Template Wizard will create pre-defined '#13#10'power sea' +
        'rches by your selections and keywords.'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Panel.Visible = False
      VisibleButtons = [bkNext, bkCancel, bkHelp]
    end
    object JvWizardInteriorPage1: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Step 1: Enter the details for your search'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 
        'By entering and selecting the keywords for your search the bette' +
        'r the wizard can create the template.'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Panel.Visible = False
      object JvHTComboBox1: TJvHTComboBox
        Left = 80
        Top = 80
        Width = 145
        Height = 22
        HideSel = False
        DropWidth = 145
        ColorHighlight = clHighlight
        ColorHighlightText = clHighlightText
        ColorDisabledText = clGrayText
        TabOrder = 0
      end
    end
    object JvWizardInteriorPage2: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Panel.Visible = False
      Caption = 'JvWizardInteriorPage2'
    end
  end
end
