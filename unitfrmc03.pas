unit unitFrmC03;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  XMLPropStorage, DateTimePicker, DB;

type

  { TFrmC03 }

  TFrmC03 = class(TForm)
    Button1: TButton;
    DateTimePicker1: TDateTimePicker;
    EditName: TEdit;
    EditDate: TEdit;
    EditID: TEdit;
    EditReason: TEdit;
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
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure Button1Click(Sender: TObject);
    procedure DateTimePicker1Click(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure EditIDChange(Sender: TObject);
    procedure EditDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Shape3ChangeBounds(Sender: TObject);
  private

  public

  end;

var
  FrmC03: TFrmC03;
  E:TEdit;

implementation
uses unitfrm000;

{$R *.lfm}

{ TFrmC03 }

procedure TFrmC03.Button1Click(Sender: TObject);
var sqlstr: string;
begin
  if messageDlg('確定要新增假單?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
     if(length(EditID.Text)>0) and (length(EditDate.Text)>0) and (length(EditName.Text)>0)and (length(EditReason.Text)>0) then
         begin
         with Frm000.SQLQueryScript do
            begin
               if Frm000.SQLQueryEmployee.Locate('員工編號',EditID.Text,[loPartialKey]) and Frm000.SQLQueryEmployee.Locate('姓名',EditName.Text,[loPartialKey]) then
                 begin
                    Try
                       sqlstr:='update 出缺勤資料 set 假別=:leave, 事由=:reason, 狀態=:state where 員工編號=:ID and 日期=:date and 員工姓名=:name';
                       SQL.Text:=sqlstr;
                       Params.ParamByName('reason').AsString:=EditReason.Text;
                       Params.ParamByName('date').AsString:=EditDate.Text;
                       Params.ParamByName('name').AsString:=EditName.Text;
                       Params.ParamByName('state').AsString:='未通過';
                       Params.ParamByName('ID').AsString:=EditID.Text;

                       if RadioButton1.Checked=True then
                       begin
                          Params.ParamByName('leave').AsString:=RadioButton1.caption;
                       end;
                       if RadioButton2.Checked=True then
                       begin
                          Params.ParamByName('leave').AsString:=RadioButton2.caption;
                       end;
                       if RadioButton3.Checked=True then
                       begin
                          Params.ParamByName('leave').AsString:=RadioButton3.caption;
                       end;
                       if RadioButton4.Checked=True then
                       begin
                          Params.ParamByName('leave').AsString:=RadioButton4.caption;
                       end;
                       if RadioButton5.Checked=True then
                       begin
                          Params.ParamByName('leave').AsString:=RadioButton5.caption;
                       end;
                       if RadioButton6.Checked=True then
                       begin
                          Params.ParamByName('leave').AsString:=RadioButton6.caption;
                       end;

                       Close;
                       ExecSQL;

                       //必須加入此行，用以完成交易(寫入資料庫)
                       Frm000.SQLTransactionSQLScript.Commit;
                           showmessage('假單已經新增');
                           Label17.Caption := EditID.Text;
                           FrmC03.Label17.Visible:=true;
                           Label18.Caption:= EditName.Text;
                           FrmC03.Label18.Visible:=true;
                           Label19.Caption := EditDate.Text;
                           FrmC03.Label19.Visible:=true;
                           Label20.Caption := EditReason.Text;
                           FrmC03.Label20.Visible:=true;
                           Label21.Caption := Params.ParamByName('leave').AsString;
                           FrmC03.Label21.Visible:=true;
                     except
                         showmessage('假單新增時發生錯誤');
                     end
                 end
               else
                showmessage('資料輸入錯誤');
            end;
            Frm000.SQLQueryAttendence.Refresh;
            //Frm000.SQLQueryAttendence.Locate('員工編號',EditID.Text,[loPartialKey]);
         end
   else
       showmessage('項目不得為空白');
end;

procedure TFrmC03.DateTimePicker1Click(Sender: TObject);
begin

end;

procedure TFrmC03.EditDateClick(Sender: TObject);
begin
    DateTimePicker1.Visible:=not DateTimePicker1.Visible;
    E:=(Sender as TEdit);
end;

procedure TFrmC03.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmC03:=nil;
end;

procedure TFrmC03.FormCreate(Sender: TObject);
begin
  //設定初始值
  EditDate.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
end;

procedure TFrmC03.Label12Click(Sender: TObject);
begin

end;

procedure TFrmC03.Shape3ChangeBounds(Sender: TObject);
begin

end;

procedure TFrmC03.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmC03.EditIDChange(Sender: TObject);
begin

end;

end.

