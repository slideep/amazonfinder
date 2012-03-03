unit frmImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TProductImage = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    ClosingTimer: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProductImage: TProductImage;

implementation

{$R *.dfm}

{-----------------------------------------------------------------------------}
{- Form3 -}

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
  @param Key The pressed key which is down.
  @param Shift The shift modifier.
}

procedure TProductImage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Self.Close;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TProductImage.Timer2Timer(Sender: TObject);
begin
  AlphaBlendValue := AlphaBlendValue - 10;
  if AlphaBlendvalue < 20 then
  begin
    Timer2.Enabled := false;
    AlphaBlendValue := 0;
    Tag := 0;
    Close;
    Release;
  end;
end;

{-----------------------------------------------------------------------------}
{**

  @param Sender The sender object.
}

procedure TProductImage.Timer1Timer(Sender: TObject);
begin
  AlphaBlendValue := AlphaBlendvalue + 10;
  if AlphaBlendValue >= 250 then
  begin
    AlphablendValue := 255;
    Timer1.Enabled := false;
    ClosingTimer.Enabled := true;
  end;
end;

end.
