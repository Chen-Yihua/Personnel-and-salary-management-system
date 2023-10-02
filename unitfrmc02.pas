unit unitFrmC02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DateTimePicker, DB;

type

  { TFrmC02 }

  TFrmC02 = class(TForm)
    ButAppend1: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ButtonClear: TButton;
    ButUpdate: TButton;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGridAttendence: TDBGrid;
    EditDate: TEdit;
    EditDate1: TEdit;
    EditEID: TEdit;
    EditEID1: TEdit;
    EditName: TEdit;
    EditName1: TEdit;
    EditReason: TEdit;
    EditSitu1: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
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
    RadioButton7: TRadioButton;
    procedure ButAppendClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure DateTimePicker2DblClick(Sender: TObject);
    procedure DBGridAttendenceCellClick(Column: TColumn);
    procedure EditDate1Click(Sender: TObject);
    procedure EditDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmC02: TFrmC02;
  E:TEdit;

implementation
uses unitFrm000,variants;
{$R *.lfm}

{ TFrmC02 }

procedure TFrmC02.ButUpdateClick(Sender: TObject);       //修改
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
               sqlstr:='update 出缺勤資料 set 假別=:Leave, 事由=:Reason, 狀態=:NotPass where 員工編號= :EID AND 日期= :Date';
	       SQL.Text := sqlstr;
               Params.ParamByName('EID').AsString :=EditEID.Text;
               Params.ParamByName('Date').AsString :=EditDate.Text;
               Params.ParamByName('Reason').AsString:=EditReason.Text;
               Params.ParamByName('NotPass').AsString:='未通過';
	       //Params.ParamByName('Leave').AsString :=EditLeave.Text;

               if RadioButton1.Checked=True then
               begin
                  Params.ParamByName('Leave').AsString:=RadioButton1.caption;
               end;
               if RadioButton2.Checked=True then
               begin
                  Params.ParamByName('Leave').AsString:=RadioButton2.caption;
               end;
               if RadioButton3.Checked=True then
               begin
                  Params.ParamByName('Leave').AsString:=RadioButton3.caption;
               end;
               if RadioButton4.Checked=True then
               begin
                  Params.ParamByName('Leave').AsString:=RadioButton4.caption;
               end;
               if RadioButton5.Checked=True then
               begin
                  Params.ParamByName('Leave').AsString:=RadioButton5.caption;
               end;
               if RadioButton6.Checked=True then
               begin
                  Params.ParamByName('Leave').AsString:=RadioButton6.caption;
               end;
               if RadioButton7.Checked=True then
               begin
                  Params.ParamByName('Leave').AsString:=RadioButton7.caption;
               end;

               Close;
               ExecSQL;

           //必須加入此行，用以完成交易(寫入資料庫)
               Frm000.SQLTransactionSQLScript.Commit;
           //showmessage('資料已經修改');
              except
                showmessage('資料修改時發生錯誤');
              end;//Try
           end;//which Frm000.SQLQueryScript do
           Frm000.SQLQueryAttendence.Refresh;
           Frm000.SQLQueryNotPass.Refresh;
           Frm000.SQLQueryPass.Refresh;
           //Frm000.SQLQueryAttendence.Locate('員工編號',EditEID.Text,[loPartialKey]) ;
           Frm000.SQLQueryAttendence.Locate('員工編號;日期',VarArrayOf([EditEID.Text,EditDate.Text]),[loPartialKey]);
           //Frm000.SQLQueryAttendence.Refresh;
        end //if messageDlg('確定要修改員工資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
end;

