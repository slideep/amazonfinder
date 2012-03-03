unit dlgBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TBackup = class(TForm)
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    StatusBar1: TStatusBar;
    lbSearches: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Backup: TBackup;

resourcestring
  SBackupCompleted = 'Backup completed successfully.';
  SBackupFailed = 'Backup failed.';
  SBackupReady = 'Ready.';

implementation

uses
  uFinderCacheUtils, uFinderGlobals;

{$R *.dfm}

{-----------------------------------------------------------------------------}
{**

}

procedure TBackup.Button2Click(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TBackup.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
