#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;

my $cgi = CGI->new;
print $cgi->header('text/html');

my $email = $cgi->param('email');
my $password = $cgi->param('password');

my $dsn = "DBI:mysql:database=river_text;host=localhost";
my $db_user = "Nikole"; # Usuario de la base de datos
my $db_password = "72725439"; # Contraseña de la base de datos

my $dbh = DBI->connect($dsn, $db_user, $db_password, { RaiseError => 1, AutoCommit => 1 });

# Preparar la consulta para verificar el usuario.
my $sth = $dbh->prepare("SELECT * FROM users WHERE email = ? AND password = ?")
    or die "No se pudo preparar la consulta: $DBI::errstr";

$sth->execute($email, $password)
    or die "No se pudo ejecutar la consulta: $DBI::errstr";

if (my $row = $sth->fetchrow_hashref) {
    print "<script>alert('Login exitoso.');</script>";
    print "<script>window.location.href='admin/inicio_admin.html';</script>";
} else {
    print "<script>alert('Email o password incorrecto');</script>";
    print "<script>window.history.back();</script>";

}

$sth->finish;
$dbh->disconnect;