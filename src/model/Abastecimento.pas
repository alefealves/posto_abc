unit Abastecimento;

interface

type
  TAbastecimento = class

  private

    FId: Integer;
    FId_Bomba: Integer;
    FValor: Currency;
    FLitros: Currency;
    FImposto: Currency;
    FData: TDateTime;

    procedure SetId(const Value: Integer);
    procedure SetId_Bomba(const Value: Integer);
    procedure SetValor(const Value: Currency);
    procedure SetLitros(const Value: Currency);
    procedure SetImposto(const Value: Currency);
    procedure SetData(const Value: TDateTime);

  public

    property Id: Integer read FId write SetId;
    property Id_Bomba: Integer read FId_Bomba write FId_Bomba;
    property Valor: Currency read FValor write FValor;
    property Litros: Currency read FLitros write FLitros;
    property Imposto: Currency read FImposto write FImposto;
    property Data: TDateTime read FData write FData;

  end;

implementation

{ TAbastecimento }

procedure TAbastecimento.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TAbastecimento.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TAbastecimento.SetId_Bomba(const Value: Integer);
begin
  FId_Bomba := Value;
end;

procedure TAbastecimento.SetImposto(const Value: Currency);
begin
  FImposto := Value;
end;

procedure TAbastecimento.SetLitros(const Value: Currency);
begin
  FLitros := Value;
end;

procedure TAbastecimento.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
