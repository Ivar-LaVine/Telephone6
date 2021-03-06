unit AddSubscriberDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    IBQuery1: TIBQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Main, AddPhoneDlg;



procedure TForm2.Button1Click(Sender: TObject);
begin
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
            SQL.Add('INSERT INTO SUBSCRIBER(SURNAME, NAME, PATRONYMIC) VALUES (:surname, :name, :patronymic)');
          end else
          begin
            SQL.Add('UPDATE SUBSCRIBER SET SURNAME = :surname, NAME = :name, PATRONYMIC = :patronymic WHERE (SUB_ID = :id)');
            ParamByName('id').AsInteger := Form1.IBDataSet2.FieldByName('SUB_ID').AsInteger;
          end;
          ParamByName('surname').AsString := Edit1.Text;
          ParamByName('name').AsString := Edit2.Text;
          ParamByName('patronymic').AsString := Edit3.Text;
          Open;
        end;
        ShowMessage('Okay');
        IBTransaction2.Commit;
        if Form1.Flag = 1 then
        begin
          with TForm3.Create(nil) do
          try
            ShowModal;
          finally
            Free;
          end;
        end;
      end;
    except
      IBTransaction2.Rollback;
    end;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
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

procedure TForm2.FormShow(Sender: TObject);
begin
  if Form1.Flag = 1 then Button1.Caption := '????????'
  else
  begin
     Button1.Caption := '????????';
     Edit1.Text := Form1.IBDataSet2.FieldByName('SURNAME').AsString;
     Edit2.Text := Form1.IBDataSet2.FieldByName('NAME').AsString;
     Edit3.Text := Form1.IBDataSet2.FieldByName('PATRONYMIC').AsString;
  end;
end;

end.
