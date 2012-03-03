{

$Id: frmMain.pas,v 1.27 2004/05/10 06:15:17 slide Exp $

Description:

Main form for the Amazon Product Finder.

The initial developer of the original code is slide@users.sourceforge.net.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General public License for more details.

You should have received a copy of the GNU General public
License along with this program; if not, write to the Free
Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA  02111-1307, USA.

}

unit frmMain;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Menus, ActnList, ImgList, ToolWin,
  ExtCtrls, IdBaseComponent, IdComponent, IdHTTP, Mask, IdURI, IdSMTP, jpeg,
  uFinderUpdateThread, uFinderGlobals, uXmlUtils, uFinderXmlHistory,
  IdAntiFreezeBase, IdAntiFreeze, StdActns, AppEvnts, XPMan, uFinderXmlConfig,
  dlgPreferences, dlgAlarmAdd, NLActions, IdTCPConnection, IdTCPClient,
  dlgShoppingCart, dlgThumbnails, dlgConnection, dlgCategories, IdMessage,
  XMLDoc, XMLIntf, LMDOneInstance, LMDCustomControl, uFinderAlarm, frmImage,
  OleCtrls, JvComponent, JvAlarms, JvBaseDlg, XPMenu, LMDCustomComponent,
  SendMail, IdMessageClient, JvDesktopAlert, JvTipOfDay;

