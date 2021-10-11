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

unit LbSpeedButton;

interface

uses
   Windows, Messages, Classes, Graphics, Controls, Forms, ImgList, ActnList, LbButtons;

type
   TLbSpeedButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);
   TLbSpeedButtonStyle = (bsNormal, bsEncarta, bsModern, bsOld, bsShape, bsQuicken);

   TLbSpeedButton = class(TGraphicControl)
   private
      FAlignment: TAlignment;
      FAllowAllUp: boolean;
      FColorWhenDown: TColor;
      FDown: boolean;
      FFlat: boolean;
      FWordWrap: boolean;
      FGlyph: TBitmap;
      FGroupIndex: integer;
      FHotTrackColor: TColor;
      FHTFont: TFont;
      FLayout: TLbSpeedButtonLayout;
      FLightColor: TColor;
      FNumGlyphs: integer;
      FShadowColor: TColor;
      FStyle: TLbSpeedButtonStyle;
      FTransparent: boolean;
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
      procedure SetColorWhenDown(fNew: TColor);
      procedure SetColorStyle(fNew: TLbColorStyle);
      procedure SetDown(fNew: boolean);
      procedure SetCaption(const fNew: TCaption);
      procedure SetGlyph(fNew: TBitmap);
      procedure SetGroupIndex(fNew: integer);
      procedure SetHTFont(fNew: TFont);
      procedure SetLayout(fNew: TLbSpeedButtonLayout);
      procedure SetLightColor(fNew: TColor);
      procedure SetNumGlyphs(fNew: integer);
      procedure SetShadowColor(fNew: TColor);
      procedure SetStyle(fNew: TLbSpeedButtonStyle);
      procedure SetTransparent(fNew: boolean);
      procedure SetWordWrap(fNew: boolean);
      procedure SetSlowDecease(fNew: boolean);

      procedure DoMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure DoMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure DoDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;

      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
      procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
   published
      property Action;
      property Align;
      property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
      property AllowAllUp: boolean read FAllowAllUp write FAllowAllUp default false;
      property Anchors;
      property Caption: TCaption read GetCaption write SetCaption;
      property Color;
      property ColorWhenDown: TColor read FColorWhenDown write SetColorWhenDown default clNone;
      property ColorStyle: TLbColorStyle read FDummyStyle write SetColorStyle default lcsCustom;
      property Down: boolean read FDown write SetDown default false;
      property Enabled;
      property Flat: boolean read FFlat write SetFlat default false;
      property Font;
      property Glyph: TBitmap read FGlyph write SetGlyph;
      property GroupIndex: integer read FGroupIndex write SetGroupIndex default 0;
      property HotTrackColor: TColor read FHotTrackColor write FHotTrackColor default clNone;
      property HotTrackFont: TFont read FHTFont write SetHTFont;
      property Hint;
      property Layout: TLbSpeedButtonLayout read FLayout write SetLayout default blGlyphLeft;
      property LightColor: TColor read FLightColor write SetLightColor default clWhite;
      property NumGlyphs: integer read FNumGlyphs write SetNumGlyphs default 0;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShadowColor: TColor read FShadowColor write SetShadowColor default clBlack;
      property ShowHint;
      property SlowDecease: boolean read FSlowDecease write SetSlowDecease default false;
      property Style: TLbSpeedButtonStyle read FStyle write SetStyle default bsNormal;
      property Transparent: boolean read FTransparent write SetTransparent default false;
      property UseHotTrackFont: boolean read FUseHTFont write FUseHTFont default false;
      property Visible;
      property WordWrap: boolean read FWordWrap write SetWordWrap default false;

      property OnClick;
//      property OnDblClick;
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
   RegisterComponents('LB', [TLbSpeedButton]);
end;

