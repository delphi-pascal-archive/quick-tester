unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Image2: TImage;
    Button1: TButton;
    Image3: TImage;
    Image16: TImage;
    Image4: TImage;
    Label2: TLabel;
    Label1: TLabel;
    Image5: TImage;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    ext: string;
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Panel1.DoubleBuffered := true;
  Image2.ControlStyle  := Image2.ControlStyle + [csOpaque];
  Image3.ControlStyle  := Image3.ControlStyle + [csOpaque];
  Image5.ControlStyle  := Image5.ControlStyle + [csOpaque];
  Image16.ControlStyle := Image16.ControlStyle + [csOpaque];
end;

procedure TForm3.FormResize(Sender: TObject);
var
  i,j: integer;
begin
  Image2.Picture := nil;
  for j := 0 to (Image2.Height div Form1.Image7.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image2.Width div Form1.Image7.Picture.Bitmap.Width)+1 do
      Image2.Canvas.Draw(i*Form1.Image7.Picture.Bitmap.Width,j*Form1.Image7.Picture.Bitmap.Height-7,Form1.Image7.Picture.Bitmap);

  Image5.Picture := nil;
  for j := 0 to (Image5.Height div Form1.Image8.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image5.Width div Form1.Image8.Picture.Bitmap.Width)+1 do
      Image5.Canvas.Draw(i*Form1.Image8.Picture.Bitmap.Width,j*Form1.Image8.Picture.Bitmap.Height,Form1.Image8.Picture.Bitmap);
end;

end.
