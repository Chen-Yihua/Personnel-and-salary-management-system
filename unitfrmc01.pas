unit unitFrmC01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  Menus, ExtDlgs, ValEdit, DBCtrls, DBDateTimePicker, DateTimePicker, DB,
  Variants;

type

  { TFrmC01 }

  TFrmC01 = class(TForm)
    ButEid: TButton;
    ButDate: TButton;
    ButName: TButton;
    ButAll: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    EditEid: TEdit;
    EditDate: TEdit;
    EditName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    good: TLabel;
    LabelSkipWork: TLabel;
    Work: TLabel;
    LabelWork: TLabel;
    SkipWork: TLabel;
    procedure ButAllClick(Sender: TObject);
    procedure ButDateClick(Sender: TObject);
    procedure ButEidClick(Sender: TObject);
    procedure ButNameClick(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure EditDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FrmC01: TFrmC01;
  E:TEdit;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmC01 }

procedure TFrmC01.Label1Click(Sender: TObject);
begin

end;

procedure TFrmC01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmC01:=nil;
end;

procedure TFrmC01.FormCreate(Sender: TObject);
begin
  //設定初始值
  EditDate.text:=DateTimeToStr(Date);
  DateTimePicker1.date:=now;
  Work.Caption:='';
  SkipWork.Caption:='';
  good.Caption:='';
  //EditFree.text:='0';
end;

procedure TFrmC01.ButEidClick(Sender: TObject);
var sqlstr:string;
var Workcount:string;
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

        if Varisnull(Frm000.SQLQuerySkipWork.Lookup('員工編號',VarArrayOf([EditEID.Text]),'員工編號')) then begin
        SkipWork.Caption:='0';
        Frm000.SQLQueryWork.Locate('員工編號',EditEID.text,[loPartialKey]);
        Work.Caption:=DBGrid2.Columns[2].Field.AsString;
        good.Caption:='全勤中，請保持。';
        end else begin
        //出勤天數
        Frm000.SQLQueryWork.Locate('員工編號',EditEID.text,[loPartialKey]);
        Work.Caption:=DBGrid2.Columns[2].Field.AsString;
        //缺勤天數
        Frm000.SQLQuerySkipWork.Locate('員工編號',EditEID.text,[loPartialKey]);
        SkipWork.Caption:=DBGrid3.Columns[2].Field.AsString;
        end;
     end;
  end;
end;

procedure TFrmC01.ButNameClick(Sender: TObject);
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


        if Varisnull(Frm000.SQLQuerySkipWork.Lookup('員工姓名',VarArrayOf([EditName.Text]),'員工姓名')) then begin
          SkipWork.Caption:='0';
          Frm000.SQLQueryWork.Locate('員工姓名',EditName.text,[loPartialKey]);
          Work.Caption:=DBGrid2.Columns[2].Field.AsString;
          good.Caption:='全勤中，請保持。';
          end else begin
          //出勤天數
          Frm000.SQLQueryWork.Locate('員工姓名',EditName.text,[loPartialKey]);
          Work.Caption:=DBGrid2.Columns[2].Field.AsString;
          //缺勤天數
          Frm000.SQLQuerySkipWork.Locate('員工姓名',EditName.text,[loPartialKey]);
          SkipWork.Caption:=DBGrid3.Columns[2].Field.AsString;
     end;
     end;

  end;
end;

procedure TFrmC01.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmC01.EditDateClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

procedure TFrmC01.ButDateClick(Sender: TObject);
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
        Work.Caption:='';
         SkipWork.Caption:='';
         good.Caption:='';
     end;
 end;
end;

procedure TFrmC01.ButAllClick(Sender: TObject);
var sqlstr:string;
begin
  with Frm000.SQLQueryAttendence1 do
    begin
      Try
        sqlstr:='select 員工編號, 日期, 員工姓名, 出缺勤狀況, 上班時間, 下班時間, 假別 from DwarfDataBase.dbo.出缺勤資料';
  	SQL.Text := sqlstr;
        Close;
        ExecSQL;
      except
        showmessage('資料修改時發生錯誤');
      end;//Try
    end;//which Frm000.SQLQueryScript do
    Frm000.SQLQueryAttendence1.Active := true;
    Frm000.SQLQueryAttendence1.Refresh;
    Work.Caption:='';
    SkipWork.Caption:='';
    Work.Caption:='';
    SkipWork.Caption:='';
    good.Caption:='';
end;
end.