type

  {-------------------------------------------------------------------------}
  {- TMainForm -}
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    mnuFile: TMenuItem;
    mnuFileNew: TMenuItem;
    N1: TMenuItem;
    mnuFileSaveAs: TMenuItem;
    mnuFileSave: TMenuItem;
    N2: TMenuItem;
    mnuFilePrint: TMenuItem;
    mnuFileClear: TMenuItem;
    mnuFileOpen: TMenuItem;
    mnuHelp: TMenuItem;
    mnuHelpContents: TMenuItem;
    mnuHelpAbout: TMenuItem;
    StatusBar: TStatusBar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbSearchMode: TComboBox;
    N4: TMenuItem;
    mnuFileExit: TMenuItem;
    cbSearchBy: TComboBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlDetails: TPanel;
    pnlSearchResults: TPanel;
    lvSearchResults: TListView;
    txtListPrice: TEdit;
    txtAmazonPrice: TEdit;
    txtUsedPrice: TEdit;
    GroupBox3: TGroupBox;
    MainToolbar: TToolBar;
    cmdNewSearch: TToolButton;
    cmdOpenSearch: TToolButton;
    cmdSaveSearch: TToolButton;
    ToolButton4: TToolButton;
    cmdRefreshSearch: TToolButton;
    ImageList1: TImageList;
    PopupMenu2: TPopupMenu;
    BrowseProductDetails1: TMenuItem;
    N5: TMenuItem;
    ClearAll1: TMenuItem;
    SaveSearch1: TMenuItem;
    SaveSearchAs2: TMenuItem;
    N6: TMenuItem;
    ToolButton6: TToolButton;
    cmdPrintSearch: TToolButton;
    cmdSearch: TToolButton;
    ToolButton9: TToolButton;
    cmdHelp: TToolButton;
    mnuTools: TMenuItem;
    mnuToolsPrefs: TMenuItem;
    AmazonClient: TIdHTTP;
    PrintDialog1: TPrintDialog;
    IAF: TIdAntiFreeze;
    AEs: TApplicationEvents;
    AddCategory2: TMenuItem;
    Label9: TLabel;
    txtSalesRank: TEdit;
    Label10: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lvSearchs: TListView;
    N7: TMenuItem;
    N9: TMenuItem;
    Print2: TMenuItem;
    Read1: TMenuItem;
    N11: TMenuItem;
    mnuFileUseLocalHistory: TMenuItem;
    N8: TMenuItem;
    N13: TMenuItem;
    CloseAmazonBrowser1: TMenuItem;
    Label11: TLabel;
    txtAvgRating: TEdit;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox4: TGroupBox;
    AcLs: TActionList;
    XPM: TXPManifest;
    CoolBar2: TCoolBar;
    Categories1: TMenuItem;
    Addtocart1: TMenuItem;
    N14: TMenuItem;
    mnuFileExport: TMenuItem;
    OpenSearch2: TMenuItem;
    Panel1: TPanel;
    cbPowerSearch: TComboBox;
    CheckBox1: TCheckBox;
    SelectAll1: TMenuItem;
    ProgressBar: TProgressBar;
    mnuView: TMenuItem;
    mnuViewBarsTools: TMenuItem;
    Progressbar1: TMenuItem;
    txtSummary: TMemo;
    ApplicationAbout1: TApplicationAbout;
    ApplicationExit1: TApplicationExit;
    ActionSearchExecute: TAction;
    PopupMenu3: TPopupMenu;
    Updatesearch1: TMenuItem;
    Removesearch1: TMenuItem;
    N10: TMenuItem;
    UpdateAll1: TMenuItem;
    N15: TMenuItem;
    RemoveAll1: TMenuItem;
    imgProduct: TImage;
    mnuViewBarsStatus: TMenuItem;
    mnuViewBarsProgress: TMenuItem;
    mnuViewPanels: TMenuItem;
    mnuViewPanelsPrice: TMenuItem;
    mnuViewPanelsDetails: TMenuItem;
    mnuViewPanelsSearch: TMenuItem;
    pnlSearchStats: TPanel;
    NaviToolbar: TToolBar;
    cmdPrevPage: TToolButton;
    cmdNextPage: TToolButton;
    ToolButton16: TToolButton;
    ToolButton11: TToolButton;
    Label16: TLabel;
    lblTotalPages: TLabel;
    Label17: TLabel;
    lblTotalResults: TLabel;
    Bevel2: TBevel;
    lblSearchText: TLabel;
    Shape1: TShape;
    mnuViewFolders: TMenuItem;
    N16: TMenuItem;
    mnuViewThumbs: TMenuItem;
    UpdateTimer: TTimer;
    lblSearchPage: TLabel;
    imgNoImage: TImage;
    Panel2: TPanel;
    cmdShop: TBitBtn;
    SendResultsAsEmail1: TMenuItem;
    AllSearchResults1: TMenuItem;
    Selected1: TMenuItem;
    Label18: TLabel;
    txtThirdPartyPrice: TEdit;
    SearchTimer: TTimer;
    mnuViewTabs: TMenuItem;
    mnuViewTabsResults: TMenuItem;
    mnuViewTabsHistory: TMenuItem;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    mnuFileExportAsTxt: TMenuItem;
    mnuFileExportHtml: TMenuItem;
    N19: TMenuItem;
    UseDefaultExportFormat1: TMenuItem;
    mnuFileNewSearch: TMenuItem;
    mnuFileNewPowerSearch: TMenuItem;
    Panel3: TPanel;
    Label15: TLabel;
    mnuViewCart: TMenuItem;
    AddPriceUpdateAlarm1: TMenuItem;
    Alarms1: TMenuItem;
    PopupMenu4: TPopupMenu;
    PopupMenu5: TPopupMenu;
    N21: TMenuItem;
    BackupSearchesAsZipFile1: TMenuItem;
    N22: TMenuItem;
    Panel4: TPanel;
    Panel5: TPanel;
    tvSearchFolders: TTreeView;
    ImageList2: TImageList;
    Splitter3: TSplitter;
    Panel6: TPanel;
    btnSearch: TBitBtn;
    cbSortBy: TComboBox;
    NewSearch1: TMenuItem;
    NewPowerSearch1: TMenuItem;
    PopupMenu6: TPopupMenu;
    UpdateSearchFolders1: TMenuItem;
    RemoveSelected1: TMenuItem;
    N17: TMenuItem;
    N23: TMenuItem;
    Hide1: TMenuItem;
    ShoppingCart2: TMenuItem;
    TabSheet5: TTabSheet;
    lvTracks: TListView;
    Panel7: TPanel;
    Panel8: TPanel;
    LMDOneInstance1: TLMDOneInstance;
    mnuEdit: TMenuItem;
    mnuEditCut: TMenuItem;
    mnuEditCopy: TMenuItem;
    mnuEditPaste: TMenuItem;
    mnuEditSelectAll: TMenuItem;
    mnuViewTabsTracks: TMenuItem;
    N24: TMenuItem;
    AddCheckedtoShoppingCart1: TMenuItem;
    Panel9: TPanel;
    mnuEditUndo: TMenuItem;
    N12: TMenuItem;
    N18: TMenuItem;
    N25: TMenuItem;
    mnuEditCopyTo: TMenuItem;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    Label5: TLabel;
    txtAuthor: TEdit;
    Label6: TLabel;
    txtName: TEdit;
    Label20: TLabel;
    txtBrowseNode: TEdit;
    Label7: TLabel;
    txtManufactured: TEdit;
    Label8: TLabel;
    txtReleased: TEdit;
    Label21: TLabel;
    txtTheaterRelease: TEdit;
    Label12: TLabel;
    txtISBN: TEdit;
    Label22: TLabel;
    txtDirector: TEdit;
    Label23: TLabel;
    txtMediaType: TEdit;
    mnuFileRecent: TMenuItem;
    txtSearchText: TComboBox;
    ProductAlarms: TJvAlarms;
    XPMenu1: TXPMenu;
    AddSearchFolder1: TMenuItem;
    mnuHelpCheckUpdate: TMenuItem;
    mnuHelpTipOfDay: TMenuItem;
    N3: TMenuItem;
    mnuHelpContextHelp: TMenuItem;
    Label13: TLabel;
    lblRating: TLabel;
    Label14: TLabel;
    lblSummary: TLabel;
    TabSheet7: TTabSheet;
    lvSimilarResults: TListView;
    SMTP: TIdSMTP;
    Email: TIdMessage;
    Panel10: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    JvDesktopAlertStack1: TJvDesktopAlertStack;
    JvDesktopAlert1: TJvDesktopAlert;
    JvTipOfDay1: TJvTipOfDay;
    procedure mnuFileExitClick(Sender: TObject);
    procedure mnuHelpAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseAmazonBrowser1Click(Sender: TObject);
    procedure txtSearchTextKeyPress(Sender: TObject; var Key: char);
    procedure lvSearchResultsSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure btnSearchClick(Sender: TObject);
    procedure AmazonClientWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: integer);
    procedure AmazonClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: integer);
    procedure AmazonClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure mnuFileOpenClick(Sender: TObject);
    procedure mnuFileSaveClick(Sender: TObject);
    procedure DumpException(Sender: TObject; E: Exception);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure mnuToolsPrefsClick(Sender: TObject);
    procedure cbSearchModeSelect(Sender: TObject);
    procedure cbSearchBySelect(Sender: TObject);
    procedure cmdRefreshSearchClick(Sender: TObject);
    procedure ClearAll1Click(Sender: TObject);
    procedure cmdPrintSearchClick(Sender: TObject);
    procedure mnuFilePrintClick(Sender: TObject);
    procedure mnuFileClearClick(Sender: TObject);
    procedure mnuFileSaveAsClick(Sender: TObject);
    procedure mnuFileUseLocalHistoryClick(Sender: TObject);
    procedure BrowseProductDetails1Click(Sender: TObject);
    procedure Read1Click(Sender: TObject);
    procedure mnuViewBarsToolsClick(Sender: TObject);
    procedure mnuViewPanelsDetailsClick(Sender: TObject);
    procedure Progressbar1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure lvSearchResultsColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure AddCategory2Click(Sender: TObject);
    procedure cmdNextPageClick(Sender: TObject);
    procedure cmdPrevPageClick(Sender: TObject);
    procedure Addtocart1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure SaveSearchAs2Click(Sender: TObject);
    procedure Print2Click(Sender: TObject);
    procedure mnuViewPanelsPriceClick(Sender: TObject);
    procedure SearchTimerTimer(Sender: TObject);
    procedure mnuFileNewSearchClick(Sender: TObject);
    procedure mnuFileExportAsTxtClick(Sender: TObject);
    procedure mnuFileExportHtmlClick(Sender: TObject);
    procedure mnuViewThumbsClick(Sender: TObject);
    procedure AddPriceUpdateAlarm1Click(Sender: TObject);
    procedure mnuViewPanelsSearchClick(Sender: TObject);
    procedure AllSearchResults1Click(Sender: TObject);
    procedure mnuViewCartClick(Sender: TObject);
    procedure mnuViewFoldersClick(Sender: TObject);
    procedure tvSearchFoldersContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure tvSearchFoldersChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tvSearchFoldersChange(Sender: TObject; Node: TTreeNode);
    procedure tvSearchFoldersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbSearchModeChange(Sender: TObject);
    procedure cbSearchByChange(Sender: TObject);
    procedure txtSearchTextChange(Sender: TObject);
    procedure lvSearchResultsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure tvSearchFoldersDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure tvSearchFoldersDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lvSearchResultsEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure lvSearchResultsDblClick(Sender: TObject);
    procedure imgProductClick(Sender: TObject);
    procedure menuRecentClick(Sender: TObject);
    procedure cmdNextReviewClick(Sender: TObject);
    procedure cmdPreviousReviewClick(Sender: TObject);
    procedure ProductAlarmsAlarm(Sender: TObject;
      const Alarm: TJvAlarmItem; const TriggerTime: TDateTime);
    procedure AddSearchFolder1Click(Sender: TObject);
    procedure lvSimilarResultsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Selected1Click(Sender: TObject);
    procedure Hide1Click(Sender: TObject);
    procedure RemoveSelected1Click(Sender: TObject);
    procedure UpdateSearchFolders1Click(Sender: TObject);
    procedure mnuHelpTipOfDayClick(Sender: TObject);
  private
    { Private declarations }
    FDebug,
    FModified,
    FSearchFinished,
    FFirstTimer,
    FListMode,
    FLocalSearches: boolean;
    FLevel,
    FCurrentPage,
    FTotalResults,
    FTotalPages,
    FSearchCatalog: integer;
    FPath,
    FAmazonURL,
    FFileName,
    FSearchDateTime: string;
    FXMLDocument: IXMLDocument;
    FParentNode: IXMLNode;    
    FSearchParams: TAmazonURL;
    FSearchType: TSearchType;
    FConfig: TuFinderXmlConfig;
    FHistory: TuFinderXmlHistory;
    FAlarm: TuFinderAlarm;
    FUpdateThread: TuFinderUpdateThread;
    FPreviousItem,
    FSelectedItem: TListItem;
    FUpdateAll: TObject;
    FRecentSearches,
    FQueries,
    FAutoComplete,
    FHistoryList: TStringList;
    FLoadingCursor: TCursor;
    FAlarmTriggered: TNotifyEvent;
    procedure NavigateNextPage;
    procedure NavigatePreviousPage;
    procedure CheckModifiedSearch;
    procedure StartNewSearch;
    procedure FetchAllPages;
    procedure ClearImage;
    procedure EnableMenuItems;
    procedure RecentSearchesUpdate;
    procedure AddRecentSearch(const AValue: string);
    procedure DropFiles(var Msg: TWMDROPFILES); message WM_DROPFILES;
    procedure SetFirstTime(AValue: boolean);
    procedure SetCaption(AValue: string);
    procedure SetDebug(AValue: boolean);
    procedure SetModified(AValue: boolean);
    procedure SetSearchStatus(AValue: boolean);
    procedure SetAmazonSearchArgs(ASearchText: string; APage: integer);
    procedure SetOnAlarmTriggered(const AValue: TNotifyEvent);
    procedure SetSearchType(ASearchType: TSearchType);
    function GetSearchType: TSearchType;
    procedure SetPageNumber(AValue: integer);
    function GetPageNumber: integer;
    procedure InitSearchResults;
    procedure InitNodes(AXMLDocument: IXMLDocument);
    procedure InitTrackNodes(AItem: TListItem);
    procedure LoadImageFromURL(AItem: TListItem; AValue: string);
    procedure LoadProductDetails(AItem: TListItem);
    procedure LoadProductReviews(AItem: TListItem);
    procedure LoadSettings(AConfig: TuFinderXmlConfig);
    procedure UpdateStatusbar(AValue: string; APanel: integer);
  public
    { public declarations }
    procedure DisplayHint(Sender: TObject);
    procedure InitSearchNodes(const AKeywords, AMode, AUpdated, APages,
      AResults,
      ACategory: WideString);
    property Debug: boolean read FDebug write SetDebug default false;
    property Modified: boolean read FModified write SetModified;
    property SearchDone: boolean read FSearchFinished write FSearchFinished;
    property FirstTime: boolean read FFirstTimer write SetFirstTime;
    property Config: TuFinderXmlConfig read FConfig write FConfig;
    property Searches: TListView read lvSearchs;
    property ListMode: boolean read FListMode write FListMode;
    property LoadingCursor: TCursor read FLoadingCursor write FLoadingCursor;
    property LocalSearch: boolean read FLocalSearches write FLocalSearches;
    property PageNumber: integer read GetPageNumber write SetPageNumber;
    property TotalResults: integer read FTotalResults write FTotalResults;
    property TotalPages: integer read FTotalPages write FTotalPages;
    property Level: integer read FLevel write FLevel;
    property History: TStringList read FHistoryList write FHistoryList;
    property Queries: TStringList read FQueries write FQueries;
    property RecentSearches: TStringList read FRecentSearches write
      FRecentSearches;
    property AutoComplete: TStringList read FAutoComplete write FAutoComplete;
    property AmazonUrl: string read FAmazonURL write FAmazonURL;
    property PreviousItem: TListItem read FPreviousItem write FPreviousItem;
    property SelectedItem: TListItem read FSelectedItem write FSelectedItem;
    property AppPath: string read FPath write FPath;
    property FileName: string read FFileName write FFileName;
    property SearchTime: string read FSearchDateTime write FSearchDateTime;
    property SearchCatalog: integer read FSearchCatalog write FSearchCatalog;
    property SearchParams: TAmazonURL read FSearchParams write FSearchParams;
    property SearchType: TSearchType read FSearchType write FSearchType;
    property ResultDoc: IXMLDocument read FXMLDocument write FXMLDocument;
    property RootNode: IXMLNode read FParentNode write FParentNode;
    property UpdateThread: TuFinderUpdateThread read FUpdateThread write
      FUpdateThread;
    property UpdateAll: TObject read FUpdateAll write FUpdateAll;
    property Alarm: TuFinderAlarm read FAlarm write FAlarm;
    property OnAlarmTriggered: TNotifyEvent read FAlarmTriggered write
      SetOnAlarmTriggered;
  end;

