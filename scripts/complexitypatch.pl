#!/usr/bin/perl

# Recursive work to do on a lot of patchs to estimate complexity to integrate patch to another source version

use POSIX qw(strftime);
use Modern::Perl;
use Getopt::Long;
use List::MoreUtils qw(uniq);

my ( $numtix, $write, $loglines );
GetOptions(
      't:s' => \$numtix
      , 'w' => \$write
      , 'l:s' => \$loglines
);

my @tix = ();
if (defined $numtix){
   @tix = split ",",$numtix;
} else {
   @tix = (
   );
}
my $now; my $filename;
if ($write) {
    $now = strftime "%F-%T", localtime;
    $filename = "/tmp/reportpatchs-$now.csv";
}
for my $t (@tix){
    my @branches = `git branch -a | grep $t`;
    say @branches;
    # récupération de la branche à traiter (copier / coller ou entrée s'il n'y en a qu'une)
    my $br = <STDIN>; #eq '' ? @branches[0] : <STDIN>;
    # log graphique des 20 derniers patchs de la branche
    my $nbl = defined $loglines ? $loglines : 10;
    my @log = `git log -$nbl --graph --pretty=format:'%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen(%ci) %Creset<%an>' --abbrev-commit $br`;
    say  @log;

    # récupération temporaire de la branche
    `git checkout $br`;
    say "Checkout branch $br";

    # calcul des variables liées à la complexité d'intégration
    # 1/ Nombre de patchs
    my $nbpatchs = grep  /$t/ , @log;
    my $cmd_diff = "git diff HEAD~$nbpatchs" ;

    # 2/ Nombre de lignes "+" du patch
    my $nblines = `$cmd_diff |grep "+[^+]"| wc -l`;
    chomp $nblines;

    # 3/ Auteur du dernier patch
    my $author = $log[0];
    $author =~ s/.*<(.*)>$/$1/;
    chomp $author;

    # 4/ Fichiers impactés par le patch
    my @files = `$cmd_diff |grep "diff"`;
    map { $_ =~ s/.* b\///  } @files;
    uniq @files;

    # Affichage des variables dans le terminal
    say "\ntix\t,who\t\t\t,nbPatchs\t,nbLines\t,nbFiles";
    say "$t\t,$author\t,$nbpatchs\t\t,$nblines\y\t,".scalar @files;
    say "FILES";
    say @files;

    # Envoi dans un fichier csv des variables
    if ($write) {
        map {chomp $_} @files;
        open my $fh, ">>", $filename;
        print $fh "$t,$author,$nbpatchs,$nblines,".scalar @files.",". join (" ",@files) ."\n";
        close $fh;
    }
}

if ($write) {
    say "file:$filename";
}
