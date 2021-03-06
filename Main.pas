unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, IBCustomDataSet, IBTable, IBDatabase, IniFiles,
  StdCtrls, IBQuery;

type
  TForm1 = class(TForm)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    IBDataSet1: TIBDataSet;
    IBDataSet2: TIBDataSet;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    IBTransaction2: TIBTransaction;
    Button1: TButton;
    Button2: TButton;
    IBQuery1: TIBQuery;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Flag : Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses AddSubscriberDlg, AddPhoneDlg;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Flag := 1;
  with TForm2.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if IBTransaction2.Active = false then IBTransaction2.StartTransaction;
  try
    begin
      with IBQuery1 do
      begin
        DataBase := IBDataBase1;
        SQL.Clear;
        SQL.Add('DELETE FROM PHONE WHERE SUB_ID = :id');
        ParamByName('id').AsInteger := Form1.IBDataSet2.FieldByName('SUB_ID').AsInteger;
        Open;
        SQL.Clear;
        SQL.Add('DELETE FROM SUBSCRIBER WHERE SUB_ID = :id');
        ParamByName('id').AsInteger := Form1.IBDataSet2.FieldByName('SUB_ID').AsInteger;
        Open;
      end;
      ShowMessage('Okay');
      IBTransaction2.Commit;
    end;
  except
    IBTransaction2.Rollback;
  end;
  Form1.IBDataSet1.Close;
  Form1.IBDataSet1.Open;
  Form1.IBDataSet2.Close;
  Form1.IBDataSet2.Open;
  Form1.DataSource1.Enabled := false;
  Form1.DataSource1.Enabled := true;
  Form1.DataSource2.Enabled := false;
  Form1.DataSource2.Enabled := true;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  // selected row index
  Flag := 2;
  with TForm2.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TForm1.DBGrid2DblClick(Sender: TObject);
begin
  Flag := 2;
  with TForm3.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TForm1.FormShow(Sender: TObject);
var F: TIniFile;
    Charset, UserName, Password: String;
begin
// ?????? ???????? ?????????? ?? ini-?????
   try
      F:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Telephone.ini');
      IBDataBase1.DatabaseName:=F.ReadString('Settings', 'Database', '');
      IBDataBase1.SQLDialect:=F.ReadInteger('Settings', 'SQLDialect', 3);
      Charset:=F.ReadString('Settings', 'Charset', 'WIN1251');
      UserName:=F.ReadString('Settings', 'UserName', 'student');
      Password:=F.ReadString('Settings', 'Password', 'edu-759');
      IBDataBase1.Params.Clear;
      IBDataBase1.Params.Add('user_name='+UserName);
      IBDataBase1.Params.Add('password='+Password);
      IBDataBase1.Params.Add('lc_ctype='+Charset);
   finally
      F.Free;
   end;
// ??????? ???????? ???? ??????
   try                                         
      IBDataBase1.Open;
   except
// ???? ?????? ??????? Firebird
//      if not() then
//      begin
//         UserName:='';
//         Password:='';
//      end;
      try
         IBDataBase1.Params.Clear;
         IBDataBase1.Params.Add('user_name='+UserName);
         IBDataBase1.Params.Add('password='+Password);
         IBDataBase1.Params.Add('lc_ctype='+Charset);
// ???????? ????? ????? ?????? ?????????????         
         IBDataBase1.Open;
      except
         MessageDlg('?????? ???????? ?????? ??????? ???? ?????? ??? ??????????? '+
          '??????????? ????????? ? ini-?????.', mtWarning, [mbOK], 0);
      end;
   end;
   if not(IBDatabase1.Connected) then Form1.Close;
end;

end.
