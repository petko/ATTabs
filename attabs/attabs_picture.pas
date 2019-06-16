unit ATTabs_Picture;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type
  { TATTabsPicture }

  TATTabsPicture = class
  private
    FPic: TPortableNetworkGraphic;
    FFileName: string;
    FWidth: integer;
    FHeight: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(const AFileName: string);
    property Width: integer read FWidth;
    property Height: integer read FHeight;
    procedure Draw(C: TCanvas; X, Y: integer);
    procedure DrawSized(C: TCanvas; X, Y, AWidth: integer);
  end;

implementation

{ TATTabsPicture }

constructor TATTabsPicture.Create;
begin
  FPic:= TPortableNetworkGraphic.Create;
end;

destructor TATTabsPicture.Destroy;
begin
  FreeAndNil(FPic);
  inherited;
end;

procedure TATTabsPicture.LoadFromFile(const AFileName: string);
begin
  if not FileExists(AFileName) then exit;
  FFileName:= AFileName;
  FPic.LoadFromFile(AFileName);
  FPic.Transparent:= true;
  FWidth:= FPic.Width;
  FHeight:= FPic.Height;
end;

procedure TATTabsPicture.Draw(C: TCanvas; X, Y: integer);
begin
  C.Draw(X, Y, FPic);
end;

procedure TATTabsPicture.DrawSized(C: TCanvas; X, Y, AWidth: integer);
var
  NDiv, NMod, i: integer;
begin
  NDiv:= AWidth div FWidth;
  NMod:= AWidth mod FWidth;

  for i:= 0 to NDiv-1 do
    C.Draw(X+i*FWidth, Y, FPic);

  if NMod>0 then
    C.StretchDraw(
      Rect(X+NDiv*FWidth, Y, X+AWidth+1, Y+FHeight),
      FPic);
end;

end.

