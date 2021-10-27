=head1 SYNOPSIS

create_static_html.pl

Builds static html pages from markup text files and media.



=head1 OPTIONS

	'-build_navigation'     Creates html code for the sites navigation

    '-force_update'         Forces all html and thumbnails to be updated reguardless of date checking

    '-build_post:post_name'       Updates the content of a single post or catagory



=head1 EXAMPLES

		create_static_html.pl -build_post:motorcycle -force_update

=cut


#
#
#
# This is the first thoughts in setting up the perl script that will convert the 'markup' blog posts to static html
# Here is the basic idea:
#
# 1. troll through the static img folder, and create thumbnails for all the larger images
#
#
#
#

#################
### LIBRARIES ###
#################
use Pod::Usage;
use File::Slurp;
use Text::Markdown 'markdown';
use warnings;
use MIME::Base64;
use File::Remove 'remove';


###################
### GLOBAL VARS ###
###################
my $IMAGE_MAGICK_ROOT = "C:/Program Files/ImageMagick-7.0.7-Q16";

my $SITE_ROOT = "D:/data/web/www.santoroland.com_3.1/Hugo/Sites/santoroland.com";


#################
### functions ###
#################


sub create_gallery_markdown{
  my ($dir_to_open) = @_;
  print "Found a gallery folder: " . $dir_to_open . "\n";

  print "Creating gallery markdown...";
  # read the directory contents
   my @dir_contents = [];
   opendir(DIR,$dir_to_open) || die("Cannot open directory !\n");
   @dir_contents = readdir(DIR);
   closedir(DIR);

   # create the 'html'
   my $html = "{{< gallery\n";
   my ($html_folder_path) = $dir_to_open =~ m/(\/img.*)/; #D:/data/web/www.santoroland.com_3.0/Hugo/Sites/santoroland/static/img/stuff/all-this-useless-beauty/gallery01
   $html .= "\t\"$html_folder_path\"\n";

   foreach my $el (@dir_contents){
     if ( ($el !~ m/^thumb/i) && ($el !~ m/^\./) && (-f "$dir_to_open/$el")  && ($el !~ m/\.html$/) && ($el !~ m/\.quantized$/)){
       $html .= "\t\"pure-u-1-3\" \"$el|alt\"\n";
     }
   }
   $html .= ">}}";

   #write out 'html' file.
   my $filename = "$dir_to_open/gallery.html";
   open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
   print $fh $html;
   close $fh;

   print "done!\n";

   return();

}




sub create_image_thumbnail{

    my ($image_file, $res) = @_;
    my $image_file_thumb = $image_file;
    $image_file_thumb =~ s/([\.\d\w\_\-\(\)]+)$/thumb_$1/;
    $image_file_thumb =~ s/\.\w{3,4}$/.jpg/;

    # create thumbnail (will put some logic into this later to check dates and such)
    my $image_magick_command = "magick convert \"${image_file}\" -resize ${res} -quality 80 \"${image_file_thumb}\"";

    if (-e $image_file_thumb){
      return($image_file_thumb)
    }
    else{
      print "\t\tCreating thumbnail for image: [$image_file_thumb] ...";
      system($image_magick_command);
      if ( $? == -1 ){
        print "command failed: $!\n";
      }
      print "done.\n";

      return($image_file_thumb);
    }
}



sub create_image_res_file{

  my ($image_file) = @_;
  my $image_file_res = "${image_file}.res";
  $image_magick_command = ("identify -format \"%wx%h\" ${image_file}");
  my @image_res = `$image_magick_command`;


  # check if the resolution file already exists and matches the images res
  my $bool_file_exists = False;
  my $bool_res_match = False;

  # check res file existance and if the data matches the image file.
  if (-e $image_file_res){
    $bool_file_exists = True;
    open(FILE, $image_file_res) or die("Can't read res file: [$!]\n");
    my $contents = <FILE>;
    close(FILE);
    
    if ($contents eq "@{image_res}"){
      $bool_res_match = True;
    } else {
      $bool_res_match = False;
    }
  }

  # write new resolution file if one does not exist
  # or if the resolution does not match the actual image file.
  if (($bool_file_exists eq False) || ($bool_res_match eq False)){
    print ("Generating Image Res File: [${image_file_res}]......");
    open(FILE, '>', $image_file_res) or die("Can't open res file for writing: [$!]\n");
    print FILE @image_res;
    close(FILE);
  }
  

  return($image_file_res)
}




