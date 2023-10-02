unit unitFrmF07;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ExtCtrls, DB;

type

  { TFrmF07 }

  TFrmF07 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    EditEID: TEdit;
    EditEName: TEdit;
    EditChildName: TEdit;
    EditCApplyDate: TEdit;
    EditCApprovalstatus: TEdit;
    EditCDisstatus: TEdit;
    EditBID: TEdit;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
  private

  public

  end;

var
  FrmF07: TFrmF07;

implementation
uses unitfrm000;

{$R *.lfm}

{ TFrmF07 }

procedure TFrmF07.Button1Click(Sender: TObject);
begin
  if not Frm000.SQLQueryChild.Locate('子女獎金編號',EditBID.Text,[loPartialKey]) then begin
     showmessage('查無 此子女獎金編號');
  end;

  EditBID.text:=Frm000.SQLQueryChild.fieldbyName('子女獎金編號').value;
  if Frm000.SQLQueryChild.FieldbyName('員工編號').IsNull then
       EditEID.Text:=''
  else
     EditEID.text:=Frm000.SQLQueryChild.fieldbyName('員工編號').value;

  if Frm000.SQLQueryChild.FieldbyName('員工姓名').IsNull then
       EditEName.Text:=''
  else
     EditEName.text:=Frm000.SQLQueryChild.fieldbyName('員工姓名').value;

  if Frm000.SQLQueryChild.FieldbyName('子女姓名').IsNull then
       EditChildName.Text:=''
  else
     EditChildName.text:=Frm000.SQLQueryChild.fieldbyName('子女姓名').value;

  if Frm000.SQLQueryChild.FieldbyName('申請日期').IsNull then
       EditCApplyDate.Text:=''
  else
     EditCApplyDate.text:=Frm000.SQLQueryChild.fieldbyName('申請日期').value;

  if Frm000.SQLQueryChild.FieldbyName('核准狀況').IsNull then
       EditCApprovalstatus.Text:=''
  else
     EditCApprovalstatus.text:=Frm000.SQLQueryChild.fieldbyName('核准狀況').value;

  if Frm000.SQLQueryChild.FieldbyName('發放狀況').IsNull then
       EditCDisstatus.Text:=''
  else
     EditCDisstatus.text:=Frm000.SQLQueryChild.fieldbyName('發放狀況').value;

  FrmF07.EditEID.enabled:=False;
  FrmF07.EditEName.enabled:=False;
  FrmF07.EditChildName.enabled:=False;
  FrmF07.EditCApplyDate.enabled:=False;
  FrmF07.EditCApprovalstatus.enabled:=False;
  FrmF07.EditCDisstatus.enabled:=False;

  FrmF07.Shape1.Visible:=true;
  FrmF07.Shape2.Visible:=true;
  FrmF07.Label9.Visible:=true;
  FrmF07.Label10.Visible:=true;
  FrmF07.Label11.Visible:=true;
  FrmF07.Label12.Visible:=true;
  FrmF07.Label13.Visible:=true;
  FrmF07.Label14.Visible:=true;
  FrmF07.Label15.Visible:=true;

  Label16.Caption := EditBID.Text;
  FrmF07.Label16.Visible:=true;
  Label17.Caption := EditEID.Text;
  FrmF07.Label17.Visible:=true;
  Label18.Caption := EditEName.Text;
  FrmF07.Label18.Visible:=true;
  Label19.Caption := EditChildName.Text;
  FrmF07.Label19.Visible:=true;
  Label20.Caption := EditCApplyDate.Text;
  FrmF07.Label20.Visible:=true;
end;

procedure TFrmF07.DBGrid1CellClick(Column: TColumn);
begin

end;

procedure TFrmF07.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmF07:=nil;
end;

procedure TFrmF07.FormCreate(Sender: TObject);
begin

end;

procedure TFrmF07.Label2Click(Sender: TObject);
begin

end;

procedure TFrmF07.Label9Click(Sender: TObject);
begin

end;

end.

