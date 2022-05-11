object FrmHistoricoDownload: TFrmHistoricoDownload
  Left = 0
  Top = 0
  Caption = 'Historico Download'
  ClientHeight = 375
  ClientWidth = 1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 1072
    Height = 375
    Align = alClient
    DataSource = DataSource
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Url'
        ReadOnly = True
        Width = 609
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataInicio'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataFim'
        ReadOnly = True
        Visible = True
      end>
  end
  object FDQuery: TFDQuery
    Connection = DataModule1.Connection
    SQL.Strings = (
      'SELECT Codigo, Url, DataInicio, DataFim'
      'FROM LogDownload'
      'order by codigo desc')
    Left = 280
    Top = 120
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 280
    Top = 184
  end
end
