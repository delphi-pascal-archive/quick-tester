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

unit LbStaticText;

interface

uses
   Windows, Messages, Classes, Graphics, Controls, Forms, LbButtons;

type
   TLbStaticText = class(TCustomControl)
   private
      FAlignment: TAlignment;
      FFlat: boolean;
      FWordWrap: boolean;
      FGlyph: TBitmap;
      FHotTrackColor: TColor;
      FHTFont: TFont;
      FLayout: TLbButtonLayout;
      FLightColor: TColor;
      FNumGlyphs: integer;
      FShadowColor: TColor;
      FStyle: TLbButtonStyle;
      FUseHTFont: boolean;
      FOnMouseEnter: TNotifyEvent;
      FOnMouseExit: TNotifyEvent;
      FDummyStyle: TLbColorStyle;
      bCursorOnButton: boolean;
      FThread: TLbButtonThread;
      FSlowDecease: boolean;
      FHotTrackStep: integer;
   public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      procedure Click; override;
   protected
      procedure Paint; override;
      procedure DoStep(Sender: TObject);

      function GetCaption: TCaption;

      procedure SetAlignment(fNew: TAlignment);
      procedure SetFlat(fNew: boolean);
      procedure SetColorStyle(fNew: TLbColorStyle);
      procedure SetCaption(const fNew: TCaption);
      procedure SetGlyph(fNew: TBitmap);
      procedure SetHTFont(fNew: TFont);
      procedure SetLayout(fNew: TLbButtonLayout);
      procedure SetLightColor(fNew: TColor);
      procedure SetNumGlyphs(fNew: integer);
      procedure SetShadowColor(fNew: TColor);
      procedure SetSlowDecease(fNew: Boolean);
      procedure SetStyle(fNew: TLbButtonStyle);
      procedure SetWordWrap(fNew: boolean);

      procedure DoMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure DoMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure DoDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
   published
      property Align;
      property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
      property Anchors;
      property Caption: TCaption read GetCaption write SetCaption;
      property Color;
      property ColorStyle: TLbColorStyle read FDummyStyle write SetColorStyle default lcsCustom;
      property Flat: boolean read FFlat write SetFlat default false;
      property Font;
      property Glyph: TBitmap read FGlyph write SetGlyph;
      property HotTrackColor: TColor read FHotTrackColor write FHotTrackColor default clNone;
      property HotTrackFont: TFont read FHTFont write SetHTFont;
      property Hint;
      property Layout: TLbButtonLayout read FLayout write SetLayout default blGlyphLeft;
      property LightColor: TColor read FLightColor write SetLightColor default clWhite;
      property NumGlyphs: integer read FNumGlyphs write SetNumGlyphs default 0;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShadowColor: TColor read FShadowColor write SetShadowColor default clBlack;
      property ShowHint;
      property SlowDecease: boolean read FSlowDecease write SetSlowDecease default false;
      property Style: TLbButtonStyle read FStyle write SetStyle default bsNormal;
      property UseHotTrackFont: boolean read FUseHTFont write FUseHTFont default false;
      property Visible;
      property WordWrap: boolean read FWordWrap write SetWordWrap default false;

      property OnClick;
      property OnDblClick;
      property OnMouseDown;
      property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
      property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
      property OnMouseMove;
      property OnMouseUp;
   end;

procedure Register;

implementation

