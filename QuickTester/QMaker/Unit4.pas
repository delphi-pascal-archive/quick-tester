unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label6: TLabel;
    SpinEdit1: TSpinEdit;
    CheckBox3: TCheckBox;
    SpinEdit2: TSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    SpinEdit3: TSpinEdit;
    Label9: TLabel;
    SpinEdit4: TSpinEdit;
    Label10: TLabel;
    SpinEdit5: TSpinEdit;
    Label11: TLabel;
    SpinEdit6: TSpinEdit;
    Label12: TLabel;
    SpinEdit7: TSpinEdit;
    Label13: TLabel;
    SpinEdit8: TSpinEdit;
    Label14: TLabel;
    SpinEdit9: TSpinEdit;
    Label15: TLabel;
    SpinEdit10: TSpinEdit;
    CheckBox4: TCheckBox;
    Edit4: TEdit;
    Label16: TLabel;
    CheckBox5: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form1.TESTDB.tName    := Form4.Edit1.Text;
  Form1.TESTDB.tSubject := Form4.Edit2.Text;
  Form1.TESTDB.tAuthor  := Form4.Edit3.Text;
  //
  Form1.TESTDB.tQUseUserDlg := CheckBox4.Checked;
  Form1.TESTDB.tQResaveRest := CheckBox5.Checked;
  Form1.TESTDB.tQSavePath   := Edit4.Text;
  //
  Form1.TESTDB.tQRndStyle := Form4.CheckBox1.Checked;
  Form1.TESTDB.tQTimeOver := Form4.CheckBox2.Checked;
  Form1.TESTDB.tQUseLimit := Form4.CheckBox3.Checked;
  //
  Form1.TESTDB.tQTime  := Form4.SpinEdit1.Value;
  Form1.TESTDB.tQLimit := Form4.SpinEdit2.Value;
  //
  Form1.TESTDB.tQ2BallsFrom := Form4.SpinEdit3.Value;
  Form1.TESTDB.tQ2BallsTo   := Form4.SpinEdit4.Value;
  Form1.TESTDB.tQ3BallsFrom := Form4.SpinEdit5.Value;
  Form1.TESTDB.tQ3BallsTo   := Form4.SpinEdit6.Value;
  Form1.TESTDB.tQ4BallsFrom := Form4.SpinEdit7.Value;
  Form1.TESTDB.tQ4BallsTo   := Form4.SpinEdit8.Value;
  Form1.TESTDB.tQ5BallsFrom := Form4.SpinEdit9.Value;
  Form1.TESTDB.tQ5BallsTo   := Form4.SpinEdit10.Value;
  //
  Form1.BitBtn4.Enabled := True;
  //
  Close;
end;

end.