procedure TFrmC02.Button1Click(Sender: TObject);      //查詢資料
var sqlstr: string;
var EDate:Tdate;
begin
    //if TryStrToDate(EditDate.Text,EDate) then begin
    //       if not (length(EditEID.Text) > 0) or not Frm000.SQLQueryAttendence.Locate('員工編號',EditEID.Text,[loPartialKey]) then begin
    //        showmessage('查無此員工編號');
    //       end else
              with Frm000.SQLQueryAttendence do
                    begin
                      Try
                        //showmessage('OK');
                        if EditEID.Text = ''  then begin
                           sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料 where 日期= (SELECT CONVERT(DATETIME, :Date) AS Datetime)';
                           SQL.Text := sqlstr;
                           Params.ParamByName('Date').AsString:= EditDate.Text;
                           end else if EditDate.Text = '' then begin
                              sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料 where 員工編號= :EID';
                              SQL.Text := sqlstr;
                              Params.ParamByName('EID').AsString:= EditEID.Text;
                              end else begin
                              sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料 where 員工編號= :EID and 日期= (SELECT CONVERT(DATETIME, :Date) AS Datetime)';
                              SQL.Text := sqlstr;
                              Params.ParamByName('EID').AsString:= EditEID.Text;
                              Params.ParamByName('Date').AsString:= EditDate.Text;

                        end;

                        //sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料 where 員工編號= :EID and 日期= (SELECT CONVERT(DATETIME, :Date) AS Datetime)';
                        //SQL.Text := sqlstr;
                        //Params.ParamByName('EID').AsString:= EditEID.Text;
                        //Params.ParamByName('Date').AsString:= EditDate.Text;
                        //showmessage(sqlstr);
                        close;
                        ExecSQL;
                         //showmessage('OK2');
                        //必加人比行・用以完成交易（寫入資料庫）
                        // Frm000.SQLTransactionCancellationSQLScript.commit;
                      except
                      showmessage('資料查詢時發生錯誤');
                      end; // Try
                      //showmessage('OK3');
                      Frm000.SQLQueryAttendence.Active := true;
                      Frm000.SQLQueryAttendence.Refresh;
                      //showmessage('OK4');
                    end; //with Frn000. SQLQueryscript do
       //end else
       //showmessage('日期格式錯誤，正確yyyy/mm/dd')  ;

  EditEID.text:=Frm000.SQLQueryAttendence.FieldByName('員工編號').value;
   if Frm000.SQLQueryAttendence.FieldByName('員工姓名').IsNull then
        EditName.text:=''
   else
        EditName.text:= Frm000.SQLQueryAttendence.FieldByName('員工姓名').value;
   if Frm000.SQLQueryAttendence.FieldByName('日期').IsNull then
        EditDate.text:=''
   else
        EditDate.text:= Frm000.SQLQueryAttendence.FieldByName('日期').value;

   if Frm000.SQLQueryAttendence.FieldByName('假別').IsNull then
   begin
        RadioButton1.Checked:=False;
        RadioButton2.Checked:=False;
        RadioButton3.Checked:=False;
        RadioButton4.Checked:=False;
        RadioButton5.Checked:=False;
        RadioButton6.Checked:=False;
   end else
   begin
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '病假') then
        begin
           RadioButton1.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '事假') then
        begin
           RadioButton2.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '喪假') then
        begin
           RadioButton3.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '生理假') then
        begin
           RadioButton4.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '產檢假') then
        begin
           RadioButton5.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '婚假') then
        begin
           RadioButton6.Checked:=True;
        end;
   end;

end;

procedure TFrmC02.ButAppendClick(Sender: TObject);            //新增出缺勤
begin
  if (length(EditEID1.text)>0) and (length(EditName1.Text)>0) and (length(EditDate1.text)>0)  and (length(EditSitu1.text)>0) then
       with Frm000.SQLQueryAttendence do
         begin
          if  Locate('員工編號',EditEID.Text,[loPartialKey]) then
          begin
            Append;
                fieldbyName('員工編號').asinteger:=strToint(EditEID1.text);
                fieldbyName('員工姓名').asstring:=EditName1.text;
                fieldbyName('日期').asstring:=EditDate1.text;
                fieldbyName('出缺勤狀況').asstring:='缺勤';
            post;
            applyupdates;

            //必須加入此行
                Frm000.SQLTransactionAttendence.CommitRetaining;
                refresh;
                showmessage('資料已經正確新增');

            end
            else
                showmessage('資料新增時發生錯誤，原因:員工編號 重複');
          end
          else
            showmessage('項目不得為空白');
          //Frm000.SQLQueryScript.Locate('員工編號',EditEID1.Text,[loPartialKey]);
          Frm000.SQLQueryAttendence.Locate('員工姓名;日期',VarArrayOf([EditName1.Text,EditDate1.Text]),[loPartialKey]);
end;

