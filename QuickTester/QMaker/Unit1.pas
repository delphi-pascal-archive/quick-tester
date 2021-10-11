unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, ComCtrls, ToolWin, Menus, StdCtrls, Buttons,
  XPMan, zLib;
  
(* ************************************************************************** *)
  const
    sHEADER      = '<HEADER>';
    sENDHEADER   = '</HEADER>';
    sBODY        = '<BODY>';
    sENDBODY     = '</BODY>';
    sQUESTION    = '<QUESTION>';
    sENDQUESTION = '</QUESTION>';
    sANSWER      = '<ANSWER>';
    sENDANSWER   = '</ANSWER>';

    cTESTTITLE   = 'TESTTITLE';
    cTESTAUTHOR  = 'TESTAUTHOR';
    cTESTSUBJECT = 'TESTSUBJECT';

    cTESTDLG     = 'USERDLG';
    cTESTRESAVE  = 'RESAVE';
    cTESTPATH    = 'SAVEPATH';

    cRNDQSTYLE   = 'RNDQSTYLE';
    cTIMEOVER    = 'TIMEOVER';
    cUSELIMIT    = 'USELIMIT';

    cQTIME       = 'QTIME';
    cQLIMIT      = 'QLIMIT';

    c2FOROM      = '2FROM';
    c2TO         = '2TO';
    c3FOROM      = '3FROM';
    c3TO         = '3TO';
    c4FOROM      = '4FROM';
    c4TO         = '4TO';
    c5FOROM      = '5FROM';
    c5TO         = '5TO';

    cQIMAGE      = 'IMAGE';
    cSOUND       = 'SOUND';
    cQUESTION    = 'QUESTION';
    cQTYPE       = 'QTYPE';
    cANSWER      = 'ANSWER';
    cISRIGHT     = 'ISRIGHT';
    cID          = 'ID';

    tTAB         = '    ';
  type
  TQuestionType = (qtRadio, qtCheck, qtPosition, qtEdit);

  type
  TAnsver = Record
    Answer  : String;
    IsRight : Boolean;
    ID      : integer;
  end;
  TAnswersArray = array of TAnsver;

  type
  TQuestion = Record
    qText   : String;
    qImage  : String; //Это НЕХ представление файла картинки
    qSound  : String;
    qType   : TQuestionType;
    Answers : TAnswersArray;
  end;
  TQuestionArray = array of TQuestion;

  type
  TTestBase = Record
    tName        : String;
    tSubject     : String;
    tAuthor      : String;
    //
    tQUseUserDlg : boolean;
    tQResaveRest : boolean;
    tQSavePath   : String; 
    //
    tQRndStyle   : boolean;
    tQTimeOver   : boolean;
    tQUseLimit   : boolean;
    //
    tQTime       : integer;
    tQLimit      : integer;
    //
    tQ2BallsFrom : integer;
    tQ2BallsTo   : integer;
    tQ3BallsFrom : integer;
    tQ3BallsTo   : integer;
    tQ4BallsFrom : integer;
    tQ4BallsTo   : integer;
    tQ5BallsFrom : integer;
    tQ5BallsTo   : integer;
    //
    tQuestions : TQuestionArray;
  end;

  type
  TDoubleParam = Record
    pName  : String;
    pParam : String;        
  end;

  type
  TArchiveHead = packed record
    Signature  : array  [0..3] of char;
  end;
  const
  Signature    = 'test';
(* ************************************************************************** *)

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    ListView1: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ImageList1: TImageList;
    BitBtn8: TBitBtn;
    XPManifest1: TXPManifest;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    procedure ListView1CustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn10Click(Sender: TObject);
  private
    { Private declarations }
  public
    TESTDB  : TTestBase;
    { Public declarations }
  end;

var
  Form1: TForm1;
  NeedNewSave : Boolean = True;
implementation

uses Unit2, Unit4, Unit5, Unit7;
(* ************************************************************************** *)
function Compress_Test(inStream, outStream :TStream; Header: TArchiveHead; const Level : TCompressionLevel = clDefault) : boolean;
begin
  inStream.Seek(0,soFromBeginning);
  outStream.Write(Header,SizeOf(TArchiveHead));
  outStream.Seek(SizeOf(Header),soFromBeginning);
  with TCompressionStream.Create(TCompressionLevel(Level), outStream) do
    try
      CopyFrom(inStream, inStream.Size);
      Free;
      result:=true;
    except
      result:=false;
    end;
