unit View.Heranca.Buscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,Utils,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, FireDAC.Comp.Client;

type
  TViewHerancaBuscar = class(TForm)
    pnTop: TPanel;
    pnGrid: TPanel;
    pnBottom: TPanel;
    Label1: TLabel;
    edtBuscar: TEdit;
    rdGroupFiltros: TRadioGroup;
    btnCadastrar: TBitBtn;
    btnUtilizar: TBitBtn;
    btnFechar: TBitBtn;
    DBGrid1: TDBGrid;
    pnTotal: TPanel;
    lbTotal: TLabel;
    DataSource1: TDataSource;
    btnAlterar: TBitBtn;
    PopupMenu1: TPopupMenu;
    PopupMenu11: TMenuItem;
    N1: TMenuItem;
    Excluir1: TMenuItem;
    procedure btnFecharClick(Sender: TObject);
    procedure btnUtilizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBuscarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure edtBuscarChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rdGroupFiltrosClick(Sender: TObject);
    procedure ApplyBestFitGrid;
    procedure btnAlterarClick(Sender: TObject);
    procedure PopupMenu11Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    FUltId: Integer;
    FIdSelecionado: Integer;
  protected
    procedure BuscarDados; virtual;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); virtual; abstract;
    procedure Excluir; Virtual; abstract;
  public
    property UltId: Integer write FUltId;
    property IdSelecionado: Integer read FIdSelecionado write FIdSelecionado;
  end;

var
  ViewHerancaBuscar: TViewHerancaBuscar;

implementation

{$R *.dfm}

procedure TViewHerancaBuscar.ApplyBestFitGrid;
var
  i, maxWidth: Integer;
  ColWidth: Integer;
begin
  for i := 0 to DBGrid1.Columns.Count - 1 do
  begin
    maxWidth := DBGrid1.Canvas.TextWidth(DBGrid1.Columns[i].Title.Caption) + 10;
    DataSource1.DataSet.First;
    while not  DataSource1.DataSet.Eof do
    begin
      ColWidth := DBGrid1.Canvas.TextWidth(DataSource1.DataSet.Fields[i].AsString) + 10;
      if ColWidth > maxWidth then
        maxWidth := ColWidth;
       DataSource1.DataSet.Next;
    end;
    DBGrid1.Columns[i].Width := maxWidth;
  end;
end;

procedure TViewHerancaBuscar.btnAlterarClick(Sender: TObject);
begin
  if(DataSource1.DataSet.IsEmpty)then
    raise Exception.Create('Selecione um registro');

  FUltId := DataSource1.DataSet.FieldByName('ID').AsInteger;
  Self.ChamarTelaCadastrar(DataSource1.DataSet.FieldByName('ID').AsInteger);
end;

procedure TViewHerancaBuscar.btnCadastrarClick(Sender: TObject);
begin
  FUltId := 0;
  if(not DataSource1.DataSet.IsEmpty)then
    FUltId := DataSource1.DataSet.FieldByName('ID').AsInteger;

  Self.ChamarTelaCadastrar;
end;

procedure TViewHerancaBuscar.btnFecharClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TViewHerancaBuscar.btnUtilizarClick(Sender: TObject);
begin
  if(DataSource1.DataSet.IsEmpty)then
    raise Exception.Create('Selecione um registro');

  FIdSelecionado := DataSource1.DataSet.FieldByName('ID').AsInteger;
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TViewHerancaBuscar.edtBuscarChange(Sender: TObject);
begin
  Self.BuscarDados;
end;

procedure TViewHerancaBuscar.BuscarDados;
begin
  lbTotal.Caption := 'Registros localizados: 000000';
  if(DataSource1.DataSet.IsEmpty)then
    Exit;

  lbTotal.Caption := 'Registros localizados: ' + FormatFloat('000000', DataSource1.DataSet.RecordCount);
  ApplyBestFitGrid;
  DataSource1.DataSet.First;

  if(FUltId > 0)then
    DataSource1.DataSet.Locate('ID', FUltId, []);
end;

procedure TViewHerancaBuscar.edtBuscarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case(Key)of
   VK_UP: DataSource1.DataSet.Prior;
   VK_DOWN: DataSource1.DataSet.Next;
  end;
end;

procedure TViewHerancaBuscar.edtBuscarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key = #13) and (not DataSource1.DataSet.IsEmpty)then
    btnUtilizar.Click;
end;

procedure TViewHerancaBuscar.Excluir1Click(Sender: TObject);
begin
  if(DataSource1.DataSet.IsEmpty)then
    raise Exception.Create('Selecione um registro');

  if (Application.MessageBox(
    'Confirma a exclusão deste registro?',
    'Confirma exclusão?',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES)
  then
    Exit;

  IdSelecionado := DataSource1.DataSet.FieldByName('ID').AsInteger;
  Self.Excluir;
  Self.BuscarDados;
end;

procedure TViewHerancaBuscar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case(Key)of
   VK_F4:
   begin
     if(ssAlt in Shift)then
       Key := 0;
   end;
   VK_ESCAPE: btnFechar.Click;
  end;

  if (Key in[VK_F1..VK_F12]) then
  begin
    if (rdGroupFiltros.Items.Count >= Key - VK_F1) then
        rdGroupFiltros.ItemIndex := Key - VK_F1;
  end;
end;

procedure TViewHerancaBuscar.FormShow(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  Self.BuscarDados;
  FIdSelecionado := 0;
  edtBuscar.SetFocus;
end;

procedure TViewHerancaBuscar.PopupMenu11Click(Sender: TObject);
begin
  Self.BuscarDados;
end;

procedure TViewHerancaBuscar.rdGroupFiltrosClick(Sender: TObject);
begin
  edtBuscar.SetFocus;
end;

procedure TViewHerancaBuscar.DBGrid1DblClick(Sender: TObject);
begin
  edtBuscar.Text:='';
  btnUtilizar.Click;
end;

procedure TViewHerancaBuscar.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if(not Odd(DataSource1.DataSet.RecNo))then
    DBGrid1.Canvas.Brush.Color := $00DDDDDD;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TViewHerancaBuscar.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then
    btnUtilizar.Click;
end;

procedure TViewHerancaBuscar.DBGrid1TitleClick(Column: TColumn);
var
  LCampo: string;
  LOrdem: string;
begin
  if(DataSource1.DataSet.IsEmpty)then
    Exit;

  LCampo := Column.FieldName.Trim;
  if(LCampo.IsEmpty) or (Column.Field.FieldKind = fkCalculated)then
    Exit;

  LOrdem := LCampo + ':D;ID';
  if(TFDQuery(DataSource1.DataSet).IndexFieldNames.Contains(':D'))then
    LOrdem := LCampo + ';ID';

  TFDQuery(DataSource1.DataSet).IndexFieldNames := LOrdem;
end;

end.
