unit unitFrmF01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,DB;

type

  { TFrmF01 }

  TFrmF01 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    EditEName: TEdit;
    EditBirthday: TEdit;
    EditRecord: TEdit;
    EditEID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmF01: TFrmF01;

implementation
uses unitfrm000;

{$R *.lfm}

{ TFrmF01 }

procedure TFrmF01.Button1Click(Sender: TObject);
begin
    if not Frm000.SQLQueryBirthday.Locate('員工編號',EditEID.Text,[loPartialKey]) then begin
    showmessage('查無 此員工編號');
  end;
  EditEID.text:=Frm000.SQLQueryBirthday.fieldbyName('員工編號').value;
  if Frm000.SQLQueryBirthday.FieldbyName('員工姓名').IsNull then
       EditEName.Text:=''
  else
       EditEName.text:=Frm000.SQLQueryBirthday.fieldbyName('員工姓名').value;

  if Frm000.SQLQueryBirthday.FieldbyName('生日').IsNull then
       EditBirthday.Text:=''
  else
       EditBirthday.text:=Frm000.SQLQueryBirthday.fieldbyName('生日').value;

  if Frm000.SQLQueryBirthday.FieldbyName('發放紀錄').IsNull then
       EditRecord.Text:=''
  else
       EditRecord.text:=Frm000.SQLQueryBirthday.fieldbyName('發放紀錄').value;

  FrmF01.EditEName.enabled:=False;
  FrmF01.EditBirthday.enabled:=False;
  FrmF01.EditRecord.enabled:=False;
end;

procedure TFrmF01.DBGrid1CellClick(Column: TColumn);
begin

end;

procedure TFrmF01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmF01:=nil;
end;

end.

