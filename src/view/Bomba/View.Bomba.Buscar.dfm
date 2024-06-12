inherited ViewBombaBuscar: TViewBombaBuscar
  Caption = 'Buscar Bomba'
  ClientHeight = 555
  ClientWidth = 754
  ExplicitWidth = 766
  ExplicitHeight = 593
  TextHeight = 15
  inherited pnTop: TPanel
    Width = 754
    ExplicitWidth = 748
    DesignSize = (
      750
      55)
    inherited edtBuscar: TEdit
      ExplicitWidth = 574
    end
  end
  inherited pnGrid: TPanel
    Width = 754
    Height = 428
    inherited DBGrid1: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TANQUE'
          Visible = True
        end>
    end
  end
  inherited pnBottom: TPanel
    Top = 505
    Width = 754
    inherited rdGroupFiltros: TRadioGroup
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'C'#243'digo (F1)'
        'Descri'#231#227'o (F2)')
    end
  end
  inherited pnTotal: TPanel
    Top = 485
    Width = 754
    inherited lbTotal: TLabel
      Height = 18
    end
  end
  inherited DataSource1: TDataSource
    DataSet = QListarBombas
  end
  object QListarBombas: TFDQuery
    Connection = ViewPrincipal.ConnectionPosto
    SQL.Strings = (
      'select'
      'b.id,'
      'b.descricao,'
      't.descricao tanque'
      'from bomba b'
      'inner join tanque t'
      'on b.id_tanque = t.id')
    Left = 64
    Top = 232
    object QListarBombasID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QListarBombasDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
    end
    object QListarBombasTANQUE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Tanque'
      FieldName = 'TANQUE'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
