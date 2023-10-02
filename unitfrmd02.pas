unit unitFrmD02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ActnList, ExtCtrls, DateTimePicker, DB, Variants;

type

  { TFrmD02 }

  TFrmD02 = class(TForm)
    Butfind: TButton;
    Button1: TButton;
    ButUpdate: TButton;
    ButAppend: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    EditYears: TEdit;
    EditRanks: TEdit;
    EditSitu: TEdit;
    EditEID: TEdit;
    EditName: TEdit;
    EditBasic: TEdit;
    EditRM: TEdit;
    EditSalary: TEdit;
    EditNote: TEdit;
    EditDate: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure ButAppendClick(Sender: TObject);
    procedure ButfindClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EditRanksChange(Sender: TObject);
    procedure EditEIDChange(Sender: TObject);
    procedure EditSalaryChange(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Label14Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
  private

  public

  end;

var
  FrmD02: TFrmD02;

implementation
uses unitFrm000;
{$R *.lfm}

{ TFrmD02 }

procedure TFrmD02.ButAppendClick(Sender: TObject);
var INT: Integer;
begin
   if TryStrToInt(EditEID.Text, INT) then
       with Frm000.SQLQuerySalary do
         begin
           ////if not FrmDO2.SQLQueryEmployee.Locate('員工編號',EditEID.Text,[loPartialKey]) then

           If EditEID.Text <> NULL then
           begin
             Append;
             fieldbyName('員工編號').asstring:=EditEID.text;
             fieldbyName('發放日期').asstring:=EditDate.text;
             fieldbyName('員工姓名').asstring:=EditName.text;
             fieldbyName('基本薪資').asstring:=EditBasic.text;
             fieldbyName('加薪或減薪').asstring:=EditRM.text;
             fieldbyName('備註').asstring:=EditNote.text;
             fieldbyName('實領薪資').asstring:=EditSalary.text;

             if RadioButton2.Checked = True then begin
             fieldbyName('發放狀況').asstring:=RadioButton2.caption;
             end;
             if RadioButton1.Checked = True then begin
             fieldbyName('發放狀況').asstring:=RadioButton1.caption;
             end;
             post;
             applyupdates;
           //必須加入此行
             Frm000.SQLTransactionSalary.CommitRetaining;
             refresh;
             showmessage('資料已經正確新增');

           end
           else
             showmessage('資料新增時發生錯誤，原因:發放日期 重複');
         end //with Fr000.ADOTableEmployee do
     else
       showmessage('項目不得為空白');
     Frm000.SQLQuerySalary.Locate('員工編號',EditEID.Text,[loPartialKey]);
end;

procedure TFrmD02.ButfindClick(Sender: TObject);   //查詢每季績效前三名,EditRanks
var sqlstr: string;
begin
     if(length(EditRanks.text)>0)then begin
     if Varisnull(Frm000.SQLQueryPerformance.Lookup('年度;季度',VarArrayOf([EditYears.Text,EditRanks.Text]),'年度;季度')) then begin
        showmessage('查無此員工此年度和季的資料');
     end else begin
        with Frm000.SQLQueryPerformance2 do
        begin
           Try
              sqlstr:='select * from  績效資料 where 年度=:Years and 季度=:Ranks order by 績效資料.銷售成果排名';
              SQL.Text:=sqlstr;
              Params.ParamByName('Years').AsString :=EditYears.Text;
              Params.ParamByName('Ranks').AsString :=EditRanks.Text;
              Close;
              ExecSQL;

        //必須加入此行，用以完成交易
              //Frm000.SQLTransactionPerformance2.Commit;
           except
              showmessage('資料發生錯誤');
           end;//Try
        end;
        Frm000.SQLQueryPerformance2.Active := True;
        Frm000.SQLQueryPerformance2.Refresh;
     end;

  end;
     //Frm000.SQLQueryPerformance2.Locate('銷售成果排名','1',[loPartialKey]);
     //Frm000.SQLQueryPerformance2.Locate('銷售成果排名','2',[loPartialKey]);
     //Frm000.SQLQueryPerformance2.Locate('銷售成果排名','3',[loPartialKey]);
     Frm000.SQLQueryPerformance2.Locate('銷售成果排名','1',[loPartialKey]);
     Label14.Caption := DBGrid2.Columns[3].Field.AsString;
     FrmD02.Label14.Visible:=true;

     Frm000.SQLQueryPerformance2.Locate('銷售成果排名','2',[loPartialKey]);
     Label15.Caption := DBGrid2.Columns[3].Field.AsString;
     FrmD02.Label15.Visible:=true;

     Frm000.SQLQueryPerformance2.Locate('銷售成果排名','3',[loPartialKey]);
     Label16.Caption:= DBGrid2.Columns[3].Field.AsString;
     FrmD02.Label16.Visible:=true;
end;

procedure TFrmD02.Button1Click(Sender: TObject);
var sqlstr:string;
begin
  with Frm000.SQLQueryPerformance2 do
    begin
      Try
        sqlstr:='select * from 績效資料';
  	SQL.Text := sqlstr;
        Close;
        ExecSQL;
      except
        showmessage('資料修改時發生錯誤');
      end;//Try
    end;//which Frm000.SQLQueryScript do
    Frm000.SQLQueryPerformance2.Active := true;
    Frm000.SQLQueryPerformance2.Refresh;
    EditYears.Text:='';
    EditRanks.Text:='';
    Label14.Caption:='';
    Label15.Caption:='';
    Label16.Caption:='';
end;
procedure TFrmD02.ButUpdateClick(Sender: TObject);
var sqlstr: string;
begin
    if (length(EditEID.Text) > 0) and Frm000.SQLQuerySalary.Locate('員工編號',EditEID.Text,[loPartialKey]) then
        if messageDlg('確定要修改員工資料?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          with Frm000.SQLQuerySalary1 do
            begin
              Try
                //sqlstr:='update 員工 set 姓名='''+ EditName.Text +''' where 員工編號= '''+ EditEID.Text +'''';
                //sqlstr:='update 員工 set 姓名='''+ EditName.Text +''', 名='''+ EditNameEN.Text +''' where 員工編號='''+ EditEID.Text +'''';
                //showmessage(sqlstr);
                //sqlstr:='update 員工 set 姓名=:Aname, 名=:AnameEN;

                sqlstr:='update 薪資資料 set 發放日期=:Date,員工姓名=:name,基本薪資=:Basic,加薪或減薪=:RM,備註=:Note,實領薪資=:Salary,發放狀況=:Situ where 員工編號= :EID and 發放日期=:Date';
                SQL.Text := sqlstr;
                Params.ParamByName('EID').AsString :=EditEID.Text;
                Params.ParamByName('Date').AsString :=EditDate.Text;
                Params.ParamByName('name').AsString :=EditName.Text;
                Params.ParamByName('Basic').AsString :=EditBasic.Text;
                Params.ParamByName('RM').AsString :=EditRM.Text;
                Params.ParamByName('Note').AsString :=EditNote.Text;
                Params.ParamByName('Salary').AsString :=EditSalary.Text;
                //Params.ParamByName('Situ').AsString :=EditSalary.Text;

                if RadioButton2.Checked = True then begin
                Params.ParamByName('Situ').asstring:=RadioButton2.caption;
                end;
                if RadioButton1.Checked = True then begin
                Params.ParamByName('Situ').asstring:=RadioButton1.caption;
                end;



                Close;
                ExecSQL;

                //必須加入此行，用已完成交易(寫入資料庫)
                Frm000.SQLTransactionSalary1.Commit;
                showmessage('資料已經修改');
              except
                showmessage('資料修改時發生錯誤');
              end;// Try

            end;//with Frm000.SQLQueryScript do
            Frm000.SQLQuerySalary.Refresh;
            Frm000.SQLQuerySalary.Locate('員工編號', EditEID.Text, [loPartialKey])
          end//if messageDlg('確定要修改員工資料? ,mtConfirmation, [mbYes, mbNo], 0]=mrYes the

end;

procedure TFrmD02.DBGrid1CellClick(Column: TColumn);
begin
  EditEID.text:=Frm000.SQLQuerySalary.fieldbyName('員工編號').value;

  if Frm000.SQLQuerySalary.fieldbyName('發放日期').IsNull then
       EditDate.text:=''
  else
       EditDate.text:= Frm000.SQLQuerySalary.fieldbyName('發放日期').value;

  if Frm000.SQLQuerySalary.fieldbyName('員工姓名').IsNull then
       EditName.text:=''
   else
       EditName.text:= Frm000.SQLQuerySalary.fieldbyName('員工姓名').value;

if Frm000.SQLQuerySalary.fieldbyName('基本薪資').IsNull then
       EditBasic.text:=''
   else
       EditBasic.text:= Frm000.SQLQuerySalary.fieldbyName('基本薪資').value;

if Frm000.SQLQuerySalary.fieldbyName('加薪或減薪').IsNull then
       EditRM.text:=''
   else
       EditRM.text:= Frm000.SQLQuerySalary.fieldbyName('加薪或減薪').value;

if Frm000.SQLQuerySalary.fieldbyName('備註').IsNull then
       EditNote.text:=''
   else
       EditNote.text:= Frm000.SQLQuerySalary.fieldbyName('備註').value;

if Frm000.SQLQuerySalary.fieldbyName('實領薪資').IsNull then
       EditSalary.text:=''
   else
       EditSalary.text:= Frm000.SQLQuerySalary.fieldbyName('實領薪資').value;

//if Frm000.SQLQuerySalary.fieldbyName('發放狀況').IsNull then
//       EditSitu.text:=''
//   else
//       EditSitu.text:= Frm000.SQLQuerySalary.fieldbyName('發放狀況').value;

if(Frm000.SQLQuerySalary.FieldByName('發放狀況').value = '已發放') then
begin
     RadioButton1.Checked:=True;
end;
if(Frm000.SQLQuerySalary.FieldByName('發放狀況').value = '未發放') then
begin
     RadioButton2.Checked:=True;
end;

end;

procedure TFrmD02.EditRanksChange(Sender: TObject);
begin

end;

procedure TFrmD02.EditEIDChange(Sender: TObject);
begin

end;

procedure TFrmD02.EditSalaryChange(Sender: TObject);
begin

end;

procedure TFrmD02.FormClick(Sender: TObject);
begin

end;

procedure TFrmD02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmD02:=nil;
end;

procedure TFrmD02.Label14Click(Sender: TObject);
begin

end;

procedure TFrmD02.Label18Click(Sender: TObject);
begin

end;

procedure TFrmD02.Label19Click(Sender: TObject);
begin

end;

procedure TFrmD02.Label8Click(Sender: TObject);
begin

end;

procedure TFrmD02.Panel1Click(Sender: TObject);
begin

end;

procedure TFrmD02.RadioButton1Change(Sender: TObject);
begin

end;

end.

