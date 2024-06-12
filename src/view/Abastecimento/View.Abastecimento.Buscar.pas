unit View.Abastecimento.Buscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Heranca.Buscar, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TViewAbastecimentoBuscar = class(TViewHerancaBuscar)
    QListarAbastecimentos: TFDQuery;
    QListarAbastecimentosID: TIntegerField;
    QListarAbastecimentosBOMBA: TStringField;
    QListarAbastecimentosVALOR: TFMTBCDField;
    QListarAbastecimentosLITROS: TFMTBCDField;
    QListarAbastecimentosIMPOSTO: TFMTBCDField;
    QListarAbastecimentosDATA: TSQLTimeStampField;
  private
  protected
    procedure BuscarDados; override;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); override;
    procedure Excluir; override;

  public
    { Public declarations }
  end;

var
  ViewAbastecimentoBuscar: TViewAbastecimentoBuscar;

implementation

{$R *.dfm}

{ TViewAbastecimentoBuscar }

uses
  View.Principal,
  Controller.Abastecimento,
  View.Abastecimento.Cadastrar;

procedure TViewAbastecimentoBuscar.BuscarDados;
var
  ControllerAbastecimento: TControllerAbastecimento;
  LCampo: string;
begin

  ControllerAbastecimento := TControllerAbastecimento.Create;
  try
    LCampo := '';

    case rdGroupFiltros.ItemIndex of
     0: LCampo := 'ID';
     1: LCampo := 'BOMBA';
    end;

    DataSource1.DataSet.Close;
    QListarAbastecimentos := ControllerAbastecimento.ListarAbastecimentos(LCampo, Trim(edtBuscar.Text));
    DataSource1.DataSet.Open;
  finally
    FreeAndNil(ControllerAbastecimento);
  end;

  inherited;
end;

procedure TViewAbastecimentoBuscar.ChamarTelaCadastrar(const AId: Integer);
var
  ViewAbastecimentoCadastrar: TViewAbastecimentoCadastrar;
begin

  inherited;
  ViewAbastecimentoCadastrar := TViewAbastecimentoCadastrar.Create(nil);
  try
    ViewAbastecimentoCadastrar.IdRegistroAlterar := AId;
    if(ViewAbastecimentoCadastrar.ShowModal = mrOk)then
    begin
      inherited UltId := ViewAbastecimentoCadastrar.UltId;
      Self.BuscarDados;
    end;
  finally
    ViewAbastecimentoCadastrar.Free;
  end;
end;

procedure TViewAbastecimentoBuscar.Excluir;
var
  ControllerAbastecimento: TControllerAbastecimento;
  sErro: string;
begin

  inherited;
  ControllerAbastecimento := TControllerAbastecimento.Create;
  try

    if not ControllerAbastecimento.Excluir(IdSelecionado,sErro) then
      raise Exception.Create(sErro)
    else
      Application.MessageBox('Regitro excluído com sucesso', 'Atenção', MB_OK +
        MB_ICONWARNING);

  finally
    FreeAndNil(ControllerAbastecimento);
  end;
end;

end.
