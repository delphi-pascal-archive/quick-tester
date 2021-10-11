unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ImgList, ExtCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    ImageList1: TImageList;
    ListView1: TListView;
    Memo1: TMemo;
    Image2: TImage;
    Image5: TImage;
    Image3: TImage;
    Image16: TImage;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  try
    Memo1.Text := item.SubItems[1];
  except
  end;
end;

procedure TForm5.FormShow(Sender: TObject);
var
  i,a,b : integer;
  j     : integer;
begin
  Image2.Picture := nil;
  for j := 0 to (Image2.Height div Form1.Image7.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image2.Width div Form1.Image7.Picture.Bitmap.Width)+1 do
      Image2.Canvas.Draw(i*Form1.Image7.Picture.Bitmap.Width,j*Form1.Image7.Picture.Bitmap.Height-7,Form1.Image7.Picture.Bitmap);

  Image5.Picture := nil;
  for j := 0 to (Image5.Height div Form1.Image8.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image5.Width div Form1.Image8.Picture.Bitmap.Width)+1 do
      Image5.Canvas.Draw(i*Form1.Image8.Picture.Bitmap.Width,j*Form1.Image8.Picture.Bitmap.Height,Form1.Image8.Picture.Bitmap);

  a := 0;
  b := 0;
  try
    for i := 0 to ListView1.Items.Count -1 do
      case ListView1.Items.Item[i].ImageIndex of
        0 : inc(a);
        1 : inc(b);
      end;
  except
  end;
    Label5.Caption := IntToStr(a+b);
    Label6.Caption := IntToStr(a);
end;

end.
