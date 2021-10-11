unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, Menus, ImgList, MPlayer, jpeg;

type
  TForm2 = class(TForm)
    Bevel1: TBevel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    ListView1: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ImageList1: TImageList;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    SpeedButton1: TSpeedButton;
    OpenDialog2: TOpenDialog;
    CheckBox2: TCheckBox;
    MediaPlayer1: TMediaPlayer;
    procedure ListView1CustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    QuestionEdit : Boolean;
    QuestionID   : integer;
    ImageBuffer  : String;
    WAVBuffer    : String;
    { Public declarations }
  end;

var
  Form2: TForm2;
implementation

uses Unit3, Unit1, Unit5, Unit6;

{$R *.dfm}
Function ConvertFileToBuffer(FileName: String) : String;
var
  i: integer;
  buf: array of byte;
  fs: tMemoryStream;
begin
  fs := TMemoryStream.Create;
  fs.LoadFromFile(FileName);
  SetLength(buf,fs.size);
  fs.Read(buf[0],fs.Size);
  fs.Free;
  Result := '';
  for i := 0 to length(buf)-1 do
    Result := Result + inttohex(buf[i],2);
  Finalize(buf);
end;

{Function ConvertBufferToFile(Buffer :String; FileName: String) : boolean;
var
  i: integer;
  buf: array of byte;
  fs: tMemoryStream;
  tmp: string;
begin
  Result := True;
  SetLength(buf, length(Buffer) div 2);
  for i := 1 to (Length(Buffer) div 2) do
    buf[i] := strtoint('$'+Buffer[(i) * 2 - 1] + Buffer[(i) * 2]);
  try
    fs := TMemoryStream.Create;
    fs.Write(buf[1],length(buf));
    fs.SaveToFile(FileName);
  except
    Result := false;
  end;
  fs.Free;
  Finalize(buf);
end; }

function G_HexToUInt(const S: string): byte;
const
  ErrorMessage: string = '';
asm
        PUSH    ESI
        PUSH    EBX
        MOV     ESI,EAX
        TEST    EAX,EAX
        JE      @@err
        MOV     ECX,[EAX-4]
        TEST    ECX,ECX
        JE      @@err
        MOV     EBX,EAX
        XOR     EAX,EAX
@@lp:   MOV     DL,BYTE PTR [EBX]
        SHL     EAX,4
        SUB     DL,$30
        JB      @@err
        CMP     DL,$09
        JBE     @@ct
        SUB     DL,$11
        JB      @@err
        CMP     DL,$05
        JBE     @@pt
        SUB     DL,$20
        JB      @@err
        CMP     DL,$05
        JA      @@err
@@pt:   ADD     DL,$0A
@@ct:   OR      AL,DL
        INC     EBX
        DEC     ECX
        JNE     @@lp
        POP     EBX
        POP     ESI
        RET
@@err:  MOV     EAX,ErrorMessage
        MOV     EDX,ESI
        POP     EBX
        POP     ESI
end;

Function GetBufferEXT(const Buffer: String): String;
var
  tmp  : string;
  tmp2 : string;
begin
  if (Buffer = '') or (Length(Buffer) < 6) then exit;
  tmp  := UpperCase(copy(Buffer, 1,6));
  tmp2 := UpperCase(copy(Buffer, 1,4));

  if tmp  = 'FFD8FF' then Result := '.jpg' else
  if tmp  = '424D66' then Result := '.bmp' else
  if tmp2 = '424D'   then Result := '.bmp' else
  if tmp  = '524946' then Result := '.wav' else Result := '.mp3';
{FFD8FF - jpg
424D66 - bmp
524946 - wav
other  - mp3}
end;

Function ConvertBufferToFile(const Buffer :PString; FileName: String) : boolean;
type
  TBuffer = array of byte;
var
  i   : integer;
  buf : ^TBuffer;
  fs  : tMemoryStream;
  byt : byte;
begin
  Result := True;
  new(buf);
  SetLength(buf^, length((Buffer^)) div 2);
  for i := 1 to (Length((Buffer^)) div 2) do
    buf^[i] := G_HexToUInt((Buffer)^[(i) * 2 - 1] + (Buffer)^[(i) * 2]);
  try
    fs := TMemoryStream.Create;
    fs.Write(buf^[1],length(buf^));
    fs.SaveToFile(FileName);
  except
    fs.Free;
    Finalize(BUF);
    FreeMemory(buf);
    Result := false;
  end;     
  fs.Free;
  Finalize(BUF^);
  FreeMem(buf);
end; 

procedure TForm2.ListView1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  ListView1.Canvas.Brush.Style := bsClear;
  ListView1.Canvas.TextOut(0,0,' ');
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  if TabSheet1.Visible then begin
    TabSheet2.Show;
    BitBtn1.Caption := 'Вопрос';
  end else begin
    TabSheet1.Show;
    BitBtn1.Caption := 'Ответы';
  end;
end;

procedure TForm2.N1Click(Sender: TObject);
begin
  Form3.AnswerEdit := False;
  Form3.Memo1.Text := 'Введите текст ответа...';
  Form3.CheckBox1.Checked := False;
  Form3.SpinEdit1.Value := 0;
  Form3.ShowModal;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
  ListView1.DeleteSelected;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  i : integer;