end;

function Decompress_Test(const inStream, outStream :TStream; var Header: TArchiveHead):boolean;
  var
  Count: integer;
  ZStream: TDecompressionStream;
  Buffer: array [0..4096] of byte;
begin
  inStream.Seek(0,soFromBeginning);
  inStream.Read(Header,SizeOf(TArchiveHead));
  if Header.Signature <> Signature then
  begin
    Result := False;
    Exit;
  end;
  inStream.Seek(0,SizeOf(TArchiveHead));
  outStream.Seek(0,soFromBeginning);
  ZStream:=TDecompressionStream.Create(InStream);
  try
   while true do
    begin
     Count:=ZStream.Read(Buffer, sizeof(buffer));
     if Count<>0
     then OutStream.WriteBuffer(Buffer, Count)
     else Break;
    end;
    Result:=True;
  Except
    Result:=False;
    ZStream.Free;
  end;
  ZStream.Free;
end;
(* ************************************************************************** *)
function FormatStringToParams(const KeyLine: String; Suffix : Char): TDoubleParam;
var
  tmp,tmp2 : String;
  i : integer;
begin
  tmp   := '';
  tmp2  := '';
  tmp   := Copy(KeyLine, 1, Pos(Suffix,KeyLine)+1);
  tmp2  := Copy(KeyLine, Length(tmp), Length(KeyLine));
  if tmp2 = Suffix then tmp2 := '';
  
  Result.pName := tmp;
  Result.pParam:= tmp2;
end;
(* ************************************************************************** *)
function ReplaseString(InStr,FindStr,ReplaseStr: String) : string;
var
  id  : integer;
  str : string;
begin
  Result := InStr;
  id     := pos(LowerCase(FindStr), LowerCase(InStr));
  str    := InStr;
  Delete(str,id,length(FindStr));
  Insert(ReplaseStr,str,id);
  Result := str;
end;
(* ************************************************************************** *)
function ReplaseAllString(Line, Prefix, Return: String) : String;
var
  tmp  : string;
begin
  tmp := Line;
  while pos(Prefix,tmp) > 0 do
    tmp := ReplaseString(tmp,prefix,return);

  Result := tmp;
end;
(* ************************************************************************** *)
function DeleteSpaces(Line: String) : String;
var
  tmp  : string;
begin
  tmp := Line;
  while pos(' ',tmp) > 0 do
    tmp := ReplaseString(tmp,' ','');
  Result := tmp;
end;
(* ************************************************************************** *)
function StrToHexEx(Str: String): String;
var
  i : integer;
  t : String;
begin
  Result := '';
  t := '';
  for i := 1 to Length(Str) do begin
    t := t + IntToHex(byte(Str[i]),2);
  end;
  Result := t;
end;

function HexToStrEx(Str: String): String;
var
  i : integer;
  t : String;
  s : String;
begin
  Result := '';
  s := '';
  try
    for i := 1 to (Length(Str) div 2) do begin
      t := Str[(i) * 2 - 1] + Str[(i) * 2];
      s := s + chr(strtoint('$'+t));
    end;
  except
  end;
  Result := s;
end;
(* ************************************************************************** *)
function StringToQType(Str: String) : TQuestionType;
begin
  if Str = '0' then Result := qtRadio;
  if Str = '1' then Result := qtCheck;
  if Str = '2' then Result := qtPosition;
  if Str = '3' then Result := qtEdit;
end;

function QTypeToString(QType: TQuestionType) : String;
begin
  case QType of
    qtRadio    : Result := '0';
    qtCheck    : Result := '1';
    qtPosition : Result := '2';
    qtEdit     : Result := '3';
  end;
end;
(* ************************************************************************** *)
Function SaveTestDataBase(DB: TTestBase; FileName: String) : boolean;
var
  i,j  : integer;
  List : TStringList;
  F,X  : TMemoryStream;
  h    : TArchiveHead;
