#!"C:/xampp/perl/bin/perl.exe"
# actualizar el estado de un pago en la base de dato

use strict;
use warnings;
use CGI; 
use DBI; 
use POSIX qw(strftime); # Herramienta para manejar fechas y horas.

my $cgi = CGI->new;

print $cgi->header;

# Recoger los datos enviados desde el formulario web.
my $pago_id = $cgi->param('pago_id'); 
my $estado = $cgi->param('estado'); 


my $dsn = "DBI:mysql:database=river_text;host=localhost"; 
my $db_user = "Nikole"; 
my $db_password = "72725439"; 

my $dbh = DBI->connect($dsn, $db_user, $db_password, { RaiseError => 1, AutoCommit => 1 });

# Obtener la fecha y hora actual en el formato adecuado para la base de datos.
my $fecha_actualizacion = strftime("%Y-%m-%d %H:%M:%S", localtime);
# Preparar y ejecutar una consulta SQL para actualizar el estado del pago en la base de datos.
my $sth = $dbh->prepare("UPDATE pagos SET estado = ?, fecha = ? WHERE pago_id = ?");
$sth->execute($estado, $fecha_actualizacion, $pago_id);

# Verificar si la actualización fue exitosa y mostrar un mensaje al usuario.
if ($sth->rows > 0) {
    print "<script>alert('Pago actualizado correctamente'); window.location.href = 'admin/pagos_admin.html';</script>";
} else {
    print "<script>alert('Error: No se pudo actualizar el pago'); window.location.href = 'admin/pagos_admin.html';</script>";
}


$sth->finish;
$dbh->disconnect;