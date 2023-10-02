unit unitFrmB02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DateTimePicker,DB;

type

  { TFrmB02 }

  TFrmB02 = class(TForm)
    ButAppend: TButton;
    ButUpdate: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    EditEID: TEdit;
    EditPID: TEdit;
    EditGender: TEdit;
    Edittelephone: TEdit;
    Editemployee: TEdit;
    EditEName: TEdit;
    EditBirthday: TEdit;
    Editcellphone: TEdit;
    Editaddress: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure ButAppendClick(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DateTimePicker1DblClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EditBirthdayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmB02: TFrmB02;
  E:TEdit;

implementation
uses UnitFrm000;

{$R *.lfm}

{ TFrmB02 }

procedure TFrmB02.ButAppendClick(Sender: TObject);
var INT: Integer;
begin
  if (length(EditEID.text)>0) and (length(EditEName.Text)>0) and (length(EditPID.text)>0)  and (length(EditBirthday.text)>0) and (length(EditGender.text)>0) and (length(Editcellphone.text)>0) and (length(Edittelephone.text)>0)and (length(Editaddress.text)>0)and (length(Editemployee.text)>0)then
       with Frm000.SQLQueryEmployee do
         begin
          if not Locate('員工編號',EditEID.Text,[loPartialKey]) then
          begin
            Append;
                fieldbyName('員工編號').asinteger:=strToint(EditEID.text);
                fieldbyName('姓名').asstring:=EditEName.text;
                fieldbyName('身分證字號').asstring:=EditPID.text;
                fieldbyName('生日').asstring:=EditBirthday.text;
                fieldbyName('性別').asstring:=EditGender.text;
                fieldbyName('手機').asstring:=Editcellphone.text;
                fieldbyName('電話').asstring:=Edittelephone.text;
                fieldbyName('住家地址').asstring:=Editaddress.text;
                fieldbyName('在職狀況').asstring:='在職';
            post;
            applyupdates;

            //必須加入此行
                Frm000.SQLTransactionEmployee.CommitRetaining;
                refresh;
                showmessage('資料已經正確新增');

            end
            else
                showmessage('資料新增時發生錯誤，原因:員工編號 重複');
          end
          else
            showmessage('項目不得為空白');
          Frm000.SQLQueryEmployee.Locate('員工編號',EditEID.Text,[loPartialKey]);
end;

procedure TFrmB02.ButUpdateClick(Sender: TObject);
var sqlstr: string;
begin
      if(length(EditEID.Text)>0) and Frm000.SQLQueryEmployee.Locate('員工編號',EditEID.Text,[loPartialKey])then
       if messageDlg('確定要修改員工資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
         with Frm000.SQLQueryEmployee1 do
           begin
             Try
               sqlstr:='update 員工資料 set 姓名= :EName, 身分證字號=:PID, 生日=:Birthday, 性別=:Gender, 手機=:cellphone, 電話=:telephone, 住家地址=:address, 在職狀況=:employee where 員工編號= :EID';
        SQL.Text := sqlstr;
        Params.ParamByName('EID').AsString :=EditEID.Text;
        Params.ParamByName('EName').AsString :=EditEName.Text;
        Params.ParamByName('PID').AsString :=EditPID.Text;
        Params.ParamByName('Birthday').AsString :=EditBirthday.Text;
        Params.ParamByName('Gender').AsString :=EditGender.Text;
        Params.ParamByName('cellphone').AsString :=Editcellphone.Text;
        Params.ParamByName('telephone').AsString :=Edittelephone.Text;
        Params.ParamByName('address').AsString :=Editaddress.Text;
        Params.ParamByName('employee').AsString :=Editemployee.Text;
               Close;
               ExecSQL;

       //必須加入此行，用以完成交易(寫入資料庫)
                   Frm000.SQLTransactionEmployee1.Commit;
                   //showmessage('資料已經修改');
                 except
                   showmessage('資料修改時發生錯誤');
                 end;//Try
             end;//which Frm000.SQLQueryScript do
             Frm000.SQLQueryEmployee.Refresh;
             Frm000.SQLQueryEmployee.Locate('員工編號',EditEID.Text,[loPartialKey])
           end //if messageDlg('確定要修改員工資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
end;

procedure TFrmB02.DateTimePicker1DblClick(Sender: TObject);
begin
  E.Text:=DateToStr(DateTimePicker1.date);
  DateTimePicker1.Visible:=False;
end;

procedure TFrmB02.DBGrid1CellClick(Column: TColumn);
begin
   EditEID.text:=Frm000.SQLQueryEmployee.fieldbyName('員工編號').value;
//  EditName.text:=Frm000.SQLQueryEmployee.fieldbyName('姓名').value;
//判斷該欄位是否為null
  if Frm000.SQLQueryEmployee.fieldbyName('員工編號').IsNull then
 	EditEID.text:=''
  else
	EditEID.text:=Frm000.SQLQueryEmployee.fieldbyName('員工編號').value;

  if Frm000.SQLQueryEmployee.fieldbyName('姓名').IsNull then
 	EditEName.text:=''
  else
	EditEName.text:=Frm000.SQLQueryEmployee.fieldbyName('姓名').value;

  if Frm000.SQLQueryEmployee.fieldbyName('身分證字號').IsNull then
 	EditPID.text:=''
  else
	EditPID.text:=Frm000.SQLQueryEmployee.fieldbyName('身分證字號').value;

    if Frm000.SQLQueryEmployee.fieldbyName('生日').IsNull then
 	EditBirthday.text:=''
  else
	EditBirthday.text:=Frm000.SQLQueryEmployee.fieldbyName('生日').value;

    if Frm000.SQLQueryEmployee.fieldbyName('性別').IsNull then
 	EditGender.text:=''
  else
	EditGender.text:=Frm000.SQLQueryEmployee.fieldbyName('性別').value;

    if Frm000.SQLQueryEmployee.fieldbyName('手機').IsNull then
 	Editcellphone.text:=''
  else
	Editcellphone.text:=Frm000.SQLQueryEmployee.fieldbyName('手機').value;

    if Frm000.SQLQueryEmployee.fieldbyName('電話').IsNull then
 	Edittelephone.text:=''
  else
	Edittelephone.text:=Frm000.SQLQueryEmployee.fieldbyName('電話').value;

    if Frm000.SQLQueryEmployee.fieldbyName('住家地址').IsNull then
 	Editaddress.text:=''
  else
	Editaddress.text:=Frm000.SQLQueryEmployee.fieldbyName('住家地址').value;

    if Frm000.SQLQueryEmployee.fieldbyName('在職狀況').IsNull then
 	Editemployee.text:=''
  else
	Editemployee.text:=Frm000.SQLQueryEmployee.fieldbyName('在職狀況').value;
end;

procedure TFrmB02.EditBirthdayClick(Sender: TObject);
begin
  DateTimePicker1.Visible:=not DateTimePicker1.Visible;
  E:=(Sender as TEdit);
end;

procedure TFrmB02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmB02:=nil;
end;

procedure TFrmB02.FormCreate(Sender: TObject);
begin
  EditBirthday.text:=DatetimeToStr(Date);
  DateTimePicker1.date:=now;
end;

end.

