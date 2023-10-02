unit unitFrmE01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,DB,Variants;

type

  { TFrmE01 }

  TFrmE01 = class(TForm)
    Button1: TButton;
    ButtonStan: TButton;
    ButtonUp: TButton;
    ButtonAll: TButton;
    ButtonEName: TButton;
    ButtonDown: TButton;
    ButtonYear: TButton;
    ButtonSeason: TButton;
    ButtonEID: TButton;
    DBGrid1: TDBGrid;
    EditEID: TEdit;
    EditYear: TEdit;
    EditEName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RadioButton1: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure ButtonAllClick(Sender: TObject);
    procedure ButtonDownClick(Sender: TObject);
    procedure ButtonEIDClick(Sender: TObject);
    procedure ButtonENameClick(Sender: TObject);
    procedure ButtonSeasonClick(Sender: TObject);
    procedure ButtonStanClick(Sender: TObject);
    procedure ButtonUpClick(Sender: TObject);
    procedure ButtonYearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmE01: TFrmE01;

implementation
uses UnitFrm000;
{$R *.lfm}

{ TFrmE01 }

procedure TFrmE01.ButtonEIDClick(Sender: TObject);
var sqlstr:string;
begin
     if(length(EditEID.text)>0)then begin
     //if Varisnull(Frm000.SQLQueryPerformance.Lookup('員工編號',VarArrayOf([EditEID.Text]),'員工編號')) then begin
     if not Frm000.SQLQueryPerformance.Locate('員工編號',EditEID.Text,[loPartialKey])then begin
        showmessage('查無此員工編號');
     end else begin
        with Frm000.SQLQueryPerformance1 do
        begin
           Try
              sqlstr:='select * from  績效資料 where 員工編號='''+ EditEID.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
     end;

  end;
end;

procedure TFrmE01.ButtonAllClick(Sender: TObject);
var sqlstr:string;
begin
    with Frm000.SQLQueryPerformance1 do
        begin
           Try
              sqlstr:='select * from 績效資料 ';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionPerformance1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
end;

procedure TFrmE01.Button1Click(Sender: TObject);
var sqlstr:string;
begin
     with Frm000.SQLQueryPerformance1 do
        begin

           Try
              if RadioButton7.Checked=True then
               begin
                  sqlstr:='select * from  績效資料 where 員工銷售成果 < 10000';
               end;
               if RadioButton8.Checked=True then
               begin
                  sqlstr:='select * from 績效資料 where 員工銷售成果 BETWEEN 10000 AND 50000';
               end;
              if RadioButton9.Checked=True then
               begin
                  sqlstr:='select * from 績效資料 where 員工銷售成果 BETWEEN 50000 AND 100000';
               end;
              if RadioButton11.Checked=True then
               begin
                  sqlstr:='select * from  績效資料 where 員工銷售成果 > 100000';
               end;
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
end;

procedure TFrmE01.ButtonDownClick(Sender: TObject);
var sqlstr:string;
begin
    with Frm000.SQLQueryPerformance1 do
        begin
           Try
              sqlstr:='select * from 績效資料 order by 銷售成果排名 DESC';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionPerformance1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
end;

procedure TFrmE01.ButtonENameClick(Sender: TObject);
var sqlstr:string;
begin
     if(length(EditEName.text)>0)then begin
     if not Frm000.SQLQueryPerformance.Locate('員工姓名',EditEName.Text,[loPartialKey])then begin
     //if Varisnull(Frm000.SQLQueryPerformance.Lookup('員工姓名',VarArrayOf([EditEName.Text]),'員工姓名')) then begin
        showmessage('查無此員工姓名');
     end else begin
        with Frm000.SQLQueryPerformance1 do
        begin
           Try
              sqlstr:='select * from  績效資料 where 員工姓名='''+ EditEName.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
     end;

  end;
end;

procedure TFrmE01.ButtonSeasonClick(Sender: TObject);
var sqlstr:string;
begin
     //if(length(EditSeason.text)>0)then begin
     //if not Frm000.SQLQueryPerformance.Locate('季度',EditSeason.Text,[loPartialKey])then begin
     //if Varisnull(Frm000.SQLQueryPerformance.Lookup('季度',VarArrayOf([EditSeason.Text]),'季度')) then begin
      //  showmessage('查無此季度');
    // end else begin
        with Frm000.SQLQueryPerformance1 do
        begin
           Try
              sqlstr:='select * from  績效資料 where 季度=:Season';
              SQL.Text:=sqlstr;

              if RadioButton1.Checked=True then
               begin
                  Params.ParamByName('Season').AsString:=RadioButton1.caption;
               end;
               if RadioButton2.Checked=True then
               begin
                  Params.ParamByName('Season').AsString:=RadioButton2.caption;
               end;
               if RadioButton3.Checked=True then
               begin
                  Params.ParamByName('Season').AsString:=RadioButton3.caption;
               end;
               if RadioButton4.Checked=True then
               begin
                  Params.ParamByName('Season').AsString:=RadioButton2.caption;
               end;

              Close;
              ExecSQL;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
     end;

procedure TFrmE01.ButtonStanClick(Sender: TObject);
var sqlstr:string;
begin
     with Frm000.SQLQueryPerformance1 do
        begin

           Try
              if RadioButton5.Checked=True then
               begin
                  sqlstr:='select * from  績效資料 where 員工銷售成果 < 10000';
               end;
               if RadioButton6.Checked=True then
               begin
                  sqlstr:='select * from  績效資料 where 員工銷售成果 >= 10000';
               end;
              SQL.Text:=sqlstr;

              Close;
              ExecSQL;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
end;

procedure TFrmE01.ButtonUpClick(Sender: TObject);
var sqlstr:string;
begin
    with Frm000.SQLQueryPerformance1 do
        begin
           Try
              sqlstr:='select * from 績效資料 order by 銷售成果排名 ';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionPerformance1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
end;

procedure TFrmE01.ButtonYearClick(Sender: TObject);
var sqlstr:string;
begin
     if(length(EditYear.text)>0)then begin
     if Varisnull(Frm000.SQLQueryPerformance.Lookup('年度',VarArrayOf([EditYear.Text]),'年度')) then begin
        showmessage('查無此年度');
     end else begin
        with Frm000.SQLQueryPerformance1 do
        begin
           Try
              sqlstr:='select * from  績效資料 where 年度='''+ EditYear.text +'''';
              SQL.Text:=sqlstr;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              Frm000.SQLTransactionPerformance1.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance1.Active := True;
        Frm000.SQLQueryPerformance1.Refresh;
     end;

  end;
end;

procedure TFrmE01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction :=caFree;
   FrmE01:=nil;
end;

end.

