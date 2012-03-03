program AmazonFinder;

{$R 'resources\FinderResources.res' 'resources\FinderResources.rc'}

uses
  Forms,
  dlgAbout in 'source\dlgAbout.pas' {AboutBox},
  dlgPreferences in 'source\dlgPreferences.pas' {Preferences},
  frmMain in 'source\frmMain.pas' {MainForm},
  frmSplash in 'source\frmSplash.pas' {SplashScreen},
  uFinderGlobals in 'source\uFinderGlobals.pas',
  uProduct in 'source\uProduct.pas',
  uShoppingCart in 'source\uShoppingCart.pas',
  dlgCategories in 'source\dlgCategories.pas' {Categories},
  uXmlUtils in 'source\uXmlUtils.pas',
  uFinderXmlConfig in 'source\uFinderXmlConfig.pas',
  uFinderXmlHistory in 'source\uFinderXmlHistory.pas',
  uFinderUpdateThread in 'source\uFinderUpdateThread.pas',
  uFinderResources in 'source\uFinderResources.pas',
  dlgConnection in 'source\dlgConnection.pas' {ConnectionDialog},
  dlgAuthentication in 'source\dlgAuthentication.pas' {Form1},
  dlgAlarmEdit in 'source\dlgAlarmEdit.pas' {AlarmEdit},
  dlgAlarmAdd in 'source\dlgAlarmAdd.pas' {AlarmAdd},
  dlgAlarm in 'source\dlgAlarm.pas' {Form2},
  uFinderCacheUtils in 'source\uFinderCacheUtils.pas',
  dlgShoppingCart in 'source\dlgShoppingCart.pas' {frmShoppingCart},
  dlgThumbnails in 'source\dlgThumbnails.pas' {Thumbnails},
  uFinderAlarm in 'source\uFinderAlarm.pas',
  frmImage in 'source\frmImage.pas' {ProductImage},
  omStrUtils in 'components\omStrUtils.pas',
  omSystem in 'components\omSystem.pas',
  omURLs in 'components\omURLs.pas',
  omWindows in 'components\omWindows.pas',
  omFileUtils in 'components\omFileUtils.pas',
  omMathUtils in 'components\omMathUtils.pas',
  uFinderTreeviewUtils in 'source\uFinderTreeviewUtils.pas',
  uFinderEuroConv in 'source\uFinderEuroConv.pas',
  DbugIntf in 'components\DbugIntf.pas',
  SendMail in 'components\SendMail.pas';

{$R *.res}

begin
  Application.Initialize;
  SplashScreen := TSplashScreen.Create(nil);
  SplashScreen.Show;
  SplashScreen.Refresh;
  Application.Title := 'Amazon Product Finder';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TPreferences, Preferences);
  Application.CreateForm(TCategories, Categories);
  Application.CreateForm(TConnectionDialog, ConnectionDialog);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAlarmEdit, AlarmEdit);
  Application.CreateForm(TAlarmAdd, AlarmAdd);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmShoppingCart, frmShoppingCart);
  Application.CreateForm(TThumbnails, Thumbnails);
  Application.CreateForm(TProductImage, ProductImage);
  Application.Run;
end.
