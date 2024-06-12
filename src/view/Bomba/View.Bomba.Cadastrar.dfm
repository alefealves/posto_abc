inherited ViewBombaCadastrar: TViewBombaCadastrar
  Caption = 'Cadastrar Bomba'
  OnShow = FormShow
  ExplicitWidth = 794
  ExplicitHeight = 391
  TextHeight = 15
  inherited pnDados: TPanel
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
      Width = 61
      Height = 15
      Caption = 'Tanque (F8)'
    end
    object edtTanque: TEdit
      Left = 256
      Top = 40
      Width = 120
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Left = 90
      Top = 40
      Width = 120
      Height = 23
      TabOrder = 1
    end
    object edtID: TEdit
      Left = 24
      Top = 40
      Width = 60
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object edtID_Tanque: TNumberBox
      Left = 216
      Top = 40
      Width = 40
      Height = 23
      TabOrder = 3
      OnExit = edtID_TanqueExit
      OnKeyDown = edtID_TanqueKeyDown
    end
  end
  inherited pnBottom: TPanel
    inherited btnCancelar: TBitBtn
      Left = 651
    end
    inherited btnGravar: TBitBtn
      Left = 521
    end
  end
end
