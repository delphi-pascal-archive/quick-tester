{
    LbButtons Suite - Two new buttons for Delphi!
    Copyright (C) 2000-2002  Leif Bruder

    This file is part of LbButtons Suite.

    LbButtons Suite is free software; you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation; either version 2.1 of the License, or
    (at your option) any later version.

    LbButtons Suite is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with LbButtons Suite; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit LbButtons;

interface

uses Windows, Graphics, Classes;

const
   cHotTrackSteps = 8;
   cHotTrackSpeed = 30;

type
   TLbColorStyle = (lcsCustom, lcsGold, lcsChrome, lcsBlue, lcsRed, lcsUltraFlat1, lcsUltraFlat2, lcsUltraFlatXP, lcsAqua, lcsDefault, lcsQuicken);
   TLbButtonKind = (bkCustom, bkOK, bkCancel, bkHelp, bkYes, bkNo, bkClose, bkAbort, bkRetry, bkIgnore, bkAll);
   TLbButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);
   TLbButtonStyle = (bsNormal, bsEncarta, bsModern, bsOld, bsShape, bsQuicken);

   TLbButtonThread = class(TThread)
   public
      FNotify: TNotifyEvent;

      constructor Create(DoNotify: TNotifyEvent);
      procedure Execute; override;
      procedure DoEvent;
   end;

//##############################################################################

procedure GetPreDefinedColors(ColorStyle: TLbColorStyle; var Color, LightColor, ShadowColor, ColorWhenDown, HotTrackColor, FontColor: TColor; var Flat, Modern, Quicken: boolean);
procedure LbPaintButton(Canvas: TCanvas; Width, Height, HotTrackStep, NumGlyphs: integer; Glyph: TBitmap; Down, CursorOnButton, Transparent, Enabled, Flat, Wordwrap, PopupArrow: boolean; Style: TLbButtonStyle; Color, ColorWhenDown, HotTrackColor, LightColor, ShadowColor: TColor; Font: TFont; Layout: TLbButtonLayout; Caption: string; Alignment: TAlignment);

//##############################################################################

implementation

{$R LBBUTTONS.RES}

//##############################################################################

constructor TLbButtonThread.Create(DoNotify: TNotifyEvent);
begin
   inherited Create(true);

   FreeOnTerminate := true;
   FNotify := DoNotify;
end;

{------------------------------------------------------------------------------}

procedure TLbButtonThread.Execute;
begin
   while not Terminated do
   begin
      SleepEx(cHotTrackSpeed, false);
      Synchronize(DoEvent);
   end;
end;

{------------------------------------------------------------------------------}

procedure TLbButtonThread.DoEvent;
begin
   FNotify(Self);
end;

//##############################################################################

