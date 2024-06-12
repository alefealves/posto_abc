unit Bomba;

interface

type
  TBomba = class

  private

    FId: Integer;
    FId_Tanque: Integer;
    FDescricao: string;

    procedure SetId(const Value: Integer);
    procedure SetId_Tanque(const Value: Integer);
    procedure SetDescricao(const Value: String);

  public

    property Id: Integer read FId write SetId;
    property Id_Tanque: Integer read FId_Tanque write FId_Tanque;
    property Descricao: String read FDescricao write SetDescricao;

  end;

implementation

{ TBomba }

procedure TBomba.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TBomba.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TBomba.SetId_Tanque(const Value: Integer);
begin
  FId_Tanque := Value;
end;

end.
