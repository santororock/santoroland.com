#!/usr/local/bin/perl
use warnings;
use MIME::Base64;
use File::Remove 'remove';


# making the gif file
my $path = "D:/data/web/www.santoroland.com_3.0/Hugo/Sites/santoroland/static/img/work";
my $image_file = "zeitoun_header.jpg";
my $gif_file = "${image_file}_quantized.gif";
my $system_command = "magick convert $path/$image_file +dither -colors 1 -resize 10% $path/$gif_file";

system($system_command);
if ( $? == -1 )
{
  print "command failed: $!\n";
}
print "done.\n";


#open gif and convert to string
local $/ = undef;
open FILE, "$path/$gif_file";
binmode(FILE); # needed for win32
my $gif = <FILE>;
my $hexgif_base64 = encode_base64($gif); # convert gif to hex string
close FILE;


#write out hex text file
my $image_file_hex = "$path/${image_file}.quantized";
open(my $fh, '>', $image_file_hex);
print $fh ("data:image/gif;base64,".$hexgif_base64);
close $fh;

#remove temp gif file
my $remove = "$path/$gif_file";
remove($remove) or die($!);
