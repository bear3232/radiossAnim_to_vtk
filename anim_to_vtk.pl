#!/usr/bin/perl
@FILES=@ARGV;
foreach $F (@FILES) {
    # print "$F\n";
    if($F =~ /^(.+)A([0-9]{3})$/i){
        $jobid=$1;
        $num=$2;
        $max=999;
        $len=3;
        $num =~ s/^0+//;
    } elsif($F =~ /^(.+)A([0-9]{4})$/i){
        $jobid=$1;
        $num=$2;
        $max=9999;
        $len=4;
        $num =~ s/^0+//;
    } elsif($F =~ /^(.+)A([0-9]{5})$/i){
        $jobid=$1;
        $num=$2;
        $max=99999;
        $len=5;
        $num =~ s/^0+//;
    }
    
    for ( $i = $num ; $i <= $max ; $i++ ) {
        $FT = sprintf( "%sA%0${len}i"     , "$jobid" , $i );
        $OT = sprintf( "%sA%0${len}i.vtk" , "$jobid" , $i );
        if ( -f "$FT" && -r "$FT" ) {
            print "$FT --> $OT\n";
            if ( $ENV{OS} =~ /window/i ) {
                system("anim_to_vtk_linux64_gf.exe $FT > $OT");
            } else {
                system("anim_to_vtk_linux64_gf $FT > $OT");
            }
        } else {
            last;
        }
    }
}
