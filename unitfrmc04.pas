unit unitFrmC04;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DateTimePicker, DBDateTimePicker, Variants;

type

  { TFrmC04 }

  TFrmC04 = class(TForm)
    ButEid: TButton;
    ButName: TButton;
    ButDate: TButton;
    ButAll: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    EditEid: TEdit;
    EditName: TEdit;
    EditDate: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure ButAllClick(Sender: TObject);
    procedure ButDateClick(Sender: TObject);
    procedure ButEidClick(Sender: TObject);
    procedure ButNameClick(Sender: TObject);
    procedure DateTimePicker1Click(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure EditDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private

  public

  end;

var
  FrmC04: TFrmC04;
  E:TEdit;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmC04 }

procedure TFrmC04.Label2Click(Sender: TObject);
begin

end;

procedure TFrmC04.ButEidClick(Sender: TObject);
var sqlstr:string;
begin
   if(length(EditEID.text)>0)then begin
     if Varisnull(Frm000.SQLQueryAttendence.Lookup('員工編號',VarArrayOf([EditEID.Text]),'員工編號')) then begin
        showmessage('查無此員工編號');
     end else begin
        with Frm000.SQLQueryAttendence1 do
        begin
           Try
              sqlstr:='select * from  出缺勤資料 where 員工編號='''+ EditEID.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionAttendence1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryAttendence1.Active := True;
        Frm000.SQLQueryAttendence1.Refresh;
     end;

  end;
end;


procedure TFrmC04.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmC04:=nil;
end;

procedure TFrmC04.FormCreate(Sender: TObject);
begin
  //設定初始值
  EditDate.text:=DateTimeToStr(Date);
  DateTimePicker1.date:=now;
  //EditFree.text:='0';
end;

procedure TFrmC04.ButDateClick(Sender: TObject);
var EDate:Tdate;
var sqlstr:string;
begin
  if TryStrToDate(EditDate.Text,EDate)then begin
  if Varisnull(Frm000.SQLQueryAttendence.Locate('日期',EditDate.Text, [loPartialKey])) then begin
    showmessage('查無此日期');
 end else begin
    with Frm000.SQLQueryAttendence1 do
        begin
           Try
              sqlstr:='select * from  出缺勤資料 where 日期='''+ EditDate.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionAttendence1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryAttendence1.Active := True;
        Frm000.SQLQueryAttendence1.Refresh;
     end;
 end;
end;

procedure TFrmC04.ButAllClick(Sender: TObject);
var sqlstr:string;
begin
  with Frm000.SQLQueryAttendence1 do
    begin
      Try
        sqlstr:='select 員工編號, 日期, 員工姓名, 下班時間, 假別, 事由, 狀態 from DwarfDataBase.dbo.出缺勤資料';
  	SQL.Text := sqlstr;
        Close;
        ExecSQL;
      except
        showmessage('資料修改時發生錯誤');
      end;//Try
    end;//which Frm000.SQLQueryScript do
    Frm000.SQLQueryAttendence1.Active := true;
    Frm000.SQLQueryAttendence1.Refresh;
end;

procedure TFrmC04.ButNameClick(Sender: TObject);
var sqlstr:string;
begin
  if(length(EditName.text)>0)then begin
     if Varisnull(Frm000.SQLQueryAttendence.Lookup('員工姓名',VarArrayOf([EditName.Text]),'員工姓名')) then begin
        showmessage('查無此員工姓名');
     end else begin
        with Frm000.SQLQueryAttendence1 do
        begin
           Try
              sqlstr:='select * from  出缺勤資料 where 員工姓名='''+ EditName.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionAttendence1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryAttendence1.Active := True;
        Frm000.SQLQueryAttendence1.Refresh;
     end;
  end;
end;

procedure TFrmC04.DateTimePicker1Click(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmC04.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmC04.EditDateClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

end.

