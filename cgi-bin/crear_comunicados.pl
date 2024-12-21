#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;

# Crear un objeto CGI
my $cgi = CGI->new;

# Obtener datos del formulario
my $titulo = $cgi->param('titulo');
my $contenido = $cgi->param('contenido');
my $fecha = $cgi->param('fecha');

# Configurar la conexión a la base de datos
my $dsn = "DBI:mysql:database=river_text;host=localhost";
my $user = "Nikole";
my $password = "72725439";

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, AutoCommit => 1 });

# Preparar la consulta SQL para insertar el comunicado
my $sth = $dbh->prepare("INSERT INTO comunicados (Titulo, Contenido, Fecha) VALUES (?, ?, ?)");

# Ejecutar la consulta con los datos del formulario
$sth->execute($titulo, $contenido, $fecha);

# Imprimir la cabecera HTTP
print $cgi->header;
print "<html><head><title>Confirmación</title></head><body>";
print "<div class='alert success'>Comunicado <strong>$titulo</strong> creado exitosamente.</div>";
print "<a href='javascript:history.back()'>Regresar</a>";
print "</body></html>";

# Cerrar la conexión a la base de datos
$sth->finish;
$dbh->disconnect;