program DesafioTecnico;

uses
  Vcl.Forms,
  Painel in 'Painel.pas' {Form1},
  Classes in 'Classes.pas',
  DModulo in 'DModulo.pas' {DataModule1: TDataModule},
  HistoricoDownload in 'HistoricoDownload.pas' {FrmHistoricoDownload},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Lavender Classico');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
