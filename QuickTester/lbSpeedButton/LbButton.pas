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

unit LbButton;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ImgList, ActnList, LbButtons, Dialogs;

type
   TLbButton = class(TCustomControl)
   private
      FAlignment: TAlignment;
      FShadowColor: TColor;
      FColorWhenDown: TColor;
      FEnabled: boolean;
      FFlat: boolean;
      FWordWrap: boolean;
      FGlyph: TBitmap;
      FHotTrackColor: TColor;
      FHTFont: TFont;
      FKind: TLbButtonKind;
      FLayout: TLbButtonLayout;
      FLightColor: TColor;
      FModalResult: TModalResult;
      FNumGlyphs: integer;
      FUseHTFont: boolean;
      FOnClick: TNotifyEvent;
      FOnMouseEnter: TNotifyEvent;
      FOnMouseExit: TNotifyEvent;
      FDummyStyle: TLbColorStyle;
      FStyle: TLbButtonStyle;
      FDefault, FCancel: boolean;
      FSlowDecease: boolean;
      bDown: boolean;
      bCursorOnButton: boolean;
      FThread: TLbButtonThread;
      FHotTrackStep: integer;
   public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      procedure Click; override;
   protected
      function GetCaption: TCaption;

      procedure SetAlignment(fNew: TAlignment);
      procedure SetCaption(const fNew: TCaption);
      procedure SetEnabled(fNew: boolean); override;
      procedure SetFlat(fNew: boolean);
      procedure SetGlyph(fNew: TBitmap);
      procedure SetHTFont(fNew: TFont);
      procedure SetKind(fNew: TLbButtonKind);
      procedure SetLayout(fNew: TLbButtonLayout);
      procedure SetLightColor(fNew: TColor);
      procedure SetModalResult(fNew: TModalResult);
      procedure SetNumGlyphs(fNew: integer);
      procedure SetStyle(fNew: TLbButtonStyle);
      procedure SetShadowColor(fNew: TColor);
      procedure SetColorStyle(fNew: TLbColorStyle);
      procedure SetWordWrap(fNew: boolean);
      procedure SetSlowDecease(fNew: boolean);

      procedure DoMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure DoMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure DoFocusChanged(var Msg: TMessage); message CM_FOCUSCHANGED;
      procedure DoKeyDown(var Msg: TMessage); message CN_KEYDOWN;
      procedure DoKeyUp(var Msg: TMessage); message CN_KEYUP;
      procedure DoDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
      procedure DoDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;

//      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

      procedure Paint; override;
      procedure DoStep(Sender: TObject);
      procedure DoClick;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
   published
      property Action;
      property Align;
      property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
      property Anchors;
      property Cancel: boolean read FCancel write FCancel default false;
      property Caption: TCaption read GetCaption write SetCaption;
      property Color;
      property ColorStyle: TLbColorStyle read FDummyStyle write SetColorStyle default lcsCustom;
      property ColorWhenDown: TColor read FColorWhenDown write FColorWhenDown default clNone;
      property Default: boolean read FDefault write FDefault default false;
      property DragCursor;
      property DragKind;
      property DragMode;
//      property Enabled: boolean read FEnabled write SetEnabled default true;
      property Enabled;
      property Flat: boolean read FFlat write SetFlat default false;
      property Font;
      property Glyph: TBitmap read FGlyph write SetGlyph;
      property Hint;
      property HotTrackColor: TColor read FHotTrackColor write FHotTrackColor default clNone;
      property HotTrackFont: TFont read FHTFont write SetHTFont;
      property Kind: TLbButtonKind read FKind write SetKind default bkCustom;
      property Layout: TLbButtonLayout read FLayout write SetLayout default blGlyphLeft;
      property LightColor: TColor read FLightColor write SetLightColor default clWhite;
      property ModalResult: TModalResult read FModalResult write SetModalResult;
      property NumGlyphs: integer read FNumGlyphs write SetNumGlyphs default 0;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShadowColor: TColor read FShadowColor write SetShadowColor default clGray;
      property ShowHint;
      property SlowDecease: boolean read FSlowDecease write SetSlowDecease default false;
      property Style: TLbButtonStyle read FStyle write SetStyle default bsNormal;
      property TabOrder;
      property TabStop default true;
      property UseHotTrackFont: boolean read FUseHTFont write FUseHTFont;
      property Visible;
      property WordWrap: boolean read FWordWrap write SetWordWrap default false;

      property OnClick: TNotifyEvent read FOnClick write FOnClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
      property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
      property OnMouseMove;
      property OnMouseUp;
      property OnStartDrag;
   end;

