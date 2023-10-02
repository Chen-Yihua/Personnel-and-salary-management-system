unit unitFrmF08;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DB,
  DateTimePicker;

type

  { TFrmF08 }

  TFrmF08 = class(TForm)
    ButUpdate: TButton;
    ButDelete: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    EditCDisstatus: TEdit;
    EditEID: TEdit;
    EditEName: TEdit;
    EditChildName: TEdit;
    EditCApprovalstatus: TEdit;
    EditCApplyDate: TEdit;
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
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EditCApplyDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmF08: TFrmF08;
  E:TEdit;
implementation uses unitFrm000;

{$R *.lfm}

{ TFrmF08 }

procedure TFrmF08.DateTimePicker1DblClick(Sender: TObject);
begin
  E.text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmF08.DBGrid1CellClick(Column: TColumn);
begin
    EditEID.text:=Frm000.SQLQueryChild.FieldByName('員工編號').value;
    if Frm000.SQLQueryChild.FieldByName('員工姓名').IsNull then
          EditEName.text:=''
    else
          EditEName.text:= Frm000.SQLQueryChild.FieldByName('員工姓名').value;
    if Frm000.SQLQueryChild.FieldByName('子女姓名').IsNull then
          EditChildName.text:=''
    else
          EditChildName.text:= Frm000.SQLQueryChild.FieldByName('子女姓名').value;
    if Frm000.SQLQueryChild.FieldByName('申請日期').IsNull then
          EditCApplyDate.text:=''
    else
          EditCApplyDate.text:= Frm000.SQLQueryChild.FieldByName('申請日期').value;
    if Frm000.SQLQueryChild.FieldByName('核准狀況').IsNull then
          EditCApprovalstatus.text:=''
    else
          EditCApprovalstatus.text:= Frm000.SQLQueryChild.FieldByName('核准狀況').value;
    if Frm000.SQLQueryChild.FieldByName('發放狀況').IsNull then
          EditCDisstatus.text:=''
    else
          EditCDisstatus.text:= Frm000.SQLQueryChild.FieldByName('發放狀況').value;
end;

procedure TFrmF08.ButUpdateClick(Sender: TObject);
var sqlstr: string;
begin
     if (length(EditEID.Text)>0) and Frm000.SQLQueryChild.Locate('員工編號',EditEID.Text,[loPartialKey]) then
       if messageDlg('確定要修改子女獎金資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
         with Frm000.SQLQueryChild1 do
          begin
            Try
                sqlstr:='update 子女獎金資料 set 員工姓名= :ename,子女姓名=:childname ,申請日期=:capplydate ,核准狀況=:capprovalstatus ,發放狀況=:cdisstatus where員工編號=:EID';
                SQL.Text := sqlstr;
                Params.ParamByName('ename').AsString:=EditEName.Text;
                Params.ParamByName('childname').AsString:=EditChildName.Text;
                Params.ParamByName('capplydate').AsString:=EditCApplyDate.Text;
                Params.ParamByName('capprovalstatus').AsString:=EditCApprovalstatus.Text;
                Params.ParamByName('cdisstatus').AsString:=EditCDisstatus.Text;
                Params.ParamByName('EID').AsString:=EditEID.Text;

                ExecSQL;
                Close;
                Frm000.SQLTransactionChild1.Commit;
            except
                showmessage('資料修改時發生錯誤');
            end;
          end;
            Frm000.SQLQueryChild.Refresh;
            Frm000.SQLQueryChild.Locate('員工編號',EditEID.Text,[loPartialKey])
       end;
end;

procedure TFrmF08.ButDeleteClick(Sender: TObject);
var sqlstr: string;
begin
     if(length(EditEID.Text)>0) and Frm000.SQLQueryChild.Locate('員工編號',EditEID.Text,[loPartialKey]) then
       if messageDlg('確定要刪除子女獎金資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
         with Frm000.SQLQueryChild1 do
          begin
            Try
                sqlstr:='delete from 員工 where 員工編號= '''+ EditEID.Text +'''';
                showmessage(sqlstr);
                SQL.Text := sqlstr;
                ExecSQL;
                Close;
                Frm000.SQLTransactionChild1.Commit;
                showmessage('資料已經刪除');
            except
                showmessage('資料刪除時發生錯誤');
            end;
          end;
         Frm000.SQLQueryChild.Refresh;
       end;
end;

procedure TFrmF08.EditCApplyDateClick(Sender: TObject);
begin
   DateTimePicker1.Visible:=not DateTimePicker1.Visible;
   E:=(Sender as TEdit);
end;

procedure TFrmF08.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  FrmF08:=nil;
end;

procedure TFrmF08.FormCreate(Sender: TObject);
begin
  EditCApplyDate.Text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
end;

end.

