object Form7: TForm7
  Left = 520
  Top = 108
  Width = 481
  Height = 374
  BorderStyle = bsSizeToolWin
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1082#1086#1076#1086#1074#1086#1081' '#1095#1072#1089#1090#1080' '#1090#1077#1089#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    473
    340)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 386
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TRichEdit
    Left = 8
    Top = 8
    Width = 457
    Height = 289
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
