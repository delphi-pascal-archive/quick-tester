unit Sample;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LbSpeedButton, ExtCtrls, Buttons, StdCtrls, LbButton, LbStaticText;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    LbStaticText2: TLbStaticText;
    LbSpeedButton2: TLbSpeedButton;
    LbSpeedButton3: TLbSpeedButton;
    LbSpeedButton4: TLbSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Notebook1: TNotebook;
    LbStaticText1: TLbStaticText;
    LbSpeedButton6: TLbSpeedButton;
    Panel4: TPanel;
    Panel5: TPanel;
    LbSpeedButton7: TLbSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Panel6: TPanel;
    Panel7: TPanel;
    LbSpeedButton8: TLbSpeedButton;
    LbSpeedButton9: TLbSpeedButton;
    LbSpeedButton10: TLbSpeedButton;
    LbSpeedButton11: TLbSpeedButton;
    LbSpeedButton12: TLbSpeedButton;
    LbSpeedButton13: TLbSpeedButton;
    LbSpeedButton24: TLbSpeedButton;
    LbSpeedButton25: TLbSpeedButton;
    LbSpeedButton26: TLbSpeedButton;
    LbSpeedButton27: TLbSpeedButton;
    LbSpeedButton28: TLbSpeedButton;
    Panel8: TPanel;
    GroupBox1: TGroupBox;
    LbSpeedButton14: TLbSpeedButton;
    LbSpeedButton15: TLbSpeedButton;
    LbSpeedButton16: TLbSpeedButton;
    GroupBox2: TGroupBox;
    LbSpeedButton17: TLbSpeedButton;
    LbSpeedButton18: TLbSpeedButton;
    LbSpeedButton19: TLbSpeedButton;
    GroupBox4: TGroupBox;
    LbSpeedButton22: TLbSpeedButton;
    LbSpeedButton23: TLbSpeedButton;
    GroupBox5: TGroupBox;
    LbSpeedButton37: TLbSpeedButton;
    LbSpeedButton38: TLbSpeedButton;
    LbSpeedButton36: TLbSpeedButton;
    LbSpeedButton35: TLbSpeedButton;
    GroupBox6: TGroupBox;
    LbSpeedButton29: TLbSpeedButton;
    LbSpeedButton30: TLbSpeedButton;
    Image2: TImage;
    GroupBox3: TGroupBox;
    LbSpeedButton34: TLbSpeedButton;
    LbSpeedButton39: TLbSpeedButton;
    LbSpeedButton40: TLbSpeedButton;
    LbSpeedButton41: TLbSpeedButton;
    LbSpeedButton42: TLbSpeedButton;
    LbSpeedButton43: TLbSpeedButton;
    LbSpeedButton20: TLbSpeedButton;
    LbSpeedButton21: TLbSpeedButton;
    LbButton1: TLbButton;
    LbButton6: TLbButton;
    Memo3: TMemo;
    LbButton2: TLbButton;
    GroupBox7: TGroupBox;
    LbSpeedButton31: TLbSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LbSpeedButton32: TLbSpeedButton;
    LbSpeedButton33: TLbSpeedButton;
    LbSpeedButton44: TLbSpeedButton;
    LbSpeedButton45: TLbSpeedButton;
    LbSpeedButton46: TLbSpeedButton;
    Memo4: TMemo;
    LbSpeedButton47: TLbSpeedButton;
    LbSpeedButton48: TLbSpeedButton;
    LbSpeedButton49: TLbSpeedButton;
    LbSpeedButton50: TLbSpeedButton;
    LbSpeedButton51: TLbSpeedButton;
    LbSpeedButton52: TLbSpeedButton;
    LbSpeedButton53: TLbSpeedButton;
    LbSpeedButton54: TLbSpeedButton;
    LbSpeedButton55: TLbSpeedButton;
    LbSpeedButton56: TLbSpeedButton;
    LbSpeedButton57: TLbSpeedButton;
    LbSpeedButton58: TLbSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox8: TGroupBox;
    LbSpeedButton59: TLbSpeedButton;
    LbSpeedButton60: TLbSpeedButton;
    LbButton3: TLbButton;
    Button1: TButton;
    LbSpeedButton61: TLbSpeedButton;
    LbSpeedButton62: TLbSpeedButton;
    LbSpeedButton63: TLbSpeedButton;
    Image1: TImage;
    LbSpeedButton64: TLbSpeedButton;
    LbSpeedButton65: TLbSpeedButton;
    LbSpeedButton66: TLbSpeedButton;
    LbSpeedButton67: TLbSpeedButton;
    LbButton4: TLbSpeedButton;
    LbButton5: TLbSpeedButton;
    Memo1: TMemo;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LbSpeedButton1: TLbSpeedButton;
    procedure BtnClick(Sender: TObject);
    procedure LbButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BtnClick(Sender: TObject);
begin
   Notebook1.PageIndex := (Sender as TLbSpeedButton).Tag;
   case (Sender as TLbSpeedButton).Tag of
      0, 1, 2, 3, 5: Panel3.Caption := '  LbSpeedButton - ' + (Sender as TLbSpeedButton).Caption;
      4:             Panel3.Caption := '  LbButton - ' + (Sender as TLbSpeedButton).Caption;
   else
      raise exception.create('Whoops...');
   end;
end;

procedure TForm1.LbButton2Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   with LbSpeedButton64 do begin Glyph := Image1.Picture.Bitmap; NumGlyphs := 4; end;
   with LbSpeedButton65 do begin Glyph := Image1.Picture.Bitmap; NumGlyphs := 4; end;
   with LbSpeedButton66 do begin Glyph := Image1.Picture.Bitmap; NumGlyphs := 4; end;
   with LbSpeedButton67 do begin Glyph := Image1.Picture.Bitmap; NumGlyphs := 4; end;
   with LbButton4 do begin Glyph := Image1.Picture.Bitmap; NumGlyphs := 4; end;
   with LbButton5 do begin Glyph := Image1.Picture.Bitmap; NumGlyphs := 4; end;
end;

end.
