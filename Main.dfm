object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 184
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 24
    Top = 24
    Width = 337
    Height = 113
    DataSource = DataSource2
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'SURNAME'
        Title.Alignment = taCenter
        Title.Caption = #1060#1072#1084#1080#1083#1080#1103
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1103
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PATRONYMIC'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        Width = 100
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 367
    Top = 24
    Width = 186
    Height = 113
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid2DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 100
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 24
    Top = 143
    Width = 75
    Height = 25
    Caption = 'Add new'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 105
    Top = 143
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = Button2Click
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = '192.168.0.3:D:\DB\TELEPHONE_PIA3.fdb'
    Params.Strings = (
      'user_name=student'
      'password=edu-759'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    Left = 24
    Top = 24
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Left = 56
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = IBDataSet1
    Left = 528
    Top = 56
  end
  object IBDataSet1: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    SelectSQL.Strings = (
      'select * from phone where sub_id = :sub_id')
    Active = True
    DataSource = DataSource2
    Left = 528
    Top = 24
  end
  object IBDataSet2: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    SelectSQL.Strings = (
      'select * from subscriber')
    Active = True
    Left = 328
    Top = 24
  end
  object DataSource2: TDataSource
    DataSet = IBDataSet2
    Left = 328
    Top = 56
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 56
    Top = 56
  end
  object IBQuery1: TIBQuery
    Left = 88
    Top = 24
  end
end
