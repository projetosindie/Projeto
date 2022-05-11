unit Painel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdComponent, IdBaseComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Classes,
  IdAntiFreezeBase, IdAntiFreeze, Vcl.Buttons, Vcl.Menus, System.IOUtils;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    GroupBox1: TGroupBox;
    EdtURL: TLabeledEdit;
    ProgressBar1: TProgressBar;
    btnDownload: TButton;
    SpeedButton1: TSpeedButton;
    MainMenu1: TMainMenu;
    HistricodeDownload1: TMenuItem;
    procedure btnDownloadClick(Sender: TObject);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HistricodeDownload1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;
  RetornaPorcentagem: TRetornaPorcentagem;
  maxSize: Int64;
  StartDownloadDate: TDateTime;
  dlgSave: TSaveDialog;
implementation
{$R *.dfm}

uses DModulo, HistoricoDownload;



procedure TForm1.btnDownloadClick(Sender: TObject);
var
fileDownload : TFileStream;
begin

  try
  if(btnDownload.Tag = 0)then
  begin
    StartDownloadDate := Now;
    btnDownload.Caption := 'Parar Download';
    btnDownload.Tag := 1;
    dlgSave:= TSaveDialog.Create(nil);
    dlgSave.Filter := ExtractFileExt(edtUrl.Text)+'|*' + ExtractFileExt(edtUrl.Text);
    dlgSave.FileName := TPath.GetFileName(edtUrl.Text);
    if dlgSave.Execute then
    begin
      fileDownload := TFileStream.Create(dlgSave.FileName, fmCreate);
      try
        ProgressBar1.Visible := True;
        IdHTTP1.Get(edtUrl.Text, fileDownload);
      finally
        FreeAndNil(fileDownload);
      end;
    end;
  end;

  if(btnDownload.Tag = 1)then
  begin
    IdHTTP1.Disconnect;
    btnDownload.Tag := 0;
    btnDownload.Caption := 'Iniciar Download';
  end;
  Except
    Application.MessageBox(Pchar('Não foi possivel efetuar o download'),'Erro', MB_OK + MB_ICONExclamation);
    btnDownload.Caption := 'Iniciar Download';
    btnDownload.Tag := 0;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if(IdHTTP1.Connected)then
  begin
    if(Application.MessageBox(Pchar('Existe um download em andamento, deseja interrompe-lo?'),
                                    'Info', MB_YESNO + MB_ICONQUESTION) = mrYes)then
    begin
      IdHTTP1.Disconnect;
      btnDownload.Tag := 2;
      Application.Terminate;
    end;
  end;
end;

procedure TForm1.HistricodeDownload1Click(Sender: TObject);
begin
  try
    FrmHistoricoDownload := TFrmHistoricoDownload.Create(nil);
    FrmHistoricoDownload.FDQuery.Active := true;
    FrmHistoricoDownload.ShowModal;
  finally

  end;
end;

procedure TForm1.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  ProgressBar1.Position := StrToInt(RetornaPorcentagem.RetornaPorcentagem(maxSize, AWorkCount));
end;

procedure TForm1.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
   maxSize := AWorkCountMax;
end;

procedure TForm1.IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  dir: TFileName;
begin

  if(btnDownload.Tag = 1)then
  begin
    Database.InsertTable('LogDownload', 'Codigo, Url, DataInicio, DataFim', IntToStr(Database.GeraCodigo) +','+
                          QuotedStr(EdtURL.Text)+','+QuotedStr(FormatDateTime('YYYY-mm-dd',StartDownloadDate))+','+
                          QuotedStr(FormatDateTime('YYYY-mm-dd',now)));
    Application.MessageBox(Pchar('Download finalizado com sucesso!'), 'Info', MB_OK + MB_ICONINFORMATION);
  end;

  if(btnDownload.Tag = 0)then
  begin
    Application.MessageBox(Pchar('Download foi cancelado!'), 'Info', MB_OK + MB_ICONINFORMATION);
  end;

  IdHTTP1.Disconnect;
  progressbar1.Position := 0;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Application.MessageBox(Pchar('Download esta em '+ProgressBar1.Position.ToString()+'%'), 'Info', MB_OK + MB_ICONQUESTION)
end;

end.
