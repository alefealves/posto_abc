inherited ViewCombustivelBuscar: TViewCombustivelBuscar
  Caption = 'Buscar Combustivel'
  ClientWidth = 748
  ExplicitWidth = 760
  TextHeight = 15
  inherited pnTop: TPanel
    Width = 748
    ExplicitWidth = 742
    inherited edtBuscar: TEdit
      ExplicitWidth = 574
    end
  end
  inherited pnGrid: TPanel
    Width = 748
    ExplicitWidth = 742
    ExplicitHeight = 383
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
          FieldName = 'VALOR'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMPOSTO'
          Visible = True
        end>
    end
  end
  inherited pnBottom: TPanel
    Width = 748
    ExplicitTop = 460
    ExplicitWidth = 742
    inherited rdGroupFiltros: TRadioGroup
      Width = 382
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'C'#243'digo (F1)'
        'Descricao (F2)')
      ExplicitWidth = 376
    end
    inherited btnCadastrar: TBitBtn
      Left = 383
      ExplicitLeft = 377
    end
    inherited btnUtilizar: TBitBtn
      Left = 565
      ExplicitLeft = 559
    end
    inherited btnFechar: TBitBtn
      Left = 656
      ExplicitLeft = 650
    end
    inherited btnAlterar: TBitBtn
      Left = 474
      ExplicitLeft = 468
    end
  end
  inherited pnTotal: TPanel
    Width = 748
    ExplicitTop = 440
    ExplicitWidth = 742
    inherited lbTotal: TLabel
      Left = 589
      Height = 18
      ExplicitLeft = 589
    end
  end
  inherited DataSource1: TDataSource
    DataSet = QListarCombustiveis
  end
  inherited PopupMenu1: TPopupMenu
    Left = 216
    Top = 145
  end
  object QListarCombustiveis: TFDQuery
    Connection = ViewPrincipal.ConnectionPosto
    SQL.Strings = (
      'select'
      '*'
      'from combustivel ')
    Left = 64
    Top = 224
    object QListarCombustiveisID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QListarCombustiveisDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
    end
    object QListarCombustiveisVALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QListarCombustiveisIMPOSTO: TFMTBCDField
      DisplayLabel = 'Imposto'
      FieldName = 'IMPOSTO'
      Origin = 'IMPOSTO'
      Required = True
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
  end
end
