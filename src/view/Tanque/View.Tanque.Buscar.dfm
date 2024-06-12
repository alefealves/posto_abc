inherited ViewTanqueBuscar: TViewTanqueBuscar
  Caption = 'Buscar Tanque'
  ClientWidth = 748
  ExplicitWidth = 760
  ExplicitHeight = 548
  TextHeight = 15
  inherited pnTop: TPanel
    Width = 748
    ExplicitWidth = 742
    DesignSize = (
      744
      55)
  end
  inherited pnGrid: TPanel
    Width = 748
    inherited DBGrid1: TDBGrid
      Width = 748
      Height = 383
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
          FieldName = 'COMBUSTIVEL'
          Visible = True
        end>
    end
  end
  inherited pnBottom: TPanel
    Width = 748
    inherited rdGroupFiltros: TRadioGroup
      Width = 382
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'C'#243'digo (F1)'
        'Descri'#231#227'o (F2)')
    end
    inherited btnCadastrar: TBitBtn
      Left = 383
    end
    inherited btnUtilizar: TBitBtn
      Left = 565
    end
    inherited btnFechar: TBitBtn
      Left = 656
    end
    inherited btnAlterar: TBitBtn
      Left = 474
    end
  end
  inherited pnTotal: TPanel
    Width = 748
    inherited lbTotal: TLabel
      Left = 589
      Height = 18
      ExplicitLeft = 589
    end
  end
  inherited DataSource1: TDataSource
    DataSet = QListarTanques
  end
  object QListarTanques: TFDQuery
    Connection = ViewPrincipal.ConnectionPosto
    SQL.Strings = (
      'select'
      't.id,'
      't.descricao,'
      'c.descricao combustivel'
      'from tanque t'
      'inner join combustivel c'
      'on t.id_combustivel = c.id')
    Left = 64
    Top = 224
    object QListarTanquesID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QListarTanquesDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
    end
    object QListarTanquesCOMBUSTIVEL: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Combustivel'
      FieldName = 'COMBUSTIVEL'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
