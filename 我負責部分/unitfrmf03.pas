unit unitFrmF03;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, DateTimePicker, DB;

type

  { TFrmF03 }

  TFrmF03 = class(TForm)
    Button1: TButton;
    ButtonClear: TButton;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    EditID: TEdit;
    EditName: TEdit;
    EditMarryDate: TEdit;
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
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure Button1Click(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure DateTimeDbPicker1Click(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure DateTimePicker2DblClick(Sender: TObject);
    //procedure DateTimePicker1DblClick(Sender: TObject);
    //procedure DateTimePicker2DblClick(Sender: TObject);
    procedure EditIDClick(Sender: TObject);
    procedure EditMarryDateClick(Sender: TObject);
    procedure EditAppDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmF03: TFrmF03;
  E:TEdit;

implementation uses unitfrm000;

{$R *.lfm}

{ TFrmF03 }

procedure TFrmF03.Button1Click(Sender: TObject);
var num: Integer;
begin
  if (length(EditID.Text)>0) and (length(EditName.Text)>0) then
     with Frm000.SQLQueryWedding do
         begin
           if Frm000.SQLQueryEmployee.Locate('員工編號',EditID.Text,[loPartialKey]) then
           begin
             if DBGrid2.columns[1].Field.AsString=EditName.Text then
              begin
                num:=DBGrid1.DataSource.DataSet.RecordCount;

              Append;
              fieldbyname('結婚禮金編號').asstring:='A'+inttostr(num+1);
              fieldbyName('員工編號').asinteger:=strToint(EditID.Text);
              fieldbyName('員工姓名').asstring:=EditName.Text;
              fieldbyName('結婚日期').asstring:=EditMarryDate.text;
              fieldbyName('申請日期').asstring:=EditAppDate.text;
              fieldbyName('核准狀況').asstring:='未核准';
              fieldbyName('發放狀況').asstring:='未發放';

              post;
              applyupdates;
             //必須加入此行
             Frm000.SQLTransactionWedding.CommitRetaining;
             refresh;
             showmessage('結婚禮金申請成功');

             Label21.Caption := 'A'+inttostr(num+1);
             FrmF03.Label21.Visible:=true;
             Label13.Caption := EditID.Text;
             FrmF03.Label13.Visible:=true;
             Label16.Caption:= EditName.Text;
             FrmF03.Label16.Visible:=true;
             Label17.Caption := EditMarryDate.Text;
             FrmF03.Label17.Visible:=true;
             Label18.Caption := EditAppDate.Text;
             FrmF03.Label18.Visible:=true;
             end
              else
                showmessage('資料輸入錯誤');
           end
         else
            showmessage('員工編號不存在');
         end
     else
         showmessage('項目不得為空白');
     //Frm000.SQLQuery1.Locate('員工編號',EditID.Text,[loPartialKey]);  SQLQueryWedding
     //Frm000.SQLQuery1.Locate('員工姓名',EditName.Text,[loPartialKey]);
     Frm000.SQLQueryWedding.Refresh;
     Frm000.SQLQueryEmployee.Refresh;
end;

procedure TFrmF03.ButtonClearClick(Sender: TObject);
begin
  EditID.text:='';
  EditName.text:='';
  EditMarryDate.text:='';
  EditAppDate.text:='';
end;

procedure TFrmF03.DateTimeDbPicker1Click(Sender: TObject);
begin

end;

procedure TFrmF03.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
    DateTimePicker1.Visible:=False;
end;

procedure TFrmF03.DateTimePicker2DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker2.date);
    DateTimePicker2.Visible:=False;
end;

//procedure TFrmF03.DateTimePicker1DblClick(Sender: TObject);
//begin
//   E.Text:=DateToStr(DateTimePicker1.date);
//    DateTimePicker1.Visible:=False;
//end;
//
//procedure TFrmF03.DateTimePicker2DblClick(Sender: TObject);
//begin
//   E.Text:=DateToStr(DateTimePicker2.date);
//   DateTimePicker2.Visible:=False;
//end;
//
//procedure TFrmF03.DateTimePicker1Db1Click(Sender: TObject);
//begin
//    //E.Text:=DateToStr(DateTimePicker1.date);
//    //DateTimePicker1.Visible:=False;
//end;
//
//procedure TFrmF03.DateTimePicker2Db1Click(Sender: TObject);
//begin
//   //E.Text:=DateToStr(DateTimePicker2.date);
//   //DateTimePicker2.Visible:=False;
//end;

procedure TFrmF03.EditIDClick(Sender: TObject);
begin

end;

procedure TFrmF03.EditMarryDateClick(Sender: TObject);
begin
     DateTimePicker1.Visible:=not DateTimePicker1.Visible;
     E:=(Sender as TEdit);
end;

procedure TFrmF03.EditAppDateClick(Sender: TObject);
begin
    DateTimePicker2.Visible:=not DateTimePicker2.Visible;
    E:=(Sender as TEdit);
end;

procedure TFrmF03.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction :=caFree;
  FrmF03:=nil;
end;

procedure TFrmF03.FormCreate(Sender: TObject);
begin
  //設定初始值
  EditMarryDate.text:=DatetimeToStr(Date);
  EditAppDate.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
  DateTimePicker2.date:=now;
end;

end.

