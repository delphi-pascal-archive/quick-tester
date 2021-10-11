unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, pngimage;

type
  TForm6 = class(TForm)
    Timer1: TTimer;
    Image16: TImage;
    Image3: TImage;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Image4: TImage;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Form1.MediaPlayer1.Play;
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
  Form1.MediaPlayer1.Pause;
end;

procedure TForm6.Button4Click(Sender: TObject);
begin
  Form1.MediaPlayer1.Position := 0;
  Form1.MediaPlayer1.Stop;
end;

procedure TForm6.Timer1Timer(Sender: TObject);
begin
  ProgressBar1.Position := Form1.MediaPlayer1.Position;
end;

end.
