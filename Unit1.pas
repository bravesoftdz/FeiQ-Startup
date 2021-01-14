unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Registry, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{$R UAC.res}//请求UAC权限声明

procedure TForm1.Button1Click(Sender: TObject);
var
  Reg:TRegistry;//首先定义一个TRegistry类型的变量Reg
begin
  if Edit1.Text <> '' then
  begin
    Reg:=TRegistry.Create;//创建一个新键
    Reg.RootKey:=HKEY_LOCAL_MACHINE;//将根键设置为HKEY_LOCAL_MACHINE
    Reg.OpenKey('SOFTWARE\Microsoft\windows\CurrentVersion\Run',true);//打开一个键
    Reg.WriteString('FEIQ',PChar('"' + Edit1.Text + '"' +' ' +'1'));//在Reg这个键中写入数据名称和数据数值
    Reg.CloseKey;//关闭键
  end
  else
  MessageBox(Handle,'还未选择飞秋路径！','提示',MB_OK + MB_ICONASTERISK);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if opendialog1.Execute then
edit1.text:=opendialog1.FileName ;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Reg:TRegistry;//首先定义一个TRegistry类型的变量Reg
begin
  Reg:=TRegistry.Create;//创建一个新键
  Reg.RootKey:=HKEY_LOCAL_MACHINE;//将根键设置为HKEY_LOCAL_MACHINE
  Reg.OpenKey('SOFTWARE\Microsoft\windows\CurrentVersion\Run',true);//打开一个键
  Reg.DeleteValue('FEIQ');//删除注册表键值
  Reg.CloseKey;//关闭键
  MessageBox(Handle,'已经取消飞秋开机启动！','提示',MB_OK + MB_ICONASTERISK);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//  AnimateWindow(Self.Handle, 500, aw_center or AW_Hide);//500为关闭窗口时间，单位是ms
  Application.Terminate;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  AnimateWindow(Self.Handle, 500, aw_center or AW_Hide);//500为关闭窗口时间，单位是ms
end;

procedure TForm1.Timer1Timer(Sender: TObject);//添加Timer组件
begin
  if Self.AlphaBlendValue <= 250 then
    Self.AlphaBlendValue := Self.AlphaBlendValue + 5;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Self.AlphaBlend := True;
  //Self.AlphaBlendValue := 0;
end;

end.