{##############################################################################}

constructor TLbSpeedButton.Create(aOwner: TComponent);
begin
   inherited;

//  ControlStyle := [csCaptureMouse, csDoubleClicks];
   ControlStyle := ControlStyle + [csSetCaption, csDoubleClicks, csCaptureMouse];
   ControlStyle := ControlStyle - [csOpaque];

   Height := 23;
   Width := 100;

   bCursorOnButton := false;
   FLightColor := clWhite;
   FShadowColor := clBlack;
   FColorWhenDown := clNone;
   FHotTrackColor := clNone;
   FWordWrap := false;
   FAlignment := taLeftJustify;
   FDummyStyle := lcsCustom;
   FSlowDecease := false;                      

   FGlyph := TBitmap.Create;
   FHtFont := TFont.Create;
   FHotTrackStep := 0;

   FThread := nil;

   if aOwner is TForm then FHtFont.Assign(TForm(aOwner).Font);
end;

{##############################################################################}

destructor TLbSpeedButton.Destroy;
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

procedure TLbSpeedButton.SetAlignment(fNew: TAlignment);
begin
   FAlignment := fNew;
   if FTransparent then invalidate else paint;  // Could have generally used invalidate, but why make it flicker if it is not transparent?
end;

{##############################################################################}

procedure TLbSpeedButton.SetCaption(const fNew: TCaption);
begin
   inherited Caption := fNew;
   invalidate;
end;

{##############################################################################}

function TLbSpeedButton.GetCaption: TCaption;
begin
   Result := inherited Caption;
end;

{##############################################################################}

procedure TLbSpeedButton.SetColorWhenDown(fNew: TColor);
begin
   FColorWhenDown := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetColorStyle(fNew: TLbColorStyle);
var
   bModern, bQuicken: boolean;
   FColor, FontColor: TColor;

begin
   if fNew = lcsCustom then exit;

   GetPreDefinedColors(fNew, FColor, FLightColor, FShadowColor, FColorWhenDown, FHotTrackColor, FontColor, FFlat, bModern, bQuicken);
   Color := FColor;
   Font.Color := FontColor;
   FStyle := bsNormal; if bModern then FStyle := bsModern; if bQuicken then FStyle := bsQuicken;
   Paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetDown(fNew: boolean);
var
   i: integer;

begin
   if FDown = fNew then exit;

   // If grouped, set all siblings to down=false
   if GroupIndex <> 0 then
      for i := 0 to Parent.ControlCount-1 do
         if Parent.Controls[i] is TLbSpeedButton then
            if TLbSpeedButton(Parent.Controls[i]).GroupIndex = GroupIndex then
               if TLbSpeedButton(Parent.Controls[i]) <> self then
                  TLbSpeedButton(Parent.Controls[i]).Down := false;

   FDown := fNew;

   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetFlat(fNew: boolean);
begin
   FFlat := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetGlyph(fNew: TBitmap);
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

procedure TLbSpeedButton.SetGroupIndex(fNew: integer);
begin
   FGroupIndex := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetHTFont(fNew: TFont);
begin
   FHTFont.Assign(fNew);
end;

{##############################################################################}

procedure TLbSpeedButton.SetLayout(fNew: TLbSpeedButtonLayout);
begin
   FLayout := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetLightColor(fNew: TColor);
begin
   FLightColor := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetNumGlyphs(fNew: integer);
begin
   FNumGlyphs := fNew;
   invalidate;
end;

{##############################################################################}

procedure TLbSpeedButton.SetShadowColor(fNew: TColor);
begin
   FShadowColor := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetSlowDecease(fNew: boolean);
begin
   FSlowDecease := fNew;

   if FSlowDecease then
   begin
      if not Assigned(FThread) then
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

procedure TLbSpeedButton.SetStyle(fNew: TLbSpeedButtonStyle);
begin
   if fNew = bsModern then if GetDeviceCaps(Canvas.Handle, BITSPIXEL) <= 8 then if not (csDesigning in ComponentState) then fNew := bsNormal;
   FStyle := fNew;
   invalidate;
end;

{##############################################################################}

procedure TLbSpeedButton.SetTransparent(fNew: boolean);
begin
   FTransparent := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.SetWordWrap(fNew: boolean);
begin
   FWordwrap := fNew;
   if FTransparent then invalidate else paint;
end;

{##############################################################################}

procedure TLbSpeedButton.Paint;
var
   aStyle: TLbButtonStyle;
   aLayout: TLbButtonLayout;
   aBitmap: TBitmap;
//   aPicture: TPicture;

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

   if FTransparent or (FStyle in [bsModern, bsShape, bsQuicken]) then
   begin
      aBitmap.TransparentMode := tmAuto;
      aBitmap.Transparent := True;
      aBitmap.Canvas.Brush.Color := clFuchsia;
      aBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
      aBitmap.TransparentColor := clFuchsia;
   end;

   if bCursorOnButton and FUseHTFont then
      LbPaintButton(aBitmap.Canvas, Width, Height, FHotTrackStep, FNumGlyphs, FGlyph, FDown, bCursorOnButton, FTransparent, Enabled, Flat, FWordWrap, assigned(PopupMenu), aStyle, Color, FColorWhenDown, FHotTrackColor, FLightColor, FShadowColor, FHTFont, aLayout, Caption, FAlignment)
   else
      LbPaintButton(aBitmap.Canvas, Width, Height, FHotTrackStep, FNumGlyphs, FGlyph, FDown, bCursorOnButton, FTransparent, Enabled, Flat, FWordWrap, assigned(PopupMenu), aStyle, Color, FColorWhenDown, FHotTrackColor, FLightColor, FShadowColor, Font, aLayout, Caption, FAlignment);

{
   if FStyle in [bsShape, bsModern] then
   begin
      aPicture := TPicture.Create;
      try aPicture.Bitmap.Assign(aBitmap); except end;
      aPicture.Bitmap.Width := Width;
      aPicture.Bitmap.Height := Height;
      aPicture.Graphic.Transparent := true;
      Canvas.Draw(0, 0, aPicture.Graphic);
      aPicture.Free;
   end
   else
      Canvas.Draw(0, 0, aBitmap);
}

   Canvas.Draw(0, 0, aBitmap);
   aBitmap.Free;
end;

{##############################################################################}

procedure TLbSpeedButton.DoMouseEnter(var Msg: TMessage);
begin
   if Enabled and Visible and (Parent <> nil) and Parent.Showing then
   begin
      bCursorOnButton := true;
      FHotTrackStep := cHotTrackSteps;
      if FTransparent then invalidate else paint;
      if assigned(FOnMouseEnter) then FOnMouseEnter(self);
   end;
end;

{##############################################################################}

procedure TLbSpeedButton.DoMouseLeave(var Msg: TMessage);
begin
   bCursorOnButton := false;
   if FSlowDecease then
   begin
      if Assigned(FThread) and (FThread.Suspended) then FThread.Resume;
   end
   else
   begin
      FHotTrackStep := 0;
      if FTransparent then invalidate else paint;
   end;
   if Enabled and Visible and (Parent <> nil) and Parent.Showing then if assigned(FOnMouseExit) then FOnMouseExit(self);
end;

{##############################################################################}

procedure TLbSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;

   if (Button <> mbLeft) then exit;

   if GroupIndex = 0 then Down := true
   else
   begin
      if Down then
      begin
         if FAllowAllUp then Down := false;
      end
      else
         Down := true;
   end;
end;

{##############################################################################}

procedure TLbSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if GroupIndex = 0 then Down := false;
end;

{##############################################################################}

procedure TLbSpeedButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  Perform(WM_LBUTTONDOWN, Message.Keys, Longint(Message.Pos));
end;

{##############################################################################}

procedure TLbSpeedButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

   procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
   begin
      with Glyph do
      begin
         Width := ImageList.Width;
         Height := ImageList.Height;
         Canvas.Brush.Color := clFuchsia;
         Canvas.FillRect(Rect(0,0, Width, Height));
         ImageList.Draw(Canvas, 0, 0, Index);
      end;
      NumGlyphs := 1;
      Paint;
   end;

begin
   inherited;

   if Sender is TCustomAction then
   begin
      with TCustomAction(Sender) do
      begin
         if (Glyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
            CopyImage(ActionList.Images, ImageIndex);
      end;
   end;
end;

{##############################################################################}

procedure TLbSpeedButton.DoDialogChar(var Message: TCMDialogChar);
var
   bWasDown: boolean;

begin
   with Message do
   begin
      if IsAccel(CharCode, Caption) and Enabled and Visible and (Parent <> nil) and Parent.Showing then
      begin
         bWasDown := Down;
         Down := true;
         Paint;
         Click;
         Down := bWasDown;
         Paint;
         Result := 1;
      end
      else
         inherited;
   end;
end;

{##############################################################################}

procedure TLbSpeedButton.Click;
begin
//   if assigned(PopupMenu) then PopupMenu.PopUp(ClientToScreen(Point(0, Height)).X + Width, ClientToScreen(Point(0, Height)).Y);
   if assigned(PopupMenu) then PopupMenu.PopUp(ClientToScreen(Point(0, Height)).X, ClientToScreen(Point(0, Height)).Y);
   inherited;  // just to make it public :-)
end;

{##############################################################################}

procedure TLbSpeedButton.DoStep(Sender: TObject);
begin
   if csDestroying in ComponentState then exit;

   dec(FHotTrackStep);
   if FHotTrackStep <= 0 then
   begin
      if Assigned(FThread) and (not FThread.Suspended) then FThread.Suspend;
      FHotTrackStep := 0;
   end;

   if FTransparent then invalidate else paint;
end;

{##############################################################################}

end.
