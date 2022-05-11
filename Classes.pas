unit Classes;

interface

uses
   Vcl.Dialogs, System.SysUtils;

  type
    TRetornaKiloBytes = class
      public
      function RetornaKiloBytes(ValorAtual: real): string;
  end;

  type
  TRetornaPorcentagem = class
    public
    function RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
  end;

implementation

{ THttp }


{ TRetornaKiloBytes }

function TRetornaKiloBytes.RetornaKiloBytes(ValorAtual: real): string;
var
resultado : real;
begin
  resultado := ((ValorAtual / 1024) / 1024);
  Result    := FormatFloat('0.000 KBs', resultado);
end;

{ TRetornaPorcentagem }

function TRetornaPorcentagem.RetornaPorcentagem(ValorMaximo,
  ValorAtual: real): string;
var
resultado: Real;
begin
  resultado := ((ValorAtual * 100) / ValorMaximo);
  Result    := FormatFloat('0', resultado); //FormatFloat('0%', resultado);
end;


end.
