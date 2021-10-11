unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, shellAPI, pngimage;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Image15: TImage;
    Image16: TImage;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Image2: TImage;
    Image1: TImage;
    Image18: TImage;
    Image24: TImage;
    Label7: TLabel;
    Label8: TLabel;
    procedure Label5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label5MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Label5Click(Sender: TObject);
begin
  shellexecute(handle,
  'Open',
  'mailto:BlackCash2006@Yandex.ru?subject=QuickTester',
  nil, nil, sw_restore);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Color := clBlue;
end;

procedure TForm2.Label5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Label5.Font.Color := clGray;
end;

procedure TForm2.Label5MouseEnter(Sender: TObject);
begin
  Label5.Font.Color := clSilver;
end;

end.