var

  MainForm: TMainForm;
  Preferences: TPreferences;
  Categories: TCategories;
  Connection: TConnectionDialog;
  AlarmDialog: TAlarmAdd;
  ShoppingCart: TfrmShoppingCart; // DONE: rename
  Thumbnails: TThumbnails;
  ProductImage: TProductImage; // DONE: rename

implementation

uses

  dlgAbout, ShellAPI, frmSplash, uFinderResources, ComObj, uFinderCacheUtils,
  StrUtils, omStrUtils, uFinderTreeviewUtils;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- MainForm -}

{-----------------------------------------------------------------------------}
{**
 Sets the program's caption.
 @param AValue The value for the caption.
}

procedure TMainForm.SetCaption(AValue: string);
begin
  if AValue = '' then
    exit
  else
    Caption := AValue;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the first timer flag for the modified or unmodified status.
  @param AValue True / False for indicating first timer status.
}

procedure TMainForm.SetFirstTime(AValue: boolean);
begin
  FFirstTimer := AValue;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the debug flag.
  @param AValue True / False for indicating debug status.
}

procedure TMainForm.SetDebug(AValue: boolean);
begin
  FDebug := AValue;
  UpdateStatusbar(SStatusDebug, InfoPanel);
end;

{-----------------------------------------------------------------------------}
{**
  Sets the search flag for the modified or unmodified status.
  @param AValue True / False for indicating modified search status.
}

procedure TMainForm.SetModified(AValue: boolean);
begin
  FModified := AValue;
  UpdateStatusbar(SStatusModified, InfoPanel);
end;

{-----------------------------------------------------------------------------}
{**
  Returns the current search page number.
  @return The current search page number.
}

function TMainForm.GetPageNumber: integer;
begin
  result := FCurrentPage;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the current search page number.
  @param AValue The current search page number.
}

procedure TMainForm.SetPageNumber(AValue: integer);
begin
  if AValue > 1 then
    FCurrentPage := AValue;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the search type for the query.
  @param ASearchType The search type.
}

procedure TMainForm.SetSearchType(ASearchType: TSearchType);
begin
  FSearchType := ASearchType;
end;

{-----------------------------------------------------------------------------}
{**
  Gets the given search type.
  @return The search type.
}

function TMainForm.GetSearchType: TSearchType;
begin
  result := FSearchType;
end;

{-----------------------------------------------------------------------------}
{**
  Starts a new search and sets the current search page number to correct one.
}

procedure TMainForm.StartNewSearch;
begin
  if PageNumber > 1 then
    PageNumber := 1;
end;

{-----------------------------------------------------------------------------}
{**
  Initializes the history, config and creates necessary cache directories if
  not already made. Presets properties for the program and inits Alarm.
  @param Sender The sender object.
}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppPath := ExtractFilePath(Application.ExeName);
  Config := TuFinderXmlConfig.Create(AppPath + DefaultConfig);
  LoadSettings(Config);
  History := TStringList.Create;
  RecentSearches := TStringList.Create;
  Queries := TStringList.Create;
  AutoComplete := TStringList.Create;
  FHistory := TuFinderXmlHistory.Create(AppPath + DefaultHistory);
  if not Assigned(Alarm) then
    Alarm := TuFinderAlarm.Create(Self);
  if not Assigned(UpdateThread) then
    UpdateThread := TuFinderUpdateThread.Create(MainForm);
  if not DirExists(AppPath + CacheDir) then
  begin
    MakePath(AppPath + CacheDir);
    MakePath(AppPath + ImageDir);
  end;
  if not DirExists(AppPath + DefaultCategories) then
    MakePath(AppPath + DefaultCategories);
  Application.OnHint := DisplayHint;
  Debug := true;
  AmazonURL := '';
  FileName := '';
  Level := 1;
  FCurrentPage := 1;
  TotalResults := -1;
  ListMode := false;
  SearchDone := false;
  DragAcceptFiles(MainForm.Handle, true);
  FXMLDocument := TXMLDocument.Create(nil);
  FXMLDocument.Active := false;
  Caption := SProgramReady;
  UpdateStatusbar(SStatusReady, MessagePanel);
  UpdateTimer.Interval := 5000;
  SearchTimer.Interval := RequestDelay;
  SearchTimer.Enabled := false;
  Alarm.OnAlarm := OnAlarmTriggered;
  FreeAndNil(SplashScreen);
end;

{-----------------------------------------------------------------------------}
{**
  Checks whether user has made a search and it hasn't been saved to the cache.
  If it's not then save the search depending on the user response.
}

procedure TMainForm.CheckModifiedSearch;
begin
  if (Modified) or (FileName = '') then
  begin
    case MessageDlg(SSearchNotSaved,
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: SaveSearch1.Click;
      mrCancel: Abort;
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Loads the configuration settings that are initialized during the program
  startup. Tries to load the given DefaultConfig file. If configuration has
  proxy parameters defined then they are set. Whether this is the first
  time when program is used then show up the preferences dialog for the user.
  @param AConfig The initialized configuration class
  @return No return
}

procedure TMainForm.LoadSettings(AConfig: TuFinderXmlConfig);
begin
  if not Assigned(AConfig) then
    exit;
  if AConfig.UseProxy then
  begin
    AmazonClient.ProxyParams.ProxyServer := AConfig.ProxyHost;
    AmazonClient.ProxyParams.ProxyPort := AConfig.ProxyPort;
    AmazonClient.ProxyParams.ProxyUsername := AConfig.ProxyUser;
    AmazonClient.ProxyParams.ProxyPassword := AConfig.ProxyPassword;
  end;
  if AConfig.FirstTime then
  begin
    Preferences.ShowModal;
    Preferences.BringToFront;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Exits from the program.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileExitClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**
  Shows user the about box.
  @param Sender The sender object.
}

procedure TMainForm.mnuHelpAboutClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

{-----------------------------------------------------------------------------}
{**
  Displays the hint on statusbar or cleans up the hint.
  @param Sender The sender object.
}

procedure TMainForm.DisplayHint(Sender: TObject);
begin
  if Application.Hint <> '' then
    StatusBar.Panels[0].Text := Application.Hint
  else
    StatusBar.Panels[0].Text := '';
end;

{-----------------------------------------------------------------------------}
{**
  Calls the exit procedure and closes program.
  @param Sender The sender object.
}

procedure TMainForm.CloseAmazonBrowser1Click(Sender: TObject);
begin
  mnuFileExitClick(Self);
end;

{-----------------------------------------------------------------------------}
{**
  When user has typed the search query then pressing Enter activates the
  search.
  @param Sender The sender object.
  @param Key The Enter key will be read from the input.
}

procedure TMainForm.txtSearchTextKeyPress(Sender: TObject; var Key: char);
begin
  if Key = CR then
  begin
    FSearchParams.SearchText := txtSearchText.Text;
    btnSearch.Click; // TODO: rename btnSearch -> cmdSearch
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the search status panel visible status non-visible and shows the details
  panel. If item has been selected then try to load the responding product
  image, also if search type was heavy, load product reviews.
  @param Sender The sender object.
  @param Item The selected product item on the listview.
  @param Selected The selected status of the product item.
}

procedure TMainForm.lvSearchResultsSelectItem(Sender: TObject;
  Item: TListItem; Selected: boolean);
begin
  pnlSearchStats.Visible := false;
  pnlDetails.Visible := true;
  LoadProductDetails(Item);
  LoadImageFromURL(Item, SImageMedium);
  if Config.SearchType = SSearchTypeHeavy then
    LoadProductReviews(Item);
  if cbSearchMode.Text = SMusic then
  begin
    TabSheet5.TabVisible := true;
    InitTrackNodes(Item);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Goes to next page in search history; only increases the page number. No
  checking here yet.
}

procedure TMainForm.NavigateNextPage;
begin
  if PageNumber = 1 then
    PageNumber := PageNumber + 1;
end;

{-----------------------------------------------------------------------------}
{**
  Goes to previous page in search history; only decreases the page number. No
  checking here yet.
}

procedure TMainForm.NavigatePreviousPage;
begin
  if PageNumber = 1 then
    exit
  else
    PageNumber := PageNumber - 1;
end;

{-----------------------------------------------------------------------------}
{**
  Enables the menuitems that aren't visible if no search has been made.
}

procedure TMainForm.EnableMenuItems;
begin
  if (Modified) and (SearchDone) then
  begin
    mnuFileClear.Enabled := true;
    mnuFileSave.Enabled := true;
    mnuFileSaveAs.Enabled := true;
    mnuFileExport.Enabled := true;
    mnuFilePrint.Enabled := true;
    SaveSearch1.Enabled := true;
    SaveSearchAs2.Enabled := true;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Starts the search process and sets the search parameters that the user has
  provided by  selecting the corresponding combo boxes. Fetches content from
  the constructed URL, saves searches to both active search, and cache history.
  Finally, initializes the result views.
  @param Sender The sender object.
}

