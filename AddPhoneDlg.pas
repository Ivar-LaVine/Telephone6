unit AddPhoneDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    IBQuery1: TIBQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Main;

procedure TForm3.Button1Click(Sender: TObject);
var i : integer;
begin
  i := 0;
  with Form1 do
  begin
    if IBTransaction2.Active = false then IBTransaction2.StartTransaction;
    try
      begin
        with IBQuery1 do
        begin
          DataBase := IBDataBase1;
          SQL.Clear;
          if Form1.Flag = 1 then
          begin
            SQL.Add('SELECT MAX(SUB_ID) FROM SUBSCRIBER');
            Open;
            i := Fields[0].AsInteger;
            SQL.Clear;
            SQL.Add('INSERT INTO PHONE(SUB_ID, PHONE) VALUES (' + inttostr(i) + ', :phone)');
          end else
          begin
            i := Form1.IBDataSet1.FieldByName('P_ID').AsInteger;
            SQL.Add('UPDATE PHONE SET PHONE = :phone WHERE P_ID = ' + inttostr(i));
          end;
          ParamByName('phone').AsString := Edit1.Text;
          Open;
        end;
        ShowMessage('Okay');
        Edit1.Text := '';
        IBTransaction2.Commit;
      end;
    except
      IBTransaction2.Rollback;
    end;
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form1.IBDataSet1.Close;
  Form1.IBDataSet1.Open;
  Form1.IBDataSet2.Close;
  Form1.IBDataSet2.Open;
  Form1.DataSource1.Enabled := false;
  Form1.DataSource1.Enabled := true;
  Form1.DataSource2.Enabled := false;
  Form1.DataSource2.Enabled := true;
  Close;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  if Form1.Flag = 1 then Button1.Caption := '????????'
  else
  begin
     Button1.Caption := '????????';
     Edit1.Text := Form1.IBDataSet1.FieldByName('PHONE').AsString;
  end;
end;

end.
