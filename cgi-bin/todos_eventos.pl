#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;

my $cgi = CGI->new;

print $cgi->header(-type => 'text/html', -charset => 'UTF-8');

my $dbname = "river_text";
my $host = "localhost";
my $user = "Nikole";
my $password = "72725439";

my $dsn = "DBI:mysql:database=$dbname;host=$host";
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, mysql_enable_utf8 => 1 }) or die $DBI::errstr;

my $query = "SELECT * FROM eventos";
my $sth = $dbh->prepare($query);
$sth->execute();

print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todos los Eventos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f9;
        }
        .wrapper {
            width: 80%;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <h1>Todos los Eventos</h1>
        <table id="allEvents">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Descripción</th>
                    <th>Tipo de evento</th>
                    <th>Fecha del evento</th>
                    <th>Instalación</th>
                </tr>
            </thead>
            <tbody>
HTML

while (my $row = $sth->fetchrow_hashref) {
    print <<HTML;
                <tr>
                    <td>$row->{id}</td>
                    <td>$row->{titulo}</td>
                    <td>$row->{descripcion}</td>
                    <td>$row->{tipo_evento}</td>
                    <td>$row->{fecha_evento}</td>
                    <td>$row->{instalacion}</td>
                </tr>
HTML
}

print <<HTML;
            </tbody>
        </table>
    </div>
</body>
</html>
HTML

$sth->finish();
$dbh->disconnect();






