unit DAO.Bomba;

interface

uses
  System.SysUtils,
  Firedac.Comp.Client,
  View.Principal,
  Bomba,
  BombaConfig,
  Utils;

type
  TDAOBomba = class
  private
    { private declarations }
  public
    function ListarBombas(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarBomba(oBomba: TBomba; AIdBomba: integer);
    function Salvar(oBomba: TBomba; out sErro: string): Boolean;
    function Excluir(AIdBomba: Integer; out sErro: string): Boolean;
    function LookBomba(oBombaConfig: TBombaConfig; AIdBomba: Integer; out sErro: string): Boolean;
  end;

implementation

{ TDAOBomba }

procedure TDAOBomba.CarregarBomba(oBomba: TBomba; AIdBomba: integer);
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('SELECT * FROM BOMBA ');
    qry.SQL.Add('WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := AIdBomba;

    qry.Open();

    if not (qry.IsEmpty)then
    begin
      oBomba.Id := qry.FieldByName('ID').AsInteger;
      oBomba.Id_Tanque := qry.FieldByName('ID_TANQUE').AsInteger;
      oBomba.Descricao := qry.FieldByName('DESCRICAO').AsString;
    end;

  finally
    TUtils.DestroyQuery(qry);
  end;
end;

function TDAOBomba.Excluir(AIdBomba: Integer; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('DELETE FROM BOMBA ');
    qry.SQL.Add('WHERE ID = :ID');

    qry.ParamByName('ID').AsInteger := AIdBomba;

    qry.ExecSQL();

    TUtils.DestroyQuery(qry);
    Result := True;
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao excluir a bomba: ' + sLineBreak + E.Message;
    end;
  end;
end;

function TDAOBomba.Salvar(oBomba: TBomba; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    if (oBomba.Id = 0) then
    begin
      qry.SQL.Add('INSERT INTO BOMBA ');
      qry.SQL.Add('(ID_TANQUE ');
      qry.SQL.Add(',DESCRICAO) ');
      qry.SQL.Add('VALUES(:ID_TANQUE ');
      qry.SQL.Add(',:DESCRICAO)');

      qry.ParamByName('ID_TANQUE').AsInteger := oBomba.Id_Tanque;
      qry.ParamByName('DESCRICAO').AsString := oBomba.Descricao;
    end
    else
    begin
      qry.SQL.Add('UPDATE BOMBA ');
      qry.SQL.Add('SET ID_TANQUE = :ID_TANQUE ');
      qry.SQL.Add(',DESCRICAO = :DESCRICAO ');
      qry.SQL.Add('WHERE ID = :ID');

      qry.ParamByName('ID_TANQUE').AsInteger := oBomba.Id_Tanque;
      qry.ParamByName('DESCRICAO').AsString := oBomba.Descricao;

      qry.ParamByName('ID').AsInteger := oBomba.Id;
    end;

    qry.ExecSQL();
    Result := True;
    TUtils.DestroyQuery(qry);
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao salvar o tanque: ' + sLineBreak + E.Message;
    end;
  end;
end;

function TDAOBomba.ListarBombas(const LCampo, LStrBuscar: string): TFDQuery;
var
  termoBusca, Condicao: string;
  qry: TFDQuery;
begin

  try

    TUtils.CreateQuery(qry);
    qry.SQL.Add('select ');
    qry.SQL.Add('b.id, ');
    qry.SQL.Add('b.descricao, ');
    qry.SQL.Add('t.descricao tanque ');
    qry.SQL.Add('from bomba b ');
    qry.SQL.Add('inner join tanque t ');
    qry.SQL.Add('on b.id_tanque = t.id ');

    termoBusca := QuotedStr('%'+ LStrBuscar +'%').ToLower;

    if(LCampo = 'ID')then
       Condicao := 'where ( b.id like ' + termoBusca + ' )'
    else
       Condicao := 'where ( lower(b.descricao) like ' + termoBusca + ' )';

    qry.SQL.Add(Condicao);
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

function TDAOBomba.LookBomba(oBombaConfig: TBombaConfig; AIdBomba: Integer; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('select ');
    qry.SQL.Add('b.id, ');
    qry.SQL.Add('b.descricao, ');
    qry.SQL.Add('t.descricao tanque, ');
    qry.SQL.Add('c.descricao combustivel, ');
    qry.SQL.Add('c.valor, ');
    qry.SQL.Add('c.imposto ');
    qry.SQL.Add('from bomba b ');
    qry.SQL.Add('inner join tanque t ');
    qry.SQL.Add('on b.id_tanque = t.id ');
    qry.SQL.Add('inner join combustivel c ');
    qry.SQL.Add('on t.id_combustivel = c.id ');
    qry.SQL.Add('where b.id = :ID');

    qry.ParamByName('ID').AsInteger := AIdBomba;
    qry.Open();

    if not (qry.IsEmpty)then
    begin
      oBombaConfig.Id := qry.FieldByName('ID').AsInteger;
      oBombaConfig.Descricao := qry.FieldByName('DESCRICAO').AsString;
      oBombaConfig.Tanque := qry.FieldByName('TANQUE').AsString;
      oBombaConfig.Combustivel := qry.FieldByName('COMBUSTIVEL').AsString;
      oBombaConfig.Valor := qry.FieldByName('VALOR').AsCurrency;
      oBombaConfig.Imposto := qry.FieldByName('IMPOSTO').AsCurrency;
    end
    else
      oBombaConfig.Id := 0;

    TUtils.DestroyQuery(qry);
    Result := true;
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao buscar a bomba: ' + sLineBreak + E.Message;
    end;
  end;
end;

end.
