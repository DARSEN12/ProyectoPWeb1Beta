#!"C:/xampp/perl/bin/perl.exe"
# pagos realizados por los usuarios en una página web.

use strict;
use warnings;
use CGI; 
use DBI; 


my $cgi = CGI->new;

print $cgi->header('text/html;charset=UTF-8');


my $dsn = "DBI:mysql:database=river_text;host=localhost"; 
my $db_user = "Nikole"; 
my $db_password = "72725439";

my $dbh = DBI->connect($dsn, $db_user, $db_password, { RaiseError => 1, AutoCommit => 1 });

# Preparar y ejecutar una consulta SQL para obtener los detalles de los pagos realizados.
my $sth = $dbh->prepare("SELECT p.pedido_id, pe.descripcion, p.cantidad, p.metodo_pago, p.estado, p.fecha
                         FROM pagos p
                         JOIN pedidos pe ON p.pedido_id = pe.pedido_id
                         ORDER BY p.fecha DESC");
$sth->execute();

# Inicio del documento HTML para mostrar los resultados de la consulta.
print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administración de Pagos</title>
    <link rel="stylesheet" href="../../styles.css">
</head>
<body>
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>ID Pedido</th>
                    <th>Descripción</th>
                    <th>Monto</th>
                    <th>Método de Pago</th>
                    <th>Estado</th>
                    <th>Fecha</th>
                </tr>
            </thead>
            <tbody>
HTML

# imprimir los detalles de cada pago en la tabla HTML.
while (my @row = $sth->fetchrow_array) {
    print "<tr>";
    foreach my $cell (@row) {
        print "<td>$cell</td>"; 
    }
    print "</tr>";
}

$sth->finish;
$dbh->disconnect;