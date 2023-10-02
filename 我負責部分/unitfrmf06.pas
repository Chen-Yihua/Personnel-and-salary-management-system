unit unitFrmF06;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, DateTimePicker, DB;

type

  { TFrmF06 }

  TFrmF06 = class(TForm)
    Button1: TButton;
    ButtonClear: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    EditID: TEdit;
    EditName: TEdit;
    EditCName: TEdit;
    EditAppDate: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    procedure Button1Click(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure EditAppDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmF06: TFrmF06;
  E:TEdit;

implementation uses unitfrm000;

{$R *.lfm}

{ TFrmF06 }

procedure TFrmF06.EditAppDateClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

procedure TFrmF06.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction :=caFree;
  FrmF06:=nil;
end;

procedure TFrmF06.FormCreate(Sender: TObject);
begin
  //設定初始值
  EditAppDate.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
end;

procedure TFrmF06.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmF06.Button1Click(Sender: TObject);
var num: Integer;
begin
  if (length(EditID.Text)>0) and (length(EditName.Text)>0) and (length(EditCName.Text)>0)then
     with Frm000.SQLQueryChild do
        begin
            if Frm000.SQLQueryEmployee.Locate('員工編號',EditID.Text,[loPartialKey]) then
              begin
                  if DBGrid2.columns[1].Field.AsString=EditName.Text then
                  begin
                    num:=DBGrid1.DataSource.DataSet.RecordCount;

                  Append;
                  fieldbyname('子女獎金編號').asstring:='B'+inttostr(num+1);
                  fieldbyName('員工編號').asinteger:=strToint(EditID.Text);
                  fieldbyName('員工姓名').asstring:=EditName.text;
                  fieldbyName('子女姓名').asstring:=EditCName.text;
                  fieldbyName('申請日期').asstring:=EditAppDate.text;
                  fieldbyName('核准狀況').asstring:='未核准';
                  fieldbyName('發放狀況').asstring:='未發放';

                  post;
                  applyupdates;

                  //必須加入此行
                  Frm000.SQLTransactionChild.CommitRetaining;
                  refresh;
                  showmessage('子女獎金申請成功');

                  Label21.Caption := 'B'+inttostr(num+1);
                  FrmF06.Label21.Visible:=true;
                  Label13.Caption := EditID.Text;
                  FrmF06.Label13.Visible:=true;
                  Label16.Caption:= EditName.Text;
                  FrmF06.Label16.Visible:=true;
                  Label17.Caption := EditCName.Text;
                  FrmF06.Label17.Visible:=true;
                  Label18.Caption := EditAppDate.Text;
                  FrmF06.Label18.Visible:=true;
                  end
                  else
                  showmessage('資料輸入錯誤');
             end
            else
              showmessage('員工編號不存在');
        end
  else
      showmessage('項目不得為空白');
            //Frm000.SQLQuery2.Locate('子女獎金編號',EditName.Text,[loPartialKey]);

  Frm000.SQLQueryChild.Refresh;
  Frm000.SQLQueryEmployee.Refresh;
end;

procedure TFrmF06.ButtonClearClick(Sender: TObject);
begin
  EditID.text:='';
  EditName.text:='';
  EditCName.text:='';
  EditAppDate.text:='';
end;

end.