begin
  List := TStringList.Create;
  //
  List.Add(sHEADER);

  List.Add(tTAB+cTESTTITLE  +'='+StrToHexEx(DB.tName));
  List.Add(tTAB+cTESTSUBJECT+'='+StrToHexEx(DB.tSubject));
  List.Add(tTAB+cTESTAUTHOR +'='+StrToHexEx(DB.tAuthor));

  List.Add(tTAB+cTESTDLG+'='+BoolToStr(Form4.CheckBox4.Checked,True));
  List.Add(tTAB+cTESTRESAVE+'='+BoolToStr(Form4.CheckBox5.Checked,True));
  List.Add(tTAB+cTESTPATH+'='+Form4.Edit4.Text);

  List.Add(tTAB+cRNDQSTYLE+'='+BoolToStr(Form4.CheckBox1.Checked,True));
  List.Add(tTAB+cTIMEOVER +'='+BoolToStr(Form4.CheckBox2.Checked,True));
  List.Add(tTAB+cUSELIMIT +'='+BoolToStr(Form4.CheckBox3.Checked,True));

  List.Add(tTAB+cQTIME +'='+IntToStr(Form4.SpinEdit1.Value));
  List.Add(tTAB+cQLIMIT+'='+IntToStr(Form4.SpinEdit2.Value));

  List.Add(tTAB+c2FOROM+'='+IntToStr(Form4.SpinEdit3.Value));
  List.Add(tTAB+c2TO   +'='+IntToStr(Form4.SpinEdit4.Value));
  List.Add(tTAB+c3FOROM+'='+IntToStr(Form4.SpinEdit5.Value));
  List.Add(tTAB+c3TO   +'='+IntToStr(Form4.SpinEdit6.Value));
  List.Add(tTAB+c4FOROM+'='+IntToStr(Form4.SpinEdit7.Value));
  List.Add(tTAB+c4TO   +'='+IntToStr(Form4.SpinEdit8.Value));
  List.Add(tTAB+c5FOROM+'='+IntToStr(Form4.SpinEdit9.Value));
  List.Add(tTAB+c5TO   +'='+IntToStr(Form4.SpinEdit10.Value));

  List.Add(sHEADER);
  //
  for i := 0 to Length(DB.tQuestions)-1 do begin
    List.Add(sQUESTION);
    //
    List.Add(tTAB+cQUESTION+'='+StrToHexEx(DB.tQuestions[i].qText));
    List.Add(tTAB+cQTYPE   +'='+QTypeToString(DB.tQuestions[i].qType));
    List.Add(tTAB+cQIMAGE  +'='+DB.tQuestions[i].qImage);
    List.Add(tTAB+cSOUND   +'='+DB.tQuestions[i].qSound);
    for j := 0 to Length(DB.tQuestions[i].Answers)-1 do begin
      List.Add(tTAB+tTAB+sANSWER);
      //
      List.Add(tTAB+tTAB+tTAB+cANSWER +'='+StrToHexEx(DB.tQuestions[i].Answers[j].Answer));
      List.Add(tTAB+tTAB+tTAB+cISRIGHT+'='+BoolToStr(DB.tQuestions[i].Answers[j].IsRight,True));
      List.Add(tTAB+tTAB+tTAB+cID     +'='+Inttostr(DB.tQuestions[i].Answers[j].ID));
      //
      List.Add(tTAB+tTAB+sENDANSWER);
    end;
    //
    List.Add(sENDQUESTION);
  end;
  //
  //List.Text := StrToHexEx(List.Text);
  {}
  F := TMemoryStream.Create;
  X := TMemoryStream.Create;
  h.Signature := Signature;
  List.SaveToStream(F);
  Compress_Test(F,X,H,clFastest);
  {}
  //List.SaveToFile(FileName);
  X.SaveToFile(FileName);
  {}
  List.Free;
end;
(* ************************************************************************** *)
function LoadTestDataBase(FileName: String; var TestDB: TTestBase) : boolean;
var
  i   : integer;
  Q   : boolean;
  A   : boolean;
  DB  : TStringList;
  F   : TMemoryStream;
  F1  : TMemoryStream;
  h   : TArchiveHead;
