#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;
use JSON;

# Crear un objeto CGI
my $cgi = CGI->new;

# Configurar la conexión a la base de datos
my $dsn = "DBI:mysql:database=river_text;host=localhost";
my $user = "Nikole";
my $password = "72725439";

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, AutoCommit => 1 });

# Preparar la consulta SQL para obtener los comunicados, limitando a los primeros 6
my $sth = $dbh->prepare("SELECT Titulo, Contenido, Fecha FROM comunicados");

# Ejecutar la consulta
$sth->execute();

# Almacenar los resultados en un array
my @comunicados;
while (my $row = $sth->fetchrow_hashref) {
    push @comunicados, $row;
}

# Convertir el array a JSON
my $json = encode_json(\@comunicados);

# Imprimir la cabecera HTTP y el JSON
print $cgi->header('application/json');
print $json;

# Cerrar la conexión a la base de datos
$sth->finish;
$dbh->disconnect;

