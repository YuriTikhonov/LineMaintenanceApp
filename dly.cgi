#!/usr/bin/perl

use CGI qw/:standard *table/;
use CGI::Carp qw(fatalsToBrowser);
use Time::localtime;
use Time::Local;

do "lm.pm";

print header;
start_html;
&LM_Login();
if ($AuthResult == 1) {
print " <link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"\/jsdatepick-calendar\/jsDatePick_ltr.min.css\" ><script type=\"text/javascript\" src=\"\/jsdatepick-calendar\/jsDatePick.min.1.3.js\"></script>";
print "<script type=\"text\/javascript\" src=\"\/scripts\/jquery.js\">";
print "<script type=\"text\/javascript\">\$(document).ready(function(){
\$(\".123\").click(function(){
\$(\"#panel\").toggle(\"now\");
\$(this).toggleClass(\"active\");
});return false; });
<\/script>";
$time = time;

&Y_dly();
}
print "<script type=\"text\/javascript\"> window.onload = function(){new JsDatePick({useMode:2,target:\"1\",dateFormat:\"%d\/%m\/%Y\"});};<\/script>";
