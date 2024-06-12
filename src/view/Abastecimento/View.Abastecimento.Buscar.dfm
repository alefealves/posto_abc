inherited ViewAbastecimentoBuscar: TViewAbastecimentoBuscar
  Caption = 'Buscar Abastecimento'
  ExplicitWidth = 736
  ExplicitHeight = 548
  TextHeight = 15
  inherited pnGrid: TPanel
    inherited DBGrid1: TDBGrid
      Width = 724
      Height = 383
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BOMBA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LITROS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMPOSTO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Visible = True
        end>
    end
  end
  inherited pnBottom: TPanel
    inherited rdGroupFiltros: TRadioGroup
      Width = 358
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'C'#243'digo (F1)'
        'Bomba (F2)')
      ExplicitWidth = 352
    end
    inherited btnCadastrar: TBitBtn
      Left = 359
      ExplicitLeft = 353
    end
    inherited btnUtilizar: TBitBtn
      Left = 541
      ExplicitLeft = 535
    end
    inherited btnFechar: TBitBtn
      Left = 632
      ExplicitLeft = 626
    end
    inherited btnAlterar: TBitBtn
      Left = 450
      ExplicitLeft = 444
    end
  end
  inherited pnTotal: TPanel
    inherited lbTotal: TLabel
      Left = 565
      Height = 18
      ExplicitLeft = 565
    end
  end
  inherited DataSource1: TDataSource
    DataSet = QListarAbastecimentos
  end
  object QListarAbastecimentos: TFDQuery
    Connection = ViewPrincipal.ConnectionPosto
    SQL.Strings = (
      'select'
      'a.id,'
      'b.descricao bomba,'
      'a.valor,'
      'a.litros,'
      'a.imposto,'
      'a.data'
      'from abastecimento a'
      'inner join bomba b'
      'on a.id_bomba = b.id')
    Left = 64
    Top = 232
    object QListarAbastecimentosID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QListarAbastecimentosBOMBA: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Bomba'
      FieldName = 'BOMBA'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
    end
    object QListarAbastecimentosVALOR: TFMTBCDField
      DisplayLabel = 'Valor R$'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QListarAbastecimentosLITROS: TFMTBCDField
      DisplayLabel = 'Litros'
      FieldName = 'LITROS'
      Origin = 'LITROS'
      Required = True
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QListarAbastecimentosIMPOSTO: TFMTBCDField
      DisplayLabel = 'Imposto R$'
      FieldName = 'IMPOSTO'
      Origin = 'IMPOSTO'
      Required = True
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QListarAbastecimentosDATA: TSQLTimeStampField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Origin = '"DATA"'
      Required = True
    end
  end
end
