program PostoAbc;

uses
  Vcl.Forms,
  View.Principal in 'src\view\View.Principal.pas' {ViewPrincipal},
  Utils in 'src\utils\Utils.pas',
  View.Heranca.Buscar in 'src\view\Herancas\View.Heranca.Buscar.pas' {ViewHerancaBuscar},
  View.Combustivel.Buscar in 'src\view\Combustivel\View.Combustivel.Buscar.pas' {ViewCombustivelBuscar},
  View.Heranca.Cadastrar in 'src\view\Herancas\View.Heranca.Cadastrar.pas' {ViewHerancaCadastrar},
  View.Combustivel.Cadastrar in 'src\view\Combustivel\View.Combustivel.Cadastrar.pas' {ViewCombustivelCadastrar},
  Controller.Combustivel in 'src\controller\Controller.Combustivel.pas',
  Combustivel in 'src\model\Combustivel.pas',
  Tanque in 'src\model\Tanque.pas',
  Controller.Tanque in 'src\controller\Controller.Tanque.pas',
  View.Tanque.Buscar in 'src\view\Tanque\View.Tanque.Buscar.pas' {ViewTanqueBuscar},
  View.Tanque.Cadastrar in 'src\view\Tanque\View.Tanque.Cadastrar.pas' {ViewTanqueCadastrar},
  Bomba in 'src\model\Bomba.pas',
  Controller.Bomba in 'src\controller\Controller.Bomba.pas',
  View.Bomba.Buscar in 'src\view\Bomba\View.Bomba.Buscar.pas' {ViewBombaBuscar},
  View.Bomba.Cadastrar in 'src\view\Bomba\View.Bomba.Cadastrar.pas' {ViewBombaCadastrar},
  Abastecimento in 'src\model\Abastecimento.pas',
  Controller.Abastecimento in 'src\controller\Controller.Abastecimento.pas',
  View.Abastecimento.Buscar in 'src\view\Abastecimento\View.Abastecimento.Buscar.pas' {ViewAbastecimentoBuscar},
  View.Abastecimento.Cadastrar in 'src\view\Abastecimento\View.Abastecimento.Cadastrar.pas' {ViewAbastecimentoCadastrar},
  BombaConfig in 'src\model\BombaConfig.pas',
  DAO.Combustivel in 'src\dao\DAO.Combustivel.pas',
  DAO.Tanque in 'src\dao\DAO.Tanque.pas',
  DAO.Bomba in 'src\dao\DAO.Bomba.pas',
  DAO.Abastecimento in 'src\dao\DAO.Abastecimento.pas',
  View.Relatorio in 'src\view\Relatorio\View.Relatorio.pas' {ViewRelatorio},
  Relatorio in 'src\view\Relatorio\Relatorio.pas' {frmRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
