#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;

my $cgi = CGI->new;
print $cgi->header('text/html');

# Configuración de la conexión a la base de datos
my $dsn         = "DBI:mysql:database=river_text;host=localhost";
my $db_user     = "Nikole";    # Usuario de la base de datos
my $db_password = "72725439";     # Contraseña de la base de datos

# Conectar a la base de datos
my $dbh = DBI->connect( $dsn, $db_user, $db_password,
    { RaiseError => 1, PrintError => 0, AutoCommit => 1 } );

if ( !$dbh ) {
    print "<p>Error: No se pudo conectar a la base de datos.</p>";
    exit;
}

# Preparar la consulta SQL para obtener los datos de los complejos deportivos
my $sth = $dbh->prepare("SELECT * FROM complejos_deportivos_simple");

# Ejecutar la consulta SQL
$sth->execute();

# Imprimir los datos en formato de fichas HTML
print "<div class='sports-complex'>";
my $is_first = 1;
while ( my @row = $sth->fetchrow_array ) {
    my ( $id, $nombre, $tipo, $capacidad ) = @row;
    if ( !$is_first ) {
        print "<hr style='width: 100%; border: 1px solid #000;'>";
    }
    $is_first = 0;
    print "<div class='complex'>";
    print "<p><strong>ID:</strong> $id</p>";
    print "<p><strong>Nombre:</strong> $nombre</p>";
    print "<p><strong>Tipo:</strong> $tipo</p>";
    print "<p><strong>Capacidad:</strong> $capacidad</p>";
    print "</div>";
}
print "</div>";

# Finalizar la consulta
$sth->finish;

# Desconectar de la base de datos
$dbh->disconnect;