sub find_images{
    # function to build a list of all the posts in the blog.
   my ($el01, $el02) = @_;
   my @image_files = @{ $el01 };       # dereferencing and copying array
   my $dir_to_open = $el02;

   # read the directory contents
    my @dir_contents = [];
    opendir(DIR,$dir_to_open) || die("Cannot open directory !\n");
    @dir_contents = readdir(DIR);
    closedir(DIR);

    # go over each file/folder in the dir
    my @filtered_contents;
    foreach my $el (@dir_contents){
        if ( ( ($el =~ m/.\.jpe?g$/i) || ($el =~ m/.\.png$/i)) && ($el !~ m/\_header\d?.+$/i) && ($el !~ m/\_youtube\d?.+$/i) && ($el !~ m/^thumb/i) && (!-f "$dir_to_open/thumb_$el")){
            # add the discovered image to the list of return files
            my $img = $dir_to_open . "/" . $el;
            push  (@image_files, $img);
        }
        elsif ( (-d "$dir_to_open/$el") && ($el !~ m/^\./) && ($el !~ m/\.dzi/) ){
          #recurse into subdir to potentially find more images
          my $path = "$dir_to_open/$el";
          my $image_files = \@image_files;
          $returned_image_files = find_images($image_files,$path);
          my @returned_image_files = @{$returned_image_files};
          @image_files = @returned_image_files;
        }
    }

    if ( ($dir_to_open =~ m/gallery.+/) && (-d $dir_to_open) ){
          create_gallery_markdown($dir_to_open);
    }

    my $return_images = \@image_files;
    return($return_images); # array of post dir names
}



sub find_images_quantize{
    # function to build a list of all the posts in the blog.
    my ($el01, $el02) = @_;
    my @image_files = @{ $el01 };       # dereferencing and copying array
    my $dir_to_open = $el02;

   # read the directory contents
    my @dir_contents = [];
    opendir(DIR,$dir_to_open) || die("Cannot open directory !\n");
    @dir_contents = readdir(DIR);
    closedir(DIR);

    # go over each file/folder in the dir
    my @filtered_contents;
    foreach my $el (@dir_contents)
    {
        if (($el =~ m/.+\.jpe?g$/i) || ($el =~ m/.+\.png$/i)){
            # add the discovered image to the list of return files
            my $img = $dir_to_open . "/" . $el;
            push  (@image_files, $img);
        }
        elsif ( (-d "$dir_to_open/$el") && ($el !~ m/^\./) && ($el !~ m/\.dzi/) ){
          #recurse into subdir to potentially find more images
          my $path = "$dir_to_open/$el";
          my $image_files = \@image_files;
          $returned_image_files = find_images_quantize($image_files,$path);
          my @returned_image_files = @{$returned_image_files};
          @image_files = @returned_image_files;
        }
    }


    my $return_images = \@image_files;
    return($return_images); # array of post dir names
}


sub quantize_color{

  my ($image_file, $color_depth) = @_;
  # making the gif file
  my $gif_file = "${image_file}_quantized.gif";
  my $image_file_hex = "${image_file}.quantized";

  my $foo = 0;
  if(-e $image_file_hex){
     return()
  }else{
     $foo = 1
  }

  #generate temp gif file
  my $system_command = "magick convert ${image_file} +dither -colors ${color_depth} -resize 10% ${gif_file}";
  system($system_command);
  if ( $? == -1 ){
    print "command failed: $!\n";
  }

  print "Generating Quantized color: [${image_file}]......";

  #open gif and convert to string
  local $/ = undef;
  open FILE, "$gif_file";
  binmode(FILE); # needed for win32
  my $gif = <FILE>;
  my $hexgif_base64 = encode_base64($gif); # convert gif to hex string
  close FILE;

  #write out hex text file

  $hexgif_base64 =~ s/\n//g;
  $hexgif_base64 =~ s/\r//g;

  open(my $fh, '>', $image_file_hex);
  print $fh ($hexgif_base64);
  close $fh;

  #remove temp gif file
  my $remove = $gif_file;
  remove($remove) or die($!);

  print "done!\n";

}






############
### MAIN ###
############


##################
### parse args ###
##################

# find all the images that require thumbnail generation
my @images = [];
my $path = ($SITE_ROOT . "/static/img");
my $image_files = find_images(@images,$path);
@images = @{$image_files};

# generate the thubnails for images
foreach my $el (@images){
  print ("\t" . $el . "\n");
  my $thumb = create_image_thumbnail($el,"150x150");
}


# find all the images that require color quantization.
@images = [];
$image_files = find_images_quantize(@images,$path);
@images = @{$image_files};

# generate the quantized color and resolution files
foreach my $el (@images){
  my $image_file_thumb = quantize_color($el,"1");
  my $image_file_res = create_image_res_file($el);
}

exit;