procedure TFrmC02.Button2Click(Sender: TObject);    //回所有資料
var sqlstr: string;
begin
    //if(length(EditEID.Text)>0) and Frm000.SQLQueryAttendence.Locate('員工編號',EditEID.Text,[loPartialKey])then
    //   if messageDlg('確定要修改員工資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    //   begin
         with Frm000.SQLQueryAttendence do
           begin
             Try
               //showmessage('ok1');
	       //sqlstr:='update 員工 set 姓名='''+EditName.Text+''' where 員工編號= '''+ EditEID.Text +'''';
	       //sqlstr:='update 員工 set 姓名='''+EditName.Text+''', 名='''' + EditNameEN.Text +''' where 員工編號= '''+ EditEID.Text +'''';
               //showmessage(sqlstr);
	       //sqlstr:='update 員工 set 姓名= :Aname, 名=:AnameEN;
               sqlstr:='select * from DwarfDataBase.dbo.出缺勤資料';
	       SQL.Text := sqlstr;
               //showmessage('ok2');
               //Params.ParamByName('EID').AsString :=EditEID.Text;
               //Params.ParamByName('Date').AsString :=EditDate.Text;
	       //Params.ParamByName('假別').AsString :=EditLeave.Text;
               Close;
               ExecSQL;
               //showmessage('ok3');
           //必須加入此行，用以完成交易(寫入資料庫)
               //Frm000.SQLTransactionSQLScript.Commit;
           //showmessage('資料已經修改');
              except
                showmessage('資料修改時發生錯誤');
              end;//Try
           end;//which Frm000.SQLQueryScript do
           Frm000.SQLQueryAttendence.Active := true;
           Frm000.SQLQueryAttendence.Refresh;
           Frm000.SQLQueryAttendence.Locate('員工編號','1',[loPartialKey]);
           //FsaPart.Locate('ID;FSAClientID;PartID',VarArrayOf([34,'Test',56]),[]);
           //showmessage('ok4');
end;

procedure TFrmC02.Button3Click(Sender: TObject);
begin
  EditEID1.Text:='';
  EditName1.Text:='';
  EditDate1.Text:='';
  RadioButton1.Checked:=False;
  RadioButton2.Checked:=False;
  RadioButton3.Checked:=False;
  RadioButton4.Checked:=False;
  RadioButton5.Checked:=False;
  RadioButton6.Checked:=False;
end;

procedure TFrmC02.ButtonClearClick(Sender: TObject);
begin
  EditEID.Text:='';
  EditName.Text:='';
  EditDate.Text:='';
  RadioButton1.Checked:=False;
  RadioButton2.Checked:=False;
  RadioButton3.Checked:=False;
  RadioButton4.Checked:=False;
  RadioButton5.Checked:=False;
  RadioButton6.Checked:=False;
end;



procedure TFrmC02.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmC02.DateTimePicker2DblClick(Sender: TObject);
begin
   E.Text:=DateToStr(DateTimePicker2.date);
  DateTimePicker2.Visible:=False;
end;

procedure TFrmC02.DBGridAttendenceCellClick(Column: TColumn);
begin
  EditEID.text:=Frm000.SQLQueryAttendence.FieldByName('員工編號').value;
   if Frm000.SQLQueryAttendence.FieldByName('員工姓名').IsNull then
        EditName.text:=''
   else
        EditName.text:= Frm000.SQLQueryAttendence.FieldByName('員工姓名').value;
   if Frm000.SQLQueryAttendence.FieldByName('日期').IsNull then
        EditDate.text:=''
   else
        EditDate.text:= Frm000.SQLQueryAttendence.FieldByName('日期').value;
   if Frm000.SQLQueryAttendence.FieldByName('事由').IsNull then
      EditReason.text:=''
   else
       EditReason.text:= Frm000.SQLQueryAttendence.FieldByName('事由').value;
   if Frm000.SQLQueryAttendence.FieldByName('假別').IsNull then
   begin
        RadioButton1.Checked:=False;
        RadioButton2.Checked:=False;
        RadioButton3.Checked:=False;
        RadioButton4.Checked:=False;
        RadioButton5.Checked:=False;
        RadioButton6.Checked:=False;
        RadioButton7.Checked:=False;
   end else
   begin
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '病假') then
        begin
           RadioButton1.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '事假') then
        begin
           RadioButton2.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '喪假') then
        begin
           RadioButton3.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '生理假') then
        begin
           RadioButton4.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '產檢假') then
        begin
           RadioButton5.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '婚假') then
        begin
           RadioButton6.Checked:=True;
        end;
        if(Frm000.SQLQueryAttendence.FieldByName('假別').value = '曠班') then
        begin
           RadioButton7.Checked:=True;
        end;
   end;
end;

procedure TFrmC02.EditDate1Click(Sender: TObject);
begin
   DateTimePicker2.Visible:=not DateTimePicker2.Visible;
  E:=(Sender as TEdit);
end;

procedure TFrmC02.EditDateClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

procedure TFrmC02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmC02:=nil;
end;

procedure TFrmC02.FormCreate(Sender: TObject);
begin
  EditDate.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
  EditDate1.text:=DatetimeToStr(Date);
  DateTimePicker2.date:=now;
  //EditEID.text:='';
  //EditName.text:='';
  //EditEID1.text:='';
  //EditName1.text:='';
  //EditSitu1.text:='';
  //
  //RadioButton1.Checked:=False;
  //RadioButton2.Checked:=False;
  //RadioButton3.Checked:=False;
  //RadioButton4.Checked:=False;
  //RadioButton5.Checked:=False;
  //RadioButton6.Checked:=False;
end;

end.

