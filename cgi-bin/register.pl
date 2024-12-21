#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;
use Digest::SHA qw(sha256_hex);

my $cgi = CGI->new;
print $cgi->header('text/html');

my $nombre = $cgi->param('nombre');
my $apellido = $cgi->param('apellido');
my $email = $cgi->param('email');
my $password = $cgi->param('password');

# Si alguno de los campos está vacío, mostrar error.
if (!$nombre || !$apellido || !$email || !$password) {
    print "<p>Error: Todos los campos son obligatorios.</p>";
    exit;
}

my $dsn = "DBI:mysql:database=river_text;host=localhost";
my $db_user = "Nikole"; # Usuario de la base de datos
my $db_password = "72725439"; # Contraseña de la base de datos

my $dbh = DBI->connect($dsn, $db_user, $db_password, { RaiseError => 1, AutoCommit => 1 });

# Preparar la inserción.
my $sth = $dbh->prepare("INSERT INTO users (nombre, apellido, email, password) VALUES (?, ?, ?, ?)");

# Ejecutar la inserción y manejar errores.
eval {
    $sth->execute($nombre, $apellido, $email, $password);
    print "<script>alert('Registro exitoso.');</script>";
    print "<script>window.location.href='admin/inicio_admin.html';</script>";
};
if ($@) {
    print "<p>Error al registrar: $@</p>";
    print "<script>window.history.back();</script>";
}

$sth->finish;
$dbh->disconnect;
