unit DModulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.Windows;

type
  TDataModule1 = class(TDataModule)
    Connection: TFDConnection;
    Query: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Type
  Database = class

    private

    public

    class procedure connectDatabaseSQLIte(dir: string);
    class procedure CreateTable(table: string; fields: string);
    class procedure InsertTable(table: string; fields: string; values: string);

    class function GeraCodigo():integer;
  end;

var
  DataModule1: TDataModule1;
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDatabase }

class procedure Database.connectDatabaseSQLIte(dir: string);
begin
  DataModule1.Connection.Params.Database := dir;
  DataModule1.Connection.DriverName := 'SQLite';
  DataModule1.Connection.Params.DriverID := DataModule1.Connection.DriverName;
  DataModule1.Connection.Connected := true;

  CreateTable('LogDownload','Codigo number(22) not null, Url varchar(600) not null, DataInicio DateTime not null, DataFim DateTime not null')
end;

class procedure Database.CreateTable(table, fields: string);
var
  query: TFDQuery;
begin
   try
     try
       query:= TFDQuery.Create(nil);
       query.Connection := DataModule1.Connection;

       query.Close;
       query.SQL.Text := 'Create Table if not exists '+table+
                         '('+fields+')';
       query.Execute();
     except
       Application.MessageBox(Pchar('Não foi possivel se criar a tabela '+table),'Erro', MB_OK + MB_ICONExclamation);
       FreeAndNil(query);
     end;
   finally
     FreeAndNil(query);
   end;

end;

class function Database.GeraCodigo: integer;
var
  query: TFDQuery;
  codigo: integer;
begin
//
  try
    query := TFDQuery.Create(nil);
    query.Connection := DataModule1.Connection;
    query.Close;
    query.SQL.Text := 'select codigo from LogDownload order by codigo desc';
    query.Open();

    codigo := query.FieldByName('codigo').AsInteger + 1;

  finally
    FreeAndNil(query);
    result := codigo;
  end;

end;

class procedure Database.InsertTable(table, fields, values: string);
var
  query: TFDQuery;
begin
   try
     try
       query:= TFDQuery.Create(nil);
       query.Connection := DataModule1.Connection;

       query.Close;
       query.SQL.Text := 'insert into '+table+
                         '('+fields+')values('+values+')';
       query.Execute();
     except
       Application.MessageBox(Pchar('Não foi possivel se criar a o log de download'),'Erro', MB_OK + MB_ICONExclamation);
       FreeAndNil(query);
     end;
   finally
     FreeAndNil(query);
   end;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
   try
    Database.connectDatabaseSQLIte('database.db');
   except
    Application.MessageBox(Pchar('Não foi possivel se conectar no banco de dados!'), 'Erro', MB_OK + MB_ICONExclamation);
   end;
end;

end.
