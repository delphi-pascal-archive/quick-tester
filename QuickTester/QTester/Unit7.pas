unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage;

type
  TForm7 = class(TForm)
    Image16: TImage;
    Image3: TImage;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Image4: TImage;
    Image19: TImage;
    Image21: TImage;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button2Click(Sender: TObject);
begin
  ModalResult := 8;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  ModalResult := 6;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  ModalResult := 16;
end;

end.
