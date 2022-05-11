object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 450
  Width = 641
  object Connection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=C:\Users\DJhow\Documents\Embarcadero\Studio\Projects\[S' +
        'oftplan] Desafio T'#233'cnico\Win32\Debug\Database.db')
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object Query: TFDQuery
    Connection = Connection
    Left = 56
    Top = 88
  end
end
