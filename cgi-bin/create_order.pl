#!"C:/xampp/perl/bin/perl.exe"
#crear un nuevo pedido en una página web.

use strict;
use warnings;
use CGI; # Herramienta para manejar datos enviados por el usuario.
use DBI; # Herramienta para conectar y trabajar con bases de datos.

# Crear un objeto para manejar datos de la web.
my $cgi = CGI->new;
# Imprimir la cabecera HTTP necesaria para la respuesta web.
print $cgi->header;

# Recoger los datos enviados desde el formulario web.
my $descripcion = $cgi->param('descripcion'); 
my $cantidad = $cgi->param('cantidad'); 
my $metodo_pago = $cgi->param('metodo_pago'); 
my $usuario_id = 1;  # Identificador del usuario que hace el pedido. En un caso real, se obtendría automáticamente.

# Información para conectar a la base de datos.
my $dsn = "DBI:mysql:database=river_text;host=localhost";
my $db_user = "Nikole"; 
my $db_password = "72725439"; 

my $dbh = DBI->connect($dsn, $db_user, $db_password, { RaiseError => 1, AutoCommit => 1 });

# Guardar los detalles del pedido
my $sth = $dbh->prepare("INSERT INTO pedidos (usuario_id, descripcion, cantidad, estado) VALUES (?, ?, ?, 'pendiente')");
$sth->execute($usuario_id, $descripcion, $cantidad);

# Obtener el identificador
my $pedido_id = $dbh->last_insert_id(undef, undef, undef, undef);

# Guardar los detalles del pago
$sth = $dbh->prepare("INSERT INTO pagos (pedido_id, cantidad, metodo_pago, estado) VALUES (?, ?, ?, 'pendiente')");
$sth->execute($pedido_id, $cantidad, $metodo_pago);


print "<script>alert('Pedido realizado correctamente'); window.location.href = '../pedido.html';</script>";

$sth->finish;
$dbh->disconnect;