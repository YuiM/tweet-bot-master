#!/usr/bin/perl
use strict;
use Net::Twitter;
use utf8;
binmode STDOUT, ":utf8";

my $consumer_key = "sample";
my $consumer_secret = "sample";
my $access_token = "sample-sample";
my $access_token_secret = "sample";

my $handle = Net::Twitter->new({
    traits => [qw/OAuth API::RESTv1_1 API::Search/],
    consumer_key => $consumer_key,
    consumer_secret => $consumer_secret,
    access_token => $access_token,
    access_token_secret => $access_token_secret});

do_search($_) foreach @ARGV;

sub do_search {
    my $term = shift;

    my @results;
    my $rs = $handle->search({q=>$term, lang=>"ja", page=>1, rpp=>100});
    if (ref $rs eq 'HASH' && exists $rs->{results}) {
        if (@{$rs->{results}}) {
            print_post($_) foreach @{$rs->{results}};
            
        }
    }
}

sub print_post {
    my $t = shift;

    my $msg = "$t->{from_user} (on $t->{created_at})  $t->{text}\n";
            my $ret = $handle->update({status=>$msg});
            print "Cannot post!!" unless $ret;
            
    #print "$t->{from_user} (on $t->{created_at})  $t->{text}\n";
}