procedure TMainForm.btnSearchClick(Sender: TObject);
var
  SearchUrls,
    Results: TStringList;
  Content,
    SearchFile: string;
begin
  if not Modified then
    exit;
  SetAmazonSearchArgs(txtSearchText.Text, PageNumber);
  Queries.Add(txtSearchText.Text);
  try
    if not ProgressBar.Visible then
      ProgressBar.Visible := true;
    Results := TStringList.Create;
    SearchUrls := TStringList.Create;
    LoadingCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      Content := AmazonClient.Get(AmazonUrl);
      FSearchDateTime := DateTimeToStr(Date);
      SearchUrls.Add(AmazonUrl);
      Results.Text := Content;
      Results.SaveToFile(AppPath + DefaultSearchFile);
      SearchFile := 'SH-' + IntToStr(PageNumber) + '-'
        + IntToStr(cbSearchMode.ItemIndex) + '-'
        + IntToStr(cbSearchBy.ItemIndex) + '-'
        + IntToStr(DateTimeToFileDate(Now))
        + XMLFileExt;
      case cbSearchMode.ItemIndex of
        0:
          begin
            Results.SaveToFile(AppPath + BooksCacheDir + '\' + SearchFile);
          end;
        1:
          begin
            Results.SaveToFile(AppPath + DvdCacheDir + '\' + SearchFile);
          end;
        2:
          begin
            Results.SaveToFile(AppPath + MagsCacheDir + '\' + SearchFile);
          end;
        3:
          begin
            Results.SaveToFile(AppPath + MusicCacheDir + '\' + SearchFile);
          end;
        4:
          begin
            Results.SaveToFile(AppPath + GamesCacheDir + '\' + SearchFile);
          end;
      end;
      AddSearchToHistory(SearchFile, History);
{$IFDEF DEBUG}
      SearchUrls.SaveToFile(ExtractFilePath(Application.ExeName) +
        DefaultSearchFile);
{$ENDIF}
      InitSearchResults;
    finally
      Screen.Cursor := LoadingCursor;
    end;
  finally
    Content := '';
    FFileName := '';
    SearchFile := '';
    SearchUrls.Free;
    Results.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Fetches all the pages from constructed search URL with given search
  parameters. Should check the total page count; if there's too many then
  don't bother to download them all. Somekind of the "data mining" mechanism
  would be better to further refine the search.
}

procedure TMainForm.FetchAllPages;
var
  i: integer;
  Results: TStringList;
  Content: string;
begin
  if PageNumber = TotalPages then
  begin
    SearchTimer.Enabled := false;
    exit;
  end;
  LoadingCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Results := TStringList.Create;
    NavigateNextPage;
    SetAmazonSearchArgs(txtSearchText.Text, PageNumber);
    for i := 0 to TotalPages - 1 do
    begin
      Content := AmazonClient.Get(AmazonUrl);
      Results.Text := Content;
      Results.SaveToFile(AppPath + SCacheSearch + LowerCase(txtSearchText.Text)
        + SPage + '_' + IntToStr(i) + SXml);
    end;
  finally
    Content := '';
    Results.Free;
    Screen.Cursor := LoadingCursor;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Initializes the freshly created search and tries to set/call all the init
  routines that populate the user interface.
}

procedure TMainForm.InitSearchResults;
begin
  try
    ResultDoc.LoadFromFile(AppPath + SSearchXml);
    if Assigned(ResultDoc) then
    begin
      if GetErrMsg(ResultDoc.DocumentElement, SErrorMsg) then
      begin
        ShowErrorMessage(SSearchResultNone);
        SetSearchStatus(false);
        exit;
      end
      else
      begin
        InitNodes(ResultDoc);
        InitSearchNodes(txtSearchText.Text, cbSearchBy.Text, FSearchDateTime,
          GetTotalPages(ResultDoc.DocumentElement),
          GetTotalResults(ResultDoc.DocumentElement),
          SearchParams.SearchMode);
        lblTotalResults.Caption :=
          GetTotalResults(ResultDoc.DocumentElement);
        lblTotalPages.Caption := GetTotalPages(ResultDoc.DocumentElement);
        lblSearchText.Caption := SSearchFor + txtSearchText.Text +
          SProduced;
        lblSearchPage.Caption := SPage1 + IntToStr(PageNumber);
        TotalPages := StrToInt(GetTotalPages(ResultDoc.DocumentElement));
        SetSearchStatus(true);
        SetModified(true);
        EnableMenuItems;
        TabSheet2.TabVisible := true;
        FHistory.UpdateHistory;
        FHistory.Updated := true;
        pnlSearchStats.Visible := true;
      end;
    end;
  except
    on E: Exception do
    begin
      UpdateStatusbar(SSearchParseFailed, MessagePanel);
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Initializes the search history listview with created search parameters and
  results.
  @param AKeywords The search query
  @param AMode The search mode
  @param AUpdated The date when search was made
  @param APages The count of search result pages
  @param AResults The count of search results
  @param ACategory The search category
}

procedure TMainForm.InitSearchNodes(const AKeywords, AMode, AUpdated, APages,
  AResults, ACategory: WideString);
begin
  with Searches.Items.Add do
  begin
    Caption := AKeywords;
    SubItems.Add(AMode);
    SubItems.Add(AUpdated);
    SubItems.Add(APages);
    SubItems.Add(AResults);
    SubItems.Add(ACategory);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Initializes the tracklist for given product; whether it was a search
  belonging to the Music category.
  @param AItem The selected product.
}

procedure TMainForm.InitTrackNodes(AItem: TListItem);
var
  i: integer;
begin
  if not Assigned(AItem) then
    exit;
  try
    lvTracks.Items.Clear;
    lvTracks.Items.BeginUpdate;
    for i := 0 to RootNode.ChildNodes.Count - 1 do
    begin
      RootNode := ResultDoc.DocumentElement.ChildNodes[AItem.Index + 3];
      if RootNode.NodeName = SDetails then
      begin
        with lvTracks.Items.Add do
        begin
          Caption := IntToStr(i);
          SubItems.Add(RootNode.ChildNodes[SArtists].ChildNodes[SArtist].Text);
          SubItems.Add(RootNode.ChildNodes[SProductName].Text);
          SubItems.Add(RootNode.ChildNodes[STracks].ChildNodes[STrack].Text);
        end;
      end;
    end;
    lvTracks.Items.EndUpdate;
  except
    on E: Exception do
    begin
      UpdateStatusbar(SSearchParseFailed, MessagePanel);
      DumpException(Self, E);
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Initializes the search results listview items.
  @param AXMLDocument The local search file.
}

procedure TMainForm.InitNodes(AXMLDocument: IXMLDocument);
var
  i: integer;
  Node: IXMLNode;
begin
  if not Assigned(AXMLDocument) then
    exit;
  try
    Node := AXMLDocument.DocumentElement;
    lvSearchResults.Items.BeginUpdate;
    for i := 0 to Node.ChildNodes.Count - 1 do
    begin
      Node := AXMLDocument.DocumentElement.ChildNodes[i];
      if Node.NodeName = SDetails then
      begin
        with lvSearchResults.Items.Add do
        begin
          Caption := Node.ChildNodes[SProductName].Text;
          SubItems.Add(Node.ChildNodes[SCatalog].Text);
          SubItems.Add(Node.ChildNodes[SOurPrice].Text);
          SubItems.Add(Node.ChildNodes[SAvailability].Text);
          SubItems.Add(Node.ChildNodes[SSalesRank].Text);
        end;
      end;
    end;
    lvSearchResults.Items.EndUpdate;
  except
    on E: Exception do
    begin
      UpdateStatusbar(SSearchParseFailed, MessagePanel);
      DumpException(Self, E);
    end;
  end;
end;
{-----------------------------------------------------------------------------}
{**
  Updates the statusbar value and to the given panel.
  @param AValue The status message.
  @param APanel The panel where to show up the message.
}

procedure TMainForm.UpdateStatusbar(AValue: string; APanel: integer);
begin
  if AValue = '' then
    StatusBar.Panels[0].Text := ''
  else
    case APanel of
      0:
        StatusBar.Panels[0].Text := AValue;
      1:
        StatusBar.Panels[1].Text := AValue;
      2:
        StatusBar.Panels[2].Text := AValue;
      3:
        StatusBar.Panels[3].Text := AValue;
    end;
end;

{-----------------------------------------------------------------------------}
{**
  Updates the progressbar while fetching content from the URL.
  @param Sender The sender object.
  @param AWorkMode
  @param AWorkCount
}

procedure TMainForm.AmazonClientWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: integer);
var
  Position,
    Max: integer;
begin
  Max := TIdHTTP(Sender).Response.ContentLength;
  Position := AWorkCount;
  if Max <= 0 then
    Max := Position * 2;
  ProgressBar.Position := AWorkCount;
  UpdateStatusBar(SRetrieving + IntToStr(Max) + SKilobytes, 0);
  Application.ProcessMessages;
end;

{-----------------------------------------------------------------------------}
{**
  Initializes the progressbar to indicate updating/search progress.
  @param Sender The sender object.
  @param AWorkMode
  @param AWorkCountMax
}

