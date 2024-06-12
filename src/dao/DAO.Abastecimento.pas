unit DAO.Abastecimento;

interface

uses
  System.SysUtils,
  Firedac.Comp.Client,
  View.Principal,
  Abastecimento,
  Utils;

type
  TDAOAbastecimento = class
  private
    { private declarations }
  public
    function ListarAbastecimentos(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarAbastecimento(oAbastecimento: TAbastecimento; AIdAbastecimento: integer);
    function Salvar(oAbastecimento: TAbastecimento; out sErro: string): Boolean;
    function Excluir(AIdAbastecimento: Integer; out sErro: string): Boolean;
  end;

implementation

{ TDAOAbastecimento }

procedure TDAOAbastecimento.CarregarAbastecimento(oAbastecimento: TAbastecimento; AIdAbastecimento: integer);
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('SELECT * FROM ABASTECIMENTO ');
    qry.SQL.Add('WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := AIdAbastecimento;

    qry.Open();

    if not (qry.IsEmpty)then
    begin
      oAbastecimento.Id := qry.FieldByName('ID').AsInteger;
      oAbastecimento.Id_Bomba:= qry.FieldByName('ID_BOMBA').AsInteger;
      oAbastecimento.Valor := qry.FieldByName('VALOR').AsCurrency;
      oAbastecimento.Litros := qry.FieldByName('LITROS').AsCurrency;
      oAbastecimento.Imposto := qry.FieldByName('IMPOSTO').AsCurrency;
      oAbastecimento.Data := qry.FieldByName('DATA').AsDateTime;
    end;

  finally
    TUtils.DestroyQuery(qry);
  end;
end;

function TDAOAbastecimento.Excluir(AIdAbastecimento: Integer; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('DELETE FROM ABASTECIMENTO ');
    qry.SQL.Add('WHERE ID = :ID');

    qry.ParamByName('ID').AsInteger := AIdAbastecimento;

    qry.ExecSQL();

    TUtils.DestroyQuery(qry);
    Result := True;
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao excluir o abastecimento: ' + sLineBreak + E.Message;
    end;
  end;
end;

function TDAOAbastecimento.Salvar(oAbastecimento: TAbastecimento; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    if (oAbastecimento.Id = 0) then
    begin
      qry.SQL.Add('INSERT INTO ABASTECIMENTO ');
      qry.SQL.Add('(ID_BOMBA ');
      qry.SQL.Add(',VALOR ');
      qry.SQL.Add(',LITROS ');
      qry.SQL.Add(',IMPOSTO)');
      qry.SQL.Add('VALUES(:ID_BOMBA ');
      qry.SQL.Add(',:VALOR ');
      qry.SQL.Add(',:LITROS ');
      qry.SQL.Add(',:IMPOSTO)');

      qry.ParamByName('ID_BOMBA').AsInteger := oAbastecimento.Id_Bomba;
      qry.ParamByName('VALOR').AsCurrency := oAbastecimento.Valor;
      qry.ParamByName('LITROS').AsCurrency := oAbastecimento.Litros;
      qry.ParamByName('IMPOSTO').AsCurrency := oAbastecimento.Imposto;
    end
    else
    begin
      qry.SQL.Add('UPDATE ABASTECIMENTO ');
      qry.SQL.Add('SET ID_BOMBA = :ID_BOMBA ');
      qry.SQL.Add(',VALOR = :VALOR ');
      qry.SQL.Add(',LITROS = :LITROS ');
      qry.SQL.Add(',IMPOSTO = :IMPOSTO ');
      qry.SQL.Add('WHERE ID = :ID');

      qry.ParamByName('ID_BOMBA').AsInteger := oAbastecimento.Id_Bomba;
      qry.ParamByName('VALOR').AsCurrency := oAbastecimento.Valor;
      qry.ParamByName('LITROS').AsCurrency := oAbastecimento.Litros;
      qry.ParamByName('IMPOSTO').AsCurrency := oAbastecimento.Imposto;

      qry.ParamByName('ID').AsInteger := oAbastecimento.Id;
    end;

    qry.ExecSQL();
    Result := True;
    TUtils.DestroyQuery(qry);
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao salvar o abastecimento: ' + sLineBreak + E.Message;
    end;
  end;
end;

function TDAOAbastecimento.ListarAbastecimentos(const LCampo, LStrBuscar: string): TFDQuery;
var
  termoBusca, Condicao: string;
  qry: TFDQuery;
begin

  try

    TUtils.CreateQuery(qry);
    qry.SQL.Add('select ');
    qry.SQL.Add('a.id, ');
    qry.SQL.Add('b.descricao bomba, ');
    qry.SQL.Add('a.valor, ');
    qry.SQL.Add('a.litros, ');
    qry.SQL.Add('a.imposto, ');
    qry.SQL.Add('a.data ');
    qry.SQL.Add('from abastecimento a ');
    qry.SQL.Add('inner join bomba b ');
    qry.SQL.Add('on a.id_bomba = b.id ');

    termoBusca := QuotedStr('%'+ LStrBuscar +'%').ToLower;

    if(LCampo = 'ID')then
       Condicao := 'where ( a.id like ' + termoBusca + ' )'
    else
       Condicao := 'where ( lower(b.descricao) like ' + termoBusca + ' )';

    qry.SQL.Add(Condicao);
    qry.SQL.Add('order by a.id');
    result := qry;
    TUtils.DestroyQuery(qry);
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := nil;
      Exception.Create(e.Message);
    end;
  end;
end;

end.
