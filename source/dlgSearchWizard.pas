{

$Id: dlgSearchWizard.pas,v 1.6 2004/05/04 19:17:19 slide Exp $

Description:

Power Search Wizard dialog for the Amazon Product Finder.

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

unit dlgSearchWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvWizard, JvWizardRouteMapSteps,
  JvExControls, JvComponent, JvExStdCtrls, JvHTControls;

type
  TSearchWizard = class(TForm)
    JvWizard1: TJvWizard;
    JvWizardWelcomePage1: TJvWizardWelcomePage;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    JvWizardInteriorPage2: TJvWizardInteriorPage;
    JvHTComboBox1: TJvHTComboBox;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Select(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure JvWizard1CancelButtonClick(Sender: TObject);
    procedure JvWizard1FinishButtonClick(Sender: TObject);
    procedure JvWizard1HelpButtonClick(Sender: TObject);
    procedure JvWizard1NextButtonClick(Sender: TObject);
    procedure JvWizard1BackButtonClick(Sender: TObject);
    procedure JvWizard1StartButtonClick(Sender: TObject);
  private
    { Private declarations }
    FStepNumber: integer;
    FRemaining: integer;
    FPreviousStep: integer;
    FDescription: string;
  public
    { Public declarations }
    property CurrentStep: integer read FStepNumber write FStepNumber;
    property PreviousStep: integer read FPreviousStep write FPreviousStep;
    property Remaining: integer read FRemaining write FRemaining;
    property Description: string read FDescription write FDescription;
  end;

var
  SearchWizard: TSearchWizard;

implementation

uses

  frmMain;

resourcestring

  SCurrentStep = 'Step %d of %d';

{$R *.dfm}

  {-----------------------------------------------------------------------------}
  {- SearchWizard -}

  {-----------------------------------------------------------------------------}
  {**

  }

procedure TSearchWizard.FormCreate(Sender: TObject);
begin
  Remaining := 2;
  CurrentStep := 1;
  lblStepNumber.Caption := Format(SCurrentStep, [CurrentStep, Remaining]);
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TSearchWizard.Button3Click(Sender: TObject);
begin
  if CurrentStep = 1 then
  begin
    CurrentStep := CurrentStep + 1;
    lblStepNumber.Caption := Format(SCurrentStep, [CurrentStep, Remaining]) +
      ': create your power search or query below';
    Panel2.BringToFront;
    Button3.Caption := 'Finish';
  end;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TSearchWizard.Button2Click(Sender: TObject);
begin
  if CurrentStep = 2 then
  begin
    Panel1.BringToFront;
    CurrentStep := CurrentStep - 1;
  end;
  Close;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TSearchWizard.Button1Click(Sender: TObject);
begin
  if CurrentStep > 1 then
  begin
    CurrentStep := CurrentStep - 1;
    Panel1.BringToFront;
  end;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TSearchWizard.ComboBox1Select(Sender: TObject);
begin
  Edit3.Text := ComboBox1.Text + ' ';
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TSearchWizard.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  Edit3.Text := Edit3.Text + Key;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TSearchWizard.ComboBox2Select(Sender: TObject);
begin
  Edit3.Text := ' ' + Edit3.Text + ComboBox2.Text;
end;

{-----------------------------------------------------------------------------}
{**

}

procedure TSearchWizard.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TSearchWizard.JvWizard1CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TSearchWizard.JvWizard1FinishButtonClick(Sender: TObject);
begin
  //
end;

procedure TSearchWizard.JvWizard1HelpButtonClick(Sender: TObject);
begin
  //
end;

procedure TSearchWizard.JvWizard1NextButtonClick(Sender: TObject);
begin
  //
end;

procedure TSearchWizard.JvWizard1BackButtonClick(Sender: TObject);
begin
  //
end;

procedure TSearchWizard.JvWizard1StartButtonClick(Sender: TObject);
begin
  //
end;

end.
