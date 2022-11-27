#!/usr/bin/perl

use CGI qw/:standard *table/;
use CGI::Carp qw(fatalsToBrowser);
use DBI;                                
use Spreadsheet::ParseExcel; 
print header;
print start_html('Shift Plan Loading');
print
start_multipart_form,
h3({-align=>'center'},'Upload Daily Plan'),

filefield(-name => 'upload_file',
			-default => 'starting value',
			-size => 50,
			-maxlenth => 80),br,
submit(),p;
end_form;
if (param()) {
$filename = (param('upload_file'));
}
open (OUTFILE,">>/usr/lib/cgi-bin/YT/LMA");
while ($bytespread = read($filename,$buffer,1024)) {
print OUTFILE $buffer;
}
close $filename;

print $filename; 
print end_html;
