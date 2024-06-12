unit View.Abastecimento.Cadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Cadastrar, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.NumberBox;

type
  TViewAbastecimentoCadastrar = class(TViewHerancaCadastrar)
    edtID: TEdit;
    Label1: TLabel;
    edtID_Bomba: TNumberBox;
    Label3: TLabel;
    edtBomba: TEdit;
    edtValorLitro: TNumberBox;
    Label2: TLabel;
    Label4: TLabel;
    edtLitros: TNumberBox;
    Label5: TLabel;
    edtImpostoPerc: TNumberBox;
    edtData: TEdit;
    Label6: TLabel;
    edtCombustivel: TEdit;
    edtTanque: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtValor: TNumberBox;
    Label9: TLabel;
    Label10: TLabel;
    edtImpostoValor: TNumberBox;
    procedure FormShow(Sender: TObject);
    procedure edtID_BombaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtID_BombaExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtLitrosExit(Sender: TObject);
  private
    procedure CarregarAbastecimento;
    function ValidarDados : Boolean;
    procedure LimpaTela;
  public
    { Public declarations }
  end;

var
  ViewAbastecimentoCadastrar: TViewAbastecimentoCadastrar;

implementation

{$R *.dfm}

{ TViewAbastecimentoCadastrar }

uses
  Abastecimento,
  Controller.Abastecimento,
  View.Bomba.Buscar,
  Bomba,
  BombaConfig,
  Utils;

procedure TViewAbastecimentoCadastrar.edtID_BombaExit(Sender: TObject);
var
   ControllerAbastecimento: TControllerAbastecimento;
   BombaConfig: TBombaConfig;
   sErro: string;
begin
  inherited;

  edtBomba.Clear;
  if(Trim(edtID_Bomba.Text).IsEmpty)then
    Exit;

  ControllerAbastecimento := TControllerAbastecimento.Create;
  BombaConfig := TBombaConfig.Create;

  try

    if not ControllerAbastecimento.LookBomba(BombaConfig,StrToInt(edtID_Bomba.Text),sErro) then
      raise Exception.Create(sErro)
    else
    begin
      if(BombaConfig.Id = 0)then
      begin
        edtID_Bomba.SetFocus;
        raise Exception.Create('Bomba não localizada');
      end;
    end;

    edtBomba.ReadOnly := False;
    edtTanque.ReadOnly := False;
    edtCombustivel.ReadOnly := False;
    edtValor.ReadOnly := False;
    edtImpostoPerc.ReadOnly := False;

    edtBomba.Text := BombaConfig.Descricao;
    edtTanque.Text := BombaConfig.Tanque;
    edtCombustivel.Text := BombaConfig.Combustivel;
    edtValorLitro.Value := BombaConfig.Valor;
    edtImpostoPerc.Value := BombaConfig.Imposto;

    edtBomba.ReadOnly := True;
    edtTanque.ReadOnly := True;
    edtCombustivel.ReadOnly := True;
    edtValor.ReadOnly := True;
    edtImpostoPerc.ReadOnly := True;

  finally
    FreeAndNil(BombaConfig);
    FreeAndNil(ControllerAbastecimento);
  end;
end;

procedure TViewAbastecimentoCadastrar.edtID_BombaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if(Key = VK_F8)then
  begin
    ViewBombaBuscar := TViewBombaBuscar.Create(nil);
    try
      if(ViewBombaBuscar.ShowModal = mrOk)then
        edtID_Bomba.Value := ViewBombaBuscar.IdSelecionado;
    finally
      FreeAndNil(ViewBombaBuscar);
    end;
  end;;
end;

procedure TViewAbastecimentoCadastrar.edtLitrosExit(Sender: TObject);
begin

  if (edtLitros.Value <= 0) then
    Exit;

  edtValor.ReadOnly := False;
  edtValor.Value := (edtLitros.Value * edtValorLitro.Value);
  edtValor.ReadOnly := True;

  edtImpostoValor.ReadOnly := False;
  edtImpostoValor.Value := (edtValor.Value * (edtImpostoPerc.Value/100));
  edtImpostoValor.ReadOnly := True;
