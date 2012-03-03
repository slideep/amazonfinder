{

$Id: dlgPreferences.pas,v 1.15 2004/05/05 22:22:25 slide Exp $

Description:

Preferences dialog for the Amazon Product Finder.

The initial developer of the original code is slide@users.sourceforge.net.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public
License along with this program; if not, write to the Free
Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA  02111-1307, USA.

}

unit dlgPreferences;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, Mask, uFinderXmlConfig, ExtCtrls, ComCtrls,
  Buttons;

type

  {-------------------------------------------------------------------------}
  {- TPreferences -}
  TPreferences = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    txtHTTPProxy: TEdit;
    txtHTTPPort: TEdit;
    txtUserID: TEdit;
    txtUserPasswd: TMaskEdit;
    cbUseProxy: TCheckBox;
    CheckBox1: TCheckBox;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    cbSearchType: TComboBox;
    UpDown1: TUpDown;
    UpdateDelay: TEdit;
    cbDeleteSearches: TCheckBox;
    Bevel2: TBevel;
    Label7: TLabel;
    Label9: TLabel;
    cbDefaultType: TCheckBox;
    cbUpdateStartup: TCheckBox;
    cbDisplaySplash: TCheckBox;
    Bevel3: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    cbCacheLocation: TComboBox;
    btnSelectDirectory: TSpeedButton;
    Label12: TLabel;
    Bevel4: TBevel;
    Label13: TLabel;
    cbExportLocation: TComboBox;
    btnSelectExportLocation: TSpeedButton;
    Label15: TLabel;
    txtResults: TEdit;
    UpDown2: TUpDown;
    Label16: TLabel;
    txtPages: TEdit;
    UpDown3: TUpDown;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox2: TCheckBox;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    Label14: TLabel;
    Bevel5: TBevel;
    Label17: TLabel;
    txtServerAddr: TEdit;
    txtServerPort: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    txtUserName: TEdit;
    Label20: TLabel;
    Bevel6: TBevel;
    Label21: TLabel;
    Bevel7: TBevel;
    CheckBox5: TCheckBox;
    Label22: TLabel;
    Bevel8: TBevel;
    Label23: TLabel;
    txtFirstName: TEdit;
    Label24: TLabel;
    txtLastName: TEdit;
    Label25: TLabel;
    txtEmailAddr: TEdit;
    cmdHelp: TButton;
    Label26: TLabel;
    Edit1: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbUseProxyClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure cbDeleteSearchesClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSelectDirectoryClick(Sender: TObject);
    procedure btnSelectExportLocationClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FUpdated: boolean;
    FConfig: TuFinderXmlConfig;
  public
    { Public declarations }
  published
    property Config: TuFinderXmlConfig read FConfig write FConfig;
  end;

var

  Preferences: TPreferences;

implementation

uses
  frmMain, ShellAPI, ShlObj, uFinderGlobals;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- Preferences -}

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.btnOKClick(Sender: TObject);
begin
  if cbUseProxy.Checked then
  begin
    Config.ProxyUser := txtUserID.Text;
    Config.ProxyPassword := txtUserPasswd.Text;
    Config.ProxyHost := txtHTTPProxy.Text;
    Config.ProxyPort := StrToInt(txtHTTPPort.Text);
    FUpdated := True;
    MainForm.AmazonClient.ProxyParams.ProxyUsername := txtUserID.Text;
    MainForm.AmazonClient.ProxyParams.ProxyPassword := txtUserPasswd.Text;
    MainForm.AmazonClient.ProxyParams.ProxyServer := txtHTTPProxy.Text;
    MainForm.AmazonClient.ProxyParams.ProxyPort := StrToInt(txtHTTPPort.Text);
    MainForm.SMTP.Host := Trim(txtServerAddr.Text);
    MainForm.SMTP.Port := StrToInt(txtServerPort.Text);
    MainForm.SMTP.Username := Trim(txtUserName.Text);
    MainForm.SMTP.Password := Trim(Edit1.Text);
    MainForm.Email.From.Text := txtFirstName.Text + ' ' + txtLastName.Text;
    MainForm.Email.From.Address := txtEmailAddr.Text;
  end
  else
  begin
    if Config.FirstTime then
    begin
      Config.FirstTime := false;
      Config.Updated := true;
    end;
    if cbDeleteSearches.Checked then
    begin
      Config.DeleteSearchs := StrToInt(UpdateDelay.Text);
      FUpdated := true;
    end;
  end;
  Config.CacheLocation := cbCacheLocation.Text;
  Config.ExportLocation := cbExportLocation.Text;
  Config.SearchType := cbSearchType.Text;
  Config.Updated := true;
  Config.SaveAllSettings;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.FormCreate(Sender: TObject);
begin
  Config := MainForm.Config;
  cbSearchType.Text := Config.SearchType;
  cbDefaultType.Checked := Config.DefaulType;
  if UpdateDelay.GetTextLen > 0 then
    cbDeleteSearches.Checked := true
  else
    cbDeleteSearches.Checked := false;
  cbUpdateStartup.Checked := Config.UpdateStartup;
  cbDisplaySplash.Checked := Config.DisplaySplash;
  txtHTTPProxy.Text := Config.ProxyHost;
  txtHTTPPort.Text := IntToStr(Config.ProxyPort);
  txtUserID.Text := Config.ProxyUser;
  txtUserPasswd.Text := Config.ProxyPassword;
  cbUseProxy.Checked := Config.UseProxy;
  CheckBox1.Checked := Config.UseAuth;
  Checkbox4.Checked := Config.CompressCache;
  cbCacheLocation.Text := Config.CacheLocation;
  cbExportLocation.Text := Config.ExportLocation;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.cbUseProxyClick(Sender: TObject);
begin
  if cbUseProxy.Checked then
  begin
    Label1.Enabled := True;
    txtHTTPProxy.Enabled := True;
    Label2.Enabled := True;
    txtHTTPPort.Enabled := True;
  end
  else
  begin
    Label1.Enabled := False;
    txtHTTPProxy.Enabled := False;
    Label2.Enabled := False;
    txtHTTPPort.Enabled := False;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Label3.Enabled := True;
    txtUserID.Enabled := True;
    Label4.Enabled := True;
    txtUserPasswd.Enabled := True;
  end
  else
  begin
    Label3.Enabled := False;
    txtUserID.Enabled := False;
    Label4.Enabled := False;
    txtUserPasswd.Enabled := False;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.cbDeleteSearchesClick(Sender: TObject);
begin
  if cbDeleteSearches.Checked then
  begin
    UpdateDelay.Enabled := True;
    UpDown1.Enabled := True;
  end
  else
  begin
    UpdateDelay.Enabled := False;
    UpDown1.Enabled := False;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.btnCancelClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.btnSelectDirectoryClick(Sender: TObject);
var
  s: string;
begin
  s := BrowseDialog('Select Cache Location', BIF_RETURNONLYFSDIRS);
  cbCacheLocation.Text := s;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TPreferences.btnSelectExportLocationClick(Sender: TObject);
var
  s: string;
begin
  s := BrowseDialog('Select Export Location', BIF_RETURNONLYFSDIRS);
  cbExportLocation.Text := s;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Key The pressed key.
}

procedure TPreferences.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
