unit formmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, attabs, StdCtrls, math, XPMan;

type
  TForm1 = class(TForm)
    chkFlat: TCheckBox;
    chkShowPlus: TCheckBox;
    chkAngled: TCheckBox;
    chkGap: TCheckBox;
    chkVarWidth: TCheckBox;
    chkMultiline: TCheckBox;
    Label1: TLabel;
    chkPosTop: TRadioButton;
    chkPosBtm: TRadioButton;
    chkPosLeft: TRadioButton;
    chkPosRight: TRadioButton;
    chkCenterCaption: TCheckBox;
    XPManifest1: TXPManifest;
    Label2: TLabel;
    btnThemeBlue1: TButton;
    btnThemeBlack1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure chkFlatClick(Sender: TObject);
    procedure chkShowPlusClick(Sender: TObject);
    procedure chkAngledClick(Sender: TObject);
    procedure chkGapClick(Sender: TObject);
    procedure chkVarWidthClick(Sender: TObject);
    procedure chkMultilineClick(Sender: TObject);
    procedure chkCenterCaptionClick(Sender: TObject);
    procedure chkPosTopClick(Sender: TObject);
    procedure chkPosBtmClick(Sender: TObject);
    procedure chkPosLeftClick(Sender: TObject);
    procedure chkPosRightClick(Sender: TObject);
    procedure btnThemeBlue1Click(Sender: TObject);
    procedure btnThemeBlack1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetTheme(const SName: string);
  public
    { Public declarations }
    t: TATTabs;
    procedure TabPlusClick(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  t:= TATTabs.Create(Self);
  t.Parent:= Self;
  t.Align:= alTop;
  t.OptTabHeight:= 40;
  t.Height:= 50;

  t.AddTab(-1, 'tab first', nil, true, clGreen);
  t.AddTab(-1, WideString('юникод строка ')+WideChar($1020)+WideChar($2020));
  t.AddTab(-1, 'tab'#10'multiline'#10'caption', nil, false, clYellow);
  t.OnTabPlusClick:= TabPlusClick;

  t.ColorBg:= clWhite;
  t.OptMouseDragEnabled:= true;
  t.Invalidate;
end;

procedure TForm1.SetTheme(const SName: string);
var
  dir: string;
  Data: TATTabTheme;
begin
  dir:= ExtractFileDir(ExtractFileDir(Application.ExeName))+
    '\'+'img_themes'+
    '\'+SName;

  if not DirectoryExists(dir) then
  begin
    ShowMessage('Theme folder not found:'#10+dir);
    exit;
  end;

  Data.FileName_Left:= dir+'\'+'l.png';
  Data.FileName_Right:= dir+'\'+'r.png';
  Data.FileName_Center:= dir+'\'+'c.png';
  Data.FileName_LeftActive:= dir+'\'+'l_a.png';
  Data.FileName_RightActive:= dir+'\'+'r_a.png';
  Data.FileName_CenterActive:= dir+'\'+'c_a.png';
  Data.FileName_CenterActive:= dir+'\'+'c_a.png';
  Data.FileName_X:= dir+'\'+'x.png';
  Data.FileName_XActive:= dir+'\'+'x_a.png';

  Data.SpaceBetweenInPercentsOfSide:= 150;
  Data.IndentOfX:= 2;
    
  t.SetTheme(Data);
  t.Invalidate;
end;

procedure TForm1.TabPlusClick(Sender: TObject);
begin
  t.AddTab(-1, 'tab'+IntToStr(t.TabCount));
  t.Invalidate;
end;

procedure TForm1.chkFlatClick(Sender: TObject);
begin
  t.OptShowFlat:= chkFlat.Checked;
  t.Invalidate;
end;

procedure TForm1.chkShowPlusClick(Sender: TObject);
begin
  t.OptShowPlusTab:= chkShowPlus.Checked;
  t.Invalidate;
end;

procedure TForm1.btnThemeBlue1Click(Sender: TObject);
begin
  SetTheme('blue_simple');
end;

procedure TForm1.chkAngledClick(Sender: TObject);
begin
  t.OptShowAngled:= chkAngled.Checked;
  t.OptSpaceInitial:= IfThen(chkAngled.Checked, 10, 4);
  t.Invalidate;
end;

procedure TForm1.chkGapClick(Sender: TObject);
begin
  t.OptSpaceBetweenTabs:= IfThen(chkGap.Checked, 6, 0);
  t.Invalidate;
end;

procedure TForm1.chkVarWidthClick(Sender: TObject);
begin
  t.OptVarWidth:= chkVarWidth.Checked;
  t.Invalidate;
end;

procedure TForm1.chkMultilineClick(Sender: TObject);
begin
  t.OptMultiline:= chkMultiline.Checked;
  t.Invalidate;
end;

procedure TForm1.btnThemeBlack1Click(Sender: TObject);
begin
  SetTheme('black_wide');
end;

procedure TForm1.chkCenterCaptionClick(Sender: TObject);
begin
  if chkCenterCaption.Checked then
    t.OptCaptionAlignment:= taCenter
  else
    t.OptCaptionAlignment:= taLeftJustify;
  t.Invalidate;
end;

procedure TForm1.chkPosTopClick(Sender: TObject);
begin
  t.Align:= alTop;
  t.OptPosition:= atpTop;
  t.Height:= 50;
  t.Invalidate;
end;

procedure TForm1.chkPosBtmClick(Sender: TObject);
begin
  t.Align:= alBottom;
  t.OptPosition:= atpBottom;
  t.Height:= 50;
  t.Invalidate;
end;

procedure TForm1.chkPosLeftClick(Sender: TObject);
begin
  t.Align:= alLeft;
  t.OptPosition:= atpLeft;
  t.Width:= 140;
  t.Invalidate;
end;

procedure TForm1.chkPosRightClick(Sender: TObject);
begin
  t.Align:= alRight;
  t.OptPosition:= atpRight;
  t.Width:= 140;
  t.Invalidate;
end;

end.