procedure Register;

implementation

{##############################################################################}

procedure Register;
begin
   RegisterComponents('LB', [TLbButton]);
end;

{##############################################################################}

constructor TLbButton.Create(aOwner: TComponent);
begin
   inherited;

   Height := 23;
   Width := 100;

   ControlStyle := [csSetCaption, csCaptureMouse];

   FGlyph := TBitmap.Create;
   FHTFont := TFont.Create;

   bDown := false;
   bCursorOnButton := false;

   FLightColor := clWhite;
   FShadowColor := clGray;
   FColorWhenDown := clNone;
   FEnabled := true;
   FStyle := bsNormal;
   FKind := bkCustom;
   TabStop := true;
   FDummyStyle := lcsCustom;
   FHotTrackColor := clNone;
   FAlignment := taCenter;
   FWordWrap := false;

   FDefault := false;
   FCancel := false;

   Color := clBtnFace;
   FThread := TLbButtonThread.Create(DoStep);
   FThread.FreeOnTerminate := false;

   if aOwner is TForm then FHtFont.Assign(TForm(aOwner).Font);
end;

{##############################################################################}

destructor TLbButton.Destroy;
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

procedure TLbButton.DoClick;
begin
   if Visible and Enabled and bDown then
   begin
      bDown := false;
      if assigned(FOnClick) then FOnClick(self);
      if FModalResult <> mrNone then GetParentForm(self).ModalResult := FModalResult;
      if assigned(PopupMenu) then PopupMenu.PopUp(ClientToScreen(Point(0, Height)).X, ClientToScreen(Point(0, Height)).Y);
   end;
end;

{##############################################################################}

procedure TLbButton.Click;
begin
   bDown := true;
   DoClick;
   inherited;
end;

{##############################################################################}

procedure TLbButton.SetAlignment(fNew: TAlignment);
begin
   FAlignment := fNew;
   Paint;
end;

{##############################################################################}

procedure TLbButton.SetCaption(const fNew: TCaption);
begin
   inherited Caption := fNew;
   Invalidate;
end;

{##############################################################################}

function TLbButton.GetCaption: TCaption;
begin
   result := inherited Caption;
end;

{##############################################################################}

procedure TLbButton.SetColorStyle(fNew: TLbColorStyle);
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

procedure TLbButton.SetEnabled(fNew: boolean);
begin
   inherited;
   FEnabled := fNew;
   bDown := false;
   Paint;
end;

{##############################################################################}

procedure TLbButton.SetFlat(fNew: boolean);
begin
   FFlat := fNew;
   Paint;
end;

{##############################################################################}

procedure TLbButton.SetGlyph(fNew: TBitmap);
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
   FKind := bkCustom;
   Invalidate;
end;

{##############################################################################}

procedure TLbButton.SetHTFont(fNew: TFont);
begin
   FHTFont.Assign(fNew);
end;

{##############################################################################}

procedure TLbButton.SetKind(fNew: TLbButtonKind);
begin
   if fNew <> bkCustom then FNumGlyphs := 2;
   case fNew of
      bkOK:     begin ModalResult := mrOK;      FGlyph.LoadFromResourceName(hInstance, 'LBOK');      Caption := 'OK';           end;
      bkCancel: begin ModalResult := mrCancel;  FGlyph.LoadFromResourceName(hInstance, 'LBCANCEL');  Caption := 'Abbrechen';    end;
      bkHelp:   begin ModalResult := mrNone;    FGlyph.LoadFromResourceName(hInstance, 'LBHELP');    Caption := 'Hilfe';        end;
      bkYes:    begin ModalResult := mrYes;     FGlyph.LoadFromResourceName(hInstance, 'LBYES');     Caption := 'Ja';           end;
      bkNo:     begin ModalResult := mrNo;      FGlyph.LoadFromResourceName(hInstance, 'LBNO');      Caption := 'Nein';         end;
      bkClose:  begin ModalResult := mrNone;    FGlyph.LoadFromResourceName(hInstance, 'LBCLOSE');   Caption := 'Schlieﬂen';    end;
      bkAbort:  begin ModalResult := mrAbort;   FGlyph.LoadFromResourceName(hInstance, 'LBABORT');   Caption := 'Abbrechen';    end;
      bkRetry:  begin ModalResult := mrRetry;   FGlyph.LoadFromResourceName(hInstance, 'LBRETRY');   Caption := 'Wiederholen';  end;
      bkIgnore: begin ModalResult := mrIgnore;  FGlyph.LoadFromResourceName(hInstance, 'LBIGNORE');  Caption := 'Ignorieren';   end;
      bkAll:    begin ModalResult := mrAll;     FGlyph.LoadFromResourceName(hInstance, 'LBALL');     Caption := 'Alle';         end;
   end;

   FKind := fNew;
   Invalidate;
end;

{##############################################################################}

procedure TLbButton.SetLayout(fNew: TLbButtonLayout);
begin
   FLayout := fNew;
   Paint;
end;

{##############################################################################}

procedure TLbButton.SetNumGlyphs(fNew: integer);
begin
   FNumGlyphs := fNew;
   Invalidate;
end;

{##############################################################################}

procedure TLbButton.SetModalResult(fNew: TModalResult);
begin
   FModalResult := fNew;
   FKind := bkCustom;
end;

{##############################################################################}

procedure TLbButton.SetLightColor(fNew: TColor);
begin
   FLightColor := fNew;
   Paint;
end;

{##############################################################################}

procedure TLbButton.SetShadowColor(fNew: TColor);
begin
   FShadowColor := fNew;
   Paint;
end;

{##############################################################################}

procedure TLbButton.SetSlowDecease(fNew: boolean);
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

procedure TLbButton.SetStyle(fNew: TLbButtonStyle);
begin
   FStyle := fNew;
   if fStyle in [bsModern, bsShape, bsQuicken] then SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_TRANSPARENT) else SetWindowLong(Handle, GWL_EXSTYLE, 0);
   Invalidate;
end;

{##############################################################################}

procedure TLbButton.SetWordWrap(fNew: boolean);
begin
   FWordWrap := fNew;
   Paint;
end;

{##############################################################################}

procedure TLbButton.DoMouseEnter(var Msg: TMessage);
begin
   if Enabled and Visible and (Parent <> nil) and Parent.Showing then
   begin
      bCursorOnButton := true;
      FHotTrackStep := cHotTrackSteps;
      Paint;
      if assigned(FOnMouseEnter) then FOnMouseEnter(self);
   end;
end;

{##############################################################################}

procedure TLbButton.DoMouseLeave(var Msg: TMessage);
begin
   bCursorOnButton := false;
   if FSlowDecease then
   begin
      if Assigned(FThread) and (FThread.Suspended) then FThread.Resume;
   end
   else
   begin
      FHotTrackStep := 0;
      Paint;
   end;
   if Enabled and Visible and (Parent <> nil) and Parent.Showing then if assigned(FOnMouseExit) then FOnMouseExit(self);
end;

{##############################################################################}

procedure TLbButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if Enabled and (Button = mbLeft) then
   begin
      bDown := true;
      SetFocus;
      Paint;
   end;
end;

{##############################################################################}

procedure TLbButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
//   if bCursorOnButton then Click;
   if bDown then Click;
   bDown := false;
   Paint;
end;

{##############################################################################}

procedure TLbButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

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

procedure TLbButton.DoFocusChanged(var Msg: TMessage);
begin
   Paint;
end;

{##############################################################################}

procedure TLbButton.DoKeyDown(var Msg: TMessage);
begin
   inherited;
   if Enabled then if Msg.WParam in [VK_SPACE, VK_RETURN] then
   begin
      bDown := true;
      Paint;
   end;
end;

{##############################################################################}

procedure TLbButton.DoKeyUp(var Msg: TMessage);
begin
   inherited;
   if Msg.WParam in [VK_SPACE, VK_RETURN] then Click;
   Paint;
end;

{##############################################################################}

procedure TLbButton.Paint;
var
   aBitmap: TBitmap;
   aFont: TFont;

begin
   if not (Visible or (csDesigning in ComponentState)) or (csLoading in ComponentState) or (csDestroying in ComponentState) then exit;

   // Draw on a Bitmap first, then just copy the Bitmap to the Canvas. Just to avoid flickering...
   aBitmap := TBitmap.Create;
   aBitmap.Height := Height;
   aBitmap.Width := Width;

   aFont := TFont.Create;
   aFont.Assign(Font);
   if (bCursorOnButton or focused) and FUseHTFont then aFont.Assign(FHtFont);

   if FStyle in [bsShape, bsModern, bsQuicken] then
   begin
      aBitmap.TransparentMode := tmAuto;
      aBitmap.Transparent := True;
      aBitmap.Canvas.Brush.Color := clFuchsia;
      aBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
      aBitmap.TransparentColor := clFuchsia;
   end;

   if (FStyle = bsOld) and Focused then
   begin
      if bDown then LbPaintButton(aBitmap.Canvas, Width-2, Height-2, FHotTrackStep, FNumGlyphs, FGlyph, bDown, bCursorOnButton or focused, false, Enabled, Flat, FWordWrap, assigned(PopupMenu), FStyle, Color, FColorWhenDown, FHotTrackColor, FShadowColor, FShadowColor, aFont, FLayout, Caption, FAlignment)
      else LbPaintButton(aBitmap.Canvas, Width-2, Height-2, FHotTrackStep, FNumGlyphs, FGlyph, bDown, bCursorOnButton or focused, false, Enabled, Flat, FWordWrap, assigned(PopupMenu), FStyle, Color, FColorWhenDown, FHotTrackColor, FLightColor, FShadowColor, aFont, FLayout, Caption, FAlignment);
      aBitmap.Canvas.Draw(1, 1, aBitmap);
      aBitmap.Canvas.Brush.Style := bsClear;
      aBitmap.Canvas.Pen.Color := clBlack;
      aBitmap.Canvas.Rectangle(0, 0, Width, Height);
   end
   else
      LbPaintButton(aBitmap.Canvas, Width, Height, FHotTrackStep, FNumGlyphs, FGlyph, bDown, bCursorOnButton or focused, false, Enabled, Flat, FWordWrap, assigned(PopupMenu), FStyle, Color, FColorWhenDown, FHotTrackColor, FLightColor, FShadowColor, aFont, FLayout, Caption, FAlignment);

   Canvas.Draw(0, 0, aBitmap);

   aFont.Free;
   aBitmap.Free;

   if focused and enabled and (FStyle <> bsShape) then Canvas.DrawFocusRect(Rect(4, 4, Width-4, Height - 4));
end;

{##############################################################################}

procedure TLbButton.DoDialogChar(var Message: TCMDialogChar);
begin
   with Message do
   begin
      if IsAccel(CharCode, Caption) and Visible and Enabled and (Parent <> nil) and Parent.Showing then
      begin
         bDown := true;
         Click;
         Result := 1;
      end
      else
         inherited;
   end;
end;

{##############################################################################}

procedure TLbButton.DoDialogKey(var Message: TCMDialogKey);

   function OwnerForm(From: TComponent): TComponent;
   begin
      if From is TForm then Result := From else Result := OwnerForm(From.Owner);
   end;

begin
   with Message do
   begin
      if (((CharCode = VK_RETURN) and FDefault) or ((CharCode = VK_ESCAPE) and FCancel) and (KeyDataToShiftState(Message.KeyData) = []) and Visible and Enabled) and ((pos('BUTTON', ansiuppercase(TForm(OwnerForm(self)).activecontrol.classname)) = 0) or (pos('RADIOBUTTON', ansiuppercase(TForm(OwnerForm(self)).activecontrol.classname)) > 0)) then
      begin
         bDown := true;
         Click;
         Result := 1;
      end
      else
         inherited;
   end;
end;

{##############################################################################}

procedure TLbButton.DoStep(Sender: TObject);
begin
   if csDestroying in ComponentState then exit;
   
   dec(FHotTrackStep);
   if FHotTrackStep <= 0 then
   begin
      if Assigned(FThread) and (not FThread.Suspended) then FThread.Suspend;
      FHotTrackStep := 0;
   end;

   Paint;
end;

{##############################################################################}

end.
