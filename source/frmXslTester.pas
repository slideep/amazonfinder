unit frmXslTester;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Label4: TLabel;
    btnTransform: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    edSrcXsl: TEdit;
    edFilename: TEdit;
    btnSrc: TButton;
    btnDestFile: TButton;
    edSrcXml: TEdit;
    Button1: TButton;
    StatusBar1: TStatusBar;
    procedure btnSrcClick(Sender: TObject);
    procedure btnTransformClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnDestFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure TransformTest(AXmlFile, AXslFile, ADir: string);
  public
    { Public declarations }
  end;

resourcestring

  SReady = 'Ready.';
  SStylesheetBad = 'Stylesheet''s bad.';
  STransformSuccess = 'Transformation OK';
  STransformBad = 'Transformation Failed';

var
  Form1: TForm1;

implementation

uses
  MSXML2_TLB;

{$R *.dfm}

{-----------------------------------------------------------------------------}

procedure TForm1.TransformTest(AXmlFile, AXslFile, ADir: string);
var
  XmlDoc: IXMLDOMDocument;
  XslDoc: IXMLDOMDocument;
  Template: IXSLTemplate;
  Processor: IXSLProcessor;
  Results: TStringList;
  Output: string;
begin
  try
    Results := TStringList.Create;
    XmlDoc := CoFreeThreadedDOMDocument30.Create;
    XslDoc := CoFreeThreadedDOMDocument30.Create;
    XmlDoc.load(AXmlFile);
    XslDoc.load(AXslFile);
    XslDoc.async := false;
    Template := CoXSLTemplate30.Create;
    try
      Template.stylesheet := XslDoc;
    except
      on E: Exception do
        Label4.Caption := SStylesheetBad;
    end;
    Processor := Template.createProcessor;
    Processor.input := XmlDoc;
    if Processor.transform then
      Label4.Caption := STransformSuccess
    else
      Label4.Caption := STransformBad;
    Output := Processor.output;
    Results.Text := Output;
    Results.SaveToFile(ADir);
  finally
    Output := '';
    XmlDoc := nil;
    XslDoc := nil;
    Results.Free;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TForm1.btnSrcClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  with SaveDialog do
  try
    InitialDir := '.';
    Title := 'Select Source XSL File';
    Filter := 'XSL Files (*.xsl)|*.xsl';
    Execute;
    edSrcXsl.Text := FileName;
  finally
    SaveDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TForm1.btnTransformClick(Sender: TObject);
begin
  TransformTest(edSrcXml.Text, edSrcXsl.Text, edFilename.Text);
end;

{-----------------------------------------------------------------------------}

procedure TForm1.Button1Click(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  with SaveDialog do
  try
    InitialDir := '.';
    Title := 'Select Source XML File';
    Filter := 'XML Files (*.xml)|*.xml';
    Execute;
    edSrcXml.Text := FileName;
  finally
    SaveDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TForm1.btnDestFileClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  with SaveDialog do
  try
    InitialDir := '.';
    Title := 'Select Destination Transformation File';
    Filter :=
      'Transformation Files (*.html;*.txt;*.msg;*.csv;*.xml)|*.html;*.txt;*.msg;*.csv;*.xml';
    Execute;
    edFilename.Text := FileName;
  finally
    SaveDialog.Free;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label4.Caption := SReady + ' Select source files.';
end;

{-----------------------------------------------------------------------------}

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Close;
end;

end.
