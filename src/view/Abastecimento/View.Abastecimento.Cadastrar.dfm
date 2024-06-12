inherited ViewAbastecimentoCadastrar: TViewAbastecimentoCadastrar
  Caption = 'Cadastrar Abastecimento'
  OnShow = FormShow
  TextHeight = 15
  inherited pnDados: TPanel
    object Label1: TLabel
      Left = 24
      Top = 25
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label3: TLabel
      Left = 104
      Top = 25
      Width = 61
      Height = 15
      Caption = 'Bomba (F8)'
    end
    object Label2: TLabel
      Left = 24
      Top = 170
      Width = 90
      Height = 15
      Caption = 'Valor por Litro R$'
    end
    object Label4: TLabel
      Left = 24
      Top = 73
      Width = 29
      Height = 15
      Caption = 'Litros'
    end
    object Label5: TLabel
      Left = 24
      Top = 214
      Width = 57
      Height = 15
      Caption = 'Imposto %'
    end
    object Label6: TLabel
      Left = 24
      Top = 257
      Width = 24
      Height = 15
      Caption = 'Data'
    end
    object Label7: TLabel
      Left = 262
      Top = 25
      Width = 67
      Height = 15
      Caption = 'Combustivel'
    end
    object Label8: TLabel
      Left = 382
      Top = 25
      Width = 38
      Height = 15
      Caption = 'Tanque'
    end
    object Label9: TLabel
      Left = 24
      Top = 118
      Width = 109
      Height = 15
      Caption = 'Valor Abastecimento'
    end
    object Label10: TLabel
      Left = 110
      Top = 214
      Width = 60
      Height = 15
      Caption = 'Imposto R$'
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
    object edtID_Bomba: TNumberBox
      Left = 104
      Top = 40
      Width = 40
      Height = 23
      TabOrder = 0
      OnExit = edtID_BombaExit
      OnKeyDown = edtID_BombaKeyDown
    end
    object edtBomba: TEdit
      Left = 142
      Top = 40
      Width = 120
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object edtValorLitro: TNumberBox
      Left = 24
      Top = 185
      Width = 80
      Height = 23
      TabStop = False
      Color = clBtnFace
      DisplayFormat = ',,0.00'
      Mode = nbmCurrency
      ReadOnly = True
      TabOrder = 2
    end
    object edtLitros: TNumberBox
      Left = 24
      Top = 88
      Width = 80
      Height = 23
      DisplayFormat = ',,0.00'
      Mode = nbmCurrency
      TabOrder = 1
      OnExit = edtLitrosExit
    end
    object edtImpostoPerc: TNumberBox
      Left = 24
      Top = 229
      Width = 80
      Height = 23
      TabStop = False
      Color = clBtnFace
      DisplayFormat = ',,0.00'
      Mode = nbmCurrency
      ReadOnly = True
      TabOrder = 5
    end
    object edtData: TEdit
      Left = 24
      Top = 274
      Width = 120
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object edtCombustivel: TEdit
      Left = 262
      Top = 40
      Width = 120
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object edtTanque: TEdit
      Left = 382
      Top = 40
      Width = 120
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object edtValor: TNumberBox
      Left = 24
      Top = 133
      Width = 80
      Height = 23
      Color = clBtnFace
      DisplayFormat = ',,0.00'
      Mode = nbmCurrency
      ReadOnly = True
      TabOrder = 9
      OnExit = edtLitrosExit
    end
    object edtImpostoValor: TNumberBox
      Left = 110
      Top = 229
      Width = 80
      Height = 23
      TabStop = False
      Color = clBtnFace
      DisplayFormat = ',,0.00'
      Mode = nbmCurrency
      ReadOnly = True
      TabOrder = 10
    end
  end
end
