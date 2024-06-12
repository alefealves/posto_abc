unit DAO.Combustivel;

interface

uses
  System.SysUtils,
  Firedac.Comp.Client,
  View.Principal,
  Combustivel,
  Utils;

type
  TDAOCombustivel = class
  private
    { private declarations }
  public
    function ListarCombustiveis(const LCampo: string; const LStrBuscar: string): TFDQuery;
    procedure CarregarCombustivel(oCombustivel: TCombustivel; AIdCombustivel: integer);
    function Salvar(oCombustivel: TCombustivel; out sErro: string): Boolean;
    function Excluir(AIdCombustivel: Integer; out sErro: string): Boolean;
    function LookCombustivel(oCombustivel: TCombustivel; AIdCombustivel: Integer; out sErro: string): Boolean;
  end;

implementation

{ TDAOCombustivel }

procedure TDAOCombustivel.CarregarCombustivel(oCombustivel: TCombustivel; AIdCombustivel: integer);
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('SELECT * FROM COMBUSTIVEL ');
    qry.SQL.Add('WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := AIdCombustivel;

    qry.Open();

    if not (qry.IsEmpty)then
    begin
      oCombustivel.Id := qry.FieldByName('ID').AsInteger;
      oCombustivel.Descricao := qry.FieldByName('DESCRICAO').AsString;
      oCombustivel.Valor := qry.FieldByName('VALOR').AsCurrency;
      oCombustivel.Imposto := qry.FieldByName('IMPOSTO').AsCurrency;
    end;

  finally
    TUtils.DestroyQuery(qry);
  end;
end;

function TDAOCombustivel.Excluir(AIdCombustivel: Integer; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('DELETE FROM COMBUSTIVEL ');
    qry.SQL.Add('WHERE ID = :ID');

    qry.ParamByName('ID').AsInteger := AIdCombustivel;

    qry.ExecSQL();

    TUtils.DestroyQuery(qry);
    Result := True;
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao excluir o combustivel: ' + sLineBreak + E.Message;
    end;
  end;
end;

function TDAOCombustivel.Salvar(oCombustivel: TCombustivel; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    TUtils.CreateQuery(qry);

    if (oCombustivel.Id = 0) then
    begin
      qry.SQL.Add('INSERT INTO COMBUSTIVEL ');
      qry.SQL.Add('(DESCRICAO ');
      qry.SQL.Add(',VALOR ');
      qry.SQL.Add(',IMPOSTO) ');
      qry.SQL.Add('VALUES(:DESCRICAO ');
      qry.SQL.Add(',:VALOR ');
      qry.SQL.Add(',:IMPOSTO)');

      qry.ParamByName('DESCRICAO').AsString := oCombustivel.Descricao;
      qry.ParamByName('VALOR').AsCurrency := oCombustivel.Valor;
      qry.ParamByName('IMPOSTO').AsCurrency := oCombustivel.Imposto;
    end
    else
    begin
      qry.SQL.Add('UPDATE COMBUSTIVEL ');
      qry.SQL.Add('SET DESCRICAO = :DESCRICAO ');
      qry.SQL.Add(',VALOR = :VALOR ');
      qry.SQL.Add(',IMPOSTO = :IMPOSTO ');
      qry.SQL.Add('WHERE ID = :ID');

      qry.ParamByName('DESCRICAO').AsString := oCombustivel.Descricao;
      qry.ParamByName('VALOR').AsCurrency := oCombustivel.Valor;
      qry.ParamByName('IMPOSTO').AsCurrency := oCombustivel.Imposto;

      qry.ParamByName('ID').AsInteger := oCombustivel.Id;
    end;

    qry.ExecSQL();
    Result := True;
    TUtils.DestroyQuery(qry);
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao salvar o combustivel: ' + sLineBreak + E.Message;
    end;
  end;
end;

function TDAOCombustivel.ListarCombustiveis(const LCampo, LStrBuscar: string): TFDQuery;
var
  termoBusca, Condicao: string;
  qry: TFDQuery;
begin

  try

    TUtils.CreateQuery(qry);
    qry.SQL.Add('SELECT * FROM COMBUSTIVEL ');
    termoBusca := QuotedStr('%'+ LStrBuscar +'%').ToLower;

    if(LCampo = 'ID')then
       Condicao := 'where ( id like ' + termoBusca + ' )'
    else
       Condicao := 'where ( lower(descricao) like ' + termoBusca + ' )';

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

function TDAOCombustivel.LookCombustivel(oCombustivel: TCombustivel; AIdCombustivel: Integer; out sErro: string): Boolean;
var
  qry: TFDQuery;
begin

  try
    TUtils.CreateQuery(qry);

    qry.SQL.Add('SELECT * FROM COMBUSTIVEL ');
    qry.SQL.Add('WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := AIdCombustivel;

    qry.Open();

    if not (qry.IsEmpty)then
    begin
      oCombustivel.Id := qry.FieldByName('ID').AsInteger;
      oCombustivel.Descricao := qry.FieldByName('DESCRICAO').AsString;
      oCombustivel.Valor := qry.FieldByName('VALOR').AsCurrency;
      oCombustivel.Imposto := qry.FieldByName('IMPOSTO').AsCurrency;
    end
    else
      oCombustivel.Id := 0;

    TUtils.DestroyQuery(qry);
    Result := true;
  except on E: Exception do
    begin
      TUtils.DestroyQuery(qry);
      Result := False;
      sErro := 'Ocorreu um erro ao buscar o combustivel: ' + sLineBreak + E.Message;
    end;
  end;
end;

end.
