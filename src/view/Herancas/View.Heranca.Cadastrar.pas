unit View.Heranca.Cadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Utils;

type
  TViewHerancaCadastrar = class(TForm)
    pnDados: TPanel;
    pnBottom: TPanel;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    FIdRegistroAlterar: Integer;
    FUltId: Integer;
    FAbastecendo: Boolean;
  public
    property IdRegistroAlterar: Integer read FIdRegistroAlterar write FIdRegistroAlterar;
    property UltId: Integer read FUltId;
    property Abastecendo: Boolean read FAbastecendo write FAbastecendo;
  end;

var
  ViewHerancaCadastrar: TViewHerancaCadastrar;

implementation

{$R *.dfm}

procedure TViewHerancaCadastrar.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TViewHerancaCadastrar.btnGravarClick(Sender: TObject);
begin
  FUltId := IdRegistroAlterar;
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TViewHerancaCadastrar.FormCreate(Sender: TObject);
begin
  FIdRegistroAlterar := 0;
  FAbastecendo := False;
end;

procedure TViewHerancaCadastrar.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case(Key)of
    VK_F3:
    btnGravar.Click;
    VK_F4:
     begin
       if(ssAlt in Shift)then
         Key := 0;
     end;
    VK_ESCAPE:
    btnCancelar.Click;
  end;
end;

procedure TViewHerancaCadastrar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13) then
  begin
    Perform(CM_DIALOGKEY, VK_TAB, 0);
    Key := #0;
  end;
end;

end.
