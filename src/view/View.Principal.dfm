object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  Caption = 'Posto ABC'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  WindowState = wsMaximized
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 320
    Top = 200
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Combustivel1: TMenuItem
        Caption = 'Combustivel'
      end
      object anque1: TMenuItem
        Caption = 'Tanque'
      end
      object Bomba1: TMenuItem
        Caption = 'Bomba'
      end
    end
    object Movimentos1: TMenuItem
      Caption = 'Movimentos'
      object Abastecimento1: TMenuItem
        Caption = 'Abastecimento'
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Relatriosporbomba1: TMenuItem
        Caption = 'Relat'#243'rios por bomba'
      end
    end
  end
end