begin
  Result := false;
  Finalize(TestDB.tQuestions);
  Finalize(TestDB);
  DB := TStringList.Create;
  //
  F  := TMemoryStream.Create;
  F1 := TMemoryStream.Create;
  F.LoadFromFile(FileName);
  if not Decompress_Test(F,F1,H) then Exit;
  //
  //DB.LoadFromFile(FileName);
  F1.Seek(0,soFromBeginning);
  DB.LoadFromStream(F1);
  F.Free;
  F1.Free;
  //DB.Text := HexToStrEx(DB.Text);
  for i := 0 to DB.Count-1 do
    DB[i] := DeleteSpaces(DB[i]);
  //
  A := False;
  Q := False;
  //Showmessage('UnPk =)');
try
  for i := 0 to DB.Count-1 do begin

    if Pos(cTESTTITLE,DB[i])   <> 0 then
      TestDB.tName    := HexToStrEx(FormatStringToParams(DB[i],'=').pParam);
    if Pos(cTESTAUTHOR,DB[i])  <> 0 then
      TestDB.tAuthor  := HexToStrEx(FormatStringToParams(DB[i],'=').pParam);
    if Pos(cTESTSUBJECT,DB[i]) <> 0 then
      TestDB.tSubject := HexToStrEx(FormatStringToParams(DB[i],'=').pParam);

    if Pos(cTESTDLG,DB[i])    <> 0 then
      TestDB.tQUseUserDlg := StrToBool(FormatStringToParams(DB[i],'=').pParam);
    if Pos(cTESTRESAVE,DB[i]) <> 0 then
      TestDB.tQResaveRest := StrToBool(FormatStringToParams(DB[i],'=').pParam);
    if Pos(cTESTPATH,DB[i]) <> 0 then
      TestDB.tQSavePath   := FormatStringToParams(DB[i],'=').pParam;

    if Pos(cRNDQSTYLE,DB[i]) <> 0 then
      TestDB.tQRndStyle := StrToBool(FormatStringToParams(DB[i],'=').pParam);
    if Pos(cTIMEOVER,DB[i])  <> 0 then
      TestDB.tQTimeOver := StrToBool(FormatStringToParams(DB[i],'=').pParam);
    if Pos(cUSELIMIT,DB[i])  <> 0 then
      TestDB.tQUseLimit := StrToBool(FormatStringToParams(DB[i],'=').pParam);

    if Pos(cQTIME,DB[i])  <> 0 then
      TestDB.tQTime := StrToInt(FormatStringToParams(DB[i],'=').pParam);
    if Pos(cQLIMIT,DB[i])  <> 0 then
      TestDB.tQLimit := StrToInt(FormatStringToParams(DB[i],'=').pParam);
      
    if Pos(c2FOROM,DB[i])  <> 0 then
      TestDB.tQ2BallsFrom := StrToInt(FormatStringToParams(DB[i],'=').pParam);
    if Pos(c2TO,DB[i])     <> 0 then
      TestDB.tQ2BallsTo   := StrToInt(FormatStringToParams(DB[i],'=').pParam);

    if Pos(c3FOROM,DB[i])  <> 0 then
      TestDB.tQ3BallsFrom := StrToInt(FormatStringToParams(DB[i],'=').pParam);
    if Pos(c3TO,DB[i])     <> 0 then
      TestDB.tQ3BallsTo   := StrToInt(FormatStringToParams(DB[i],'=').pParam);

    if Pos(c4FOROM,DB[i])  <> 0 then
      TestDB.tQ4BallsFrom := StrToInt(FormatStringToParams(DB[i],'=').pParam);
    if Pos(c4TO,DB[i])     <> 0 then
      TestDB.tQ4BallsTo   := StrToInt(FormatStringToParams(DB[i],'=').pParam);

    if Pos(c5FOROM,DB[i])  <> 0 then
      TestDB.tQ5BallsFrom := StrToInt(FormatStringToParams(DB[i],'=').pParam);
    if Pos(c5TO,DB[i])     <> 0 then
      TestDB.tQ5BallsTo   := StrToInt(FormatStringToParams(DB[i],'=').pParam);
    //Question
    if Pos(sENDQUESTION,DB[i]) <> 0 then begin
      Q := False;
      A := False;
    end;
    if Pos(sQUESTION,DB[i]) <> 0 then begin
      Q := True;
      A := False;
      SetLength(TestDB.tQuestions,Length(TestDB.tQuestions)+1);
    end;
    if Q then begin
      if Pos(cQUESTION,DB[i]) <> 0 then
        TestDB.tQuestions[Length(TestDB.tQuestions)-1].qText  :=HexToStrEx(FormatStringToParams(DB[i],'=').pParam);
      if Pos(cQTYPE,DB[i]) <> 0 then
        TestDB.tQuestions[Length(TestDB.tQuestions)-1].qType  := StringToQType(FormatStringToParams(DB[i],'=').pParam);
      if Pos(cSOUND,DB[i]) <> 0 then {new}
        TestDB.tQuestions[Length(TestDB.tQuestions)-1].qSound := FormatStringToParams(DB[i],'=').pParam;
      if Pos(cQIMAGE,DB[i]) <> 0 then
        TestDB.tQuestions[Length(TestDB.tQuestions)-1].qImage := FormatStringToParams(DB[i],'=').pParam;
      //Answer
      if Pos(sENDANSWER,DB[i]) <> 0 then A := False;
      if Pos(sANSWER,DB[i]) <> 0 then begin
        A := True;
        SetLength(TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers,Length(TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers)+1);
      end;
      if A then begin
        if Pos(cANSWER,DB[i]) <> 0 then
          TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers[Length(TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers)-1].Answer  := HexToStrEx(FormatStringToParams(DB[i],'=').pParam);
        if Pos(cISRIGHT,DB[i]) <> 0 then
          TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers[Length(TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers)-1].IsRight := StrToBool(FormatStringToParams(DB[i],'=').pParam);
        if Pos(cID,DB[i]) <> 0 then
          TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers[Length(TestDB.tQuestions[Length(TestDB.tQuestions)-1].Answers)-1].ID      := StrToInt(FormatStringToParams(DB[i],'=').pParam);
      end;
    end;
  end;
