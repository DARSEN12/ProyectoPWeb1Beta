#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;
use JSON;

my $cgi = CGI->new;

print $cgi->header('application/json');

my $id = $cgi->param('id');
my $tipo_evento = $cgi->param('tipo_evento');
my $fecha_evento = $cgi->param('fecha_evento');

my $dbname = "river_text";
my $host = "localhost";
my $user = "Nikole";
my $password = "72725439";

my $dsn = "DBI:mysql:database=$dbname;host=$host";
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1 }) or die $DBI::errstr;

my $query = "SELECT * FROM eventos WHERE 1=1";
$query .= " AND id = ?" if $id;
$query .= " AND tipo_evento = ?" if $tipo_evento;
$query .= " AND fecha_evento = ?" if $fecha_evento;

my $sth = $dbh->prepare($query);

my @params;
push @params, $id if $id;
push @params, $tipo_evento if $tipo_evento;
push @params, $fecha_evento if $fecha_evento;

$sth->execute(@params);

my @resultados;
while (my $row = $sth->fetchrow_hashref) {
    push @resultados, $row;
}

print encode_json(\@resultados);

$dbh->disconnect();

