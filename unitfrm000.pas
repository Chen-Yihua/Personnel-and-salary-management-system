unit unitfrm000;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, MSSQLConn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  Menus, StdCtrls, ExtCtrls;

type

  { TFrm000 }

  TFrm000 = class(TForm)
    DataSourceAttendence: TDataSource;
    DataSourceAttendence1: TDataSource;
    DataSourceEmployee1: TDataSource;
    DataSourceWork: TDataSource;
    DataSourcePerformance1: TDataSource;
    DataSourcePerformance2: TDataSource;
    DataSourceSalary1: TDataSource;
    DataSourceScript: TDataSource;
    DataSourcePerformance: TDataSource;
    DataSourceEmployee: TDataSource;
    DataSourceSalary: TDataSource;
    DataSourceBirthday: TDataSource;
    DataSourceScript1: TDataSource;
    DataSourceNotPass: TDataSource;
    DataSourcePass: TDataSource;
    DataSourceWedding: TDataSource;
    DataSourceChild: TDataSource;
    DataSourceSkipWork: TDataSource;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    A: TMenuItem;
    A01: TMenuItem;
    A02: TMenuItem;
    B: TMenuItem;
    B02: TMenuItem;
    B01: TMenuItem;
    C01: TMenuItem;
    C: TMenuItem;
    C02: TMenuItem;
    C03: TMenuItem;
    C04: TMenuItem;
    D: TMenuItem;
    D01: TMenuItem;
    D02: TMenuItem;
    E: TMenuItem;
    E01: TMenuItem;
    E02: TMenuItem;
    F: TMenuItem;
    F01: TMenuItem;
    F02: TMenuItem;
    F04: TMenuItem;
    F05: TMenuItem;
    F07: TMenuItem;
    F08: TMenuItem;
    C05: TMenuItem;
    F03: TMenuItem;
    F06: TMenuItem;
    MSSQLConnectionAttendence1: TMSSQLConnection;
    MSSQLConnectionWork: TMSSQLConnection;
    MSSQLConnectionBirthday1: TMSSQLConnection;
    MSSQLConnectionChild1: TMSSQLConnection;
    MSSQLConnectionEmployee1: TMSSQLConnection;
    MSSQLConnectionPerformance: TMSSQLConnection;
    MSSQLConnectionPerformance1: TMSSQLConnection;
    MSSQLConnectionPerformance2: TMSSQLConnection;
    MSSQLConnectionSalary: TMSSQLConnection;
    MSSQLConnectionBirthday: TMSSQLConnection;
    MSSQLConnectionSalary1: TMSSQLConnection;
    MSSQLConnectionChild: TMSSQLConnection;
    MSSQLConnectionSQLScript: TMSSQLConnection;
    MSSQLConnectionAttendence: TMSSQLConnection;
    MSSQLConnectionEmployee: TMSSQLConnection;
    MSSQLConnectionSQLScript1: TMSSQLConnection;
    MSSQLConnectionNotPass: TMSSQLConnection;
    MSSQLConnectionPass: TMSSQLConnection;
    MSSQLConnectionWedding: TMSSQLConnection;
    MSSQLConnectionWedding1: TMSSQLConnection;
    MSSQLConnectionSkipWork: TMSSQLConnection;
    Panel1: TPanel;
    SQLQueryAttendence1: TSQLQuery;
    SQLQueryWork: TSQLQuery;
    SQLQueryBirthday1: TSQLQuery;
    SQLQueryChild1: TSQLQuery;
    SQLQueryEmployee1: TSQLQuery;
    SQLQueryPerformance: TSQLQuery;
    SQLQueryPerformance1: TSQLQuery;
    SQLQueryPerformance2: TSQLQuery;
    SQLQuerySalary: TSQLQuery;
    SQLQueryBirthday: TSQLQuery;
    SQLQuerySalary1: TSQLQuery;
    SQLQueryChild: TSQLQuery;
    SQLQueryScript: TSQLQuery;
    SQLQueryAttendence: TSQLQuery;
    SQLQueryEmployee: TSQLQuery;
    SQLQueryScript1: TSQLQuery;
    SQLQueryNotPass: TSQLQuery;
    SQLQueryPass: TSQLQuery;
    SQLQueryWedding: TSQLQuery;
    SQLQueryWedding1: TSQLQuery;
    SQLQuerySkipWork: TSQLQuery;
    SQLTransactionAttendence1: TSQLTransaction;
    SQLTransactionWork: TSQLTransaction;
    SQLTransactionBirthday1: TSQLTransaction;
    SQLTransactionChild1: TSQLTransaction;
    SQLTransactionEmployee1: TSQLTransaction;
    SQLTransactionPerformance: TSQLTransaction;
    SQLTransactionPerformance1: TSQLTransaction;
    SQLTransactionPerformance2: TSQLTransaction;
    SQLTransactionSalary: TSQLTransaction;
    SQLTransactionBirthday: TSQLTransaction;
    SQLTransactionSalary1: TSQLTransaction;
    SQLTransactionChild: TSQLTransaction;
    SQLTransactionSQLScript: TSQLTransaction;
    SQLTransactionAttendence: TSQLTransaction;
    SQLTransactionEmployee: TSQLTransaction;
    SQLTransactionSQLScript1: TSQLTransaction;
    SQLTransactionNotPass: TSQLTransaction;
    SQLTransactionPass: TSQLTransaction;
    SQLTransactionWedding: TSQLTransaction;
    SQLTransactionWedding1: TSQLTransaction;
    SQLTransactionSkipWork: TSQLTransaction;
    procedure A01Click(Sender: TObject);
    procedure A02Click(Sender: TObject);
    procedure AClick(Sender: TObject);
    procedure B01Click(Sender: TObject);
    procedure B02Click(Sender: TObject);
    procedure C01Click(Sender: TObject);
    procedure C02Click(Sender: TObject);
    procedure C03Click(Sender: TObject);
    procedure C04Click(Sender: TObject);
    procedure C05Click(Sender: TObject);
    procedure D01Click(Sender: TObject);
    procedure D02Click(Sender: TObject);
    procedure E01Click(Sender: TObject);
    procedure E02Click(Sender: TObject);
    procedure F01Click(Sender: TObject);
    procedure F02Click(Sender: TObject);
    procedure F03Click(Sender: TObject);
    procedure F04Click(Sender: TObject);
    procedure F05Click(Sender: TObject);
    procedure F06Click(Sender: TObject);
    procedure F07Click(Sender: TObject);
    procedure F08Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MSSQLConnectionEmployeeAfterConnect(Sender: TObject);
    procedure MSSQLConnectionSalaryAfterConnect(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public

  end;

var
  Frm000: TFrm000;

implementation
uses unitFrmA01, unitFrmB01, unitFrmB02, unitFrmC01, unitFrmC02, unitFrmC03, unitFrmC04, unitFrmC05,
  unitFrmD01, unitFrmD02, unitFrmE01, unitFrmE02, unitFrmF01, unitFrmF02, unitFrmF03, unitFrmF04,
  unitFrmF05, unitFrmF06, unitFrmF07, unitFrmF08;
{$R *.lfm}

{ TFrm000 }

procedure TFrm000.MSSQLConnectionEmployeeAfterConnect(Sender: TObject);
begin

end;

procedure TFrm000.MSSQLConnectionSalaryAfterConnect(Sender: TObject);
begin

end;

procedure TFrm000.Panel1Click(Sender: TObject);
begin

end;

procedure TFrm000.AClick(Sender: TObject);
begin

end;

procedure TFrm000.A01Click(Sender: TObject);
begin
  if not Assigned(FrmA01) then
     FrmA01:= TFrmA01.Create(Frm000);
   FrmA01.show;

   Frm000.Panel1.visible:=false;
end;

procedure TFrm000.A02Click(Sender: TObject);
begin
  close;
end;

procedure TFrm000.B01Click(Sender: TObject);
begin
  if not Assigned(FrmB01) then
     FrmB01:= TFrmB01.Create(Frm000);
   FrmB01.show;
   Frm000.Panel1.visible:=false;
end;

procedure TFrm000.B02Click(Sender: TObject);
begin
  if not Assigned(FrmB02) then
     FrmB02:= TFrmB02.Create(Frm000);
   FrmB02.show;
   Frm000.Panel1.visible:=false;
end;

procedure TFrm000.C01Click(Sender: TObject);
begin
  if not Assigned(FrmC01) then
     FrmC01:= TFrmC01.Create(Frm000);
   FrmC01.show;
   Frm000.Panel1.visible:=false;
end;

procedure TFrm000.C02Click(Sender: TObject);
begin
  if not Assigned(FrmC02) then
     FrmC02 := TFrmC02.Create(Frm000);
  FrmC02.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.C03Click(Sender: TObject);
begin
  if not Assigned(FrmC03) then
     FrmC03 := TFrmC03.Create(Frm000);
  FrmC03.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.C04Click(Sender: TObject);
begin
  if not Assigned(FrmC04) then
     FrmC04 := TFrmC04.Create(Frm000);
  FrmC04.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.C05Click(Sender: TObject);
begin
  if not Assigned(FrmC05) then
     FrmC05 := TFrmC05.Create(Frm000);
  FrmC05.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.D01Click(Sender: TObject);
begin
  if not Assigned(FrmD01) then
     FrmD01 := TFrmD01.Create(Frm000);
  FrmD01.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.D02Click(Sender: TObject);
begin
  if not Assigned(FrmD02) then
     FrmD02 := TFrmD02.Create(Frm000);
  FrmD02.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.E01Click(Sender: TObject);
begin
  if not Assigned(FrmE01) then
     FrmE01 := TFrmE01.Create(Frm000);
  FrmE01.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.E02Click(Sender: TObject);
begin
  if not Assigned(FrmE02) then
     FrmE02 := TFrmE02.Create(Frm000);
  FrmE02.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F01Click(Sender: TObject);
begin
  if not Assigned(FrmF01) then
     FrmF01 := TFrmF01.Create(Frm000);
  FrmF01.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F02Click(Sender: TObject);
begin
  if not Assigned(FrmF02) then
     FrmF02 := TFrmF02.Create(Frm000);
  FrmF02.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F03Click(Sender: TObject);
begin
  if not Assigned(FrmF03) then
     FrmF03 := TFrmF03.Create(Frm000);
  FrmF03.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F04Click(Sender: TObject);
begin
  if not Assigned(FrmF04) then
     FrmF04 := TFrmF04.Create(Frm000);
     FrmF04.Shape1.Visible:=false;
     FrmF04.Shape2.Visible:=false;
     FrmF04.Label2.Visible:=false;
     FrmF04.Label3.Visible:=false;
     FrmF04.Label4.Visible:=false;
     FrmF04.Label5.Visible:=false;
     FrmF04.Label7.Visible:=false;
     FrmF04.Label8.Visible:=false;
     FrmF04.Label9.Visible:=false;
     FrmF04.Label16.Visible:=false;
     FrmF04.Label17.Visible:=false;
     FrmF04.Label18.Visible:=false;
     FrmF04.Label19.Visible:=false;
     FrmF04.Label20.Visible:=false;
  FrmF04.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F05Click(Sender: TObject);
begin
  if not Assigned(FrmF05) then
     FrmF05 := TFrmF05.Create(Frm000);
  FrmF05.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F06Click(Sender: TObject);
begin
  if not Assigned(FrmF06) then
     FrmF06 := TFrmF06.Create(Frm000);
  FrmF06.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F07Click(Sender: TObject);
begin
  if not Assigned(FrmF07) then
     FrmF07 := TFrmF07.Create(Frm000);
     FrmF07.Shape1.Visible:=false;
     FrmF07.Shape2.Visible:=false;
     FrmF07.Label9.Visible:=false;
     FrmF07.Label10.Visible:=false;
     FrmF07.Label11.Visible:=false;
     FrmF07.Label12.Visible:=false;
     FrmF07.Label13.Visible:=false;
     FrmF07.Label14.Visible:=false;
     FrmF07.Label15.Visible:=false;
     FrmF07.Label16.Visible:=false;
     FrmF07.Label17.Visible:=false;
     FrmF07.Label18.Visible:=false;
     FrmF07.Label19.Visible:=false;
     FrmF07.Label20.Visible:=false;
  FrmF07.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.F08Click(Sender: TObject);
begin
  if not Assigned(FrmF08) then
     FrmF08 := TFrmF08.Create(Frm000);
  FrmF08.show;
  Frm000.Panel1.visible:=false;
end;

procedure TFrm000.FormCreate(Sender: TObject);
begin

end;

end.