procedure TMainForm.AmazonClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: integer);
begin
  ProgressBar.Max := AWorkCountMax;
  ProgressBar.Position := 0;
  Application.ProcessMessages;
end;

{-----------------------------------------------------------------------------}
{**
  Updates the statusbar for search/update success.
  @param Sender The sender object.
  @param AWorkMode
}

procedure TMainForm.AmazonClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  UpdateStatusbar(SSearchFinished, SearchPanel);
end;

{-----------------------------------------------------------------------------}
{**
 
  @param ASearchText
  @param APage
}

procedure TMainForm.SetAmazonSearchArgs(ASearchText: string; APage: integer);
begin
  if ASearchText = '' then
    exit;
  case cbSearchBy.ItemIndex of
    0: // author
      AmazonUrl := Format(SAuthorSearch, [URLEncode(ASearchText),
        LowerCase(Config.SearchType), APage]);
    1: // artist
      AmazonUrl := Format(SArtistSearch, [URLEncode(ASearchText),
        LowerCase(Config.SearchType), APage]);
    2: // keyword
      AmazonUrl := Format(SKeywordSearch, [URLEncode(ASearchText),
        LowerCase(cbSearchMode.Text), APage]);
    3: // power
      AmazonUrl := Format(SPowerSearch, [URLEncode(ASearchText),
        cbSearchMode.Text, LowerCase(Config.SearchType), APage]);
    4: // asin
      AmazonUrl := Format(SAsinSearch, [URLEncode(ASearchText),
        LowerCase(cbSearchMode.Text)]);        
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Loads the selected product's image to the preview picture. If there's no
  product image associated then fall back and show NoProductImage -picture.
  @param AItem The selected product in listview.
}

procedure TMainForm.LoadImageFromURL(AItem: TListItem; AValue: string);
var
  ResponseStream: TStringStream;
  FileName: TIdURI;
  StreamImage: TJPEGImage;
begin
  if Assigned(AItem) then
    RootNode := ResultDoc.DocumentElement.ChildNodes[AItem.Index + 3]
  else
    exit;
  ResponseStream := TStringStream.Create('');
  StreamImage := TJPEGImage.Create;
  StreamImage.ProgressiveDisplay := false;
  try
    try
      if AValue = SImageMedium then
        FileName := TIdURI.Create(GetChild(RootNode, SImageUrlMedium).text)
      else if AValue = SImageHeavy then
        FileName := TIdURI.Create(GetChild(RootNode, SImageUrlLarge).text);
      if FileExists(AppPath + ImageDir + FileName.Document) then
        imgProduct.Picture.LoadFromFile(AppPath + ImageDir + FileName.Document)
      else
      begin
        LoadingCursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        try
          AmazonClient.Get(GetChild(RootNode, SImageUrlMedium).text,
            ResponseStream);
          ResponseStream.Seek(0, soFromBeginning);
          if CompareStr(AmazonClient.Response.ContentType, SImageGif) = 0 then
          begin
            imgNoImage.Visible := true;
            UpdateStatusbar(SNoImageAssociated, MessagePanel);
            exit;
          end
          else
          begin
            StreamImage.LoadFromStream(ResponseStream);
            imgProduct.Picture.Assign(StreamImage);
            imgNoImage.Visible := false;
            imgProduct.Picture.SaveToFile(AppPath + ImageDir +
              FileName.Document);
          end;
        finally
          Screen.Cursor := LoadingCursor;
        end;
      end;
    finally
      FileName.Free;
      ResponseStream.Free;
      StreamImage.Free;
    end;
  except
    on e: Exception do
    begin
      UpdateStatusbar(SNoImageAssociated, MessagePanel);
      DumpException(Self, e);
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Loads selected product's user reviews to review panel.
  @param AItem The selected product in listview.
}

procedure TMainForm.LoadProductReviews(AItem: TListItem);
begin
  if Assigned(AItem) then
  begin
    RootNode := ResultDoc.DocumentElement.ChildNodes[AItem.Index + 3];
    lblRating.Caption :=
      RootNode.ChildNodes[SReviews].ChildNodes[SCustomerReview].ChildNodes[SRating].Text;
    lblSummary.Caption :=
      RootNode.ChildNodes[SReviews].ChildNodes[SCustomerReview].ChildNodes[SSummary].Text;
    txtSummary.Text :=
      RootNode.ChildNodes[SReviews].ChildNodes[SCustomerReview].ChildNodes[SComment].Text;
  end
  else
    exit;
end;

{-----------------------------------------------------------------------------}
{**
  Loads selected product's details to the details panel.
  @param AItem The selected product in the listiview.
}

procedure TMainForm.LoadProductDetails(AItem: TListItem);
  function ParseCaption(AValue: string): string;
  begin
    Result := AnsiReplaceStr(AValue, '&', '&&');
  end;
begin
  if Assigned(AItem) then
  begin
    RootNode := ResultDoc.DocumentElement.ChildNodes[AItem.Index + 3];

      if Length(RootNode.ChildNodes[SArtists].ChildNodes[SArtist].Text) = 0 then
        txtAuthor.Text := RootNode.ChildNodes[SAuthors].ChildNodes[SAuthor].Text
      else
        txtAuthor.Text :=
          RootNode.ChildNodes[SArtists].ChildNodes[SArtist].Text;

//      txtAuthor.Text := '-'; // TODO: add no details resourcestring

    TabSheet6.Caption := ParseCaption(RootNode.ChildNodes[SProductName].Text);
    txtName.Text := RootNode.ChildNodes[SProductName].Text;
    txtManufactured.Text := RootNode.ChildNodes[SManufacturer].Text;
    txtReleased.Text := RootNode.ChildNodes[SReleaseDate].Text;
    if cbSearchMode.Text = SDVD then
      txtTheaterRelease.Text := RootNode.ChildNodes[STheaterReleaseDate].Text
    else
      txtTheaterRelease.Text := '-'; // TODO: add no details resourcestring
    txtListPrice.Text := RootNode.ChildNodes[SListPrice].Text;
    txtAmazonPrice.Text := RootNode.ChildNodes[SOurPrice].Text;
    txtUsedPrice.Text := RootNode.ChildNodes[SUsedPrice].Text;
    txtISBN.Text := RootNode.ChildNodes[SAsin].Text;
    if cbSearchMode.Text = SDVD then
      txtDirector.Text :=
        RootNode.ChildNodes[SDirectors].ChildNodes[SDirector].Text
    else
      txtDirector.Text := '-'; // TODO: add no details resourcestring
    txtMediaType.Text := RootNode.ChildNodes[SMedia].Text;
    txtBrowseNode.Text :=
      RootNode.ChildNodes[SBrowseList].ChildNodes[SBrowseNode].ChildNodes[SBrowseName].Text;
    txtThirdPartyPrice.Text := RootNode.ChildNodes[SThirdPartyNewPrice].Text;
    txtSalesRank.Text := RootNode.ChildNodes[SSalesRank].Text;
    txtAvgRating.Text :=
      RootNode.ChildNodes[SReviews].ChildNodes[SAvgCustomerRating].Text;
  end
  else
    exit;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the search status to done or information message that user has to enter
  search parameters.
  @param AValue The boolean flag to indicate search status.
}

procedure TMainForm.SetSearchStatus(AValue: boolean);
begin
  SearchDone := AValue;
  if SearchDone then
  begin
    UpdateStatusbar('', SearchPanel);
  end
  else
  begin
    UpdateStatusbar(SEnterSearchParams, InfoPanel);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Clears the associated product from the canvas and assigns it to nill.
  // TODO: fix this
}

procedure TMainForm.ClearImage;
begin
  if imgProduct.Picture.Graphic is TJPEGImage then
    imgProduct.Picture.Assign(nil);
end;

{-----------------------------------------------------------------------------}
{**
  Opens a local search result page that user has selected.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileOpenClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  FileName: string;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.InitialDir := AppPath;
    OpenDialog.Title := SOpenAmazonSearchResults;
    OpenDialog.Filter := SAmazonProductFinderSearchFilesXm;
    if OpenDialog.Execute then
    begin
      FileName := OpenDialog.FileName;
      if FileName = '' then
        exit;
      try
        ResultDoc.LoadFromFile(FileName);
        if Assigned(ResultDoc) then
        begin
          if GetErrMsg(ResultDoc.DocumentElement, SErrorMsg) then
          begin
            ShowErrorMessage(SSearchResultNone);
            SetSearchStatus(false);
            exit;
          end
          else
          begin
            if lvSearchResults.Items.Count > 0 then
              mnuFileNewSearchClick(self)
            else
              InitNodes(ResultDoc);
            SetCaption(SAmazonProductFinder + SLoadedSearch +
              FileName + ']');
            TabSheet2.TabVisible := true;
            cmdShop.Visible := true;
            AddRecentSearch(FileName);
          end;
        end;
      except
        on E: Exception do
        begin
          UpdateStatusbar(SLoadedSearchParseFailed, MessagePanel);
        end;
      end;
    end;
  finally
    OpenDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Loads the user's selected recent search file from the local cache.
  @param Sender The sender object.
}

