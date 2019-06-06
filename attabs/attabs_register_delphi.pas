unit attabs_register_delphi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Menus,
  Forms, ExtCtrls, Math, StrUtils, Vcl.AppEvnts, System.UITypes,TypInfo,
  System.Types, DesignIntf, DesignEditors, ImgList, VCLEditors, ATTabs, dialogs;

type
  TImageIndexProperty = class(TIntegerProperty,
    ICustomPropertyListDrawing)
  private
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetImageListAt(Index: Integer): TCustomImageList; virtual;
    procedure GetValues(Proc: TGetStrProc); override;
end;

procedure Register;

implementation

function TImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

function TImageIndexProperty.GetImageListAt(Index: Integer): TCustomImageList;
begin

  Result := nil; //default

  //This won't work without casting the collection to TATTabListCollection
  //(see below) which has an "AOwner" property, but I kept this in as a
  //reference... SRD
  //if GetComponent(Index) is TATTabData then
  //if (GetComponent(Index) as TATTabData).Collection.Owner is TATTabs then
  //  Result := ((GetComponent(Index) as TATTabData).Collection.Owner as TATTabs).Images;

  //Basic idea from:
  //https://stackoverflow.com/questions/41345168/delphi-component-design-get-property-from-component-from-subproperty
  if GetComponent(Index) is TATTabData then
  if TATTabListCollection((GetComponent(Index) as TATTabData).Collection).AOwner is TATTabs then
  begin
    Result := TATTabs(TATTabListCollection((GetComponent(Index) as TATTabData).Collection).AOwner).Images;
    //debug use:
    //ShowMessage( FTabListCollection((GetComponent(Index) as TATTabData).Collection).AOwner.Name );
    exit;
  end;

end;

procedure TImageIndexProperty.GetValues(Proc: TGetStrProc);
var
  ImgList: TCustomImageList;
  i: Integer;
begin
  ImgList := GetImageListAt(0);
  if Assigned(ImgList) then
    for i := 0 to ImgList.Count - 1 do
      Proc(IntToStr(i));
end;

procedure TImageIndexProperty.ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  ImgList: TCustomImageList;
  R: TRect;
begin
  ImgList := GetImageListAt(0);
  ACanvas.FillRect(ARect);
  R := ARect;
  Inc(R.Left, 2);
  if Assigned(ImgList) then
  begin
    ImgList.Draw(ACanvas, R.Left, R.Top + 2, StrToInt(Value));
    Inc(R.Left, ImgList.Width + 2);
  end;
  DefaultPropertyListDrawValue(Value, ACanvas, R, ASelected);
end;

procedure TImageIndexProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);
var
  ImgList: TCustomImageList;
begin
  ImgList := GetImageListAt(0);
  AHeight := ACanvas.TextHeight(Value) + 2;
  if Assigned(ImgList) then
    AHeight := Max(AHeight, ImgList.Height + 4);
end;

procedure TImageIndexProperty.ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);
var
  ImgList: TCustomImageList;
begin
  ImgList := GetImageListAt(0);
  AWidth := ACanvas.TextWidth(Value) + 4;
  if Assigned(ImgList) then
    AWidth := Max(AWidth, ImgList.Width + 4);
end;

procedure Register;
begin
  RegisterComponents('Misc', [TATTabs]);

  //Note: Using '' as the PropertyName param lets this work for ALL imageindexes
  //in the component IF you are using ONLY ONE imagelist. SRD

  //Note: Either of these below will work. I chose to use the one that targets
  //the "TabImageIndex" PropertyName explicitly since there is only one
  //imagelist in the component and one place where the image previews are
  //needed when in the IDE. SRD

  //RegisterPropertyEditor(TypeInfo( TImageIndex ), TATTabData , '', TImageIndexProperty);
  RegisterPropertyEditor(TypeInfo( TImageIndex ), TATTabData , 'TabImageIndex', TImageIndexProperty);

end;

initialization

end.

