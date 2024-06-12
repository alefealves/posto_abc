unit View.Relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,Utils,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, FireDAC.Comp.Client, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.NumberBox;

type
  TViewRelatorio = class(TForm)
    pnTop: TPanel;
    pnGrid: TPanel;
    pnBottom: TPanel;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    dat_ini: TDateTimePicker;
    dat_fim: TDateTimePicker;
    Label2: TLabel;
    btnPesquisar: TBitBtn;
    btnExportar: TBitBtn;
    QRelatorio: TFDQuery;
    QRelatorioTANQUE: TStringField;
    QRelatorioBOMBA: TStringField;
    QRelatorioVALOR: TFMTBCDField;
    QRelatorioSumarizado: TFDQuery;
    QRelatorioSumarizadoVALOR: TFMTBCDField;
    edtSoma: TNumberBox;
    Label3: TLabel;
    DS_Sumarizado: TDataSource;
    QRelatorioSumarizadoDAT_INI: TStringField;
    QRelatorioSumarizadoDAT_FIM: TStringField;
    QRelatorioDATA: TStringField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ApplyBestFitGrid;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    
  protected
    procedure BuscarDados;
  public

  end;

var
  ViewRelatorio: TViewRelatorio;

implementation

{$R *.dfm}

uses
  View.Principal,
  Relatorio;

procedure TViewRelatorio.btnExportarClick(Sender: TObject);
begin
  if (DataSource1.DataSet.IsEmpty) then
  begin
     Application.MessageBox('Realize a pesquisar do período antes de exportar', 'Atenção', MB_OK +
        MB_ICONWARNING);
     Exit;
  end;

  if (frmRelatorio = nil)then
    frmRelatorio := TfrmRelatorio.Create(nil);

  frmRelatorio.relAbastecimento.Preview;
  frmRelatorio.Destroy;
end;

procedure TViewRelatorio.btnPesquisarClick(Sender: TObject);
begin
  if (dat_fim.DateTime < dat_ini.DateTime) then
  begin
     Application.MessageBox('A data final não poder ser menor que data inicial', 'Atenção', MB_OK +
        MB_ICONWARNING);
     Exit;
  end;

  Self.BuscarDados;
end;

procedure TViewRelatorio.BuscarDados;
begin
   edtSoma.Value := 0;

   QRelatorio.Close;
   QRelatorio.ParamByName('DAT_INI').AsDate := dat_ini.Date;
   QRelatorio.ParamByName('DAT_FIM').AsDate := dat_fim.Date;
   QRelatorio.Open;

   if (QRelatorio.IsEmpty) then
   begin
     Application.MessageBox('Nenhum registro foi encontrado', 'Atenção', MB_OK +
        MB_ICONWARNING);
     Exit;
   end;

   QRelatorioSumarizado.Close;
   QRelatorioSumarizado.ParamByName('DAT_INI').AsDate := dat_ini.Date;
   QRelatorioSumarizado.ParamByName('DAT_FIM').AsDate := dat_fim.Date;
   QRelatorioSumarizado.Open;

   edtSoma.Value := QRelatorioSumarizadoVALOR.AsFloat;
   QRelatorioSumarizado.Edit;
   QRelatorioSumarizadoDAT_INI.AsString := DateToStr(dat_ini.Date);
   QRelatorioSumarizadoDAT_FIM.AsString := DateToStr(dat_fim.Date);

   ApplyBestFitGrid;
   QRelatorio.First;
end;

procedure TViewRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    frmRelatorio := nil;
  except on E: Exception do
    begin
      Exception.Create(e.Message);
    end;
  end;
end;

procedure TViewRelatorio.FormShow(Sender: TObject);
begin
  dat_ini.SetFocus;
end;

procedure TViewRelatorio.ApplyBestFitGrid;
var
  i, maxWidth: Integer;
  ColWidth: Integer;
begin
  for i := 0 to DBGrid1.Columns.Count - 1 do
  begin

    if(i = 3) then begin

      maxWidth := DBGrid1.Canvas.TextWidth(DBGrid1.Columns[i].Title.Caption) + 30;
      DataSource1.DataSet.First;
      while not  DataSource1.DataSet.Eof do
      begin
        ColWidth := DBGrid1.Canvas.TextWidth(DataSource1.DataSet.Fields[i].AsString) + 30;
        if ColWidth > maxWidth then
          maxWidth := ColWidth;
         DataSource1.DataSet.Next;
      end;
      DBGrid1.Columns[i].Width := maxWidth;
    end
    else begin

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
end;

procedure TViewRelatorio.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if(not Odd(DataSource1.DataSet.RecNo))then
    DBGrid1.Canvas.Brush.Color := $00DDDDDD;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
