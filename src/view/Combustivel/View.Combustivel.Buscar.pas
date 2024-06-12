unit View.Combustivel.Buscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Buscar, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TViewCombustivelBuscar = class(TViewHerancaBuscar)
    QListarCombustiveis: TFDQuery;
    QListarCombustiveisID: TIntegerField;
    QListarCombustiveisDESCRICAO: TStringField;
    QListarCombustiveisVALOR: TFMTBCDField;
    QListarCombustiveisIMPOSTO: TFMTBCDField;
  private
  protected
    procedure BuscarDados; override;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); override;
    procedure Excluir; override;
  public
    { Public declarations }
  end;

var
  ViewCombustivelBuscar: TViewCombustivelBuscar;

implementation

{$R *.dfm}

{ TViewCombustivelBuscar }

uses
   View.Principal,
   Controller.Combustivel,
   View.Combustivel.Cadastrar;

procedure TViewCombustivelBuscar.BuscarDados;
var
  ControllerCombustivel: TControllerCombustivel;
  LCampo: string;
  qry: TFDQuery;
begin

  ControllerCombustivel := TControllerCombustivel.Create;
  try
    LCampo := '';

    case rdGroupFiltros.ItemIndex of
     0: LCampo := 'ID';
     1: LCampo := 'DESCRICAO';
    end;

    DataSource1.DataSet.Close;
    QListarCombustiveis := ControllerCombustivel.ListarCombustiveis(LCampo, Trim(edtBuscar.Text));
    DataSource1.DataSet.Open;
  finally
    FreeAndNil(ControllerCombustivel);
  end;

  inherited;
end;

procedure TViewCombustivelBuscar.ChamarTelaCadastrar(const AId: Integer = 0);
var
  ViewCombustivelCadastrar: TViewCombustivelCadastrar;
begin
  inherited;
  ViewCombustivelCadastrar := TViewCombustivelCadastrar.Create(nil);
  try
    ViewCombustivelCadastrar.IdRegistroAlterar := AId;
    if(ViewCombustivelCadastrar.ShowModal = mrOk)then
    begin
      inherited UltId := ViewCombustivelCadastrar.UltId;
      Self.BuscarDados;
    end;
  finally
    ViewCombustivelCadastrar.Free;
  end;
end;

procedure TViewCombustivelBuscar.Excluir;
var
  ControllerCombustivel: TControllerCombustivel;
  sErro: string;
begin

  inherited;
  ControllerCombustivel := TControllerCombustivel.Create;
  try

    if not ControllerCombustivel.Excluir(IdSelecionado,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox('Regitro excluído com sucesso', 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(ControllerCombustivel);
  end;
end;

end.
