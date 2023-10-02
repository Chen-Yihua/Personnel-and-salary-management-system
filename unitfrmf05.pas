unit unitFrmF05;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DB,
  DateTimePicker;

type

  { TFrmF05 }

  TFrmF05 = class(TForm)
    ButUpdate: TButton;
    ButDelete: TButton;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    EditEID: TEdit;
    EditEName: TEdit;
    EditMApprovalstatus: TEdit;
    EditMDisstatus: TEdit;
    EditMarriage: TEdit;
    EditMApplyDate: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure ButDeleteClick(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure DateTimePicker2DblClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EditMApplyDateClick(Sender: TObject);
    procedure EditMarriageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FrmF05: TFrmF05;
  E:TEdit;
  F:TEdit;

implementation uses unitfrm000;

{$R *.lfm}

{ TFrmF05 }

procedure TFrmF05.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  FrmF05:=nil;
end;

procedure TFrmF05.FormCreate(Sender: TObject);
begin
  EditMarriage.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
  EditMApplyDate.text:=DatetimeToStr(Date);
  DateTimePicker2.date:=now;
end;

procedure TFrmF05.Label1Click(Sender: TObject);
begin

end;

procedure TFrmF05.ButUpdateClick(Sender: TObject);
var sqlstr: string;
begin
  if (length(EditEID.Text)>0) and Frm000.SQLQueryWedding.Locate('員工編號',EditEID.Text,[loPartialKey]) then
    if messageDlg('確定要修改結婚禮金資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      with Frm000.SQLQueryWedding1 do
       begin
         Try
             sqlstr:='update 結婚禮金資料 set 員工姓名= :ename,結婚日期=:marriage ,申請日期=:mapplydate ,核准狀況=:mapprovalstatus ,發放狀況=:mdisstatus where員工編號=:EID';
             SQL.Text := sqlstr;
             Params.ParamByName('ename').AsString:=EditEName.Text;
             Params.ParamByName('marriage').AsString:=EditMarriage.Text;
             Params.ParamByName('mapplydate').AsString:=EditMApplyDate.Text;
             Params.ParamByName('mapprovalstatus').AsString:=EditMApprovalstatus.Text;
             Params.ParamByName('mdisstatus').AsString:=EditMDisstatus.Text;
             Params.ParamByName('EID').AsString:=EditEID.Text;

             ExecSQL;
             Close;
             Frm000.SQLTransactionWedding1.Commit;
         except
             showmessage('資料修改時發生錯誤');
         end;
       end;
         Frm000.SQLQueryWedding.Refresh;
         Frm000.SQLQueryWedding.Locate('員工編號',EditEID.Text,[loPartialKey])
    end;

end;

procedure TFrmF05.ButDeleteClick(Sender: TObject);
var sqlstr: string;
begin
  if(length(EditEID.Text)>0) and Frm000.SQLQueryWedding.Locate('員工編號',EditEID.Text,[loPartialKey]) then
    if messageDlg('確定要刪除子女獎金資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      with Frm000.SQLQueryWedding1 do
       begin
         Try
             sqlstr:='delete from 員工 where 員工編號= '''+ EditEID.Text +'''';
             showmessage(sqlstr);
             SQL.Text := sqlstr;
             ExecSQL;
             Close;
             Frm000.SQLTransactionWedding1.Commit;
             showmessage('資料已經刪除');
         except
             showmessage('資料刪除時發生錯誤');
         end;
       end;
      Frm000.SQLQueryWedding.Refresh;
    end;
end;

procedure TFrmF05.DateTimePicker1DblClick(Sender: TObject);
begin
    E.Text:=DateToStr(DateTimePicker1.date);
    DateTimePicker1.Visible:=False;
end;

procedure TFrmF05.DateTimePicker2DblClick(Sender: TObject);
begin
  F.Text:=DateToStr(DateTimePicker2.date);
  DateTimePicker2.Visible:=False;
end;

procedure TFrmF05.DBGrid1CellClick(Column: TColumn);
begin
  EditEID.text:=Frm000.SQLQueryWedding.FieldByName('員工編號').value;
  if Frm000.SQLQueryWedding.FieldByName('員工姓名').IsNull then
        EditEName.text:=''
  else
        EditEName.text:= Frm000.SQLQueryWedding.FieldByName('員工姓名').value;
  if Frm000.SQLQueryWedding.FieldByName('結婚日期').IsNull then
        EditMarriage.text:=''
  else
        EditMarriage.text:= Frm000.SQLQueryWedding.FieldByName('結婚日期').value;
  if Frm000.SQLQueryWedding.FieldByName('申請日期').IsNull then
        EditMApplyDate.text:=''
  else
        EditMApplyDate.text:= Frm000.SQLQueryWedding.FieldByName('申請日期').value;
  if Frm000.SQLQueryWedding.FieldByName('核准狀況').IsNull then
        EditMApprovalstatus.text:=''
  else
        EditMApprovalstatus.text:= Frm000.SQLQueryWedding.FieldByName('核准狀況').value;
  if Frm000.SQLQueryWedding.FieldByName('發放狀況').IsNull then
        EditMDisstatus.text:=''
  else
        EditMDisstatus.text:= Frm000.SQLQueryWedding.FieldByName('發放狀況').value;
end;

procedure TFrmF05.EditMApplyDateClick(Sender: TObject);
begin
  DateTimePicker2.Visible:=not DateTimePicker2.Visible;
  F:=(Sender as TEdit);
end;

procedure TFrmF05.EditMarriageClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

end.

