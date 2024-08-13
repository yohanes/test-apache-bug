#!/usr/bin/perl
use CGI;
my $q = CGI->new;
my $redir = $q->param("r");
if ($redir =~ m{^https?://}) {
print "Location: $redir\n";
}
print "Content-Type: text/html\n\n";
