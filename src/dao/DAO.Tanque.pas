unit DAO.Tanque;

interface

uses
  System.SysUtils,
  Firedac.Comp.Client,
  View.Principal,
  Tanque,
  Utils;

type
  TDAOTanque = class
  private
    { private declarations }
  public
    function ListarTanques(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarTanque(oTanque: TTanque; AIdTanque: integer);
    function Salvar(oTanque: TTanque; out sErro: string): Boolean;
    function Excluir(AIdTanque: Integer; out sErro: string): Boolean;
    function LookTanque(oTanque: TTanque; AIdTanque: Integer; out sErro: string): Boolean;
  end;

implementation

{ TDAOTanque }

procedure TDAOTanque.CarregarTanque(oTanque: TTanque; AIdTanque: integer);
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('SELECT * FROM TANQUE ');
    qry.SQL.Add('WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := AIdTanque;

    qry.Open();

    if not (qry.IsEmpty)then
    begin
      oTanque.Id := qry.FieldByName('ID').AsInteger;
      oTanque.Id_Combustivel := qry.FieldByName('ID_COMBUSTIVEL').AsInteger;
      oTanque.Descricao := qry.FieldByName('DESCRICAO').AsString;
    end;

  finally
    TUtils.DestroyQuery(qry);
  end;
end;

function TDAOTanque.Excluir(AIdTanque: Integer; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('DELETE FROM TANQUE ');
    qry.SQL.Add('WHERE ID = :ID');

    qry.ParamByName('ID').AsInteger := AIdTanque;

    qry.ExecSQL();

    TUtils.DestroyQuery(qry);
    Result := True;
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao excluir o tanque: ' + sLineBreak + E.Message;
    end;
  end;
end;

function TDAOTanque.Salvar(oTanque: TTanque; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    if (oTanque.Id = 0) then
    begin
      qry.SQL.Add('INSERT INTO TANQUE ');
      qry.SQL.Add('(ID_COMBUSTIVEL ');
      qry.SQL.Add(',DESCRICAO) ');
      qry.SQL.Add('VALUES(:ID_COMBUSTIVEL ');
      qry.SQL.Add(',:DESCRICAO)');

      qry.ParamByName('ID_COMBUSTIVEL').AsInteger := oTanque.Id_Combustivel;
      qry.ParamByName('DESCRICAO').AsString := oTanque.Descricao;
    end
    else
    begin
      qry.SQL.Add('UPDATE TANQUE ');
      qry.SQL.Add('SET ID_COMBUSTIVEL = :ID_COMBUSTIVEL ');
      qry.SQL.Add(',DESCRICAO = :DESCRICAO ');
      qry.SQL.Add('WHERE ID = :ID');

      qry.ParamByName('ID_COMBUSTIVEL').AsInteger := oTanque.Id_Combustivel;
      qry.ParamByName('DESCRICAO').AsString := oTanque.Descricao;

      qry.ParamByName('ID').AsInteger := oTanque.Id;
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

function TDAOTanque.ListarTanques(const LCampo, LStrBuscar: string): TFDQuery;
var
  termoBusca, Condicao: string;
  qry: TFDQuery;
begin

  try

    TUtils.CreateQuery(qry);
    qry.SQL.Add('select ');
    qry.SQL.Add('t.id, ');
    qry.SQL.Add('t.descricao, ');
    qry.SQL.Add('c.descricao combustivel ');
    qry.SQL.Add('from tanque t ');
    qry.SQL.Add('inner join combustivel c ');
    qry.SQL.Add('on t.id_combustivel = c.id ');

    termoBusca := QuotedStr('%'+ LStrBuscar +'%').ToLower;

    if(LCampo = 'ID')then
       Condicao := 'where ( t.id like ' + termoBusca + ' )'
    else
       Condicao := 'where ( lower(t.descricao) like ' + termoBusca + ' )';

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

function TDAOTanque.LookTanque(oTanque: TTanque; AIdTanque: Integer; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('SELECT * FROM TANQUE ');
    qry.SQL.Add('WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := AIdTanque;

    qry.Open();

    if not (qry.IsEmpty)then
    begin
      oTanque.Id := qry.FieldByName('ID').AsInteger;
      oTanque.Id_Combustivel := qry.FieldByName('ID_COMBUSTIVEL').AsInteger;
      oTanque.Descricao := qry.FieldByName('DESCRICAO').AsString;
    end
    else
      oTanque.Id := 0;

    TUtils.DestroyQuery(qry);
    Result := true;
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao buscar o tanque: ' + sLineBreak + E.Message;
    end;
  end;
end;

end.