begin
  if not QuestionEdit then begin
    SetLength(Form1.TESTDB.tQuestions,length(Form1.TESTDB.tQuestions)+1);
    {}
    Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qText  := '';
    Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qImage := '';
    Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qSound := '';
    Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qType  := qtRadio; 
    {}
    Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qText := Memo1.Text;
    case RadioGroup1.ItemIndex of
      0 : Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qType := qtRadio;
      1 : Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qType := qtCheck;
      2 : Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qType := qtPosition;
      3 : Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qType := qtEdit;
    end;
    {}
    if CheckBox1.Checked then
      Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qImage := ImageBuffer;
    if CheckBox2.Checked then
      Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].qSound := WAVBuffer;
    {}
    for i := 0 to ListView1.Items.Count-1 do begin
      SetLength(Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers,length(Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers)+1);
      {}
      Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers[i].Answer   := '';
      Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers[i].IsRight  := False;
      Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers[i].ID       := -1;
      {}
      Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers[i].Answer  := ListView1.Items.Item[i].Caption;
      if ListView1.Items.Item[i].ImageIndex = 0 then
        Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers[i].IsRight := False;
      if ListView1.Items.Item[i].ImageIndex = 1 then
        Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers[i].IsRight := true;
      Form1.TESTDB.tQuestions[length(Form1.TESTDB.tQuestions)-1].Answers[i].ID := Strtoint(ListView1.Items.Item[i].SubItems[1]);
    end;
    with Form1.ListView1.Items.Add do begin
      Caption := 'Вопрос №'+inttostr(length(Form1.TESTDB.tQuestions)-1);
      ImageIndex := 0;
    end;
  end else begin
    Form1.TESTDB.tQuestions[QuestionID].qText := Memo1.Text;
    Finalize(Form1.TESTDB.tQuestions[QuestionID].Answers);
    SetLength(Form1.TESTDB.tQuestions[QuestionID].Answers,0);
    case RadioGroup1.ItemIndex of
      0 : Form1.TESTDB.tQuestions[QuestionID].qType := qtRadio;
      1 : Form1.TESTDB.tQuestions[QuestionID].qType := qtCheck;
      2 : Form1.TESTDB.tQuestions[QuestionID].qType := qtPosition;
      3 : Form1.TESTDB.tQuestions[QuestionID].qType := qtEdit;
    end;
    Form1.TESTDB.tQuestions[QuestionID].qImage := ImageBuffer;
    Form1.TESTDB.tQuestions[QuestionID].qSound := WAVBuffer;
    for i := 0 to ListView1.Items.Count-1 do begin
      SetLength(Form1.TESTDB.tQuestions[QuestionID].Answers,length(Form1.TESTDB.tQuestions[QuestionID].Answers)+1);
      Form1.TESTDB.tQuestions[QuestionID].Answers[i].Answer  := ListView1.Items.Item[i].Caption;
      if ListView1.Items.Item[i].ImageIndex = 0 then
       Form1.TESTDB.tQuestions[QuestionID].Answers[i].IsRight := False;
      if ListView1.Items.Item[i].ImageIndex = 1 then
        Form1.TESTDB.tQuestions[QuestionID].Answers[i].IsRight := true;
      Form1.TESTDB.tQuestions[QuestionID].Answers[i].ID := Strtoint(ListView1.Items.Item[i].SubItems[1]);
    end;
  end;
  //
  Form1.BitBtn4.Enabled := True;
  //
  Close;
end;

procedure TForm2.N4Click(Sender: TObject);
begin
  if ListView1.ItemIndex < 0 then Exit;

  Form3.AnswerEdit := True;
  Form3.AnswerID   := ListView1.ItemIndex;
  Form3.Memo1.Text := ListView1.Selected.Caption;
  if ListView1.Selected.ImageIndex = 0 then
    Form3.CheckBox1.Checked := False
  else
    Form3.CheckBox1.Checked := True;

  Form3.SpinEdit1.Value := strtoint(ListView1.Selected.SubItems[1]);

  Form3.ShowModal;
end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  if Form2.Visible then
  if not CheckBox1.Checked then ImageBuffer := '' else
    if OpenDialog1.Execute then
      ImageBuffer := ConvertFileToBuffer(OpenDialog1.FileName) else CheckBox1.Checked := false;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  ext : string;
begin
  ext := GetBufferEXT(ImageBuffer);
  if CheckBox1.Checked then
    if ConvertBufferToFile(@ImageBuffer,ExtractFilePath(paramstr(0))+'image'+ext) then
    begin
      Form6.Image1.Picture.LoadFromFile(ExtractFilePath(paramstr(0))+'image'+ext);
      DeleteFile(ExtractFilePath(paramstr(0))+'image'+ext);
      Form6.ShowModal;
    end;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
var
  ext : string;
begin
  ext := GetBufferEXT(WAVBuffer);
  if CheckBox2.Checked then
    if ConvertBufferToFile(@WAVBuffer,ExtractFilePath(paramstr(0))+'sound'+ext) then
    begin
      try
        MediaPlayer1.FileName := ExtractFilePath(paramstr(0))+'sound'+ext;
        MediaPlayer1.Open;
        MediaPlayer1.Play;
        ShowMessage('Идет воспроизведение мелодии...');
        MediaPlayer1.Stop;
        MediaPlayer1.Close;
      except
        MediaPlayer1.Close;
        DeleteFile(ExtractFilePath(paramstr(0))+'sound'+ext);
      end;
    end;
end;

procedure TForm2.CheckBox2Click(Sender: TObject);
begin
  if Form2.Visible then
  if not CheckBox2.Checked then ImageBuffer := '' else
    if OpenDialog2.Execute then
      WAVBuffer := ConvertFileToBuffer(OpenDialog2.FileName) else CheckBox2.Checked := false;
end;

end.
