unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPI;

type
  TForm5 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.Label5Click(Sender: TObject);
begin
  shellexecute(handle,
  'Open',
  'mailto:BlackCash2006@Yandex.ru?subject=QuickTester',
  nil, nil, sw_restore);
end;

end.