except
  Result := False;
  DB.Free;
  Exit;
end;
  //
  DB.Free;
  Result := true;
  if Length(TestDB.tQuestions) <= 0 then Result := false;
end;
(* ************************************************************************** *)
procedure DeleteArrayIndex(var X: TQuestionArray; Index: Integer);
begin
  if Index > High(X) then Exit;
  if Index < Low(X) then Exit;
  if Index = High(X) then
  begin
    SetLength(X, Length(X) - 1);
    Exit;
  end;
  Finalize(X[Index]);
  System.Move(X[Index +1], X[Index],
  (Length(X) - Index -1) * SizeOf(string) + 1);
  SetLength(X, Length(X) - 1);
end;


{$R *.dfm}

procedure TForm1.ListView1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  ListView1.Canvas.Brush.Style := bsClear;
  ListView1.Canvas.TextOut(0,0,' ');
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  Form2.QuestionEdit := False;
  Form2.CheckBox1.Checked := false;
  Form2.CheckBox2.Checked := false;
  Form2.ImageBuffer := '';
  Form2.WAVBuffer := '';
  Form2.Memo1.Text := 'Введите текст вопроса...';
  Form2.TabSheet1.Show;
  Form2.BitBtn1.Caption :='Ответы';
  Form2.ListView1.Clear;
  Form2.RadioGroup1.ItemIndex := 0;
  Form2.ShowModal;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Finalize(TestDB.tQuestions);
  Finalize(TestDB);
  ListView1.Clear;
  //
  NeedNewSave := True;
  //
  TESTDB.tName        := 'Новый тест';
  TESTDB.tSubject     := '';
  TESTDB.tAuthor      := '';
  TESTDB.tQRndStyle   := False;
  TESTDB.tQTimeOver   := False;
  TESTDB.tQUseLimit   := False;
  TESTDB.tQTime       := 0;
  TESTDB.tQLimit      := 0;
  TESTDB.tQ2BallsFrom := 0;
  TESTDB.tQ2BallsTo   := 0;
  TESTDB.tQ3BallsFrom := 0;
  TESTDB.tQ3BallsTo   := 0;
  TESTDB.tQ4BallsFrom := 0;
  TESTDB.tQ4BallsTo   := 0;
  TESTDB.tQ5BallsFrom := 0;
  TESTDB.tQ5BallsTo   := 0;
  //
  //BitBtn4.Enabled     := True;
  BitBtn5.Enabled     := True;
  BitBtn6.Enabled     := True;
  BitBtn7.Enabled     := True;
  BitBtn8.Enabled     := True;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
