unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, XPMan, MPlayer, zLib,
  LbSpeedButton, pngimage;
  
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

    cRNDQSTYLE   = 'RNDQSTYLE';
    cTIMEOVER    = 'TIMEOVER';
    cUSELIMIT    = 'USELIMIT';

    cTESTDLG     = 'USERDLG';
    cTESTRESAVE  = 'RESAVE';
    cTESTPATH    = 'SAVEPATH';

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
    qImage  : String;
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
    tQRndStyle   : boolean;
    tQTimeOver   : boolean;
    tQUseLimit   : boolean;
    //
    tQUseUserDlg : boolean;
    tQResaveRest : boolean;
    tQSavePath   : String; 
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
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer1: TTimer;
    Image2: TImage;
    BitBtn6: TBitBtn;
    OpenDialog1: TOpenDialog;
    TabSheet3: TTabSheet;
    Panel5: TPanel;
    XPManifest1: TXPManifest;
    BitBtn7: TBitBtn;
    Timer2: TTimer;
    MediaPlayer1: TMediaPlayer;
    Image3: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label3: TLabel;
    Image12: TImage;
    ScrollBox1: TScrollBox;
    Panel6: TPanel;
    Image4: TImage;
    BitBtn5: TLbSpeedButton;
    BitBtn8: TLbSpeedButton;
    BitBtn9: TLbSpeedButton;
    Panel4: TPanel;
    Bevel2: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Image5: TImage;
    Image6: TImage;
    Label10: TLabel;
    Bevel7: TBevel;
    Bevel6: TBevel;
    Bevel5: TBevel;
    Bevel4: TBevel;
    Bevel3: TBevel;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image22: TImage;
    Image23: TImage;
    Label17: TLabel;
    Image21: TImage;
    Label18: TLabel;
    procedure FormResize(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
  private
    { Private declarations }
  public
    TESTDB  : TTestBase;
    procedure UpAnswerBtn(Sender: TObject);
    { Public declarations }
  end;

var
  Form1: TForm1;
  
  LastNum      : integer;
  QuestionLine : array [0..10000] of boolean;
  QuestionTime : integer;

  QuestionNum  : integer;
  RightAnswers : integer;

  NowAnswers   : TAnswersArray;
  ImageBuffer  : String = '';
  WAVBuffer    : String = '';

  StrAnswer    : String = '';
implementation

uses Unit2, Unit3, Unit4, Unit5, Unit6, Unit7;
(* ************************************************************************** *)
function Compress_Test(inStream, outStream :TStream; Header: TArchiveHead) : boolean;
begin
  inStream.Seek(0,soFromBeginning);
  outStream.Write(Header,SizeOf(TArchiveHead));
  outStream.Seek(SizeOf(Header),soFromBeginning);
  with TCompressionStream.Create(zLib.TCompressionLevel(clDefault), outStream) do
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

  form4.ProgressBar1.Max := inStream.Size;
  form4.ProgressBar1.Position := 0;
  form4.Label2.Caption := 'Распаковка теста...';

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
     form4.ProgressBar1.Position := form4.ProgressBar1.Position + count;
     form4.ProgressBar1.Update;
     form4.Panel1.Update;
//     Application.ProcessMessages;
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
  //
  Form4.show;
  form1.Update;
  //
  if not Decompress_Test(F,F1,H) then begin
    Form4.hide;
    Exit;
  end;
  //
  //DB.LoadFromFile(FileName);
  F1.Seek(0,soFromBeginning);
  DB.LoadFromStream(F1);
  F.Free;
  F1.Free;
  //DB.Text := HexToStrEx(DB.Text);
  form4.ProgressBar1.Max := Db.Count-1;
  form4.ProgressBar1.Position := 0;
  form4.Label2.Caption := 'Загрузка тестового файла...';
  //
  for i := 0 to DB.Count-1 do
    DB[i] := DeleteSpaces(DB[i]);
  //
  A := False;
  Q := False;
  TestDB.tQUseUserDlg := False;
try
  for i := 0 to DB.Count-1 do begin

    form4.ProgressBar1.Position := i;
    form4.Panel1.Update;

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
      TestDB.tQuestions[Length(TestDB.tQuestions)-1].qSound := '';
      TestDB.tQuestions[Length(TestDB.tQuestions)-1].qImage := '';
    end;
    if Q then begin
      if Pos(cQUESTION,DB[i]) <> 0 then
        TestDB.tQuestions[Length(TestDB.tQuestions)-1].qText  :=HexToStrEx(FormatStringToParams(DB[i],'=').pParam);
      if Pos(cQTYPE,DB[i]) <> 0 then
        TestDB.tQuestions[Length(TestDB.tQuestions)-1].qType  := StringToQType(FormatStringToParams(DB[i],'=').pParam);
      if Pos(cSOUND,DB[i]) <> 0 then begin
        TestDB.tQuestions[Length(TestDB.tQuestions)-1].qSound := FormatStringToParams(DB[i],'=').pParam;
      end;
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
  Form4.hide;
  Exit;
end;
  //
  Form4.hide;
  DB.Free;
  Result := true;
  if Length(TestDB.tQuestions) <= 0 then Result := false;
end;
(* ************************************************************************** *)
Procedure CreateRadioAnswer(Ps: integer; Answer: String; Id: integer; Right: Boolean; Name: integer);
var
  C: TRadioButton;
  L: TLabel;
begin
  C := TRadioButton.Create(Form1.ScrollBox1);
  C.Parent        := Form1.ScrollBox1;
  C.Name          := 'Otvet'+inttostr(Name);
  C.Width         := 16;
  C.Top           := Ps-2;

  if Right then
  C.Tag := 1 else C.Tag := 0;

  C.Left          := 14;
  C.Color         := clWhite;
  C.Checked       := False;

  L := TLabel.Create(Form1.ScrollBox1);
  L.Parent        := Form1.ScrollBox1;
  L.Top           := Ps - 17;
  L.Left          := 35;
  L.Width         := Form1.ScrollBox1.Width - 45;
  L.Height        := 45;
  L.Anchors       := L.Anchors+ [akLeft]+[akRight];
  L.AutoSize      := False;
  L.WordWrap      := true;
  L.Transparent   := True;
  L.Caption       := Answer;
  L.Layout        := tlCenter;
  Form1.ScrollBox1.Repaint;
  Application.ProcessMessages;
end;
(* ************************************************************************** *)
Procedure CreateCheckAnswer(Ps: integer; Answer: String; Id: integer; Right: Boolean; Name: integer);
var
  C: TCheckBox;
  L: TLabel;
begin
  C := TCheckBox.Create(Form1.ScrollBox1);
  C.Parent        := Form1.ScrollBox1;
  C.Name          := 'Otvet'+inttostr(Name);
  C.Width         := 16;
  C.Top           := Ps-2;

  if Right then
  C.Tag := 1 else C.Tag := 0;

  C.Left          := 14;
  C.Color         := clWhite;
  C.Checked       := False;

  L := TLabel.Create(Form1.ScrollBox1);
  L.Parent        := Form1.ScrollBox1;
  L.Top           := Ps - 17;
  L.Left          := 35;
  L.Width         := Form1.ScrollBox1.Width - 45;
  L.Height        := 45;
  L.Anchors       := L.Anchors+ [akLeft]+[akRight];
  L.AutoSize      := False;
  L.WordWrap      := true;
  L.Transparent   := True;
  L.Caption       := Answer;
  L.Layout        := tlCenter;
  Form1.ScrollBox1.Repaint;
  Application.ProcessMessages;
end;
(* ************************************************************************** *)
Procedure CreateOrderAnswer(Ps: integer; Answer: String; Id: integer; Right: Boolean; Name: integer);
var
  C: TSpeedButton;
  L: TLabel;
begin
    C := TSpeedButton.Create(Form1.ScrollBox1);
    C.Parent        := Form1.ScrollBox1;
    C.Name          := 'Otvet'+inttostr(Name);
    C.Width         := 17;
    C.Height        := 17;
    C.Top           := Ps-3;
    C.Tag           := Id; //it ansver ID
    C.Left          := 14;
    C.Caption       := '';
    C.OnClick       := Form1.UpAnswerBtn;

    L := TLabel.Create(Form1.ScrollBox1);
    L.Parent        := Form1.ScrollBox1;
    L.Top           := Ps - 17;
    L.Left          := 35;
    L.Width         := Form1.ScrollBox1.Width - 45;
    L.Height        := 45;
    L.Anchors       := L.Anchors+ [akLeft]+[akRight];
    L.AutoSize      := False;
    L.WordWrap      := true;
    L.Transparent   := True;
    L.Caption       := Answer;
    L.Layout        := tlCenter;
  Form1.ScrollBox1.Repaint;
  Application.ProcessMessages;
end;
(* ************************************************************************** *)
Procedure CreateEditAnswer(Ps: integer; Answer: String; Id: integer; Right: Boolean; Name: integer);
var
  C: TEdit;
  L: TLabel;
begin
  C := TEdit.Create(Form1.ScrollBox1);
  C.Parent        := Form1.ScrollBox1;
  C.Name          := 'Otvet'+inttostr(Name);
  C.Width         := Form1.ScrollBox1.Width - 25;
  C.Height        := 21;
  C.Top           := Ps+10;
  C.Tag           := Id; //it ansver ID
  C.Left          := 15;
  C.Text          := '';
  C.Anchors       := C.Anchors+ [akLeft]+[akRight];

  L := TLabel.Create(Form1.ScrollBox1);
  L.Parent        := Form1.ScrollBox1;
  L.Top           := Ps-10;
  L.Left          := 15;
  L.Width         := Form1.ScrollBox1.Width - 45;
  L.Height        := 13;
  L.Anchors       := L.Anchors+ [akLeft]+[akRight];
  L.AutoSize      := False;
  L.WordWrap      := true;
  L.Transparent   := True;
  L.Caption       := 'Введите свой ответ:';
  L.Layout        := tlCenter;

  Form1.ScrollBox1.Repaint;
  Application.ProcessMessages;
end;
(* ************************************************************************** *)
Procedure DestroyAll(Father: TObject);
begin
  While (Father as TScrollBox).ComponentCount > 0 do
    (Father as TScrollBox).Components[(Father as TScrollBox).ComponentCount-1].Destroy;
end;
(* ************************************************************************** *)
Procedure DisplayQuestion(Question: TQuestion);
var
  i : integer;
  Ps: integer;
  AL: array [0..10000] of boolean;
  RI: integer;
begin
  ImageBuffer := '';
  WAVBuffer   := '';
  
  Form1.BitBtn8.Enabled := False;
  Form1.BitBtn9.Enabled := False;

  ImageBuffer := Question.qImage;
  WAVBuffer   := Question.qSound;

  if WAVBuffer <> '' then
  begin
    try
      Form1.BitBtn9.Enabled := True;
    except
    end;
  end;

  if ImageBuffer <> '' then
  begin
    try
      Form1.BitBtn8.Enabled := True;
    except
    end;
  end;
    
  RI := 0;
  Randomize;
  for i := 0 to 10000 do
    AL[i] := False;

  DestroyAll(Form1.ScrollBox1);
  Finalize(NowAnswers);
  NowAnswers := Question.answers;
  LastNum := 0;
  Ps := -33;
  //
  Form1.Label10.Caption := Question.qText;

  if Question.qType = qtEdit then begin
    CreateEditAnswer(Ps+50,'',0,False,0);
  end else
    if not Form1.TESTDB.tQRndStyle then begin
      for i := 0 to length(Question.Answers)-1 do
      begin
      Ps := Ps + 50;
        case Question.qType of
          qtRadio    : CreateRadioAnswer(Ps,Question.Answers[i].Answer,Question.Answers[i].ID,Question.Answers[i].IsRight,i);
          qtCheck    : CreateCheckAnswer(Ps,Question.Answers[i].Answer,Question.Answers[i].ID,Question.Answers[i].IsRight,i);
          qtPosition : CreateOrderAnswer(Ps,Question.Answers[i].Answer,Question.Answers[i].ID,Question.Answers[i].IsRight,i);
        end;
      end;
    end else begin
      for i := 0 to length(Question.Answers)-1 do begin
        repeat
          RI := Random(length(Question.Answers));
        until AL[RI] = False;
        Ps := Ps + 50;
        AL[RI] := True;
        case Question.qType of
          qtRadio    : CreateRadioAnswer(Ps,Question.Answers[RI].Answer,Question.Answers[RI].ID,Question.Answers[RI].IsRight,RI);
          qtCheck    : CreateCheckAnswer(Ps,Question.Answers[RI].Answer,Question.Answers[RI].ID,Question.Answers[RI].IsRight,RI);
          qtPosition : CreateOrderAnswer(Ps,Question.Answers[RI].Answer,Question.Answers[RI].ID,Question.Answers[RI].IsRight,RI);
        end;
      end;
    end;
  //
end;
(* ************************************************************************** *)
procedure TForm1.UpAnswerBtn(Sender: TObject);
  Procedure ClearLeterBtn(MaxID: integer);
  var
    i : integer;
  begin
    for i := 0 to ScrollBox1.ComponentCount-1 do
      if ScrollBox1.Components[i] is TSpeedButton then
        if (ScrollBox1.Components[i] as TSpeedButton).Caption <> '' then
          if strtoint((ScrollBox1.Components[i] as TSpeedButton).Caption) >= MaxID then
          begin
            if LastNum > strtoint((ScrollBox1.Components[i] as TSpeedButton).Caption) then
              LastNum := strtoint((ScrollBox1.Components[i] as TSpeedButton).Caption)-1;
            (ScrollBox1.Components[i] as TSpeedButton).Caption := '';
            (ScrollBox1.Components[i] as TSpeedButton).Repaint;
            (ScrollBox1.Components[i] as TSpeedButton).Update;
          end;
  end;
  var
   MyID: integer;
begin
  with Sender as TSpeedButton do begin
    if Caption = '' then begin
      inc(LastNum);
      Caption := inttostr(LastNum);
      Exit;
    end else
      MyID    := StrToInt(Caption);
      LastNum := MyID-1;
      ClearLeterBtn(MyID);
      Caption := '';
  end;
end;
(* ************************************************************************** *)
Procedure ClearQline;
var
  i : integer;
begin
  for i := 0 to 10000 do
    QuestionLine[i] := False;
end;

Procedure DisplayNextQuestion;
var
  RandomID : integer;
begin
  ImageBuffer := '';
  WAVBuffer   := '';
  Inc(QuestionNum);
  Randomize;

  if Form1.TESTDB.tQUseLimit then
    if QuestionNum-1 > Form1.TESTDB.tQLimit-1 then begin
      Form1.BitBtn2.Click;
      exit;
    end;

  if QuestionNum-1 > length(Form1.TESTDB.tQuestions)-1 then begin
    Dec(QuestionNum);
    Form1.BitBtn2.Click;
    Exit;
  end;

  if Form1.TESTDB.tQRndStyle then begin

    Repeat
      RandomID := Random(length(Form1.TESTDB.tQuestions));
    Until QuestionLine[RandomID] = False;

    DisplayQuestion(Form1.TESTDB.tQuestions[RandomID]);
    QuestionLine[RandomID] := True;
  end else begin
    DisplayQuestion(Form1.TESTDB.tQuestions[QuestionNum-1]);
    QuestionLine[QuestionNum-1] := True;
  end;
end;
(* ************************************************************************** *)
Function IsRightAnswer : Boolean;
var
  i,j   : integer;
  Error : Boolean;
begin
  Error := True;
  StrAnswer := '';

  for i := 0 to Form1.ScrollBox1.ComponentCount-1 do begin
    if pos('Otvet',Form1.ScrollBox1.Components[i].Name) <> 0 then
      if Form1.ScrollBox1.Components[i] is TRadioButton then
      begin
        if (Form1.ScrollBox1.Components[i] as TRadioButton).Checked then
          if (Form1.ScrollBox1.Components[i] as TRadioButton).Tag = 1 then Error := False else
          begin
            Error := True;
            Break;
          end;
      end else
      if Form1.ScrollBox1.Components[i] is TCheckBox then
      begin
        if (Form1.ScrollBox1.Components[i] as TCheckBox).Checked then
          if (Form1.ScrollBox1.Components[i] as TCheckBox).Tag = 1 then Error := False else
          begin
            Error := True;
            Break;
          end;
      end else
      if Form1.ScrollBox1.Components[i] is TSpeedButton then
      begin
        if (Form1.ScrollBox1.Components[i] as TSpeedButton).Caption <> '' then
          if (Form1.ScrollBox1.Components[i] as TSpeedButton).Tag = Strtoint((Form1.ScrollBox1.Components[i] as TSpeedButton).Caption) then Error := False else
          begin
            Error := True;
            Break;
          end;
      end else
      if Form1.ScrollBox1.Components[i] is TEdit then
      begin
        if (Form1.ScrollBox1.Components[i] as TEdit).Text <> '' then
          for j := 0 to Length(NowAnswers)-1 do begin
            if LowerCase((Form1.ScrollBox1.Components[i] as TEdit).Text) = LowerCase(NowAnswers[j].Answer) then
              Error := False;
          end 
      end;
  end;
  
  if Error then
    Result := False
  else
    Result := True;
end;
(* ************************************************************************** *)
Procedure AcceptAnswer;
begin
  if IsRightAnswer then begin
    inc(RightAnswers);
  end;
  {!!!}
  with Form5.ListView1.Items.Add do begin
    Caption := inttostr( Form5.ListView1.Items.Count );

    if IsRightAnswer then begin
      SubItems.Add('Верный');
      ImageIndex := 0;
    end else begin
      SubItems.Add('Не верный');
      ImageIndex := 1;
    end;

    SubItems.Add(Form1.Label10.Caption);
  end;
end;
(* ************************************************************************** *)
function ConvertRightAnswersToString(RA: integer) : String;
begin
  Result := '0';
  if RA = 0 then
    Exit;
  //
  if (RA >= Form1.TESTDB.tQ2BallsFrom) and (RA <= Form1.TESTDB.tQ2BallsTo)
    then Result := '2';
  if (RA >= Form1.TESTDB.tQ3BallsFrom) and (RA <= Form1.TESTDB.tQ3BallsTo)
    then Result := '3';
  if (RA >= Form1.TESTDB.tQ4BallsFrom) and (RA <= Form1.TESTDB.tQ4BallsTo)
    then Result := '4';
  if (RA >= Form1.TESTDB.tQ5BallsFrom) and (RA <= Form1.TESTDB.tQ5BallsTo)
    then Result := '5';
end;
(* ************************************************************************** *)
{$R *.dfm}

procedure TForm1.FormResize(Sender: TObject);
var
  i,j : integer;
begin

  Image12.Picture := nil;
  for j := 0 to (Image12.Height div Image7.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image12.Width div Image7.Picture.Bitmap.Width)+1 do
      Image12.Canvas.Draw(i*Image7.Picture.Bitmap.Width,j*Image7.Picture.Bitmap.Height,Image7.Picture.Bitmap);

  Image13.Picture := nil;
  for j := 0 to (Image13.Height div Image7.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image13.Width div Image7.Picture.Bitmap.Width)+1 do
      Image13.Canvas.Draw(i*Image7.Picture.Bitmap.Width,j*Image7.Picture.Bitmap.Height,Image7.Picture.Bitmap);

  Image3.Picture := nil;
  for j := 0 to (Image3.Height div Image7.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image3.Width div Image7.Picture.Bitmap.Width)+1 do
      Image3.Canvas.Draw(i*Image7.Picture.Bitmap.Width,j*Image7.Picture.Bitmap.Height,Image7.Picture.Bitmap);

  Image9.Picture := nil;
  for j := 0 to (Image9.Height div Image8.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image9.Width div Image8.Picture.Bitmap.Width)+1 do
      Image9.Canvas.Draw(i*Image8.Picture.Bitmap.Width,j*Image8.Picture.Bitmap.Height,Image8.Picture.Bitmap);

  Image14.Picture := nil;
  for j := 0 to (Image14.Height div Image8.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image14.Width div Image8.Picture.Bitmap.Width)+1 do
      Image14.Canvas.Draw(i*Image8.Picture.Bitmap.Width,j*Image8.Picture.Bitmap.Height,Image8.Picture.Bitmap);

  Image2.Picture := nil;
  for j := 0 to (Image2.Height div Image7.Picture.Bitmap.Height)+1 do
    for i := 0 to (Image2.Width div Image7.Picture.Bitmap.Width)+1 do
      Image2.Canvas.Draw(i*Image7.Picture.Bitmap.Width,j*Image7.Picture.Bitmap.Height,Image7.Picture.Bitmap);


  Label10.Width    := (Panel2.Width div 2) - 15;
  ScrollBox1.Width := (Panel2.Width div 2) - 15;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then Exit;

  if LoadTestDataBase(OpenDialog1.FileName,TESTDB) then begin
    try
    if Form4.Visible then Form4.Hide;
    except
    end;
    BitBtn6.Enabled := true;
    BitBtn4.Enabled := true;

    BitBtn1.Enabled := False;

    Label11.Caption := 'Тест на тему: ' + TESTDB.tName;
    Label12.Caption := 'По предмету: ' + TESTDB.tSubject;
    Label13.Caption := 'Автор: ' + TESTDB.tAuthor;

    Label11.Visible := true;
    Label12.Visible := true;
    Label13.Visible := true;
    
    TabSheet2.Show;
  end else
    MessageDlg('Произошла ошибка при загрузке файла теста.'
               +#13#10+
               'Данный файл не является файлом тестирования QuickTester'
               ,mtInformation,[mbOk],0);

  Timer1.Enabled := False;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  Finalize(TESTDB);

  TabSheet2.Show;
  BitBtn1.Default := true;
//  BitBtn5.Default := False;

  BitBtn6.Enabled := false;
  BitBtn4.Enabled := false;
  BitBtn2.Enabled := false;
  BitBtn5.Enabled := false;

  Label11.Visible := false;
  Label12.Visible := false;
  Label13.Visible := false;

  BitBtn1.Enabled := True;

  Timer1.Enabled := False;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  if TESTDB.tQUseUserDlg then begin
    if Form7.ShowModal <> 16 then Exit;

    if (Form7.Edit1.Text = '') or (Form7.Edit2.Text = '')
    or (Form7.Edit3.Text = '') or (Form7.Edit4.Text = '') then begin
      ShowMessage('Внимание! Вы не заполнили все поля!');
      Exit;
    end;
  end;

  TabSheet1.Show;

  Form5.ListView1.Items.Clear;

  BitBtn1.Default := False;
//  BitBtn5.Default := true;
  BitBtn2.Enabled := True;
  BitBtn5.Enabled := True;
  BitBtn6.Enabled := False;
  BitBtn4.Enabled := False;

  ClearQline;
  QuestionTime := 0;
  QuestionNum  := 0;
  RightAnswers := 0;

  Label6.Caption := '0';
  if TESTDB.tQUseLimit then
    Label7.Caption := inttostr(TESTDB.tQLimit-QuestionNum)
  else
    Label7.Caption := inttostr(Length(TESTDB.tQuestions));

  if TESTDB.tQTimeOver then begin
    QuestionTime   := TESTDB.tQTime * 60;
    Timer1.Enabled := True;
  end;

  DisplayNextQuestion;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  ResultList : TStringList;
  i : integer;
  FN : String;
begin
  if TabSheet3.Visible then begin
    TabSheet2.Show;
    BitBtn1.Default := true;
//    BitBtn5.Default := False;
    
    BitBtn2.Enabled := False;
    BitBtn5.Enabled := False;
    BitBtn8.Enabled := False;
    BitBtn9.Enabled := False;
    BitBtn6.Enabled := true;
    BitBtn4.Enabled := true;
  end else begin
    BitBtn5.Enabled := False;
    BitBtn8.Enabled := False;
    BitBtn9.Enabled := False;

    Label16.Caption := ConvertRightAnswersToString(RightAnswers);

    if ConvertRightAnswersToString(RightAnswers) = '0' then Label16.Font.Color := clGray;
    if ConvertRightAnswersToString(RightAnswers) = '2' then Label16.Font.Color := clRed;
    if ConvertRightAnswersToString(RightAnswers) = '3' then Label16.Font.Color := clTeal;
    if ConvertRightAnswersToString(RightAnswers) = '4' then Label16.Font.Color := clNavy;
    if ConvertRightAnswersToString(RightAnswers) = '5' then Label16.Font.Color := clGreen;
    {!}
    if TESTDB.tQUseUserDlg then begin
      ResultList := TStringList.Create;
      {!}
      ResultList.Add('Название теста: '+TESTDB.tName);
      ResultList.Add('');
      ResultList.Add('Фамилия: '+Form7.Edit1.Text);
      ResultList.Add('Имя: '+Form7.Edit2.Text);
      ResultList.Add('Отчество: '+Form7.Edit3.Text);
      ResultList.Add('Группа: '+Form7.Edit4.Text);
      ResultList.Add('');
      ResultList.Add('Оценка: '+Label16.Caption);
      ResultList.Add('');
      ResultList.Add(' -->> ');
      ResultList.Add('');
      for i := 0 to Form5.ListView1.Items.Count - 1 do
        with Form5.ListView1.Items.Item[i] do begin
          ResultList.Add('Вопрос: '+Form5.ListView1.Items.Item[i].SubItems[1]);
          if ImageIndex = 0 then
            ResultList.Add('Отвечен верно') else
            ResultList.Add('Отвечен неверно');
        end;

      try
      FN := Form7.Edit1.Text+' '+Form7.Edit2.Text[1]+'.'+Form7.Edit3.Text[1]+' ('+Form7.Edit4.Text+').txt';
      {}
      FN := ReplaseAllString(FN,' ','_');
      {}
        ChDir(ExtractFileDir(paramstr(0)));
        if not FileExists(TESTDB.tQSavePath+FN) then
        ResultList.SaveToFile(TESTDB.tQSavePath+FN) else
          if TESTDB.tQResaveRest then ResultList.SaveToFile(TESTDB.tQSavePath+FN)
          else ShowMessage('Сохранение невозможно! Ваш результат уже существует.');
      except
        ShowMessage('При сохранении произошла ошибка.')
      end;
      ResultList.Free;
      {!}
    end;
    {!}
    TabSheet3.Show;
    Form1.Repaint;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Dec(QuestionTime);
  if QuestionTime <= 0 then begin
    Timer1.Enabled := False;
    BitBtn2.Click;
  end;  
  Label9.Caption := inttostr(QuestionTime div 60)+':'+inttostr(QuestionTime-((QuestionTime div 60)*60))+' минут';
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  Label6.Caption := inttostr(QuestionNum);
  Form1.BitBtn8.Enabled := False;
  Form1.BitBtn9.Enabled := False;
  
  if TESTDB.tQUseLimit then
    Label7.Caption := inttostr(TESTDB.tQLimit-QuestionNum)
  else
    Label7.Caption := inttostr((Length(TESTDB.tQuestions))-QuestionNum);

  AcceptAnswer;
  DisplayNextQuestion;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if BitBtn5.Enabled then begin
    if MessageDlg('Запущено тестирование. Вы уверены что хотите выйти?',mtInformation,[mbYes,mbNo],0) = 7 then Action := caNone;
  end;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  Form2.Showmodal;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
var
  ext : string;
begin
  ext := GetBufferEXT(ImageBuffer);
  Form3.ext := ext;
    if ConvertBufferToFile(@ImageBuffer,ExtractFilePath(paramstr(0))+'image'+ext) then
    begin
      try
        Form3.Image1.Picture := nil;
        Form3.Image1.Picture.LoadFromFile(ExtractFilePath(paramstr(0))+'image'+ext);
      except
      end;
      Form3.ShowModal;
      DeleteFile(ExtractFilePath(paramstr(0))+'image'+ext);
    end;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
var
  ext : string;
begin
  ext := GetBufferEXT(WAVBuffer);

  if ConvertBufferToFile(@WAVBuffer,ExtractFilePath(paramstr(0))+'sound'+ext) then
  begin
    try
      MediaPlayer1.FileName := ExtractFilePath(paramstr(0))+'sound'+ext;
      MediaPlayer1.Open;
      MediaPlayer1.Play;
      Form6.ProgressBar1.Max := MediaPlayer1.Length;
      Form6.ShowModal;
      MediaPlayer1.Stop;
      MediaPlayer1.Close;
      DeleteFile(ExtractFilePath(paramstr(0))+'sound'+ext);
    except
      DeleteFile(ExtractFilePath(paramstr(0))+'sound'+ext);
    end;
  end;
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
  Form5.showmodal;
end;

procedure TForm1.Label3MouseLeave(Sender: TObject);
begin
  Label3.Font.Color := clGreen;
end;

procedure TForm1.Label3MouseEnter(Sender: TObject);
begin
  Label3.Font.Color := clMaroon;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  ChDir(ExtractFileDir(paramstr(0)));
  
  ScrollBox1.DoubleBuffered := true;
  ScrollBox1.ControlStyle   := ScrollBox1.ControlStyle + [csOpaque];

  Panel2.DoubleBuffered := true;
  Panel2.ControlStyle   := Panel4.ControlStyle  + [csOpaque];
  Panel3.DoubleBuffered := true;
  Panel3.ControlStyle   := Panel4.ControlStyle  + [csOpaque];
  Panel4.DoubleBuffered := true;
  Panel4.ControlStyle   := Panel4.ControlStyle  + [csOpaque];
  Panel5.DoubleBuffered := true;
  Panel5.ControlStyle   := Panel5.ControlStyle  + [csOpaque];
  Panel6.DoubleBuffered := true;
  Panel6.ControlStyle   := Panel6.ControlStyle  + [csOpaque];

  Image2.ControlStyle   := Image2.ControlStyle  + [csOpaque];
  Image14.ControlStyle  := Image14.ControlStyle + [csOpaque];
  Image15.ControlStyle  := Image15.ControlStyle + [csOpaque];
  Image16.ControlStyle  := Image16.ControlStyle + [csOpaque];
  Image3.ControlStyle   := Image3.ControlStyle  + [csOpaque];
  Image10.ControlStyle  := Image10.ControlStyle + [csOpaque];

  Image11.ControlStyle  := Image11.ControlStyle + [csOpaque];
  Image18.ControlStyle  := Image18.ControlStyle + [csOpaque];
  Image19.ControlStyle  := Image19.ControlStyle + [csOpaque];
  Image20.ControlStyle  := Image20.ControlStyle + [csOpaque];
  Image22.ControlStyle  := Image22.ControlStyle + [csOpaque];
  Image23.ControlStyle  := Image23.ControlStyle + [csOpaque];
  Image9.ControlStyle   := Image9.ControlStyle  + [csOpaque];
  Image4.ControlStyle   := Image4.ControlStyle  + [csOpaque];
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Label17.Caption := FormatDateTime('dd.mm.yy',now);
  Label18.Caption := FormatDateTime('hh:mm:ss',now);

end;

procedure TForm1.TabSheet1Show(Sender: TObject);
begin
  Form1.OnResize(nil);
  Form1.Repaint;
end;

end.
