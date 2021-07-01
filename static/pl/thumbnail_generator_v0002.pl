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


###################
### GLOBAL VARS ###
###################
my $IMAGE_MAGICK_ROOT = "C:/Program Files/ImageMagick-7.0.5-Q16";

my $SITE_ROOT = "D:/data/web/www.santoroland.com_3.0/Hugo/Sites/santoroland";
my $SITE_POSTS_ROOT = "${BLOG_ROOT}/posts";
my $SITE_ETC = $BLOG_ROOT . "/etc";
my $SITE_RESOURCES = $BLOG_ROOT . "/resources";

my $SITE_WEB_ROOT = "/blog";
my $SITE_WEB_POSTS_ROOT = "${BLOG_WEB_ROOT}/posts";

my $POST_IMAGE_THUMBNAIL_SIZE = "320x320";



#################
### functions ###
#################




sub create_image_thumbnail
{

    my ($image_file, $res) = @_;
    my $image_file_thumb = $image_file;
    $image_file_thumb =~ s/([\d\w\_\-\(\)]+\.[\w]{3,4})$/thumb_$1/;

    # create thumbnail (will put some logic into this later to check dates and such)
    my $image_magick_command = "magick convert \"${image_file}\" -resize ${res} -quality 80 \"${image_file_thumb}\"";

    print "\t\tCreating thumbnail for image: [$image_file_thumb] ...";
    #print("\t\t$image_magick_command");
    system($image_magick_command);
    if ( $? == -1 )
    {
      print "command failed: $!\n";
    }
    print "done.\n";

    return($image_file_thumb);
}







sub find_images
{
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
        if ( ( ($el =~ m/.\.jpe?g$/i) || ($el =~ m/.\.png$/i)) && ($el !~ m/\_header\d?.+$/i) && ($el !~ m/\_youtube\d?.+$/i) && ($el !~ m/^thumb/i) && (!-f "$dir_to_open/thumb_$el"))
        {
            # add the discovered image to the list of return files
            my $img = $dir_to_open . "/" . $el;
            push  (@image_files, $img);
        }
        elsif ( (-d "$dir_to_open/$el") && ($el !~ m/^\./) )
        {
          #recurse into subdir to potentially find more images
          my $path = "$dir_to_open/$el";
          my $image_files = \@image_files;
          $returned_image_files = find_images($image_files,$path);
          my @returned_image_files = @{$returned_image_files};
          @image_files = @returned_image_files;
        }
    }

    my $return_images = \@image_files;
    return($return_images); # array of post dir names
}





############
### MAIN ###
############


##################
### parse args ###
##################

# find all the images that require thumbnail generation
my @images = [];
my $path = ($SITE_ROOT . "/static/img/stuff");
my $image_files = find_images(@images,$path);
@images = @{$image_files};



# generate the thubnails for images
foreach my $el (@images)
{
  print ("\t" . $el . "\n");
  my $thumb = create_image_thumbnail($el,"150x150");
}

exit;