var
  i : integer;
begin
  if ListView1.ItemIndex < 0 then exit;
  //
  Form2.QuestionEdit := True;
  Form2.QuestionID   := ListView1.ItemIndex;
  Form2.TabSheet1.Show;
  Form2.BitBtn1.Caption :='Ответы';
  Form2.ListView1.Clear;

  Form2.ImageBuffer := '';
  Form2.WAVBuffer   := '';

  Form2.Memo1.Text  := TESTDB.tQuestions[ListView1.ItemIndex].qText;
  Form2.ImageBuffer := TESTDB.tQuestions[ListView1.ItemIndex].qImage;
  Form2.WAVBuffer   := TESTDB.tQuestions[ListView1.ItemIndex].qSound;
  
  if Form2.ImageBuffer <> '' then
    Form2.CheckBox1.Checked := True else Form2.CheckBox1.Checked := false;

  if Form2.WAVBuffer <> '' then
    Form2.CheckBox2.Checked := True else Form2.CheckBox2.Checked := false;

  case TESTDB.tQuestions[ListView1.ItemIndex].qType of
    qtRadio    : Form2.RadioGroup1.ItemIndex := 0;
    qtCheck    : Form2.RadioGroup1.ItemIndex := 1;
    qtPosition : Form2.RadioGroup1.ItemIndex := 2;
    qtEdit     : Form2.RadioGroup1.ItemIndex := 3;
  end;
  if Length(TESTDB.tQuestions[ListView1.ItemIndex].Answers) <> 0 then
    for i := 0 to Length(TESTDB.tQuestions[ListView1.ItemIndex].Answers)-1 do
    begin
      with Form2.ListView1.Items.Add do begin
        Caption := TESTDB.tQuestions[ListView1.ItemIndex].Answers[i].Answer;
        if TESTDB.tQuestions[ListView1.ItemIndex].Answers[i].IsRight then
          ImageIndex := 1 else ImageIndex := 0;
        if TESTDB.tQuestions[ListView1.ItemIndex].Answers[i].IsRight then
          SubItems.Add('Верный') else SubItems.Add('Не верный');
        SubItems.Add(inttostr(TESTDB.tQuestions[ListView1.ItemIndex].Answers[i].ID));
      end;
    end;
  Form2.ShowModal;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
{  if ListView1.ItemIndex < 0 then Exit;
  
  DeleteArrayIndex(TESTDB.tQuestions,ListView1.ItemIndex);
  ListView1.DeleteSelected;

  Form1.BitBtn4.Enabled := True; }
  ShowMessage('Данная функция в данной версии недоступна.');
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
begin
  if ListView1.ItemIndex < 0 then begin
    BitBtn6.Click;
  end else begin
    BitBtn8.Click;
  end;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  if NeedNewSave then
  if not SaveDialog1.Execute then exit;
    SaveTestDataBase(TESTDB,SaveDialog1.FileName);
    BitBtn4.Enabled := False;
    NeedNewSave := False;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  Form4.Edit1.Text := TESTDB.tName;
  Form4.Edit2.Text := TESTDB.tSubject;
  Form4.Edit3.Text := TESTDB.tAuthor;
  //
  Form4.CheckBox1.Checked := TESTDB.tQRndStyle;
  Form4.CheckBox2.Checked := TESTDB.tQTimeOver;
  Form4.CheckBox3.Checked := TESTDB.tQUseLimit;
  Form4.CheckBox4.Checked := TESTDB.tQUseUserDlg;
  Form4.CheckBox5.Checked := TESTDB.tQResaveRest;

  Form4.Edit4.Text      := TESTDB.tQSavePath;
  //
  Form4.SpinEdit1.Value := TESTDB.tQTime;
  Form4.SpinEdit2.Value := TESTDB.tQLimit;
  //
  Form4.SpinEdit3.Value := TESTDB.tQ2BallsFrom;
  Form4.SpinEdit4.Value := TESTDB.tQ2BallsTo;
  Form4.SpinEdit5.Value := TESTDB.tQ3BallsFrom;
  Form4.SpinEdit6.Value := TESTDB.tQ3BallsTo;
  Form4.SpinEdit7.Value := TESTDB.tQ4BallsFrom;
  Form4.SpinEdit8.Value := TESTDB.tQ4BallsTo;
  Form4.SpinEdit9.Value := TESTDB.tQ5BallsFrom;
  Form4.SpinEdit10.Value := TESTDB.tQ5BallsTo;
  //
  Form4.ShowModal;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i: integer;
