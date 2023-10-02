unit unitFrmD01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DateTimePicker, DB, Variants;

type

  { TFrmD01 }

  TFrmD01 = class(TForm)
    ButtonAll: TButton;
    ButtonSituation: TButton;
    ButtonSDate: TButton;
    ButtonEID: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGridSalary: TDBGrid;
    EditEID: TEdit;
    EditSDate: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure ButtonAllClick(Sender: TObject);
    procedure ButtonEIDClick(Sender: TObject);
    procedure ButtonSDateClick(Sender: TObject);
    procedure ButtonSituationClick(Sender: TObject);
    procedure DateTimePicker1Click(Sender: TObject);
    procedure EditSDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FrmD01: TFrmD01;
  E:TEdit;
implementation
uses UnitFrm000;
{$R *.lfm}

{ TFrmD01 }

procedure TFrmD01.Label1Click(Sender: TObject);
begin

end;

procedure TFrmD01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction :=caFree;
  FrmD01:=nil;
end;

procedure TFrmD01.FormCreate(Sender: TObject);
begin
   EditSDate.text:=DatetimeToStr(Date);
   DateTimePicker1.date:=now;
end;

procedure TFrmD01.ButtonEIDClick(Sender: TObject);
var sqlstr:string;
begin
  if(length(EditEID.text)>0)then begin
     //if Varisnull(Frm000.SQLQuerySalary.Lookup('員工編號',VarArrayOf([EditEID.Text]),'員工編號')) then begin
     if not Frm000.SQLQuerySalary.Locate('員工編號',EditEID.Text,[loPartialKey])then begin
        showmessage('查無此員工編號');
     end else begin
        with Frm000.SQLQuerySalary1 do
        begin
           Try
              sqlstr:='select * from  薪資資料 where 員工編號='''+ EditEID.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
           //   Frm000.SQLTransactionSalary1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQuerySalary1.Active := True;
        Frm000.SQLQuerySalary1.Refresh;
     end;

  end;
end;

procedure TFrmD01.ButtonAllClick(Sender: TObject);
var sqlstr:string;
begin
    with Frm000.SQLQuerySalary1 do
        begin
           Try
              sqlstr:='select * from  薪資資料 ';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQuerySalary1.Active := True;
        Frm000.SQLQuerySalary1.Refresh;
end;

procedure TFrmD01.ButtonSDateClick(Sender: TObject);
var sqlstr:string;
begin
   if(length(EditSDate.text)>0)then begin
   if not Frm000.SQLQuerySalary.Locate('發放日期',EditSDate.Text,[loPartialKey])then begin
     //if Varisnull(Frm000.SQLQuerySalary.Lookup('發放日期',VarArrayOf([EditSDate.Text]),'發放日期')) then begin
        showmessage('查無此發放日期');
     end else begin
         with Frm000.SQLQuerySalary1 do
        begin
           Try
              sqlstr:='select * from  薪資資料 where  發放日期='''+ EditSDate.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionSalary1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQuerySalary1.Active := True;
        Frm000.SQLQuerySalary1.Refresh;
     end;
  end;
end;

procedure TFrmD01.ButtonSituationClick(Sender: TObject);
var sqlstr:string;
begin
  //if(length(EditSituation.text)>0)then begin
  //if not Frm000.SQLQuerySalary.Locate('發放狀況',EditSituation.Text,[loPartialKey])then begin
  //   //if Varisnull(Frm000.SQLQuerySalary.Lookup('發放狀況',VarArrayOf([EditSituation.Text]),'發放狀況')) then begin
  //      showmessage('查無此發放狀況');
  //   end else begin
        with Frm000.SQLQuerySalary1 do
        begin
           Try
              sqlstr:='select * from  薪資資料 where  發放狀況=:State';
              SQL.Text:=sqlstr;

              if RadioButton1.Checked=True then
               begin
                  Params.ParamByName('State').AsString:=RadioButton1.caption;
               end;
               if RadioButton2.Checked=True then
               begin
                  Params.ParamByName('State').AsString:=RadioButton2.caption;
               end;

              Close;
              ExecSQL;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQuerySalary1.Active := True;
        Frm000.SQLQuerySalary1.Refresh;
     end;



procedure TFrmD01.DateTimePicker1Click(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmD01.EditSDateClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

end.

