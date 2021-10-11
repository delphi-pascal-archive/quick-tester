unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    AnswerEdit : Boolean;
    AnswerID   : integer;
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit2, ComCtrls;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  if not AnswerEdit then 
  with Form2.ListView1.Items.Add do begin
    Caption := Memo1.Text;
    if CheckBox1.Checked then begin
      SubItems.Add('Верный');
      ImageIndex := 1;
    end else begin
      SubItems.Add('Не верный');
      ImageIndex := 0;
    end;
    SubItems.Add(inttostr(SpinEdit1.Value));
  end;
  //
  if AnswerEdit then
  with Form2.ListView1.Items.Item[AnswerID] do begin
    Caption := Memo1.Text;
    if CheckBox1.Checked then begin
      SubItems[0] := ('Верный');
      ImageIndex  := 1;
    end else begin
      SubItems[0] :=('Не верный');
      ImageIndex  := 0;
    end;
    SubItems[1] := (inttostr(SpinEdit1.Value));
  end;
  //
  Close;
end;

end.