procedure TMainForm.menuRecentClick(Sender: TObject);
begin
  try
    ResultDoc.LoadFromFile(ExtractFileName(TMenuItem(Sender).Caption));
    if Assigned(ResultDoc) then
    begin
      if GetErrMsg(ResultDoc.DocumentElement, SErrorMsg) then
      begin
        ShowErrorMessage(SSearchResultNone);
        SetSearchStatus(false);
        exit;
      end
      else
      begin
        if lvSearchResults.Items.Count > 0 then
          mnuFileNewSearchClick(self)
        else
          InitNodes(ResultDoc);
        SetCaption(SAmazonProductFinder + SLoadedSearch + FileName + ']');
        AddRecentSearch(FileName);
      end;
    end;
  except
    on E: Exception do
    begin
      UpdateStatusbar(SLoadedSearchParseFailed, MessagePanel);
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Saves the search as a local search. If file exists ask user for
  confirmation to overwrite it.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileSaveClick(Sender: TObject);
var
  FileName: string;
  SaveDialog: TSaveDialog;
begin
  if not Modified then
    exit;
  FileName := '';
  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.InitialDir := AppPath;
    SaveDialog.Title := SSaveAmazonSearchResults;
    SaveDialog.Filter := SAmazonFinderSearchFilesXmlXml;
    if SaveDialog.Execute then
      FileName := SaveDialog.FileName;
    if ExtractFileExt(FileName) = '' then
    begin
      MessageDlg(SAnExtensionMustBeSpesifiedToIndi +
        STheAmazonProductFinderFormat, mtConfirmation, [mbOk], 0);
      Abort;
    end;
    if FileExists(FileName) and
      (MessageDlg(SFile + FFileName + SExists + SOverwrite,
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      Abort;
    ResultDoc.SaveToFile(FileName);
  finally
    SaveDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Dumps the occurred exception to the log-file and appends it to the end of
  file is log exists.
  @param Sender The sender object.
  @param E The exception that occurred.
}

procedure TMainForm.DumpException(Sender: TObject; E: Exception);
var
  FLogFile: TextFile;
  FileName: string;
begin
  try
    FileName := ChangeFileExt(Application.ExeName, '.log');
{$IFDEF DEBUG}
    DumpLog('Application log file and path are ' + FileName +
      ExtractFilePath(FileName));
{$ENDIF}
    AssignFile(FLogFile, FileName);
    if FileExists(FileName) then
      Append(FLogFile)
    else
      Rewrite(FLogFile);
    Writeln(FLogFile, DateTimeToStr(Now) + ' : ' + E.Message);
    CloseFile(FLogFile);
  finally
    UpdateStatusBar(SUpdateFinished, InfoPanel);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Queries whether program should close.
  @param Sender The sender object.
  @param CanClose The status flag whether to close or not.
}

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if MessageDlg(SProgramExit, mtConfirmation,
    [mbYes, mbNo], 0) = idNo then
    CanClose := false;
end;

{-----------------------------------------------------------------------------}
{**
  Show the preferences.
  @param Sender The sender object.
}

procedure TMainForm.mnuToolsPrefsClick(Sender: TObject);
begin
  Preferences.ShowModal;
end;

{-----------------------------------------------------------------------------}
{**
  Selects and sets the search mode.
  @param Sender The sender object.
}

procedure TMainForm.cbSearchModeSelect(Sender: TObject);
begin
  FSearchParams.SearchMode := cbSearchMode.Text;
end;

{-----------------------------------------------------------------------------}
{**
  Selects and sets the search by value.
  @param Sender The sender object.
}

procedure TMainForm.cbSearchBySelect(Sender: TObject);
begin
  FSearchParams.SearchBy := cbSearchBy.Text;
end;

{-----------------------------------------------------------------------------}
{**
  Refreshes the program views, data files and pending updates.
  @param Sender The sender object.
}

procedure TMainForm.cmdRefreshSearchClick(Sender: TObject);
begin
  // TODO:
  Refresh;
end;

{-----------------------------------------------------------------------------}
{**
  Clears the search results, entered search parameters and starts from a
  fresh start.
  @param Sender The sender object.
}

procedure TMainForm.ClearAll1Click(Sender: TObject);
begin
  mnuFileNewSearchClick(Self);
end;

{-----------------------------------------------------------------------------}
{**
  Prints the performed search as a report.
  @param Sender The sender object.
}

procedure TMainForm.cmdPrintSearchClick(Sender: TObject);
begin
  mnuFilePrintClick(Self);
end;

{-----------------------------------------------------------------------------}
{**
  Prints the performed search as a report.
  @param Sender The sender object.
}

procedure TMainForm.mnuFilePrintClick(Sender: TObject);
begin
  // TODO:
  PrintDialog1.Execute;
end;

{-----------------------------------------------------------------------------}
{**
  Clears the search results, entered search parameters and starts from a
  fresh start.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileClearClick(Sender: TObject);
begin
  mnuFileNewSearchClick(Self);
end;

{-----------------------------------------------------------------------------}
{**
  Saves the search as a local search. If file exists ask user for
  confirmation.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileSaveAsClick(Sender: TObject);
begin
  SaveSearch1.Click;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the local search status flag. True if to use, False if not.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileUseLocalHistoryClick(Sender: TObject);
begin
  if mnuFileUseLocalHistory.Checked then
  begin
    LocalSearch := true;
    mnuFileUseLocalHistory.Checked := true;
  end
  else
  begin
    LocalSearch := false;
    mnuFileUseLocalHistory.Checked := false;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Browses the selected product's Web page in Web browser.
  @param Sender The sender object.
}

procedure TMainForm.BrowseProductDetails1Click(Sender: TObject);
begin
  if Config.SearchType = SSearchTypeHeavy then
  begin
    if not ResultDoc.Active then
      exit;
    RootNode :=
      ResultDoc.DocumentElement.ChildNodes[lvSearchResults.Selected.Index +
      3];
    ExecuteFile(RootNode.ChildNodes[SDetails].Attributes[SUrl], '', '',
      SW_SHOW);
  end
  else
  begin
    UpdateStatusbar(SSelectHeavySearchType, MessagePanel);
    exit;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Gets the dropped file and populates the search view.
  @param Msg The drop message.
}

procedure TMainForm.DropFiles(var Msg: TWMDROPFILES);
var
  i,
    DropFileCount: integer;
  FileName: array[0..255] of char;
begin
  DropFileCount := DragQueryFile(Msg.Drop, Cardinal(-1), nil, 0);
  LoadingCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    for i := 0 to DropFileCount - 1 do
    begin
      DragQueryFile(Msg.Drop, i, FileName, SizeOf(FileName) - 1);
      ResultDoc.LoadFromFile(FileName);
      if lvSearchResults.Items.Count > 0 then
        mnuFileNewSearchClick(Self);
      InitNodes(ResultDoc);
      SetCaption(SLocalSearchLoaded);
      UpdateStatusbar(SSearchLoaded, SearchPanel);
    end;
  finally
    Screen.Cursor := LoadingCursor;
  end;
  DragFinish(Msg.Drop);
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility for the
  @param Sender The sender object.
}

procedure TMainForm.Read1Click(Sender: TObject);
begin
  if PageControl2.Pages[0].Visible then
    PageControl2.Pages[1].Show
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility for the program's toolbar.
  @param Sender The sender object.
}

procedure TMainForm.mnuViewBarsToolsClick(Sender: TObject);
begin
  if MainToolbar.Visible then
  begin
    mnuViewBarsTools.Checked := false;
    MainToolbar.Visible := false;
  end
  else
  begin
    mnuViewBarsTools.Checked := true;
    MainToolbar.Visible := true;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility for the product details panel.
  @param Sender The sender object.
}

procedure TMainForm.mnuViewPanelsDetailsClick(Sender: TObject);
begin
  if pnlDetails.Visible then
  begin
    mnuViewPanelsDetails.Checked := false;
    pnlDetails.Visible := false;
  end
  else
  begin
    mnuViewPanelsDetails.Checked := true;
    pnlDetails.Visible := true;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility for the program's progressbar.
  @param Sender The sender object.
}

procedure TMainForm.Progressbar1Click(Sender: TObject);
begin
  if ProgressBar.Visible then
  begin
    ProgressBar1.Checked := false;
    ProgressBar.Visible := false;
  end
  else
  begin
    ProgressBar1.Checked := true;
    ProgressBar.Visible := true;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Performs any clean-up that's left as program's exiting. Frees the search
  thread(s) and timers.
  @param Sender The sender object.
}

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if (SearchTimer.Enabled) and (UpdateTimer.Enabled) then
  begin
    SearchTimer.Enabled := false;
    SearchTimer.Free;
    UpdateTimer.Enabled := false;
    UpdateTimer.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility for the power-search feature.
  @param Sender The sender object.
}

procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    cbPowerSearch.Visible := true
  else
  begin
    cbPowerSearch.Visible := false;
    CheckBox1.Checked := false;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Sorts the search resultview with selected value.
  @param Sender The sender object.
  @param Column The selected resultview column.
}

procedure TMainForm.lvSearchResultsColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  // TODO:
  lvSearchResults.AlphaSort;
end;

{-----------------------------------------------------------------------------}
{**
  Shows the the search categories.
  @param Sender The sender object.
}