end;

procedure TViewAbastecimentoCadastrar.FormShow(Sender: TObject);
begin
  inherited;
  if (IdRegistroAlterar > 0) then
    Self.CarregarAbastecimento
  else
  begin
    edtData.ReadOnly := False;
    edtData.ReadOnly := True;
    edtID_Bomba.SetFocus;
  end;
end;

procedure TViewAbastecimentoCadastrar.CarregarAbastecimento;
var
  ControllerAbastecimento: TControllerAbastecimento;
  Abastecimento: TAbastecimento;
begin

  ControllerAbastecimento := TControllerAbastecimento.Create;
  Abastecimento := TAbastecimento.Create;
  try

    ControllerAbastecimento.CarregarAbastecimento(Abastecimento, inherited IdRegistroAlterar);
    edtID.Text := IntToStr(Abastecimento.Id);
    edtID_Bomba.Value := Abastecimento.Id_Bomba;
    edtLitros.ValueCurrency := Abastecimento.Litros;

    edtValor.ReadOnly := False;
    edtValor.ValueCurrency := Abastecimento.Valor;
    edtValor.ReadOnly := True;

    edtImpostoValor.ReadOnly := False;
    edtImpostoValor.ValueCurrency := Abastecimento.Imposto;
    edtImpostoValor.ReadOnly := True;

    edtData.ReadOnly := False;
    edtData.Text := DateTimeToStr(Abastecimento.Data);
    edtData.ReadOnly := True;

    edtID_Bomba.SetFocus;
    edtValor.SetFocus;
    edtID_Bomba.SetFocus;
  finally
    FreeAndNil(Abastecimento);
    FreeAndNil(ControllerAbastecimento);
  end;
end;

procedure TViewAbastecimentoCadastrar.btnGravarClick(Sender: TObject);
var
  ControllerAbastecimento: TControllerAbastecimento;
  Abastecimento: TAbastecimento;
  sErro: string;
  sMsg: PWideChar;
begin

  if not (ValidarDados) then
    Exit;

  if(Application.MessageBox('Deseja realmente salvar esse registro?', 'Confirmação',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES)
  then
    Exit;

  ControllerAbastecimento := TControllerAbastecimento.Create;
  Abastecimento := TAbastecimento.Create;
  if (IdRegistroAlterar = 0) then
    sMsg := 'Registro salvo com sucesso'
  else
    sMsg := 'Registro alterado com sucesso';

  try

    Abastecimento.Id := IdRegistroAlterar;
    Abastecimento.Id_Bomba := StrToInt(edtID_Bomba.Text);
    Abastecimento.Valor := edtValor.Value;
    Abastecimento.Litros := edtLitros.Value;
    Abastecimento.Imposto := edtImpostoValor.Value;

    if not ControllerAbastecimento.Salvar(Abastecimento,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox(sMsg, 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(Abastecimento);
    FreeAndNil(ControllerAbastecimento);
  end;

  if not (Abastecendo) then
    inherited
  else
    Self.LimpaTela;

end;

procedure TViewAbastecimentoCadastrar.LimpaTela;
begin
   edtID.Clear;
   edtID_Bomba.Clear;
   edtBomba.Clear;
   edtTanque.Clear;
   edtCombustivel.Clear;
   edtLitros.Clear;
   edtValorLitro.Clear;
   edtValor.Clear;
   edtImpostoPerc.Clear;
   edtImpostoValor.Clear;
   edtData.Clear;
   edtID_Bomba.SetFocus;
end;

function TViewAbastecimentoCadastrar.ValidarDados: Boolean;
begin

  try
    Result := False;

    if (edtID_Bomba.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o campo bomba.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtID_Bomba.SetFocus;
      Exit;
    end;

    if (edtValor.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o campo valor.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtValor.SetFocus;
      Exit;
    end;

    if (edtLitros.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o campo litros.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtLitros.SetFocus;
      Exit;
    end;

    if (edtImpostoValor.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o campo imposto.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtImpostoValor.SetFocus;
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
