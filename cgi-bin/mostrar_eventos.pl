#!"C:/xampp/perl/bin/perl.exe"
use strict;
use warnings;
use CGI;
use DBI;
use JSON;

my $cgi = CGI->new;
print $cgi->header('application/json');

my $dbname = "river_text";
my $host = "localhost";
my $user = "Nikole";
my $password = "72725439";

my $dsn = "DBI:mysql:database=$dbname;host=$host";
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1 }) or die $DBI::errstr;

my $query = "SELECT * FROM eventos ORDER BY fecha_evento LIMIT 6";
my $sth = $dbh->prepare($query);
$sth->execute();

my @eventos;
while (my $row = $sth->fetchrow_hashref) {
    push @eventos, $row;
}

print encode_json(\@eventos);

$dbh->disconnect();


