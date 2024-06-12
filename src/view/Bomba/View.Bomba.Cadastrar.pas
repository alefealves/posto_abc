unit View.Bomba.Cadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Cadastrar, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.NumberBox;

type
  TViewBombaCadastrar = class(TViewHerancaCadastrar)
    Label1: TLabel;
    edtID: TEdit;
    edtDescricao: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtID_Tanque: TNumberBox;
    edtTanque: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtID_TanqueKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtID_TanqueExit(Sender: TObject);
  private
    procedure CarregarBomba;
    function ValidarDados : Boolean;
  public
    { Public declarations }
  end;

var
  ViewBombaCadastrar: TViewBombaCadastrar;

implementation

{$R *.dfm}

uses
  Bomba,
  Controller.Bomba,
  Utils,
  Tanque,
  View.Tanque.Buscar;

{ TViewBombaCadastrar }

procedure TViewBombaCadastrar.FormShow(Sender: TObject);
begin
  inherited;
  if (IdRegistroAlterar > 0) then
    Self.CarregarBomba;

  edtDescricao.SetFocus;
end;

procedure TViewBombaCadastrar.CarregarBomba;
var
  ControllerBomba: TControllerBomba;
  Bomba: TBomba;
begin

  ControllerBomba := TControllerBomba.Create;
  Bomba := TBomba.Create;
  try

    ControllerBomba.CarregarBomba(Bomba, inherited IdRegistroAlterar);
    edtID.Text := IntToStr(Bomba.Id);
    edtID_Tanque.Value := Bomba.Id_Tanque;
    edtDescricao.Text := Bomba.Descricao;
    edtID_Tanque.SetFocus;
  finally
    FreeAndNil(Bomba);
    FreeAndNil(ControllerBomba);
  end;
end;

procedure TViewBombaCadastrar.btnGravarClick(Sender: TObject);
var
  ControllerBomba: TControllerBomba;
  Bomba: TBomba;
  sErro: string;
  sMsg: PWideChar;
begin

  if not (ValidarDados) then
    Exit;

  if(Application.MessageBox('Deseja realmente salvar esse registro?', 'Confirmação',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES)
  then
    Exit;

  ControllerBomba := TControllerBomba.Create;
  Bomba := TBomba.Create;
  if (IdRegistroAlterar = 0) then
    sMsg := 'Registro salvo com sucesso'
  else
    sMsg := 'Registro alterado com sucesso';

  try

    Bomba.Id := IdRegistroAlterar;
    Bomba.Id_Tanque := StrToInt(edtID_Tanque.Text);
    Bomba.Descricao := edtDescricao.Text;

    if not ControllerBomba.Salvar(Bomba,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox(sMsg, 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(Bomba);
    FreeAndNil(ControllerBomba);
  end;

  inherited;
end;

function TViewBombaCadastrar.ValidarDados: Boolean;
begin

  try
    Result := False;

    if (edtID_Tanque.Value <= 0) then
    begin

      Application.MessageBox('Favor, informe o campo tanque.', 'Atenção', MB_OK +
        MB_ICONWARNING);
      edtID_Tanque.SetFocus;
      Exit;
    end;

    if (Trim(edtDescricao.Text) = '') then
    begin

      Application.MessageBox('Favor, informe a descrição da bomba.', 'Atenção', MB_OK +
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

procedure TViewBombaCadastrar.edtID_TanqueExit(Sender: TObject);
var
   ControllerBomba: TControllerBomba;
   Tanque: TTanque;
   sErro: string;
begin
  inherited;

  edtTanque.Clear;
  if(Trim(edtID_Tanque.Text).IsEmpty)then
    Exit;

  ControllerBomba := TControllerBomba.Create;
  Tanque := TTanque.Create;

  try

    if not ControllerBomba.LookTanque(Tanque,StrToInt(edtID_Tanque.Text),sErro) then
      raise Exception.Create(sErro)
    else
    begin
      if(Tanque.Id = 0)then
      begin
        edtID_Tanque.SetFocus;
        raise Exception.Create('Tanque não localizado');
      end;
    end;

    edtTanque.Text := Tanque.Descricao;

  finally
    FreeAndNil(Tanque);
    FreeAndNil(ControllerBomba);
  end;
end;

procedure TViewBombaCadastrar.edtID_TanqueKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_F8)then
  begin
    ViewTanqueBuscar := TViewTanqueBuscar.Create(nil);
    try
      if(ViewTanqueBuscar.ShowModal = mrOk)then
        edtID_Tanque.Value := ViewTanqueBuscar.IdSelecionado;
    finally
      FreeAndNil(ViewTanqueBuscar);
    end;
  end;
end;

end.
