inherited ViewTanqueCadastrar: TViewTanqueCadastrar
  Caption = 'Cadastrar Tanque'
  ClientWidth = 788
  OnShow = FormShow
  TextHeight = 15
  inherited pnDados: TPanel
    Width = 788
    ExplicitTop = -5
    ExplicitWidth = 788
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
      Left = 216
      Top = 25
      Width = 90
      Height = 15
      Caption = 'Combustivel (F8)'
    end
    object edtDescricao: TEdit
      Left = 90
      Top = 40
      Width = 120
      Height = 23
      TabOrder = 0
    end
    object edtID: TEdit
      Left = 24
      Top = 40
      Width = 60
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object edtCombustivel: TEdit
      Left = 256
      Top = 40
      Width = 120
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object edtID_Combustivel: TNumberBox
      Left = 216
      Top = 40
      Width = 40
      Height = 23
      TabOrder = 3
      OnExit = edtID_CombustivelExit
      OnKeyDown = edtID_CombustivelKeyDown
    end
  end
  inherited pnBottom: TPanel
    Width = 788
  end
end
