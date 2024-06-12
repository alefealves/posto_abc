unit View.Combustivel.Cadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Cadastrar, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.NumberBox;

type
  TViewCombustivelCadastrar = class(TViewHerancaCadastrar)
    edtID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtDescricao: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtValor: TNumberBox;
    edtImposto: TNumberBox;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    procedure CarregarCombustivel;
    function ValidarDados : Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewCombustivelCadastrar: TViewCombustivelCadastrar;

implementation

{$R *.dfm}

uses
  Combustivel,
  Controller.Combustivel,
  Utils;

procedure TViewCombustivelCadastrar.FormShow(Sender: TObject);
begin
  inherited;

  if (IdRegistroAlterar > 0) then
    Self.CarregarCombustivel;

  edtDescricao.SetFocus;
end;

procedure TViewCombustivelCadastrar.CarregarCombustivel;
var
  ControllerCombustivel: TControllerCombustivel;
  Combustivel: TCombustivel;
begin

  ControllerCombustivel := TControllerCombustivel.Create;
  Combustivel := TCombustivel.Create;
  try

    ControllerCombustivel.CarregarCombustivel(Combustivel, inherited IdRegistroAlterar);
    edtID.Text := IntToStr(Combustivel.Id);
    edtDescricao.Text := Combustivel.Descricao;
    edtValor.ValueCurrency := Combustivel.Valor;
    edtImposto.ValueCurrency := Combustivel.Imposto;
  finally
    FreeAndNil(Combustivel);
    FreeAndNil(ControllerCombustivel);
  end;
end;

procedure TViewCombustivelCadastrar.btnGravarClick(Sender: TObject);
var
  ControllerCombustivel: TControllerCombustivel;
  Combustivel: TCombustivel;
  sErro: string;
  sMsg: PWideChar;
begin

  if not (ValidarDados) then
    Exit;

  if(Application.MessageBox('Deseja realmente salvar esse registro?', 'Confirmação',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES)
  then
    Exit;

  ControllerCombustivel := TControllerCombustivel.Create;
  Combustivel := TCombustivel.Create;
  if (IdRegistroAlterar = 0) then
    sMsg := 'Registro salvo com sucesso'
  else
    sMsg := 'Registro alterado com sucesso';

  try

    Combustivel.Id := IdRegistroAlterar;
    Combustivel.Descricao := edtDescricao.Text;
    Combustivel.Valor := edtValor.ValueCurrency;
    Combustivel.Imposto := edtImposto.ValueCurrency;

    if not ControllerCombustivel.Salvar(Combustivel,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox(sMsg, 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(Combustivel);
    FreeAndNil(ControllerCombustivel);
  end;

  inherited;
end;

function TViewCombustivelCadastrar.ValidarDados: Boolean;
begin

  try
    Result := False;

    if (Trim(edtDescricao.Text) = '') then
    begin

      Application.MessageBox('Favor, informe a descrição do combustivel.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtDescricao.SetFocus;
      Exit;
    end;

    if (edtValor.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o valor do combustivel.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtValor.SetFocus;
      Exit;
    end;

    if (edtImposto.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o imposto do combustivel.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtImposto.SetFocus;
      Exit;
    end;

    Result := True;
  except on E: Exception do
    begin
      Result := False;
      Exception.Create(e.Message);
    end;
  end;
end;

end.
