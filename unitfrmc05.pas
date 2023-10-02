unit unitFrmC05;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DateTimePicker, DB;

type

  { TFrmC05 }

  TFrmC05 = class(TForm)
    ButtonUpdate: TButton;
    ButtonFind: TButton;
    ButtonClear: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGridPass: TDBGrid;
    DBGridNotPass: TDBGrid;
    EditDate: TEdit;
    EditEID: TEdit;
    EditName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure ButtonUpdateClick(Sender: TObject);
    procedure ButtonFindClick(Sender: TObject);
    //procedure ButtonRefreshClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure DBGridNotPassCellClick(Column: TColumn);
    procedure DBGridPassCellClick(Column: TColumn);
    procedure EditDateChange(Sender: TObject);
    procedure EditDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmC05: TFrmC05;
  E:TEdit;

implementation
uses unitFrm000, variants;
{$R *.lfm}

{ TFrmC05 }

procedure TFrmC05.ButtonUpdateClick(Sender: TObject);  //修改
var sqlstr: string;
begin
    if(length(EditEID.Text)>0) and Frm000.SQLQueryAttendence.Locate('員工編號',EditEID.Text,[loPartialKey])then
       if messageDlg('確定要修改員工資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
         with Frm000.SQLQueryScript do
           begin
             Try
	       //sqlstr:='update 員工 set 姓名='''+EditName.Text+''' where 員工編號= '''+ EditEID.Text +'''';
	       //sqlstr:='update 員工 set 姓名='''+EditName.Text+''', 名='''' + EditNameEN.Text +''' where 員工編號= '''+ EditEID.Text +'''';
               //showmessage(sqlstr);
	       //sqlstr:='update 員工 set 姓名= :Aname, 名=:AnameEN;
               sqlstr:='update DwarfDataBase.dbo.出缺勤資料 set 狀態=:Status where 員工編號= :EID and 日期= (SELECT CONVERT(DATETIME, :Date))';
	       SQL.Text := sqlstr;
               Params.ParamByName('EID').AsString :=EditEID.Text;
               Params.ParamByName('Date').AsString :=EditDate.Text;
	       //Params.ParamByName('Status').AsString :=EditStatus.Text;

               if RadioButton1.Checked=True then
               begin
                  Params.ParamByName('Status').AsString:=RadioButton1.caption;
               end;
               if RadioButton2.Checked=True then
               begin
                  Params.ParamByName('Status').AsString:=RadioButton2.caption;
               end;

               Close;
               ExecSQL;
               //showmessage('ok1');
               sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料 where 狀態= :Status';
	       SQL.Text := sqlstr;
               //Params.ParamByName('EID').AsString :=EditEID.Text;
               //Params.ParamByName('Date').AsString :=EditDate.Text;
	       //Params.ParamByName('Status').AsString :=EditStatus.Text;

               if RadioButton1.Checked=True then
               begin
                  Params.ParamByName('Status').AsString:=RadioButton1.caption;
               end;
               if RadioButton2.Checked=True then
               begin
                  Params.ParamByName('Status').AsString:=RadioButton2.caption;
               end;

               Close;
               ExecSQL;
               //showmessage('ok2');
               sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料 where 狀態= :Status';
	       SQL.Text := sqlstr;
               //Params.ParamByName('EID').AsString :=EditEID.Text;
               //Params.ParamByName('Date').AsString :=EditDate.Text;
	       //Params.ParamByName('Status').AsString :=EditStatus.Text;

               if RadioButton1.Checked=True then
               begin
                  Params.ParamByName('Status').AsString:=RadioButton1.caption;
               end;
               if RadioButton2.Checked=True then
               begin
                  Params.ParamByName('Status').AsString:=RadioButton2.caption;
               end;

               Close;
               ExecSQL;
               //showmessage('ok3');
           //必須加入此行，用以完成交易(寫入資料庫)
               Frm000.SQLTransactionSQLScript.Commit;
           //showmessage('資料已經修改');
              except
                //showmessage('資料修改時發生錯誤');
              end;//Try
           end;//which Frm000.SQLQueryScript do
           Frm000.SQLQueryAttendence.Active := true;
           //showmessage('ok4');
           Frm000.SQLQueryScript.Active := true;
           Frm000.SQLQueryAttendence.Refresh;
           //showmessage('ok5');
           Frm000.SQLQueryScript.Refresh;
           //showmessage('ok6');
           Frm000.SQLQueryNotPass.Refresh;
           //showmessage('ok7');
           Frm000.SQLQueryPass.Refresh;
           //showmessage('ok8');
           //Frm000.SQLQueryAttendence.Locate('員工編號',EditEID.Text,[loPartialKey])
           Frm000.SQLQueryPass.Locate('員工編號;日期',VarArrayOf([EditEID.Text,EditDate.Text]),[loPartialKey]);
           Frm000.SQLQueryNotPass.Locate('員工編號;日期',VarArrayOf([EditEID.Text,EditDate.Text]),[loPartialKey]);
           //showmessage('ok9');
       end //if messageDlg('確定要修改員工資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
end;

procedure TFrmC05.ButtonFindClick(Sender: TObject);      //查詢
var sqlstr1: string;
begin
  //if not (length(EditEID.Text) > 0) or not Frm000.SQLQueryAttendence.Locate('員工編號',EditEID.Text,[loPartialKey]) then begin
            //showmessage('查無此員工編號');
           //end else
              with Frm000.SQLQueryScript1 do
                    begin
                      Try
                        //showmessage('OK');
                        if EditEID.Text = ''  then begin
                           sqlstr1:='select * from DwarfDataBase.dbo.出缺勤資料 where 日期= (SELECT CONVERT(DATETIME, :Date) AS Datetime)';
                           SQL.Text := sqlstr1;
                           Params.ParamByName('Date').AsString:= EditDate.Text;
                           end else if EditDate.Text = '' then begin
                              sqlstr1:='select * from DwarfDataBase.dbo.出缺勤資料 where 員工編號= :EID';
                              SQL.Text := sqlstr1;
                              Params.ParamByName('EID').AsString:= EditEID.Text;
                              end else begin
                              sqlstr1:='select * from DwarfDataBase.dbo.出缺勤資料 where 員工編號= :EID and 日期= (SELECT CONVERT(DATETIME, :Date) AS Datetime)';
                              SQL.Text := sqlstr1;
                              Params.ParamByName('EID').AsString:= EditEID.Text;
                              Params.ParamByName('Date').AsString:= EditDate.Text;

                              end;
                        //sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料 where 員工編號= :EID and 日期= (SELECT CONVERT(DATETIME, :Date) AS Datetime)';
                        //SQL.Text := sqlstr;
                        //Params.ParamByName('EID').AsString:= EditEID.Text;
                        //Params.ParamByName('Date').AsString:= EditDate.Text;
                        //showmessage(sqlstr1);
                        close;
                        ExecSQL;
                        // showmessage('OK2');
                        //必加人比行・用以完成交易（寫入資料庫）
                        // Frm000.SQLTransactionCancellationSQLScript.commit;
                      except
                      showmessage('資料查詢時發生錯誤');
                      end; // Try
                     // showmessage('OK3');
                      Frm000.SQLQueryScript1.Active := true;
                      Frm000.SQLQueryScript1.Refresh;
                      Frm000.SQLQueryPass.Locate('員工編號;日期',VarArrayOf([EditEID.Text,EditDate.Text]),[loPartialKey]);
                      Frm000.SQLQueryNotPass.Locate('員工編號;日期',VarArrayOf([EditEID.Text,EditDate.Text]),[loPartialKey]);
                     // showmessage('OK4');
                    end;
    EditEID.text := Frm000.SQLQueryScript1.fieldbyName('員工編號').value;
  // EditName.text := Frm000.SQLQueryEmployee.fieldbyName('員工姓名').value;
  // 判斷該欄位是否為null
  if Frm000.SQLQueryScript1.fieldbyName('員工姓名').IsNull then
	EditName.text := ''
  else
	EditName.text := Frm000.SQLQueryScript1.fieldbyName('員工姓名').value;

  if Frm000.SQLQueryScript1.fieldbyName('日期').IsNull then
	EditDate.text := ''
  else
	EditDate.text := Frm000.SQLQueryScript1.fieldbyName('日期').value;

  // EditNameEN.text := Frm000.SQLQueryEmployee.fieldbyName('名').value;
  // 判斷該欄位是否為null
  if Frm000.SQLQueryScript1.fieldbyName('狀態').IsNull then
  begin
	RadioButton1.Checked:=False;
        RadioButton2.Checked:=False;
  end else
  begin
	if(Frm000.SQLQueryScript1.FieldByName('狀態').value = '已通過') then
        begin
           RadioButton1.Checked:=True;
        end;
        if(Frm000.SQLQueryScript1.FieldByName('狀態').value = '未通過') then
        begin
           RadioButton2.Checked:=True;
        end;
  end;
end;

//procedure TFrmC05.ButtonRefreshClick(Sender: TObject);
//var sqlstr: string;
//begin
//       with Frm000.SQLQueryScript1 do
//           begin
//             Try
//               showmessage('ok1');
//	       //sqlstr:='update 員工 set 姓名='''+EditName.Text+''' where 員工編號= '''+ EditEID.Text +'''';
//	       //sqlstr:='update 員工 set 姓名='''+EditName.Text+''', 名='''' + EditNameEN.Text +''' where 員工編號= '''+ EditEID.Text +'''';
//               //showmessage(sqlstr);
//	       //sqlstr:='update 員工 set 姓名= :Aname, 名=:AnameEN;
//               sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料';
//	       SQL.Text := sqlstr;
//               showmessage('ok2');
//               //Params.ParamByName('EID').AsString :=EditEID.Text;
//               //Params.ParamByName('Date').AsString :=EditDate.Text;
//	       //Params.ParamByName('假別').AsString :=EditLeave.Text;
//               Close;
//               ExecSQL;
//               showmessage('ok3');
//           //必須加入此行，用以完成交易(寫入資料庫)
//               //Frm000.SQLTransactionSQLScript.Commit;
//           //showmessage('資料已經修改');
//              except
//                showmessage('資料修改時發生錯誤');
//              end;//Try
//           end;//which Frm000.SQLQueryScript do
//           Frm000.SQLQueryScript1.Active := true;
//           Frm000.SQLQueryScript1.Refresh;
//           Frm000.SQLQueryScript1.Locate('員工編號','1',[loPartialKey]);
//           showmessage('ok4');
//end;

procedure TFrmC05.ButtonClearClick(Sender: TObject);
begin
  EditEID.Text:='';
  EditName.Text:='';
  EditDate.Text:='';
  RadioButton1.Checked:=False;
  RadioButton2.Checked:=False;
end;

procedure TFrmC05.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmC05.DBGridNotPassCellClick(Column: TColumn);
begin
  //Frm000.SQLQueryNotPass.Refresh;
   EditEID.text := Frm000.SQLQueryNotPass.fieldbyName('員工編號').value;
  // EditName.text := Frm000.SQLQueryEmployee.fieldbyName('員工姓名').value;
  // 判斷該欄位是否為null
  if Frm000.SQLQueryNotPass.fieldbyName('員工姓名').IsNull then
	EditName.text := ''
  else
	EditName.text := Frm000.SQLQueryNotPass.fieldbyName('員工姓名').value;

  if Frm000.SQLQueryNotPass.fieldbyName('日期').IsNull then
	EditDate.text := ''
  else
	EditDate.text := Frm000.SQLQueryNotPass.fieldbyName('日期').value;

  // EditNameEN.text := Frm000.SQLQueryEmployee.fieldbyName('名').value;
  // 判斷該欄位是否為null
  if Frm000.SQLQueryNotPass.fieldbyName('狀態').IsNull then
  begin
	RadioButton1.Checked:=False;
        RadioButton2.Checked:=False;
  end else
  begin
	if(Frm000.SQLQueryNotPass.FieldByName('狀態').value = '已通過') then
        begin
           RadioButton1.Checked:=True;
        end;
        if(Frm000.SQLQueryNotPass.FieldByName('狀態').value = '未通過') then
        begin
           RadioButton2.Checked:=True;
        end;
  end;
end;

procedure TFrmC05.DBGridPassCellClick(Column: TColumn);
begin
  //Frm000.SQLQueryPass.Refresh;
   EditEID.text := Frm000.SQLQueryPass.fieldbyName('員工編號').value;
  // EditName.text := Frm000.SQLQueryEmployee.fieldbyName('員工姓名').value;
  // 判斷該欄位是否為null
  if Frm000.SQLQueryPass.fieldbyName('員工姓名').IsNull then
	EditName.text := ''
  else
	EditName.text := Frm000.SQLQueryPass.fieldbyName('員工姓名').value;

  if Frm000.SQLQueryPass.fieldbyName('日期').IsNull then
	EditDate.text := ''
  else
	EditDate.text := Frm000.SQLQueryPass.fieldbyName('日期').value;

  // EditNameEN.text := Frm000.SQLQueryEmployee.fieldbyName('名').value;
  // 判斷該欄位是否為null
  if Frm000.SQLQueryPass.fieldbyName('狀態').IsNull then
  begin
	RadioButton1.Checked:=False;
        RadioButton2.Checked:=False;
  end else
  begin
	if(Frm000.SQLQueryPass.FieldByName('狀態').value = '已通過') then
        begin
           RadioButton1.Checked:=True;
        end;
        if(Frm000.SQLQueryPass.FieldByName('狀態').value = '未通過') then
        begin
           RadioButton2.Checked:=True;
        end;
  end;
end;

procedure TFrmC05.EditDateChange(Sender: TObject);
begin

end;

procedure TFrmC05.EditDateClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

procedure TFrmC05.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmC05:=nil;
end;

procedure TFrmC05.FormCreate(Sender: TObject);
begin
  EditDate.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
end;

end.

