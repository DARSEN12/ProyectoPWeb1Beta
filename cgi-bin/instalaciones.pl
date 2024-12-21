#!C:/xampp/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use DBI;

my $cgi = CGI->new;
print $cgi->header('text/html');

my $accion    = $cgi->param('accion');
my $nombre    = $cgi->param('nombre');
my $tipo      = $cgi->param('tipo');
my $capacidad = $cgi->param('capacidad');

my $dsn         = "DBI:mysql:database=river_text;host=localhost";
my $db_user     = "Nikole";  
my $db_password = "72725439";  


my $dbh = DBI->connect( $dsn, $db_user, $db_password,
    { RaiseError => 1, PrintError => 0, AutoCommit => 1 } );

if ( !$dbh ) {
    print "<p>Error: No se pudo conectar a la base de datos.</p>";
    exit;
}

if ( $accion eq 'Agregar Complejo' ) {

    if ( !$nombre || !$tipo || !$capacidad ) {
        print "<p>Error: Todos los campos son obligatorios.</p>";
        exit;
    }

    my $sth = $dbh->prepare(
"INSERT INTO complejos_deportivos_simple (nombre, tipo, capacidad) VALUES (?, ?, ?)"
    );

    eval {
        $sth->execute( $nombre, $tipo, $capacidad );
        print
"<script>alert('Complejo deportivo agregado correctamente.');</script>";
        print
"<script>window.location.href='/ejercicio/cgi-bin/admin/inicio_admin.html';</script>";
    };
    if ($@) {
        print "<p>Error al agregar el complejo deportivo: $@</p>";
        print "<script>window.history.back();</script>";
    }

    $sth->finish;
}
elsif ( $accion eq 'Visualizar' ) {

    print
"<iframe src='/ejercicio/Instalaciones.html' style='width: 100%; height: 400px; border: none;'></iframe>";
}

$dbh->disconnect;
