unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm6 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm6.FormResize(Sender: TObject);
begin
  Panel1.Repaint;
  Application.ProcessMessages;
  Image1.Repaint;
  Image1.Update;
end;

end.
