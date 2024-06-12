unit Utils;

interface

uses
  System.SysUtils,
  System.IniFiles,
  Forms,
  Windows,
  FireDAC.Comp.Client,
  View.Principal;

type
  TUtils = class
  private
  public
    class procedure CreateQuery(var Query: TFDQuery);
    class procedure DestroyQuery(var Query: TFDQuery);
    class procedure Mensagem(Mensagem: String);
    class function StringInCurrency(Txt: String): Currency;
    class procedure SetConnection(var Connection: TFDConnection; out bancoConectado: String);
    class function CheckFileDatabase: Boolean;
    class function CheckConfig: Boolean;
    class function ReadConfig(key: String): String;
    class procedure GravarConfig(key, value: string);
  end;

implementation

{ TUtils }

class procedure TUtils.CreateQuery(var Query: TFDQuery);
begin
  try
    Query := TFDQuery.Create(ViewPrincipal);
    Query.Connection := ViewPrincipal.ConnectionPosto;
    Query.Close;
    Query.SQL.Clear;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TUtils.DestroyQuery(var Query: TFDQuery);
begin
  try
    Query.Close;
    Query.Free;
    Query := nil;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TUtils.Mensagem(Mensagem: String);
begin
  try
    Application.MessageBox(PWideChar(Mensagem),'Posto ABC',MB_OK + MB_ICONINFORMATION);
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class function TUtils.StringInCurrency(Txt: String): Currency;
begin
  try
    Txt := StringReplace(Trim(Txt),'.','',[rfReplaceAll, rfIgnoreCase]);
    Result := StrToCurr(Txt);
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TUtils.SetConnection(var Connection: TFDConnection; out bancoConectado: String);
begin

  try
    if not(CheckFileDatabase) then
    begin
      raise Exception.Create('Coloque o arquivo de banco de dados junto ao executável do sistema.');
    end;

    if not(CheckConfig) then
    begin
      GravarConfig('Banco','');
      GravarConfig('Usuario','');
      GravarConfig('Senha','');
      raise Exception.Create('O arquivo de configuração não foi encontrado, o sistema criara um novo arquivo, configure com as informações necessárias.');
    end;

    bancoConectado := ChangeFileExt(ExtractFileName(ReadConfig('Banco')), '');
    Connection.Params.Values['Database'] := (ExtractFileDir(Application.ExeName) + '\' + ReadConfig('Banco'));
    Connection.Params.Values['User_Name'] := ReadConfig('Usuario');
    Connection.Params.Values['Password'] := ReadConfig('Senha');
    Connection.Connected := True;
  except on E: Exception do
    raise Exception.Create('Não foi possível estabelecer a conexão com o banco de dados.'+#13+
                           'Verifique o arquivo de configurações o Config.ini que se encontra junto do executável.');
  end;
end;

class function TUtils.CheckConfig: Boolean;
begin
  try
    Result := (FileExists(ExtractFileDir(Application.ExeName) + '\Config.ini'));
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class function TUtils.CheckFileDatabase: Boolean;
begin
  try
    Result := (FileExists(ExtractFileDir(Application.ExeName) + '\BASE.FDB'));
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class function TUtils.ReadConfig(key: String): String;
var
  fileConfig: TIniFile;
begin

  try
    fileConfig := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\Config.ini');
    Result := fileConfig.ReadString('Configuracoes', key, '');
    fileConfig.Free;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TUtils.GravarConfig(key, value: string);
var
  fileConfig: TIniFile;
begin

  try
    fileConfig := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\Config.ini');
    fileConfig.WriteString('Configuracoes', key, value);
    fileConfig.Free;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
