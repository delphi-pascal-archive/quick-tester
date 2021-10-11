object Form6: TForm6
  Left = 191
  Top = 108
  Width = 376
  Height = 338
  BorderIcons = [biMaximize]
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnResize = FormResize
  DesignSize = (
    368
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 283
    Top = 273
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 350
    Height = 258
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 346
      Height = 254
      Align = alClient
      Center = True
      IncrementalDisplay = True
      Proportional = True
    end
  end
end
