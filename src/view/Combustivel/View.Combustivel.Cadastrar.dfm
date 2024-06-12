inherited ViewCombustivelCadastrar: TViewCombustivelCadastrar
  Caption = 'Cadastrar Combustivel'
  ClientHeight = 322
  ClientWidth = 563
  OnShow = FormShow
  ExplicitWidth = 575
  ExplicitHeight = 360
  TextHeight = 15
  inherited pnDados: TPanel
    Width = 563
    Height = 281
    ExplicitWidth = 557
    ExplicitHeight = 272
    object Label1: TLabel
      Left = 24
      Top = 25
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 90
      Top = 25
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 24
      Top = 81
      Width = 42
      Height = 15
      Caption = 'Valor R$'
    end
    object Label4: TLabel
      Left = 90
      Top = 81
      Width = 57
      Height = 15
      Caption = 'Imposto %'
    end
    object edtID: TEdit
      Left = 24
      Top = 40
      Width = 60
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object edtDescricao: TEdit
      Left = 90
      Top = 40
      Width = 120
      Height = 23
      TabOrder = 0
    end
    object edtValor: TNumberBox
      Left = 24
      Top = 96
      Width = 60
      Height = 23
      DisplayFormat = ',,0.00'
      Mode = nbmCurrency
      TabOrder = 1
    end
    object edtImposto: TNumberBox
      Left = 90
      Top = 96
      Width = 60
      Height = 23
      DisplayFormat = ',,0.00'
      Mode = nbmCurrency
      TabOrder = 2
    end
  end
  inherited pnBottom: TPanel
    Top = 281
    Width = 563
    ExplicitTop = 272
    ExplicitWidth = 557
    inherited btnCancelar: TBitBtn
      Left = 432
      ExplicitLeft = 426
    end
    inherited btnGravar: TBitBtn
      Left = 302
      ExplicitLeft = 296
    end
  end
end
