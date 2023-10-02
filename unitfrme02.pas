unit unitFrmE02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,DB;

type

  { TFrmE02 }

  TFrmE02 = class(TForm)
    ButUpdate: TButton;
    ButAppend: TButton;
    DBGrid1: TDBGrid;
    EditRank: TEdit;
    EditEID: TEdit;
    EditYear: TEdit;
    EditEName: TEdit;
    EditSeason: TEdit;
    EditResult: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure ButAppendClick(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Label2Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private

  public

  end;

var
  FrmE02: TFrmE02;

implementation
uses unitFrm000;
{$R *.lfm}

{ TFrmE02 }

procedure TFrmE02.Label2Click(Sender: TObject);
begin

end;

procedure TFrmE02.Label7Click(Sender: TObject);
begin

end;

procedure TFrmE02.DBGrid1CellClick(Column: TColumn);
begin
  EditEID.text:=Frm000.SQLQueryPerformance.fieldbyName('員工編號').value;

if Frm000.SQLQueryPerformance.fieldbyName('年度').IsNull then
       EditYear.text:=''
  else
       EditYear.text:= Frm000.SQLQueryPerformance.fieldbyName('年度').value;

if Frm000.SQLQueryPerformance.fieldbyName('季度').IsNull then
       EditSeason.text:=''
   else
       EditSeason.text:= Frm000.SQLQueryPerformance.fieldbyName('季度').value;

if Frm000.SQLQueryPerformance.fieldbyName('員工姓名').IsNull then
       EditEName.text:=''
   else
       EditEName.text:= Frm000.SQLQueryPerformance.fieldbyName('員工姓名').value;

if Frm000.SQLQueryPerformance.fieldbyName('員工銷售成果').IsNull then
       EditResult.text:=''
   else
       EditResult.text:= Frm000.SQLQueryPerformance.fieldbyName('員工銷售成果').value;

if Frm000.SQLQueryPerformance.fieldbyName('銷售成果排名').IsNull then
       EditRank.text:=''
   else
       EditRank.text:= Frm000.SQLQueryPerformance.fieldbyName('銷售成果排名').value;
end;

procedure TFrmE02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     CloseAction := caFree;
     FrmE02:= nil;
end;

procedure TFrmE02.ButAppendClick(Sender: TObject);
var INT: Integer;
begin
   if TryStrToInt(EditEID.Text, INT) then
       with Frm000.SQLQueryPerformance do
         begin
           //if not FrmDO2.SQLQueryPerformance.Locate('員工編號',EditEID.Text,[loPartialKey]) then
           If EditEID.Text <> NULL then
           begin
             Append;
             fieldbyName('員工編號').asstring:=EditEID.text;
             fieldbyName('年度').asstring:=EditYear.text;
             fieldbyName('季度').asstring:=EditSeason.text;
             fieldbyName('員工姓名').asstring:=EditEName.text;
             fieldbyName('員工銷售成果').asstring:=EditResult.text;
             fieldbyName('銷售成果排名').asstring:=EditRank.text;
             post;
             applyupdates;
           //必須加入此行
             Frm000.SQLTransactionPerformance.CommitRetaining;
             refresh;
             showmessage('資料已經正確新增');

           end
           else
             showmessage('資料新增時發生錯誤，原因:員工編號 重複');
         end //with Fr000.ADOTableEmployee do
     else
       showmessage('項目不得為空白');
     Frm000.SQLQueryPerformance.Locate('員工編號',EditEID.Text,[loPartialKey]);
end;

procedure TFrmE02.ButUpdateClick(Sender: TObject);
var sqlstr: string;
begin
  if (length(EditEID.Text) > 0) and Frm000.SQLQueryPerformance.Locate('員工編號',EditEID.Text, [loPartialKey]) then
        if messageDlg('確定要修改員工資料?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          with Frm000.SQLQueryPerformance1 do
            begin
              Try
                //sqlstr:='update 員工 set 姓名='''+ EditName.Text +''' where 員工編號= '''+ EditEID.Text +'''';
                //sqlstr:='update 員工 set 姓名='''+ EditName.Text +''', 名='''+ EditNameEN.Text +''' where 員工編號='''+ EditEID.Text +'''';
                //showmessage(sqlstr);
                //sqlstr:='update 員工 set 姓名=:Aname, 名=:AnameEN;

                sqlstr:='update 績效資料 set 年度=:Year,季度=:Season,員工姓名=:EName,員工銷售成果=:Result,銷售成果排名=:Rank where 員工編號= :EID';
                SQL.Text := sqlstr;
                Params.ParamByName('EID').AsString :=EditEID.Text;
                Params.ParamByName('Year').AsString :=EditYear.Text;
                Params.ParamByName('Season').AsString :=EditSeason.Text;
                Params.ParamByName('EName').AsString :=EditEName.Text;
                Params.ParamByName('Result').AsString :=EditResult.Text;
                Params.ParamByName('Rank').AsString :=EditRank.Text;

                Close;
                ExecSQL;

                //必須加入此行，用已完成交易(寫入資料庫)
                Frm000.SQLTransactionPerformance1.Commit;
                showmessage('資料已經修改');
              except
                showmessage('資料修改時發生錯誤');
              end;// Try

            end;//with Frm000.SQLQuerySQLScript5 do
            Frm000.SQLQueryPerformance.Refresh;
            Frm000.SQLQueryPerformance.Locate('員工編號', EditEID.Text, [loPartialKey])
          end//if messageDlg('確定要修改員工資料? ,mtConfirmation, [mbYes, mbNo], 0]=mrYes the
end;

end.

