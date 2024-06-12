unit View.Tanque.Cadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Cadastrar, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.NumberBox;

type
  TViewTanqueCadastrar = class(TViewHerancaCadastrar)
    Label1: TLabel;
    edtID: TEdit;
    edtDescricao: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtCombustivel: TEdit;
    edtID_Combustivel: TNumberBox;
    procedure FormShow(Sender: TObject);
    procedure edtID_CombustivelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtID_CombustivelExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    procedure CarregarTanque;
    function ValidarDados : Boolean;
  public
    { Public declarations }
  end;

var
  ViewTanqueCadastrar: TViewTanqueCadastrar;

implementation

{$R *.dfm}

{ TViewTanqueCadastrar }

uses
  Tanque,
  Controller.Tanque,
  Utils,
  Combustivel,
  View.Combustivel.Buscar;

procedure TViewTanqueCadastrar.edtID_CombustivelExit(Sender: TObject);
var
   ControllerTanque: TControllerTanque;
   Combustivel: TCombustivel;
   sErro: string;
begin
  inherited;

  edtCombustivel.Clear;
  if(Trim(edtID_Combustivel.Text).IsEmpty)then
    Exit;

  ControllerTanque := TControllerTanque.Create;
  Combustivel := TCombustivel.Create;

  try

    if not ControllerTanque.LookCombustivel(Combustivel,StrToInt(edtID_Combustivel.Text),sErro) then
      raise Exception.Create(sErro)
    else
    begin
      if(Combustivel.Id = 0)then
      begin
        edtID_Combustivel.SetFocus;
        raise Exception.Create('Combustivel não localizado');
      end;
    end;

    edtCombustivel.Text := Combustivel.Descricao;

  finally
    FreeAndNil(Combustivel);
    FreeAndNil(ControllerTanque);
  end;
end;

procedure TViewTanqueCadastrar.edtID_CombustivelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if(Key = VK_F8)then
  begin
    ViewCombustivelBuscar := TViewCombustivelBuscar.Create(nil);
    try
      if(ViewCombustivelBuscar.ShowModal = mrOk)then
        edtID_Combustivel.Value := ViewCombustivelBuscar.IdSelecionado;
    finally
      FreeAndNil(ViewCombustivelBuscar);
    end;
  end;
end;

procedure TViewTanqueCadastrar.FormShow(Sender: TObject);
begin
  inherited;
  if (IdRegistroAlterar > 0) then
    Self.CarregarTanque;

  edtDescricao.SetFocus;
end;

procedure TViewTanqueCadastrar.CarregarTanque;
var
  ControllerTanque: TControllerTanque;
  Tanque: TTanque;
begin

  ControllerTanque := TControllerTanque.Create;
  Tanque := TTanque.Create;
  try

    ControllerTanque.CarregarTanque(Tanque, inherited IdRegistroAlterar);
    edtID.Text := IntToStr(Tanque.Id);
    edtID_Combustivel.Value := Tanque.Id_Combustivel;
    edtDescricao.Text := Tanque.Descricao;
    edtID_Combustivel.SetFocus;
  finally
    FreeAndNil(Tanque);
    FreeAndNil(ControllerTanque);
  end;
end;

procedure TViewTanqueCadastrar.btnGravarClick(Sender: TObject);
var
  ControllerTanque: TControllerTanque;
  Tanque: TTanque;
  sErro: string;
  sMsg: PWideChar;
begin

  if not (ValidarDados) then
    Exit;

  if(Application.MessageBox('Deseja realmente salvar esse registro?', 'Confirmação',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES)
  then
    Exit;

  ControllerTanque := TControllerTanque.Create;
  Tanque := TTanque.Create;
  if (IdRegistroAlterar = 0) then
    sMsg := 'Registro salvo com sucesso'
  else
    sMsg := 'Registro alterado com sucesso';

  try

    Tanque.Id := IdRegistroAlterar;
    Tanque.Id_Combustivel := StrToInt(edtID_Combustivel.Text);
    Tanque.Descricao := edtDescricao.Text;

    if not ControllerTanque.Salvar(Tanque,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox(sMsg, 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(Tanque);
    FreeAndNil(ControllerTanque);
  end;

  inherited;
end;

function TViewTanqueCadastrar.ValidarDados: Boolean;
begin

  try
    Result := False;

    if (edtID_Combustivel.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o campo combustivel.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtID_Combustivel.SetFocus;
      Exit;
    end;

    if (Trim(edtDescricao.Text) = '') then
    begin

      Application.MessageBox('Favor, informe a descrição do tanque.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtDescricao.SetFocus;
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