procedure TMainForm.AddCategory2Click(Sender: TObject);
begin
  if not Assigned(Categories) then
    Categories := TCategories.Create(nil);
  Categories.ShowModal;
end;

{-----------------------------------------------------------------------------}
{**
  Navigates and fetches the next search result page.
  @param Sender The sender object.
}

procedure TMainForm.cmdNextPageClick(Sender: TObject);
begin
  NavigateNextPage;
  lvSearchResults.Items.Clear;
  if PageNumber = 1 then
    cmdPrevPage.Enabled := false
  else if PageNumber >= 1 then
    cmdPrevPage.Enabled := true;
  btnSearchClick(Self);
  lblSearchPage.Caption := SPage1 + IntToStr(PageNumber);
end;

{-----------------------------------------------------------------------------}
{**
  Navigates and fetches the previous search result page.
  @param Sender The sender object.
}

procedure TMainForm.cmdPrevPageClick(Sender: TObject);
begin
  NavigatePreviousPage;
  lvSearchResults.Items.Clear;
  if PageNumber = 1 then
    cmdPrevPage.Enabled := false;
  btnSearchClick(Self);
  lblSearchPage.Caption := SPage1 + IntToStr(PageNumber);
end;

{-----------------------------------------------------------------------------}
{**
  Adds the selected product to the shopping cart.
  @param Sender The sender object.
}

procedure TMainForm.Addtocart1Click(Sender: TObject);
var
  i,
    ProductCount: integer;
  Item: TListItem;
  ProductAsinList: TStringList;
begin
  try
    ProductAsinList := TStringList.Create;
    for i := 0 to lvSearchResults.Items.Count - 1 do
    begin
      Item := lvSearchResults.Items[i];
      if not Item.Selected then
        continue;
      RootNode := ResultDoc.DocumentElement.ChildNodes[Item.Index + 3];
      ProductAsinList.Add(RootNode.ChildNodes[SAsin].Text);
      Inc(ProductCount);
      lvSearchResults.Items[i].Checked := true;
      UpdateStatusbar(SShoppingCartAdd, SearchPanel);
      if not Assigned(ShoppingCart) then
      begin
        ShoppingCart := TfrmShoppingCart.Create(nil);
        ShoppingCart.AddItem(RootNode.ChildNodes[SProductName].Text,
          RootNode.ChildNodes[SOurPrice].Text, IntToStr(1));
      end;
      if not cmdShop.Enabled then
        cmdShop.Enabled := true;
    end;
  finally
    ProductAsinList.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Selects all results in the search resultview.
  @param Sender The sender object.
}

procedure TMainForm.SelectAll1Click(Sender: TObject);
begin
  // TODO:
  lvSearchResults.SelectAll;
end;

{-----------------------------------------------------------------------------}
{**
  Saves the search as a local search. If file exists ask user for
  confirmation.
  @param Sender The sender object.
}

procedure TMainForm.SaveSearchAs2Click(Sender: TObject);
begin
  mnuFileSaveAsClick(Self);
end;

{-----------------------------------------------------------------------------}
{**
  Prints the performed search as a report.
  @param Sender The sender object.
}

procedure TMainForm.Print2Click(Sender: TObject);
begin
  mnuFilePrintClick(Self);
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility for the product price information panel.
  @param Sender The sender object.
}

procedure TMainForm.mnuViewPanelsPriceClick(Sender: TObject);
begin
  if GroupBox2.Visible then
  begin
    mnuViewPanelsPrice.Checked := false;
    GroupBox2.Visible := false;
  end
  else
  begin
    mnuViewPanelsPrice.Checked := true;
    GroupBox2.Visible := true;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Starts fetching all search result pages.
  @param Sender The sender object.
}

procedure TMainForm.SearchTimerTimer(Sender: TObject);
begin
  // TODO:
  FetchAllPages;
end;

{-----------------------------------------------------------------------------}
{**
  Starts a new search, cleans up every field and sets program ready for a new
  search.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileNewSearchClick(Sender: TObject);
begin
  // TODO:
  StartNewSearch;
  txtSearchText.Clear;
  lvSearchResults.Items.Clear;
  txtAuthor.Clear;
  txtName.Clear;
  txtManufactured.Clear;
  txtReleased.Clear;
  txtListPrice.Clear;
  txtAmazonPrice.Clear;
  txtUsedPrice.Clear;
  txtSalesRank.Clear;
  txtAvgRating.Clear;
  txtThirdPartyPrice.Clear;
  txtISBN.Clear;
  txtBrowseNode.Clear;
  txtTheaterRelease.Clear;
  txtMediaType.Clear;
  txtDirector.Clear;
  lblSearchText.Caption := '';
  lblTotalPages.Caption := '';
  lblTotalResults.Caption := '';
  Tabsheet6.Caption := '';
  lblRating.Caption := '';
  lblSummary.Caption := '';
  txtSummary.Clear;
  ClearImage;
  pnlDetails.Visible := false;
  cbSearchMode.Text := 'Search product:';
  cbSearchBy.Text := 'Search by:';
  ProgressBar.Position := -1;
  UpdateStatusbar(SEnterSearchParams, MessagePanel);
end;

{-----------------------------------------------------------------------------}
{**
  Exports search results as a tab delimited text or comma-delimited text.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileExportAsTxtClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  if not Modified then
    exit;
  SaveDialog := TSaveDialog.Create(nil);
  with SaveDialog do
  try
    InitialDir := '.';
    Title := SExportSearchResults;
    Filter := STextFilesTabCsvTabCsv;
    Execute;
  finally
    ExportResults(AppPath + SSearchXml, DefaultHtmlExport, FileName);
    SaveDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Exports search results as a HTML-page.
  @param Sender The sender object.
}

procedure TMainForm.mnuFileExportHtmlClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  if not Modified then
    exit;
  SaveDialog := TSaveDialog.Create(nil);
  with SaveDialog do
  try
    InitialDir := '.';
    Title := SExportSearchResults;
    Filter := SHTMLFileHtmlHtml;
    Execute;
  finally
    // TODO: use resource stream here
    ExportResults(AppPath + SSearchXml, DefaultHtmlExport, FileName);
    SaveDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Shows the thumbnails from local search cache.
  @param Sender The sender object.
}

procedure TMainForm.mnuViewThumbsClick(Sender: TObject);
begin
  if not Assigned(Thumbnails) then
    Thumbnails := TThumbnails.Create(nil);
  Thumbnails.ShowModal;
end;

{-----------------------------------------------------------------------------}
{**
  Shows the alarm updates.
  @param Sender The sender object.
}

procedure TMainForm.AddPriceUpdateAlarm1Click(Sender: TObject);
begin
  if not Assigned(AlarmDialog) then
    AlarmDialog := TAlarmAdd.Create(nil);
  AlarmDialog.ShowModal;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility of the search panel.
  @param Sender The sender object.
}

procedure TMainForm.mnuViewPanelsSearchClick(Sender: TObject);
begin
  if mnuViewPanelsSearch.Checked or (mnuViewPanelsSearch.Checked = false) then
  begin
    if GroupBox1.Visible then
    begin
      GroupBox1.Hide;
      mnuViewPanelsSearch.Checked := false;
    end
    else
    begin
      GroupBox1.Show;
      mnuViewPanelsSearch.Checked := true;
    end;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Adds all search results to the shopping cart.
  TODO: fix this
  @param Sender The sender object.
}

procedure TMainForm.AllSearchResults1Click(Sender: TObject);
var
  s: string;
  i,
  j: integer;
  sProductList,
  sRecipients: TStringList;
  m: TMAPIMail;
begin
  try
    try
      m := TMAPIMail.Create(Self);
      sProductList := TStringList.Create;
      sRecipients := TStringList.Create;
      for i := 0 to lvSearchResults.Items.Count - 1 do
      begin
        sProductList.Add(lvSearchResults.Items[i].Caption);
        for j := 0 to lvSearchResults.Items[i].SubItems.Count - 1 do
          sProductList.Add(#9 + lvSearchResults.Items[i].SubItems[j]);
      end;
      s := InputBox('Enter recipient name', 'Please enter the recipient''s address:', '');
      if s <> '' then
        with m do
        begin
          Recipients.Add(s);
          Subject := URLEncode('Search Results for Query ' + txtSearchText.Text + DateTimeToStr(Now));
          Body := sProductList.Text;
          EditDialog := false;
          Send;
        end;
    finally
      sRecipients.Free;
      sProductList.Free;
      m.Free;
    end;
  except
    on e: Exception do
      Application.HandleException(Sender);
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Shows the shopping cart contents.
  @param Sender The sender object.
}

procedure TMainForm.mnuViewCartClick(Sender: TObject);
begin
  if not Assigned(ShoppingCart) then
    ShoppingCart := TfrmShoppingCart.Create(nil);
  ShoppingCart.ShowModal;
end;

{-----------------------------------------------------------------------------}
{**
  Sets the visibility of the details panel.
  @param Sender The sender object.
}

