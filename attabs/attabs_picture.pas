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

end.

