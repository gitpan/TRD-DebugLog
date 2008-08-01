package TRD::DebugLog;

use warnings;
use strict;

=head1 NAME

TRD::DebugLog - debug log

=head1 VERSION

Version 0.0.5

=cut

our $VERSION = '0.0.5';
our $enabled = 0;
our $timestamp = 1;
our $file = undef;

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use TRD::DebugLog;

    $TRD::DebugLog::enabled = 1;
    dlog( "this is debug log" );

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 dlog( log )

   show debug log.

   $TRD::DebugLog::enabled
       = 1 : enable debug log
       = 0 : disable debug log
   $TRD::DebugLog::timestamp
       = 1 : show timestamp enable
       = 0 : show timestamp disable
   $TRD::DebugLog::file
       debug log append to file

=cut

#======================================================================
sub dlog {
	my( $log ) = @_;

	if( $TRD::DebugLog::enabled ){
		my( $source, $line, $func, $buff, $timestr );
		( $source, $line ) = (caller 0)[1,2];
		( $func ) = (caller 1)[3];
		$func =~s/^main:://;

		$buff = "${source}(${line}):${func}:${log}\n";

		if( $TRD::DebugLog::timestamp ){
			my( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) =
				localtime( time );
			$timestr = sprintf( "%04d/%02d/%02d %02d:%02d:%02d",
				$year +=1900, $mon+1, $mday, $hour, $min, $sec );

			$buff = $timestr. " ". $buff;
		}

		if( $TRD::DebugLog::file ){
			open( my $fh, ">>", "${file}" ) || die $!;
			print $fh $buff;
			close( $fh );
		} else {
			print STDERR $buff;
		}
	}
}

=head1 AUTHOR

Takuya Ichikawa, C<< <trd.ichi at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-trd-debuglog at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=TRD-DebugLog>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc TRD::DebugLog


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=TRD-DebugLog>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/TRD-DebugLog>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/TRD-DebugLog>

=item * Search CPAN

L<http://search.cpan.org/dist/TRD-DebugLog>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Takuya Ichikawa, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of TRD::DebugLog