procedure GetPreDefinedColors(ColorStyle: TLbColorStyle; var Color, LightColor, ShadowColor, ColorWhenDown, HotTrackColor, FontColor: TColor; var Flat, Modern, Quicken: boolean);
begin
   Quicken := false;
   Modern := false;
   Flat := false;
   FontColor := clBlack;

   case ColorStyle of
      lcsDefault:     begin Color := clBtnFace;  LightColor := clWhite;     ShadowColor := clGray;     ColorWhenDown := clNone;     HotTrackColor := clNone;     end;
      lcsGold:        begin Color := $0000C0C0;  LightColor := clYellow;    ShadowColor := clOlive;    ColorWhenDown := clNone;     HotTrackColor := $0000DFDF;  Modern := true; end;
      lcsChrome:      begin Color := clSilver;   LightColor := clWhite;     ShadowColor := clGray;     ColorWhenDown := clNone;     HotTrackColor := clNone;     Modern := true; end;
      lcsBlue:        begin Color := $00FF8000;  LightColor := clAqua;      ShadowColor := clBlue;     ColorWhenDown := clNone;     HotTrackColor := clNone;     Modern := true; end;
      lcsRed:         begin Color := clRed;      LightColor := $00C0C0FF;   ShadowColor := $000000C0;  ColorWhenDown := clNone;     HotTrackColor := clNone;     Modern := true; end;
      lcsAqua:        begin Color := $00ECCE94;  LightColor := $00FCE6D4;   ShadowColor := clBlack;    ColorWhenDown := clNone;     HotTrackColor := clNone;     Modern := true; end;
      lcsUltraFlat1:  begin Color := clBtnFace;  LightColor := $00B59284;   ShadowColor := $00B59284;  ColorWhenDown := $00B59284;  HotTrackColor := $00DED3D6;  Flat := True;   end;
      lcsUltraFlat2:  begin Color := clBtnFace;  LightColor := clBlack;     ShadowColor := clBlack;    ColorWhenDown := $0024DABC;  HotTrackColor := $008CF6E4;  Flat := True;   end;
      lcsUltraFlatXP: begin Color := $00D1D8DB;  LightColor := $00B59284;   ShadowColor := $00B59285;  ColorWhenDown := $00B59285;  HotTrackColor := $00D2BDB6;  Flat := True;   end;
      lcsQuicken:     begin Color := $00603000;  LightColor := clSilver;    ShadowColor := clSilver;   ColorWhenDown := $00AD6529;  HotTrackColor := $00CEAE9C;  Quicken := true; FontColor := clWhite; end;
   end;
end;

//##############################################################################

procedure LbPaintButton(Canvas: TCanvas; Width, Height, HotTrackStep, NumGlyphs: integer; Glyph: TBitmap; Down, CursorOnButton, Transparent, Enabled, Flat, Wordwrap, PopupArrow: boolean; Style: TLbButtonStyle; Color, ColorWhenDown, HotTrackColor, LightColor, ShadowColor: TColor; Font: TFont; Layout: TLbButtonLayout; Caption: string; Alignment: TAlignment);
var
   iCaptionHeight, iCaptionWidth, iGlyphHeight, iGlyphWidth, iGlyphOffset: integer;
   dtMode: integer;
   iGlyphIndex: integer;
   iOffset, iVertHeight: integer;
   clBackColor: TColor;
   iCapX, iCapY, iGlX, iGlY: integer;
   wR, wG, wB: word;
   aRect: TRect;
   FArrowGlyph: TPicture;

   procedure DrawColorFade(StartColor, StopColor: TColor; iLeft, iTop, iRight, iBottom: integer);
   var
      iCounter, iBuffer, iFillStep: integer;
      bR1, bG1, bB1, bR2, bG2, bB2: byte;
      aColor1, aColor2: LongInt;
      dCurrentR, dCurrentG, dCurrentB, dRStep, dGStep, dBStep: double;
      aOldStyle: TPenStyle;
      iHeight, iDrawBottom: integer;

   begin
      iHeight := (iBottom - iTop);
      aOldStyle := Canvas.Pen.Style; Canvas.Pen.Style := psClear;
      aColor1 := ColorToRGB(StartColor); bR1 := GetRValue(aColor1); bG1 := GetGValue(aColor1); bB1 := GetBValue(aColor1);
      aColor2 := ColorToRGB(StopColor);  bR2 := GetRValue(aColor2); bG2 := GetGValue(aColor2); bB2 := GetBValue(aColor2);
      dCurrentR := bR1; dCurrentG := bG1; dCurrentB := bB1;
      dRStep := (bR2-bR1) / 31; dGStep := (bG2-bG1) / 31; dBStep := (bB2-bB1) / 31;

      iFillStep := (iHeight div 31) + 1;
      for iCounter := 0 to 31 do
      begin
         iBuffer := iCounter * iHeight div 31;
         Canvas.Brush.Color := rgb(trunc(dCurrentR), trunc(dCurrentG), trunc(dCurrentB));
         dCurrentR := dCurrentR + dRStep; dCurrentG := dCurrentG + dGStep; dCurrentB := dCurrentB + dBStep;
         iDrawBottom := iTop + iBuffer + iFillStep; if iDrawBottom > iBottom then iDrawBottom := iBottom;
         Canvas.FillRect(Rect(iLeft, iTop + iBuffer, iRight, iDrawBottom));
      end;
      Canvas.Pen.Style := aOldStyle;
   end;

   function GetSteppedColor: TColor;
   var
      bR1, bG1, bB1, bR2, bG2, bB2: byte;
      aColor1, aColor2: LongInt;
      d1, d2: double;

   begin
      aColor1 := ColorToRGB(Color);
      aColor2 := ColorToRGB(HotTrackColor);
      bR1 := GetRValue(aColor1); bG1 := GetGValue(aColor1); bB1 := GetBValue(aColor1);
      bR2 := GetRValue(aColor2); bG2 := GetGValue(aColor2); bB2 := GetBValue(aColor2);
      d2 := HotTrackStep / cHotTrackSteps;
      d1 := 1 - d2;
      Result := RGB(Trunc(d1 * bR1 + d2 * bR2), Trunc(d1 * bG1 + d2 * bG2), Trunc(d1 * bB1 + d2 * bB2));
   end;

   procedure DrawGlyph(iDestLeft, iDestTop, iSrcLeft, iSrcTop, iWidth, iHeight: integer);  // transparent draw
   var
      aPicture: TPicture;

   begin
      aPicture := TPicture.Create;
      try aPicture.Bitmap.Assign(Glyph); except end;
      aPicture.Bitmap.Width := iWidth;
      aPicture.Bitmap.Height := iHeight;
      aPicture.Bitmap.Canvas.Draw(-iSrcLeft, -iSrcTop, Glyph);
      aPicture.Graphic.Transparent := true;
      Canvas.Draw(iDestLeft, iDestTop, aPicture.Graphic);
      aPicture.Free;
   end;

