unit unitFrmB01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DB;

type

  { TFrmB01 }

  TFrmB01 = class(TForm)
    ButEid: TButton;
    ButName: TButton;
    DBGrid1: TDBGrid;
    EditQueryStr: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure ButEidClick(Sender: TObject);
    procedure ButNameClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmB01: TFrmB01;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmB01 }

procedure TFrmB01.ButEidClick(Sender: TObject);
begin
  if not Frm000.SQLQueryEmployee.Locate('員工編號',EditQueryStr.Text,[loPartialKey]) then begin
    showmessage('查無此員工編號');
  end;
end;

procedure TFrmB01.ButNameClick(Sender: TObject);
begin
  if not Frm000.SQLQueryEmployee.Locate('姓名',EditQueryStr.Text,[loPartialKey]) then begin
    showmessage('查無此員工姓名');
  end;
end;

procedure TFrmB01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmB01:=nil;
end;

end.

