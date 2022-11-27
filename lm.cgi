#!/usr/bin/perl
       use CGI qw/:standard *table/;
       use CGI::Carp qw(fatalsToBrowser);
       use DBI;
       use Time::localtime;
       use Time::Local;
 my $dsn = 'DBI:mysql:alex:localhost';
 my $db_user_name = 'root';
 my $db_password = 'sh7XclC';
 my $dbh = DBI -> connect ($dsn, $db_user_name, $db_password);
$dtCurr =`date +%d/%m/%Y`;
 print header,
          start_html('LINE MAINTENANCE ASSISTANT'),
 do "lm.pm"; &LM_Login(); if ($AuthResult == 1)
{
print " <link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"\/jsdatepick-calendar\/jsDatePick_ltr.min.css\" ><script type=\"text/javascript\" src=\"\/jsdatepick-calendar\/jsDatePick.min.1.3.js\"></script>";
print "<script type=\"text\/javascript\" src=\"\/scripts\/jquery.js\">";
print "<script type=\"text\/javascript\">\$(document).ready(function(){\$(\".123\").click(function(){\$(\"#panel\").toggle(\"now\");\$(this).toggleClass(\"active\");});return false; });
<\/script>";

&Y_shift();
&Y_Quest();
	print "welcome LMA developer! today is $dtCurr";
}
print "<script type=\"text\/javascript\"> window.onload = function(){new JsDatePick({useMode:2,target:\"1\",dateFormat:\"%d\/%m\/%Y\"});};<\/script>";
