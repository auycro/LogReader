//Copyright (c) 2014 Gumpanat Keardkeawfa
//Licensed under the MIT license

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //ドラックアンドドロップ
    procedure DropFiles(var Msg: TWMDROPFILES);message WM_DROPFILES;
    procedure ReadLog;
  end;

var
  Form1: TForm1;
  LogFileStream: TStream;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
//var ext: String;
begin
    //ext:= ExtractFileExt(Edit1.Text);

    if Timer1.Enabled then
    begin
      Timer1.Enabled:= False;
      Button1.Caption:= 'Press for Start';
      Edit1.Enabled:=True;
      //LogFileStream.Free;
    end else
    begin
      Timer1.Enabled:=True;
      Button1.Caption:= 'Press for Stop';
      Edit1.Enabled:=False;
      //LogFileStream:= TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyNone);
      //ReadLog;
    end;

    Form1.Caption:= Edit1.Text;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
    if CheckBox1.Checked then
    begin
        Form1.FormStyle:= fsStayOnTop;
    end else
    begin
        Form1.FormStyle:= fsNormal;
    end;
end;

//ドラックアンドドロップ
procedure TForm1.DropFiles(var Msg: TWMDROPFILES);
var
    FileName: array [0..MAX_PATH] of Char;
begin
    try
        DragQueryFile(Msg.Drop, 0, FileName, SizeOf(FileName)-1);

        Edit1.Text := FileName;
        Edit1.SelStart:= Length(Edit1.Text);
    finally
        DragFinish(Msg.Drop);
    end;
end;

//ドラックアンドドロップ
procedure TForm1.FormCreate(Sender: TObject);
begin
    DragAcceptFiles(Self.Handle,true);
    //LogFileStream:= TStream.Create;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    //Memo1.Lines.LoadFromStream(LogFileStream);
    //Memo1.ScrollBy(0,Memo1.Lines.Count);
    //Memo1.Refresh;
    //Memo1.SelStart:= Memo1.Lines.Count;
    //Memo1.SelLength:= 0;
    //SendMessage(Memo1.Handle, EM_SCROLL, SB_LINEDOWN, 0);
    //SendMessage(Memo1.Handle, EM_LINESCROLL, 0,Memo1.Lines.Count);
    //ReadLog;
    try
        ReadLog;
    except
        ShowMessage('Error');
        Timer1.Enabled:=False;
        Application.Terminate;
    end;

end;

procedure TForm1.ReadLog;
begin
    try
      LogFileStream:= TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyNone);
      Memo1.Lines.LoadFromStream(LogFileStream);
      Memo1.SelStart:= Memo1.Lines.Count;
      Memo1.SelLength:= 0;
      //SendMessage(Memo1.Handle, EM_SCROLL, SB_LINEDOWN, 0);
      SendMessage(Memo1.Handle, EM_LINESCROLL, 0,Memo1.Lines.Count);
    finally
      LogFileStream.Free;
    end;

end;

end.
