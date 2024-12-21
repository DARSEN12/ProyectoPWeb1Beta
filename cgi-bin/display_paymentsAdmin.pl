#lista de todos los pagos realizados

use CGI; 
use DBI; 


my $cgi = CGI->new;
# Decirle al navegador que vamos a mostrar una página web.
print $cgi->header('text/html;charset=UTF-8');


my $dsn = "DBI:mysql:database=river_text;host=localhost"; 
my $db_user = "Nikole"; 
my $db_password = "72725439"; 

my $dbh = DBI->connect($dsn, $db_user, $db_password, { RaiseError => 1, AutoCommit => 1 });

# Preparar una consulta para obtener información de los pagos.
my $sth = $dbh->prepare("SELECT p.pago_id, p.pedido_id, pe.descripcion, p.cantidad, p.metodo_pago, p.estado, p.fecha
                         FROM pagos p
                         JOIN pedidos pe ON p.pedido_id = pe.pedido_id
                         ORDER BY p.fecha DESC");

$sth->execute();

#página web.
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
        <h1>Administración de Pagos</h1>
        <!-- Tabla para mostrar los pagos -->
        <table>
            
            <thead>
                <tr>
                    <th>ID Pago</th>
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


print <<HTML;
            </tbody>
        </table>
    </div>
</body>
</html>
HTML


$sth->finish;
$dbh->disconnect;