#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;

# Crear un objeto CGI
my $cgi = CGI->new;

# Configurar la conexión a la base de datos
my $dsn = "DBI:mysql:database=river_text;host=localhost";
my $user = "Nikole";
my $password = "72725439";

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, AutoCommit => 1 });

# Preparar la consulta SQL para obtener los comunicados
my $sth = $dbh->prepare("SELECT Titulo, Contenido, Fecha FROM comunicados");

# Ejecutar la consulta
$sth->execute();

# Imprimir la cabecera HTTP
print $cgi->header;
print "<html><head><title>Lista de Comunicados</title></head><body>";
print "<h2>Lista de Comunicados</h2>";
print "<table border='1'>";
print "<tr><th>Título</th><th>Descripción</th><th>Fecha de Publicación</th></tr>";

# Imprimir los resultados en una tabla
while (my @row = $sth->fetchrow_array) {
    print "<tr>";
    print "<td>$row[0]</td>";
    print "<td>$row[1]</td>";
    print "<td>$row[2]</td>";
    print "</tr>";
}

print "</table>";
print "<a href='javascript:history.back()'>Regresar</a>";
print "</body></html>";

# Cerrar la conexión a la base de datos
$sth->finish;
$dbh->disconnect;