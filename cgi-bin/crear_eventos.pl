#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;

# Configuración de la conexión a la base de datos
my $dbname = "river_text";
my $host = "localhost";
my $user = "Nikole";
my $password = "72725439";

my $cgi = CGI->new;
print $cgi->header(-type => 'text/html', -charset => 'UTF-8');

# Datos del formulario
my $titulo = $cgi->param('titulo');
my $descripcion = $cgi->param('descripcion');
my $tipo_evento = $cgi->param('tipo_evento');
my $fecha_evento = $cgi->param('fecha_evento');
my $instalacion = $cgi->param('instalacion');

# Conexión a la base de datos
my $dsn = "DBI:mysql:database=$dbname;host=$host";
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, mysql_enable_utf8 => 1 }) or die $DBI::errstr;

# Preparar la consulta SQL
my $query = "INSERT INTO eventos (titulo, descripcion, tipo_evento, fecha_evento, instalacion) VALUES (?, ?, ?, ?, ?)";
my $sth = $dbh->prepare($query);
$sth->execute($titulo, $descripcion, $tipo_evento, $fecha_evento, $instalacion) or die "Error al insertar evento: $DBI::errstr";

# Cerrar la conexión y mostrar mensaje de éxito
$sth->finish();
$dbh->disconnect();

# Mostrar mensaje de éxito y redirigir a eventos_admin.html después de unos segundos
print <<HTML;
<html>
<head>
    <title>Evento Creado</title>
    <meta http-equiv="refresh" content="3;url=/ejercicio/cgi-bin/admin/eventos_admin.html">
</head>
<body>
    <h1>Evento creado exitosamente.</h1>
    <p>Redirigiendo a la página de eventos...</p>
</body>
</html>
HTML


