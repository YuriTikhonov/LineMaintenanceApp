#!/usr/bin/perl
sub LM_Login{ use DBI; if ($AuthResult != 1){
          print
                     start_form,div({-bgcolor=>'#fffff'},
                       h1 ({-align=>"center"},'Line Maintenance Assistant v2.0'),
                        h5 ({-align=>"center"},'')),
                      "LOGIN:",textfield('login'),p,
                      "PASSW:",password_field('password'),p,
                        submit(-name=>'LOGIN'),p,br,br,br;
                         if (param) {
                                 $LOGIN = param('login');
                                 $PASS = param('password');
                                        }
                                 $LogQuery = "select * from LOGIN where LOGIN = ? and PASS = ?";
                                my $dsn = 'DBI:mysql:alex:localhost';
                                my $db_user_name = 'root';
                                my $db_password = 'xxxxxx';
                                my $dbh = DBI -> connect ($dsn, $db_user_name, $db_password) or die "error can\'t connect to DB";
                                 $sth = $dbh -> prepare ($LogQuery);
                                 $sth -> execute($LOGIN,$PASS);
                                 @AuthPara = $sth -> fetchrow_array;
                        if (@AuthPara[2] =~ /admin/gi or @AuthPara[2] =~ /Brigadir/gi){
                                        $AuthResult = 1;
                                        $logDat = time();
                                        open Login, ">> login.log";
                                        print Login "@AuthPara[3] logged in at $logDat\n";
 close (Login);
                                }#Sucseed auth end
                        else {
                                        print "You Are NOT authorised user hear";
                                }#Error Auth end
                        }#subform end
                };#end of M_Login
#----------------------------------------------календарь--------------------------------------------------
sub Y_shift {
use Time::localtime;

print
start_form,
h3({-align=>'center'},'SELECT SHIFT PLAN'),
	#radio_group(-name=>'ShiftSelect',-align=>'center',
	#-values=>['Today','Today Night','Tomorrow','Tomorrow Night'],
	#-default=>'Today'),br,
		"Select Plan Date",textfield(-id=>1,-name=>'date'),p,
		radio_group(-name=>'DayNight',-align=>'center',-values=>['Day','Night'],-default=>'Say'),br,
submit(),p,
end_form;

if (param()) {
$shift = (param('date'));
$dn = (param('DayNight'))
}
if ($shift !~ // or $shift != undef) {
$sec = 0;
$min = 0;
$hours = 0;
@dt = split /\//,$shift;
$mday = @dt[0];
$month = @dt[1];
$year = @dt[2];

$TIME = timelocal($sec,$min,$hours,$mday,$month,$year);#возращает количество секунд для введенной даты
$period = 1;#значение для добавления новых суток при ночной смене
$dlsec = $period * 86400;
$TIME2 = $TIME + $dlsec;
$tm = localtime($TIME2);
($day,$month,$year)=($tm->mday,$tm->mon,$tm->year);
#$month = $month+1;
$year = $year+1900;
$cldt = "$day\/$month\/$year";#сумма введенной даты и периода в днях
}

}

sub Y_Quest {
use DBI;
 my $dsn = 'DBI:mysql:alex:localhost';
                                my $db_user_name = 'root';
                                my $db_password = 'sh7XclC';
                                my $dbh = DBI -> connect ($dsn, $db_user_name, $db_password) or die "error can\'t connect to DB";

if ($dn  =~ /Night/gi) {$dNight = $cldt}
print $dNight,p;
#chomp $dtQuery;
my $L_Query = "select * from line where (date like \"$shift\" or date like \"$dNight\") and DayNight like \"$dn\"";

$sth = $dbh -> prepare ($L_Query);
$sth -> execute();
@Action = ("","Close","Differ");
$str = 0;
print 
	start_table({-border=>1}),
Tr,th({-align=>'center',-cellspacing=>3},["Daily Plan Date","Shift Number","Flight Number","AC Registration","Arrival Time","Remarks",
"Maintenance Type","MH","Departure Time","Additional Jobs","MH","Action","Accomplished"]);
#print end_table;
while (
@active = $sth -> fetchrow_array) {
push@DT,@active[0];
push@REG,@active[3];
push@MT,@active[6];
$str++;
print
Tr,td(["@active[0]"]),td(["@active[1]","@active[2]","@active[3]","@active[4]","@active[5]","@active[6]","@active[7]","@active[8]","@active[9]","@active[10]",
popup_menu(-name=>"action",-values=>[@Action[0..2]]),"@active[11]"]);
}

}


