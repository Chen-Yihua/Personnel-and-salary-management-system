unit unitFrmF04;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ExtCtrls, DB, dbf;

type

  { TFrmF04 }

  TFrmF04 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    EditEID: TEdit;
    EditEName: TEdit;
    EditMarriage: TEdit;
    EditMApplyDate: TEdit;
    EditMApprovalstatus: TEdit;
    EditMDisstatus: TEdit;
    EditAID: TEdit;
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
    procedure Shape2ChangeBounds(Sender: TObject);
  private

  public

  end;

var
  FrmF04: TFrmF04;

implementation
uses unitfrm000;

{$R *.lfm}

{ TFrmF04 }

procedure TFrmF04.Button1Click(Sender: TObject);
begin
  if not Frm000.SQLQueryWedding.Locate('結婚禮金編號',EditAID.Text,[loPartialKey]) then begin
     showmessage('查無 此結婚禮金編號');
  end;

  EditAID.text:=Frm000.SQLQueryWedding.fieldbyName('結婚禮金編號').value;
  if Frm000.SQLQueryWedding.FieldbyName('員工編號').IsNull then
       EditEID.Text:=''
  else
     EditEID.text:=Frm000.SQLQueryWedding.fieldbyName('員工編號').value;

  if Frm000.SQLQueryWedding.FieldbyName('員工姓名').IsNull then
       EditEName.Text:=''
  else
     EditEName.text:=Frm000.SQLQueryWedding.fieldbyName('員工姓名').value;

  if Frm000.SQLQueryWedding.FieldbyName('結婚日期').IsNull then
       EditMarriage.Text:=''
  else
     EditMarriage.text:=Frm000.SQLQueryWedding.fieldbyName('結婚日期').value;

  if Frm000.SQLQueryWedding.FieldbyName('申請日期').IsNull then
       EditMApplyDate.Text:=''
  else
     EditMApplyDate.text:=Frm000.SQLQueryWedding.fieldbyName('申請日期').value;

  if Frm000.SQLQueryWedding.FieldbyName('核准狀況').IsNull then
       EditMApprovalstatus.Text:=''
  else
     EditMApprovalstatus.text:=Frm000.SQLQueryWedding.fieldbyName('核准狀況').value;

  if Frm000.SQLQueryWedding.FieldbyName('發放狀況').IsNull then
       EditMDisstatus.Text:=''
  else
     EditMDisstatus.text:=Frm000.SQLQueryWedding.fieldbyName('發放狀況').value;

  FrmF04.EditEID.enabled:=False;
  FrmF04.EditEName.enabled:=False;
  FrmF04.EditMarriage.enabled:=False;
  FrmF04.EditMApplyDate.enabled:=False;
  FrmF04.EditMApprovalstatus.enabled:=False;
  FrmF04.EditMDisstatus.enabled:=False;

  FrmF04.Shape1.Visible:=true;
  FrmF04.Shape2.Visible:=true;
  FrmF04.Label2.Visible:=true;
  FrmF04.Label3.Visible:=true;
  FrmF04.Label4.Visible:=true;
  FrmF04.Label5.Visible:=true;
  FrmF04.Label7.Visible:=true;
  FrmF04.Label8.Visible:=true;
  FrmF04.Label9.Visible:=true;

  Label16.Caption := EditAID.Text;
  FrmF04.Label16.Visible:=true;
  Label17.Caption := EditEID.Text;
  FrmF04.Label17.Visible:=true;
  Label18.Caption := EditEName.Text;
  FrmF04.Label18.Visible:=true;
  Label19.Caption := EditMarriage.Text;
  FrmF04.Label19.Visible:=true;
  Label20.Caption := EditMApplyDate.Text;
  FrmF04.Label20.Visible:=true;
end;

procedure TFrmF04.DBGrid1CellClick(Column: TColumn);
begin


end;

procedure TFrmF04.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
  FrmF04:=nil;
end;

procedure TFrmF04.FormCreate(Sender: TObject);
begin

end;

procedure TFrmF04.Shape2ChangeBounds(Sender: TObject);
begin

end;

end.