procedure TMainForm.mnuViewFoldersClick(Sender: TObject);
begin
  if mnuViewFolders.Checked then
  begin
    Panel4.Visible := false;
    mnuViewFolders.Checked := false;
  end
  else
  begin
    Panel4.Visible := true;
    mnuViewFolders.Checked := true;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Brings up the popup-menu in search folders on selected treenode.
  @param Sender The sender object.
  @param MousePos The position of the mouse and click.
  @param Handled Checks whether event is handled.
}

procedure TMainForm.tvSearchFoldersContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  p: TPoint;
  Node: TTreeNode;
begin
  p := tvSearchFolders.ClientToScreen(MousePos);
  Node := tvSearchFolders.GetNodeAt(MousePos.X, MousePos.Y);
  if not Assigned(Node) then
    exit;
  tvSearchFolders.Selected := Node;
  if Node.Level = 0 then
    PopupMenu6.Popup(p.X, p.Y);
  Handled := true;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Node
  @param AllowChange
}

procedure TMainForm.tvSearchFoldersChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  // TODO:
  Node.MakeVisible;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Node
}

procedure TMainForm.tvSearchFoldersChange(Sender: TObject;
  Node: TTreeNode);
begin
  // TODO:
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TMainForm.tvSearchFoldersClick(Sender: TObject);
var
  i,
    index: integer;
  Node: TTreeNode;
  p: TPoint;
begin
  if not Assigned(tvSearchFolders.Selected) then
    exit;
  if tvSearchFolders.Selected.Data <> Pointer(-1) then
  begin
    if Assigned(tvSearchFolders.Selected) then
      Node := tvSearchFolders.Selected
    else
    begin
      p := tvSearchFolders.ScreenToClient(Mouse.CursorPos);
      Node := tvSearchFolders.GetNodeAt(p.X, p.Y);
    end;
    if Assigned(Node) and (integer(Node.Data) <> -1) then
      if Node.Level >= 1 then
      begin
        i := integer(Node.Data);
        // TODO: open file and initialize view
      end;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TMainForm.FormShow(Sender: TObject);
var
  i: integer;
begin
  // TODO:
  if FirstTime then
  begin

    AddSearchFolder(tvSearchFolders, SBooks);
    AddSearchFolder(tvSearchFolders, SDVD);
    AddSearchFolder(tvSearchFolders, SMagazines);
    AddSearchFolder(tvSearchFolders, SMusic);
    AddSearchFolder(tvSearchFolders, SVideogames);

    {
    for i := 0 to SearchFolders.Count - 1 do
      AddSearchFolder(tvSearchFolders, SearchFolders[i]);
    }

  end;
  mnuHelpTipOfDay.Enabled := true;
  mnuHelpContextHelp.Enabled := true;
  mnuHelpContents.Enabled := true;
  if toShowOnStartUp in JvTipOfDay1.Options then
    JvTipOfDay1.Execute;
end;

{-----------------------------------------------------------------------------}
{**
 
  @param AValue
}

procedure TMainForm.SetOnAlarmTriggered(const AValue: TNotifyEvent);
begin
  // TODO:
  FAlarmTriggered := AValue;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TMainForm.cbSearchModeChange(Sender: TObject);
begin
  Modified := true;
  UpdateStatusbar(SStatusModified, InfoPanel);
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TMainForm.cbSearchByChange(Sender: TObject);
begin
  Modified := true;
  UpdateStatusbar(SStatusModified, InfoPanel);
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TMainForm.txtSearchTextChange(Sender: TObject);
begin
  Modified := true;
  UpdateStatusbar(SStatusModified, InfoPanel);
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param DragObject
}

procedure TMainForm.lvSearchResultsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  // TODO:
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Source The source object.
  @param X The mouse X position.
  @param Y The mouse Y position.
}

procedure TMainForm.tvSearchFoldersDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  SourceNode,
    TargetNode: TTreeNode;
begin
  // TODO:
  with tvSearchFolders do
  begin
    //
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Source The source object.
  @param X The mouse X position.
  @param Y The mouse Y position.
  @param State The mouse drag state.
  @param Accept The accept value.
}

procedure TMainForm.tvSearchFoldersDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
  // TODO:
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Target The targe object.
  @param X The mouse X position.
  @param Y The mosue Y position.
}

procedure TMainForm.lvSearchResultsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  // TODO:
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TMainForm.lvSearchResultsDblClick(Sender: TObject);
begin
  // TODO:
end;

{-----------------------------------------------------------------------------}
{**
  Shows up the larger product image when user clicks the image.
  @param Sender The sender object.
}

procedure TMainForm.imgProductClick(Sender: TObject);
begin
  // TODO:
end;

{-----------------------------------------------------------------------------}
{**
  Updates the recent file menu by adding the items in the recent searches.
}

procedure TMainForm.RecentSearchesUpdate;
var
  i: integer;
  itm: TMenuItem;
begin
  mnuFileRecent.Visible := RecentSearches.Count > 0;
  if RecentSearches.Count > 0 then
  begin
    mnuFileRecent.Clear;
    for i := 0 to RecentSearches.Count - 1 do
    begin
      itm := TMenuItem.Create(Self);
      itm.Caption := RecentSearches.Strings[i];
      itm.OnClick := menuRecentClick;
      mnuFileRecent.Add(itm)
    end;
  end
end;

{-----------------------------------------------------------------------------}
{**
  Adds a new search file entry made (and saved) to the File-menu's recent
  item.
  @param AValue The recent file entry.
}

procedure TMainForm.AddRecentSearch(const AValue: string);
var
  i: integer;
begin
  if AValue = '' then
    exit;
  for i := 0 to RecentSearches.Count - 1 do
    if AnsiLowercase(AValue) = AnsiLowerCase(RecentSearches[i]) then
      RecentSearches.Delete(i);
  RecentSearches.Add(AValue);
  RecentSearchesUpdate;
end;

{-----------------------------------------------------------------------------}
{**
  Reads the next product review.
  @param Sender The sender object.
}

procedure TMainForm.cmdNextReviewClick(Sender: TObject);
begin
  RootNode :=
    ResultDoc.DocumentElement.ChildNodes[lvSearchResults.Selected.Index + 3];
  lblRating.Caption :=
    RootNode.ChildNodes[SReviews].ChildNodes[SCustomerReview].ChildNodes[SRating].Text;
  lblSummary.Caption :=
    RootNode.ChildNodes[SReviews].ChildNodes[SCustomerReview].ChildNodes[SSummary].Text;
  txtSummary.Text :=
    RootNode.ChildNodes[SReviews].ChildNodes[SCustomerReview].ChildNodes[SComment].Text;
end;

{-----------------------------------------------------------------------------}
{**
  Reads the previous product review.
  @param Sender The sender object.
}

procedure TMainForm.cmdPreviousReviewClick(Sender: TObject);
begin
  //  RootNode := ResultDoc.DocumentElement.ChildNodes[lvSearchResults.Selected.Index + 3];
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Alarm The alarm item.
  @param TriggerTime The time and date when alarm was set on.
}

procedure TMainForm.ProductAlarmsAlarm(Sender: TObject;
  const Alarm: TJvAlarmItem; const TriggerTime: TDateTime);
begin
  with Alarm do
  begin
    if Alarm.Name = SAlarmPrice then
      //
    else
    if Alarm.Name = SAlarmSales then
      //
    else
    if Alarm.Name = SAlarmAverage then
      // ;
  end;
end;

{-----------------------------------------------------------------------------}
{**
  Adds a new search folder to the search folder tree.
  @param Sender The sender object.
}

procedure TMainForm.AddSearchFolder1Click(Sender: TObject);
var
  s: string;
begin
  s := InputBox(SAddSearchFolder, 'Please enter a name for your search folder:', '');
  if s <> '' then
    AddSearchFolder(tvSearchFolders, s)
  else
    exit;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object
  @param Item The selected list item
  @param Selected Is the item selected
}

procedure TMainForm.lvSimilarResultsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  pnlSearchStats.Visible := false;
  LoadProductDetails(Item);
  LoadImageFromURL(Item, SImageMedium);
  if Config.SearchType = SSearchTypeHeavy then
    LoadProductReviews(Item);
  if cbSearchMode.Text = SMusic then
  begin
    TabSheet5.TabVisible := true;
    InitTrackNodes(Item);
  end;
  TabSheet6.Show;  
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object
}

procedure TMainForm.Selected1Click(Sender: TObject);
var
  s: string;
begin
  s := InputBox('Enter recipient name', 'Please enter the recipient''s address:', '');
  if s <> '' then
  begin
    Email.Subject := URLEncode('Search Results for Query ' + txtSearchText.Text + DateTimeToStr(Now));
    Email.Recipients.EMailAddresses := Trim(s);
    Email.Body.Text := 'blah';
    SMTP.Connect;
    try
      SMTP.Send(Email);
    finally
      SMTP.Disconnect;
    end;
  end;
end;

procedure TMainForm.Hide1Click(Sender: TObject);
begin
  if Panel4.Visible then
    Panel4.Visible := false
end;

procedure TMainForm.RemoveSelected1Click(Sender: TObject);
begin
//
end;

procedure TMainForm.UpdateSearchFolders1Click(Sender: TObject);
begin
//
end;

procedure TMainForm.mnuHelpTipOfDayClick(Sender: TObject);
begin
  JvTipOfDay1.Execute;
end;

end.