begin
  if not OpenDialog1.Execute then exit;

  if LoadTestDataBase(OpenDialog1.FileName ,TESTDB) then begin
    ListView1.Items.Clear;
    for i := 0 to Length(TESTDB.tQuestions)-1 do
      with ListView1.Items.Add do
        Caption := 'Вопрос №'+inttostr(i);

    BitBtn5.Enabled     := True;
    BitBtn6.Enabled     := True;
    BitBtn7.Enabled     := True;
    BitBtn8.Enabled     := True;
    NeedNewSave         := True;
    {!}
    Form4.Edit1.Text        := TESTDB.tName;
    Form4.Edit2.Text        := TESTDB.tSubject;
    Form4.Edit3.Text        := TESTDB.tAuthor;
    Form4.CheckBox1.Checked := TESTDB.tQRndStyle;
    Form4.CheckBox2.Checked := TESTDB.tQTimeOver;
    Form4.CheckBox3.Checked := TESTDB.tQUseLimit;
    Form4.CheckBox4.Checked := TESTDB.tQUseUserDlg;
    Form4.CheckBox5.Checked := TESTDB.tQResaveRest;
    Form4.Edit4.Text        := TESTDB.tQSavePath;
    Form4.SpinEdit1.Value   := TESTDB.tQTime;
    Form4.SpinEdit2.Value   := TESTDB.tQLimit;
    Form4.SpinEdit3.Value   := TESTDB.tQ2BallsFrom;
    Form4.SpinEdit4.Value   := TESTDB.tQ2BallsTo;
    Form4.SpinEdit5.Value   := TESTDB.tQ3BallsFrom;
    Form4.SpinEdit6.Value   := TESTDB.tQ3BallsTo;
    Form4.SpinEdit7.Value   := TESTDB.tQ4BallsFrom;
    Form4.SpinEdit8.Value   := TESTDB.tQ4BallsTo;
    Form4.SpinEdit9.Value   := TESTDB.tQ5BallsFrom;
    Form4.SpinEdit10.Value  := TESTDB.tQ5BallsTo;
    {!}
  end else
    MessageDlg('Произошла ошибка при загрузке файла теста.'
               +#13#10+
               'Данный файл не является файлом тестирования QuickTester'
               ,mtInformation,[mbOk],0);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
  Form5.Showmodal;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if BitBtn4.Enabled then begin
    if MessageDlg('Измененные данные не будут сохранены. Вы уверены что хотите выйти?',mtInformation,[mbYes,mbNo],0) = 7 then Action := caNone;
  end;
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
var
  L    : TStringList;
  F,F1 : TMemoryStream;
  H    : TArchiveHead;
begin
  if OpenDialog1.Execute then begin
    L := TStringList.Create;
    {!}
    F  := TMemoryStream.Create;
    F1 := TMemoryStream.Create;
    F.LoadFromFile(OpenDialog1.FileName);
    if not Decompress_Test(F,F1,H) then Exit;
    F1.Seek(0,soFromBeginning);
    L.LoadFromStream(F1);
    F.Free;
    F1.Free;
    Form7.Memo1.Lines.BeginUpdate;
    Form7.Memo1.Text := {HexToStrEx(}L.Text{)};
    Form7.Memo1.Lines.EndUpdate;
    L.Free;
    Form7.ShowModal;
  end;
end;

end.