sub Y_dly{#start sub

my $dsn = 'DBI:mysql:alex:localhost';
my $db_user_name = 'root';
my $db_password = 'xxxxxx';
my $dbh = DBI -> connect ($dsn, $db_user_name, $db_password) or die "error can\'t connect to DB";

print h2({-align=>'CENTER'},'DAILY PLAN CREATION'),
start_form,
"Daily Plan Date",textfield(-id=>1,-name=>'date'),"_________",
"Select DAY or NIGHT Shift",radio_group(-name=>'DayNight',
				-values=>['DAY','NIGHT'],
				-default=>'DAY'),"________",
"Select Shift Number",popup_menu(-name=>'shift_n',
				-values=>['1','2','3','4'],
				-default=>'1'),p,
h4({-align=>'CENTER'},'ENTER AC DATA AND TYPE OF PLANNING MAINTENANCE'),
"Enter REG Nbr1:",textfield('reg1'),"___",
"Enter FLT Nbrs",textfield(-name=>'flt1'),"____",
"Arrival Time:",textfield('arrv'),"___",
"Departure Time:",textfield('dpt'),p,
"Enter Maintenance Type1",textfield(-name=>'maint'),
"Enter MH 1:",textfield(-name=>'mh1'),
"Enter Add Job1",textfield(-name=>'add'),
"Enter Add MH 1:",textfield(-name=>'addMH1'),p,
"Enter Maintenance Type2",textfield(-name=>'maint2'),
"Enter MH 2:",textfield(-name=>'mh2'),
"Enter Add Job2",textfield(-name=>'add2'),
"Enter Add MH 2:",textfield(-name=>'addMH2'),p,

"Enter Remarks:",p,textarea(-align=>"CENTER",
			-name=>'rem',
			-rows=>3,
			-columns=>60),p,
submit,reset;
if (param) {#start if
$dlyDATE = param('date');
$dn = param('DayNight');
$sh_n =param('shift_n');
$reg = param('reg1');
$flt1 = param('flt1');
$arrv = param('arrv');
$dpt = param('dpt');
$mnt = param('maint');
$add = param('add');
$rem = param('rem');
$mh1 = param('mh1');
$addmh1 = param('addMH1');
$mnt2 = param('maint2');
$mh2 = param('mh2');
$add2 = param('add2');
$addmh2 = param('addMH2');
}#end if

#}
my $order = "insert into line (date,shiftNBR,fltNBR,ACreg,arrvTIME,remarks,mntTYPE,mntMH,dptTIME,addJOBS,addJOBSmh,DayNight) values (?,?,?,?,?,?,?,?,?,?,?,?)";
$sth = $dbh -> prepare($order);
$sth -> execute($dlyDATE,$sh_n,$flt1,$reg,$arrv,$rem,$mnt,$mh1,$dpt,$add,$addmh1,$dn);
print "$dlyDATE-------$dn----$sh_n----$reg----$flt1---$arrv---$dpt--$mh1---$add--$addmh1----$rem";
my $order1 = "insert into line (date,shiftNBR,fltNBR,ACreg,arrvTIME,remarks,mntTYPE,mntMH,dptTIME,addJOBS,addJOBSmh,DayNight) values (?,?,?,?,?,?,?,?,?,?,?,?)";
if (($mnt2 != undef or $mnt2 != "")or($add2 != undef or $add2 != "")) {
$sth = $dbh -> prepare($order1);

$sth -> execute($dlyDATE,$sh_n,$flt1,$reg,$arrv,$rem,$mnt2,$mh2,$dpt,$add2,$addmh2,$dn);
}
#}
#}

}