begin
   if not Enabled then Down := false;
   iOffset := 0; if Down then if Style in [bsNormal, bsModern, bsOld, bsShape, bsQuicken] then iOffset := 1;

   // Background
   clBackColor := colortorgb(Color);
   if Enabled then if HotTrackColor <> clNone then clBackColor := GetSteppedColor;
   if Down then if ColorWhenDown <> clNone then clBackColor := ColorWhenDown;

   if Style = bsShape then
   begin
      Canvas.Brush.Color := clFuchsia;
      Canvas.Rectangle(-1, -1, Width+1, Height+1)
   end
   else
   begin
      if not Transparent then
      begin
         Canvas.Brush.Color := clBackColor;
         if Style in [bsNormal, bsEncarta, bsOld] then Canvas.Rectangle(-1, -1, Width+1, Height+1)
         else
         if Style = bsModern then
         begin
            DrawColorFade(LightColor, clBackColor, 2, 2, Width - 2, Height div 4 + iOffset);
            DrawColorFade(clBackColor, LightColor, 2, Height div 4 + iOffset, Width - 2, Height - 1);
         end;
      end;
   end;

   Canvas.Brush.Style := bsclear;

   // Border
   if Style in [bsNormal, bsEncarta, bsOld] then
   begin
      if (Enabled and (not Flat or CursorOnButton or Down)) or (not Enabled and not Flat) then
      begin
         with Canvas do
         begin
            if Style = bsOld then
            begin
               Pen.Color := ShadowColor;
               if Down then
               begin
                  MoveTo(1, Height-3);
                  LineTo(1, 1);
                  LineTo(Width-2, 1);
               end
               else
               begin
                  MoveTo(Width-2, 0);
                  LineTo(Width-2, Height-2);
                  LineTo(0, Height-2);
               end;
               if Down then Pen.Color := cl3DDkShadow else Pen.Color := LightColor;
               MoveTo(0, Height-1);
               LineTo(0, 0);
               LineTo(Width-1, 0);
               if Down then Pen.Color := LightColor else Pen.Color := cl3DDkShadow;
               LineTo(Width-1, Height-1);
               LineTo(-1, Height-1);
            end
            else
            begin
               if Down then Pen.Color := ShadowColor else Pen.Color := LightColor;
               MoveTo(0, Height-1);
               LineTo(0, 0);
               LineTo(Width-1, 0);
               if Down then Pen.Color := LightColor else Pen.Color := ShadowColor;
               LineTo(Width-1, Height-1);
               LineTo(0, Height-1);
            end;
         end;
      end;
   end
   else
   if Style = bsModern then
   begin
      with Canvas do
      begin
         Pen.Color := clBackColor; if Down then Pen.Color := ShadowColor;
         Rectangle(1, 1, Width-1, Height-1);
         Pen.Color := ShadowColor;
         RoundRect(0, 0, Width, Height, 6, 6);
      end;
   end
   else
   if Style = bsQuicken then
   begin
      with Canvas do
      begin
         Pen.Color := clBackColor; if Down then Pen.Color := ShadowColor;
         Pen.Style := psClear;
         Canvas.Brush.Color := clBackColor;
         Canvas.Brush.Style := bssolid;
         RoundRect(0, 1, Width, Height, 4, 4);
         Canvas.Brush.Style := bsclear;
         Pen.Style := psSolid;
         Pen.Color := ShadowColor;
         MoveTo(4, 0); LineTo(Width-5, 0);
         MoveTo(4, Height-1); LineTo(Width-5, Height-1);
      end;
   end;

   // Prepare layout
   Canvas.Font := Font;
   if ((Style = bsEncarta) and down) {or ((Style = bsQuicken) and (CursorOnButton or Down))} then Canvas.Font.Style := Canvas.Font.Style + [fsBold];
   iGlX := 0;
   dtMode := DT_CENTER or DT_VCENTER or DT_SINGLELINE;

   iGlyphHeight := Glyph.Height;
   if NumGlyphs <> 0 then iGlyphWidth := Glyph.Width div NumGlyphs else iGlyphWidth := 0;
   iGlyphIndex := 0;
   if not Enabled then iGlyphIndex := iGlyphWidth
   else
   begin
      if CursorOnButton and (NumGlyphs > 3) then iGlyphIndex := 3 * iGlyphWidth;
      if Down and (NumGlyphs > 2) then iGlyphIndex := 2 * iGlyphWidth;
   end;

   case Alignment of
      taLeftJustify:  dtMode := DT_LEFT or DT_WORDBREAK;
      taRightJustify: dtMode := DT_RIGHT or DT_WORDBREAK;
      taCenter:       dtMode := DT_CENTER or DT_WORDBREAK;
   end;

   if Style = bsShape then
   begin
      iCaptionWidth := Width - 8; if iCaptionWidth < 0 then iCaptionWidth := 0;
      if not WordWrap then while Canvas.TextWidth(Caption) > iCaptionWidth do Caption := copy(Caption, 1, length(Caption)-1);
      aRect := Rect(0, 0, iCaptionWidth, 0);
      DrawText(Canvas.Handle, pChar(Caption), Length(Caption), aRect, DT_WORDBREAK or DT_CALCRECT);
      iCaptionHeight := aRect.Bottom;

      DrawGlyph((Width-iGlyphWidth) div 2, (Height-iGlyphHeight) div 2, iGlyphIndex, 0, iGlyphWidth, iGlyphHeight);
      aRect := Rect(iOffset, iOffset + (Height-iCaptionHeight) div 2, Width, Height);
      DrawText(Canvas.Handle, pChar(Caption), Length(Caption), aRect, DT_CENTER or DT_WORDBREAK);
   end
   else
   begin
      if Layout in [blGlyphLeft, blGlyphRight] then
      begin
         iCaptionWidth := Width - 8; if iGlyphWidth > 0 then dec(iCaptionWidth, iGlyphWidth + 4);
         if iCaptionWidth < 0 then iCaptionWidth := 0;
         if not WordWrap then while Canvas.TextWidth(Caption) > iCaptionWidth do Caption := copy(Caption, 1, length(Caption)-1);
         aRect := Rect(0, 0, iCaptionWidth, 0);
         DrawText(Canvas.Handle, pChar(Caption), Length(Caption), aRect, DT_WORDBREAK or DT_CALCRECT);
         iCaptionHeight := aRect.Bottom;
         iCapY := (Height - iCaptionHeight) div 2 + iOffset;
         iCapX := 4 + iOffset;
         iGlY := (Height - iGlyphHeight) div 2 + iOffset;
         iGlyphOffset := 0; if Caption <> '' then iGlyphOffset := aRect.Right + 4;

         if Layout = blGlyphLeft then
         begin
            if iGlyphWidth > 0 then inc(iCapX, iGlyphWidth + 4);
            iGlX := iOffset + 4;
            if not WordWrap then
            begin
               case Alignment of
                  taLeftJustify:  iGlX := iOffset + 4;
                  taRightJustify: iGlX := Width - 4 - iGlyphWidth - iGlyphOffset + iOffset;
                  taCenter:       iGlX := (Width - iGlyphWidth) div 2 + iOffset - (iGlyphOffset div 2);
               end;
            end;
         end
         else
         begin
            iGlX := iCapX + iGlyphOffset;
            if not WordWrap then
            begin
               case Alignment of
                  taLeftJustify:  iGlX := iCapX + iGlyphOffset;
                  taRightJustify: iGlX := Width - 4 + iOffset - iGlyphWidth;
                  taCenter:       iGlX := (Width - iGlyphWidth) div 2 + iOffset + (iGlyphOffset div 2);
               end;
            end;
         end;
      end
      else
      begin
         iCaptionWidth := Width - 8;
         if iCaptionWidth < 0 then iCaptionWidth := 0;
         if not WordWrap then while Canvas.TextWidth(Caption) > iCaptionWidth do Caption := copy(Caption, 1, length(Caption)-1);
         aRect := Rect(0, 0, iCaptionWidth, 0);
         DrawText(Canvas.Handle, pChar(Caption), Length(Caption), aRect, DT_WORDBREAK or DT_CALCRECT);
         iCaptionHeight := aRect.Bottom;
         iVertHeight := iCaptionHeight; if iGlyphHeight > 0 then inc(iVertHeight, iGlyphHeight + 4);
         iCapX := 4 + iOffset;

         if Layout = blGlyphTop then
         begin
            iCapY := (Height - iVertHeight) div 2 + iGlyphHeight + iOffset;
            iGlY := (Height - iVertHeight) div 2 + iOffset;
            case Alignment of
               taLeftJustify:  iGlX := 4 + iOffset;
               taRightJustify: iGlX := Width - iGlyphWidth - 4 + iOffset;
               taCenter:       iGlX := (Width - iGlyphWidth) div 2 + iOffset;
            end;
         end
         else
         begin
            iCapY := (Height - iVertHeight) div 2 + iOffset;
            iGlY := (Height - iVertHeight) div 2 + iCaptionHeight + iOffset;
            case Alignment of
               taLeftJustify:  iGlX := 4 + iOffset;
               taRightJustify: iGlX := Width - iGlyphWidth - 4 + iOffset;
               taCenter:       iGlX := (Width - iGlyphWidth) div 2 + iOffset;
            end;
         end;
      end;

      if not Enabled then Canvas.Font.Color := clGray;

      aRect := Rect(iCapX, iCapY, iCapX + iCaptionWidth, iCapY + iCaptionHeight);
      DrawText(Canvas.Handle, pChar(Caption), Length(Caption), aRect, dtMode);
      DrawGlyph(iGlX, iGlY, iGlyphIndex, 0, iGlyphWidth, iGlyphHeight);
   end;

   if PopupArrow then
   begin
      FArrowGlyph := TPicture.Create;
      FArrowGlyph.Bitmap.LoadFromResourceName(hInstance, 'LBARROW');
      FArrowGlyph.Graphic.Transparent := true;
      Canvas.Draw(Width - 11, Height div 2 - 1, FArrowGlyph.Graphic);
      FArrowGlyph.Free;
   end;
end;

//##############################################################################

end.
