unit unitfrmA01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ExtCtrls, DateTimePicker, DB, Variants;

type

  { TFrmA01 }

  TFrmA01 = class(TForm)
    ButLogin: TButton;
    ButCancel: TButton;
    Butchangepass: TButton;
    Butchangecancel: TButton;
    DBGrid1: TDBGrid;
    Editchangeacc: TEdit;
    Editchangeid: TEdit;
    Editchangenew: TEdit;
    Editaccount: TEdit;
    Editpassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Labelchangeshow: TLabel;
    Labelchangeconceal: TLabel;
    Labelconceal: TLabel;
    Labelshow: TLabel;
    Labelchange: TLabel;
    Panelchange: TPanel;
    procedure ButCancelClick(Sender: TObject);
    procedure ButchangecancelClick(Sender: TObject);
    procedure ButchangepassClick(Sender: TObject);
    procedure ButLoginClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Label2Click(Sender: TObject);
    procedure LabelchangeconcealClick(Sender: TObject);
    procedure LabelchangeshowClick(Sender: TObject);
    procedure LabelconcealClick(Sender: TObject);
    procedure LabelshowClick(Sender: TObject);
    procedure LabelchangeaccClick(Sender: TObject);
    procedure LabelchangeClick(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
  private

  public

  end;

var
  FrmA01: TFrmA01;

implementation
uses UnitFrm000;

{$R *.lfm}

{ TFrmA01 }

procedure TFrmA01.Label2Click(Sender: TObject);
begin

end;

procedure TFrmA01.LabelchangeconcealClick(Sender: TObject);
begin
  FrmA01.Editchangenew.PasswordChar:='*';
end;

procedure TFrmA01.LabelchangeshowClick(Sender: TObject);
begin
  FrmA01.Editchangenew.PasswordChar:=#0;
end;

procedure TFrmA01.LabelconcealClick(Sender: TObject);
begin
  FrmA01.Editpassword.PasswordChar:='*';
end;

procedure TFrmA01.LabelshowClick(Sender: TObject);
begin
   FrmA01.Editpassword.PasswordChar:=#0;
end;

procedure TFrmA01.LabelchangeaccClick(Sender: TObject);
begin

end;

procedure TFrmA01.LabelchangeClick(Sender: TObject);
begin
   FrmA01.Panelchange.visible:=true;
   FrmA01.Editchangeacc.visible:=true;
   FrmA01.Editchangeid.visible:=true;
   FrmA01.Editchangenew.visible:=true;
   FrmA01.Butchangepass.visible:=true;
   FrmA01.Butchangecancel.visible:=true;
end;

procedure TFrmA01.RadioButton1Change(Sender: TObject);
begin

end;

procedure TFrmA01.ButLoginClick(Sender: TObject);
var FindResultName:Variant;
begin
   Try
   if(length(Editaccount.Text)>0)then begin
     FindResultName:=Frm000.SQLQueryEmployee.Lookup('員工編號;密碼',VarArrayOf([Editaccount.Text,Editpassword.Text]),'姓名');
     Frm000.Panel1.visible:=true;
   if not Varisnull(FindResultName) then begin
     //Frm000.caption:='朵福人事薪資管理系統 - '+varToStr(FindResultName);
     //人事部
     if Editaccount.Text ='1' then begin
       Frm000.caption:='朵福人事薪資管理系統 - '+varToStr(FindResultName)+' 人事部';
       Frm000.A01.visible:=false;
       Frm000.A02.visible:=true;
       Frm000.B.enabled:=true;
       Frm000.B01.enabled:=true;
       Frm000.B02.enabled:=true;
       Frm000.C.enabled:=true;
       Frm000.C01.enabled:=true;
       Frm000.C02.enabled:=true;
       Frm000.C03.enabled:=true;
       Frm000.C04.enabled:=true;
       Frm000.C05.enabled:=true;
       Frm000.D.enabled:=true;
       Frm000.D01.enabled:=true;
       Frm000.D02.enabled:=true;
       Frm000.E.enabled:=true;
       Frm000.E01.enabled:=true;
       Frm000.E02.enabled:=true;
       Frm000.F.enabled:=true;
       Frm000.F01.enabled:=true;
       Frm000.F02.enabled:=true;
       Frm000.F03.enabled:=true;
       Frm000.F04.enabled:=true;
       Frm000.F05.enabled:=true;
       Frm000.F06.enabled:=true;
       Frm000.F07.enabled:=true;
       Frm000.F08.enabled:=true;
     end
     //人資部
     else if Editaccount.Text ='2' then begin
       Frm000.caption:='朵福人事薪資管理系統 - '+varToStr(FindResultName)+' 人資部';
       Frm000.A01.visible:=false;
       Frm000.A02.visible:=true;
       Frm000.E.enabled:=true;
       Frm000.E01.enabled:=true;
       Frm000.E02.enabled:=true;
     end
     //財務部
     else if Editaccount.Text ='3' then begin
       Frm000.caption:='朵福人事薪資管理系統 - '+varToStr(FindResultName)+' 財務部';
       Frm000.A01.visible:=false;
       Frm000.A02.visible:=true;
       Frm000.D.enabled:=true;
       Frm000.D01.enabled:=true;
       Frm000.D02.enabled:=true;
       Frm000.F.enabled:=true;
       Frm000.F01.enabled:=true;
       Frm000.F02.enabled:=true;
       Frm000.F03.enabled:=true;
       Frm000.F04.enabled:=true;
       Frm000.F05.enabled:=true;
       Frm000.F06.enabled:=true;
       Frm000.F07.enabled:=true;
       Frm000.F08.enabled:=true;
     end
     //員工
     else begin
       Frm000.caption:='朵福人事薪資管理系統 - '+varToStr(FindResultName)+' 員工';
       Frm000.A01.visible:=false;
       Frm000.A02.visible:=true;
       //Frm000.B.enabled:=true;
       //Frm000.B01.enabled:=true;
       Frm000.C.enabled:=true;
       //Frm000.C01.enabled:=true;
       Frm000.C03.enabled:=true;
       //Frm000.D.enabled:=true;
       //Frm000.D01.enabled:=true;
       //Frm000.E.enabled:=true;
       //Frm000.E01.enabled:=true;
       Frm000.F.enabled:=true;
       //Frm000.F01.enabled:=true;
       Frm000.F03.enabled:=true;
       //Frm000.F04.enabled:=true;
       Frm000.F06.enabled:=true;
       //Frm000.F07.enabled:=true;
     end;
   end

     else begin
        showMessage('帳密錯誤');
     end;
      close;
     end
     else
        showMessage('帳號不得為空白');
    except
    end;
end;

procedure TFrmA01.ButCancelClick(Sender: TObject);
begin
    Editaccount.Text :='';
    Editpassword.Text :='';
end;

procedure TFrmA01.ButchangecancelClick(Sender: TObject);
begin
    Editchangeacc.Text :='';
    Editchangeid.Text :='';
    Editchangenew.Text :='';
end;

procedure TFrmA01.ButchangepassClick(Sender: TObject);
var sqlstr: string;
begin
   with Frm000.SQLQueryEmployee1 do
   begin
   Try
   if(length(Editchangeacc.Text)>0) and (length(Editchangeid.Text)>0) and (length(Editchangenew.Text)>0) then begin
     Frm000.SQLQueryEmployee1.Locate('員工編號',Editchangeacc.Text,[loPartialKey]);
     Try
     if DBGrid1.columns[1].Field.AsString=Editchangeid.Text
     then begin
       if messageDlg('確定要修改密碼?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
       with Frm000.SQLQueryEmployee do
         begin
           Try
             sqlstr:='update 員工資料 set 密碼= :password where 員工編號= :EID';
             SQL.Text := sqlstr;
             Params.ParamByName('password').AsString :=Editchangenew.Text;
             Params.ParamByName('EID').AsString :=Editchangeacc.Text;

             Close;
             ExecSQL;
             Frm000.SQLTransactionEmployee.Commit;

             sqlstr:='select * from 員工資料 where 員工編號= :EID1';
             SQL.Text := sqlstr;
             Params.ParamByName('EID1').AsString :=Editchangeacc.Text;

             Close;
             ExecSQL;
           except
             showmessage('密碼修改時發生錯誤');
           end;
         end;
         Frm000.SQLQueryEmployee.Active := true;
         Frm000.SQLQueryEmployee.Refresh;
       end;
       showmessage('密碼已成功修改');
       FrmA01.Panelchange.visible:=false;
       FrmA01.Editchangeacc.visible:=false;
       FrmA01.Editchangeid.visible:=false;
       FrmA01.Editchangenew.visible:=false;
       FrmA01.Butchangepass.visible:=false;
       FrmA01.Butchangecancel.visible:=false;
       Editchangeacc.Text :='';
       Editchangeid.Text :='';
       Editchangenew.Text :='';
     end
      else
        showmessage('身分證字號錯誤');
        except;
      end;
      end
      else
        showmessage('欄位不得為空');
      except;
   end;
   end;
end;


procedure TFrmA01.Button2Click(Sender: TObject);
begin

end;

procedure TFrmA01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction:=caFree;
    FrmA01:=nil;
end;

end.

