unit unitFrmF02;


{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DB,
  DateTimePicker;

type

  { TFrmF02 }

  TFrmF02 = class(TForm)
    ButAppend: TButton;
    ButUpdate: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    EditEID: TEdit;
    EditEName: TEdit;
    EditBirthday: TEdit;
    EditRecord: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure ButAppendClick(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DateTimePicker1Click(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EditBirthdayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmF02: TFrmF02;
  E:TEdit;
implementation uses unitfrm000;

{$R *.lfm}

{ TFrmF02 }

procedure TFrmF02.ButAppendClick(Sender: TObject);
begin
  if (length(EditEID.Text)>0) and (length(EditEName.Text)>0) and (length(EditEName.Text)>0) then
   with Frm000.SQLQueryBirthday do
    begin
      if not Locate('員工編號',EditEID.Text,[loPartialKey]) then
      begin
        Append;
        fieldbyName('員工編號').asinteger:=strToint(EditEID.text);
        fieldbyName('員工姓名').asstring:=EditEName.text;
        fieldbyName('生日').asstring:=EditBirthday.text;
        fieldbyName('發放紀錄').asstring:='未發放';
        post;
        applyupdates;
        Frm000.SQLTransactionBirthday.CommitRetaining;
        refresh;
        showmessage('資料已正確新增');

      end
      else
        showmessage('資料新增時發生錯誤，原因:員工編號 重複');
    end
  else
    showmessage('項目不得為空白');
  Frm000.SQLQueryBirthday.Locate('員工編號',EditEID.Text,[loPartialKey])
end;

procedure TFrmF02.ButUpdateClick(Sender: TObject);
var sqlstr: string;
begin
     if (length(EditEID.Text)>0) and Frm000.SQLQueryBirthday.Locate('員工編號',EditEID.Text,[loPartialKey]) then
       if messageDlg('確定要修改生日禮金資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
         with Frm000.SQLQueryBirthday1 do
          begin
            Try
              sqlstr:='update 生日禮金資料 set 員工姓名= :ename,生日=:birthday ,發放紀錄=:record where員工編號=:EID';
              SQL.Text := sqlstr;
              Params.ParamByName('ename').AsString:=EditEName.Text;
              Params.ParamByName('birthday').AsString:=EditBirthday.Text;
              Params.ParamByName('record').AsString:=EditRecord.Text;
              Params.ParamByName('EID').AsString:=EditEID.Text;

              ExecSQL;
              Close;
              Frm000.SQLTransactionBirthday1.Commit;
            except
              showmessage('資料修改時發生錯誤');
            end;
          end;
          Frm000.SQLQueryBirthday.Refresh;
          Frm000.SQLQueryBirthday.Locate('員工編號',EditEID.Text,[loPartialKey])
       end;
end;

procedure TFrmF02.DateTimePicker1Click(Sender: TObject);
begin

end;

procedure TFrmF02.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmF02.DBGrid1CellClick(Column: TColumn);
begin
  EditEID.text:=Frm000.SQLQueryBirthday.FieldByName('員工編號').value;
   if Frm000.SQLQueryBirthday.FieldByName('員工姓名').IsNull then
        EditEName.text:=''
   else
        EditEName.text:= Frm000.SQLQueryBirthday.FieldByName('員工姓名').value;
   if Frm000.SQLQueryBirthday.FieldByName('生日').IsNull then
        EditBirthday.text:=''
   else
        EditBirthday.text:= Frm000.SQLQueryBirthday.FieldByName('生日').value;
   if Frm000.SQLQueryBirthday.FieldByName('發放紀錄').IsNull then
        EditRecord.text:=''
   else
        EditRecord.text:= Frm000.SQLQueryBirthday.FieldByName('發放紀錄').value;
end;

procedure TFrmF02.EditBirthdayClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

procedure TFrmF02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  FrmF02:=nil;
end;

procedure TFrmF02.FormCreate(Sender: TObject);
begin
  EditBirthday.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
end;

end.