{##############################################################################}

procedure Register;
begin
   RegisterComponents('LB', [TLbStaticText]);
end;

{##############################################################################}

constructor TLbStaticText.Create(aOwner: TComponent);
begin
   inherited;

   ControlStyle := ControlStyle + [csSetCaption];
   ControlStyle := ControlStyle - [csOpaque];

   Height := 23;
   Width := 100;

   bCursorOnButton := false;
   FLightColor := clWhite;
   FShadowColor := clBlack;
   FHotTrackColor := clNone;
   FWordWrap := false;
   FAlignment := taLeftJustify;
   FDummyStyle := lcsCustom;
   FSlowDecease := false;                      

   FGlyph := TBitmap.Create;
   FHtFont := TFont.Create;
   FHotTrackStep := 0;

   FThread := TLbButtonThread.Create(DoStep);
   FThread.FreeOnTerminate := false;

   if aOwner is TForm then FHtFont.Assign(TForm(aOwner).Font);
end;

{##############################################################################}

destructor TLbStaticText.Destroy;
begin
   if Assigned(FThread) then
   begin
      try while FThread.Suspended do FThread.Resume; except end;
      try FThread.Terminate; FThread.WaitFor; FThread.Free; except end;
   end;
   FHtFont.Free;
   FGlyph.Free;
   inherited;
end;

{##############################################################################}

procedure TLbStaticText.SetAlignment(fNew: TAlignment);
begin
   FAlignment := fNew;
   paint;
end;

{##############################################################################}

procedure TLbStaticText.SetCaption(const fNew: TCaption);
begin
   inherited Caption := fNew;
   invalidate;
end;

{##############################################################################}

function TLbStaticText.GetCaption: TCaption;
begin
   Result := inherited Caption;
end;

{##############################################################################}

procedure TLbStaticText.SetColorStyle(fNew: TLbColorStyle);
var
   bModern, bQuicken: boolean;
   FColor, FontColor, FDummy: TColor;

begin
   if fNew = lcsCustom then exit;

   GetPreDefinedColors(fNew, FColor, FLightColor, FShadowColor, FDummy, FHotTrackColor, FontColor, FFlat, bModern, bQuicken);
   Color := FColor;
   Font.Color := FontColor;
   FStyle := bsNormal; if bModern then FStyle := bsModern; if bQuicken then FStyle := bsQuicken;
   Paint;
end;

{##############################################################################}

procedure TLbStaticText.SetFlat(fNew: boolean);
begin
   FFlat := fNew;
   paint;
end;

{##############################################################################}

procedure TLbStaticText.SetGlyph(fNew: TBitmap);
begin
   if fNew <> nil then
   begin
      FGlyph.Assign(fNew);
      if fNew.Height <> 0 then FNumGlyphs := fNew.Width div fNew.Height else FNumGlyphs := 0;
   end
   else
   begin
      FGlyph.Height := 0;
      FNumGlyphs := 0;
   end;
   invalidate;
end;

{##############################################################################}

procedure TLbStaticText.SetHTFont(fNew: TFont);
begin
   FHTFont.Assign(fNew);
end;

{##############################################################################}

procedure TLbStaticText.SetLayout(fNew: TLbButtonLayout);
begin
   FLayout := fNew;
   paint;
end;

{##############################################################################}

procedure TLbStaticText.SetLightColor(fNew: TColor);
begin
   FLightColor := fNew;
   paint;
end;

{##############################################################################}

procedure TLbStaticText.SetNumGlyphs(fNew: integer);
begin
   FNumGlyphs := fNew;
   invalidate;
end;

{##############################################################################}

procedure TLbStaticText.SetShadowColor(fNew: TColor);
begin
   FShadowColor := fNew;
   paint;
end;

{##############################################################################}

procedure TLbStaticText.SetSlowDecease(fNew: Boolean);
begin
   FSlowDecease := fNew;

   if FSlowDecease then
   begin
      if NOT Assigned(FThread) then
      begin
         FThread := TLbButtonThread.Create(DoStep);
         FThread.FreeOnTerminate := false;
      end;
   end
   else
   begin
      if Assigned(FThread) then
      begin
         FHotTrackStep := 0;
         try while FThread.Suspended do FThread.Resume; except end;
         try FThread.Terminate; FThread.WaitFor; FThread.Free; except end;
         FThread := nil;
      end;
   end;
   Invalidate;
end;

{##############################################################################}

procedure TLbStaticText.SetStyle(fNew: TLbButtonStyle);
begin
   if fNew = bsModern then if GetDeviceCaps(Canvas.Handle, BITSPIXEL) <= 8 then if not (csDesigning in ComponentState) then fNew := bsNormal;
   FStyle := fNew;
   invalidate;
end;

{##############################################################################}

procedure TLbStaticText.SetWordWrap(fNew: boolean);
begin
   FWordwrap := fNew;
   paint;
end;

{##############################################################################}

procedure TLbStaticText.Paint;
var
   aStyle: TLbButtonStyle;
   aLayout: TLbButtonLayout;
   aBitmap: TBitmap;
   aFont: TFont;

begin
   if not (Visible or (csDesigning in ComponentState)) or (csLoading in ComponentState) then exit;

   aStyle := LbButtons.bsNormal;
   case FStyle of
      bsEncarta:  aStyle := LbButtons.bsEncarta;
      bsModern:   aStyle := LbButtons.bsModern;
      bsOld:      aStyle := LbButtons.bsOld;
      bsShape:    aStyle := LbButtons.bsShape;
      bsQuicken:  aStyle := LbButtons.bsQuicken;
   end;

   aLayout := LbButtons.blGlyphLeft;
   case FLayout of
      blGlyphTop:    aLayout := LbButtons.blGlyphTop;
      blGlyphRight:  aLayout := LbButtons.blGlyphRight;
      blGlyphBottom: aLayout := LbButtons.blGlyphBottom;
   end;

   aBitmap := TBitmap.Create;
   aBitmap.Height := Height;
   aBitmap.Width := Width;

   if FStyle in [bsModern, bsShape, bsQuicken] then
   begin
      aBitmap.TransparentMode := tmAuto;
      aBitmap.Transparent := True;
      aBitmap.Canvas.Brush.Color := clFuchsia;
      aBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
      aBitmap.TransparentColor := clFuchsia;
   end;

   aFont := Font; if bCursorOnButton and FUseHTFont then aFont := FHtFont;
   LbPaintButton(aBitmap.Canvas, Width, Height, FHotTrackStep, FNumGlyphs, FGlyph, false, bCursorOnButton, false, true, Flat, FWordWrap, assigned(PopupMenu), aStyle, Color, clNone, FHotTrackColor, FLightColor, FShadowColor, aFont, aLayout, Caption, FAlignment);

   Canvas.Draw(0, 0, aBitmap);
   aBitmap.Free;
end;

{##############################################################################}

procedure TLbStaticText.DoMouseEnter(var Msg: TMessage);
begin
   if Visible and (Parent <> nil) and Parent.Showing then
   begin
      bCursorOnButton := true;
      FHotTrackStep := cHotTrackSteps;
      paint;
      if assigned(FOnMouseEnter) then FOnMouseEnter(self);
   end;
end;

{##############################################################################}

procedure TLbStaticText.DoMouseLeave(var Msg: TMessage);
begin
   bCursorOnButton := false;
   if FSlowDecease then
   begin
      if Assigned(FThread) and (FThread.Suspended) then FThread.Resume;
   end
   else
   begin
      FHotTrackStep := 0;
      paint;
   end;
   if Visible and (Parent <> nil) and Parent.Showing then if assigned(FOnMouseExit) then FOnMouseExit(self);
end;

{##############################################################################}

procedure TLbStaticText.DoDialogChar(var Message: TCMDialogChar);
begin
   with Message do
   begin
      if IsAccel(CharCode, Caption) and Visible and (Parent <> nil) and Parent.Showing then
      begin
         Click;
         Result := 1;
      end
      else
         inherited;
   end;
end;

{##############################################################################}

procedure TLbStaticText.Click;
begin
//   if assigned(PopupMenu) then PopupMenu.PopUp(ClientToScreen(Point(0, Height)).X + Width, ClientToScreen(Point(0, Height)).Y);
   if assigned(PopupMenu) then PopupMenu.PopUp(ClientToScreen(Point(0, Height)).X, ClientToScreen(Point(0, Height)).Y);
   inherited;  // just to make it public :-)
end;

{##############################################################################}

procedure TLbStaticText.DoStep(Sender: TObject);
begin
   if csDestroying in ComponentState then exit;

   dec(FHotTrackStep);
   if FHotTrackStep <= 0 then
   begin
      if Assigned(FThread) and (not FThread.Suspended) then FThread.Suspend;
      FHotTrackStep := 0;
   end;

   paint;
end;

{##############################################################################}

end.
