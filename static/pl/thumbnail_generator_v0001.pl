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
# 1. create static html for each and every post on the blog.
#     1.a create thumbnails for all images used in post
#     1.b build html using 'markup'
#     1.c embed special santoroland stuff into markup html
#         code (supported natively by markup)
#         comments (started)
#         file
#         gallery
#         post_info
#         video (started)
#     1.d embed post html into site web frame which includes, javascripts, css, menus and navigation cookies
#
# 2. build site menu(s)
#     2.a post catigory (motorcycles, vfx, aftereffects, nuke, stereo...etc)
#     2.b historical
#
# 3. build home page.....? Is this a thing that needs doing? Or will it be a static thing which is loaded....and has the posts and menu inserted.....?
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
my $IMAGE_MAGICK_ROOT = "C:/Program Files/ImageMagick-6.9.0-Q16";

my $BLOG_ROOT = "D:/data/web/www.santoroland.com_2.0/blog";
my $BLOG_POSTS_ROOT = "${BLOG_ROOT}/posts";
my $BLOG_ETC = $BLOG_ROOT . "/etc";
my $BLOG_RESOURCES = $BLOG_ROOT . "/resources";

my $BLOG_WEB_ROOT = "/blog";
my $BLOG_WEB_POSTS_ROOT = "${BLOG_WEB_ROOT}/posts";

my $POST_IMAGE_THUMBNAIL_SIZE = "320x320";



#################
### functions ###
#################

sub build_code
{
    # function to build the code embedding html for the website
    my ($post_name, $code_string) = @_;
    my @code_string_lines = split("\n",$code_string);
    my %elements = build_element_hash(@code_string_lines);

    print "\t\tAdded a code snippet to the webpage: [$elements{'file'}] ...";

    # first to open the code snippet file
    my $code_file = "$BLOG_POSTS_ROOT/$post_name/$elements{'file'}";
    my $code_string = read_file($code_file);

    my $code_html = "<pre>\n";
    $code_html   .= "\t<code>\n";
    $code_html   .= "${code_string}\n";
    $code_html   .= "\t</code>\n";
    $code_html   .= "</pre>\n";

    print "done.\n";

    return($code_html);

}



sub build_comments
{
    # build the comments html to replace the place holder in the post.txt
    # made this into it's own sub routine incase it got big and fiddly.
    # also, the deeper I get into writing this web site authorthing thing...
    # the more and more it seems like a bad idea.
    # there are tools that do this?
    # the days of the personal web site are LONG since gone.
    # is it nostalsia?
    # because I need to feel clever?
    # you are making this in PERL for christs sake.
    # but the thing is.....this doesn't make me unhappy to do.
    # love, yourself
    my ($post_name) = @_;
    my $comments_html_file = $BLOG_RESOURCES . "/disques_comments_embed_script.html";
    my $comments_string = read_file($comments_html_file);

    return($comments_string);
}




sub build_file
{
    # function to build the file history embedding html.
    my ($file_string) = @_;
    my @file_string_lines = split("\n",$file_string);
    foreach my $el (@file_string_lines)
    {
        # placeholder code till you figure out how you want to make the image html and with what lightbox
        # ox, -you
        #print $el . "\n";
    }

    return("");

}



sub build_gallery
{
    # function to build the gallery embedding html from the raw post.
    # sub rountine will eventually create thumbnails and all sorts of amazing things.
    # for now it sucessfully locates a gallery and deals with it.
    my ($post_name, $gallery_string) = @_;
    my @gallery_string_lines = split("\n",$gallery_string);
    my %elements = build_element_hash(@gallery_string_lines);
    my $gallery_title = $elements{'title'};
    my $res = "120x120";


    # to make the gallery, I need to create thumbail image links to all the files inside the folder
    my $gallery_disk_path = "${BLOG_POSTS_ROOT}/${post_name}/${gallery_title}";
    opendir(DIR,$gallery_disk_path) || die("Cannot open directory !\n");
    @files = readdir( DIR ) or die "Error reading from '$area' : $!";
    closedir( DIR ); # Don't care about errors here

    # make a list of just the image files
    my @image_files;
    foreach my $file (@files) {
        if ( ($file =~ m/jpg|jpeg|png|gif|tif|tiff|tga|sgi|jps$/i) and ($file !~ m/_thumb\./) )
        {
            push @image_files, $file;
        }
    }

    # build thumbnails
    my %images;
    foreach my $file (@image_files)
    {
        my $image_file_thumb = create_image_thumbnail($gallery_disk_path,$file,$res);
        $images{$file} = $image_file_thumb;
    }

    # construct the embedding html code
    my $gallery_embed_html = "";
    $gallery_embed_html .= "<div class=\"image_gallery_popup\">\n";
    $gallery_embed_html .= "\t<div class=\"grid-of-images\">\n";
    $gallery_embed_html .= "\t\t<div class=\"popup-gallery\">\n";

    foreach my $image (sort(keys(%images)))
    {
        my $image_file = $image;
        my $image_file_thumb = $images{$image};
        $gallery_embed_html .= "\t\t\t<div class=\"gallery_image\">\n";
        $gallery_embed_html .= "\t\t\t\t<a href=\"${BLOG_WEB_POSTS_ROOT}/${post_name}/${gallery_title}/${image_file}\" title=\"The Cleaner\"><img src=\"${BLOG_WEB_POSTS_ROOT}/${post_name}/${gallery_title}/${image_file_thumb}\"></a>\n";
        $gallery_embed_html .= "\t\t\t</div>\n";
    }

    $gallery_embed_html .= "\t\t</div>\n";
    $gallery_embed_html .= "\t</div>\n";
    $gallery_embed_html .= "</div>";

    return($gallery_embed_html);

}




sub create_image_thumbnail
{

    my ($image_file_path, $image_file, $res) = @_;
    my $image_file_thumb = $image_file;
    $image_file_thumb =~ s/(\.[\w]{3,4})$/_thumb$1/;

    # create thumbnail (will put some logic into this later to check dates and such)
    my $image_file_disk_path = "${image_file_path}/$image_file";
    my $image_file_disk_path_thumb = "$image_file_path/$image_file_thumb";
    my $image_magick_command = "convert \"${image_file_disk_path}\" -resize ${res} -quality 80 \"${image_file_disk_path_thumb}\"";

    #if ( (stat($image_file_disk_path))[9] > (stat($image_file_disk_path_thumb))[9] )
    print "\t\tCreating thumbnail for image: [$image_file] ...";
    system($image_magick_command);
    if ( $? == -1 )
    {
      print "command failed: $!\n";
    }
    print "done.\n";

    return($image_file_thumb);
}




sub build_element_hash
{
    # build hash of tag elements
    my %elements = [];
    foreach my $line (@_)
    {
        if ($line =~ m/^\w+=/)
        {
            my @el = split("=", $line);
            $elems{$el[0]} = $el[1];
        }
    }
    return(%elems);
}

sub build_image
{
    # function to build the video embedding html from the raw post file

    my ($post_name, $image_string) = @_;
    my @image_string_lines = split("\n",$image_string);
    my %elements = build_element_hash(@image_string_lines);

    my $image_file = $elements{"file"};
    my $image_altext = $elements{"alt"};
    my $image_caption = $elements{"caption"};

    my $image_file_disk_path = $BLOG_POSTS_ROOT . "/${post_name}";

    my $image_file_thumb = create_image_thumbnail($image_file_disk_path,$image_file,$POST_IMAGE_THUMBNAIL_SIZE);

    # create the html that will embed the image into the page
    my $image_html = "";
    #$image_html   .= "<div class=\"image_popup\">\n";
    $image_html   .= "\t<a class=\"image-popup-vertical-fit\" href=\"${BLOG_WEB_POSTS_ROOT}/${post_name}/$image_file\" title=\"${image_caption}\">\n";
    $image_html   .= "\t\t<img class=\"image_popup\" src=\"${BLOG_WEB_POSTS_ROOT}/${post_name}/$image_file_thumb\">\n";
    $image_html   .= "\t</a>\n";
    #$image_html   .= "</div>\n";

    return($image_html);

}






sub build_post
{
    # function to build the 'blog post'
    # this is a main function in this scirpt
    my ($post_name) = @_;

    # 1.a
    # build image thumbnails for galleries.

    # first let's grab all the gallery directories
    my @dir_contents = [];
    my $post_directory = $BLOG_ROOT . "/posts/" . $post_name . "/";
    opendir(DIR,$post_directory) || die("Cannot open directory !\n");
    @dir_contents = readdir(DIR);
    closedir(DIR);
    my @gallery_dirs;
    foreach my $file (@dir_contents)
    {
        if($file =~ m/^gallery/)
        {
            push  (@gallery_dirs, $file);
        }
    }

    # now we will create the thumbnails
    foreach my $gallery (@gallery_dirs){
        #print ("\t" . $post_directory . $gallery . "\n");
        # sub routine here to make thumbnails()
    }


    # 1.b
    # building the static html that will become the web page.

    # first to open the post.text file
    my $post_text_file = $post_directory . "post.text";
    my $post_string = read_file($post_text_file);


    # second, do some stuff to the text file, and convert it to html

    # let's convert the text file to html via markdown
    my $m = Text::Markdown->new;
    my $post_html_string = $m->markdown($post_string);



    # replace / build the CODE section of the page
    while ($post_html_string =~ /(\<\![\-]{2}[\n\s]*?CODE[\w\s=\-\:\(\)\n\.\'\!\@\(\)\$\%\^\&\*\[\]\,\'\"\~\;]*[\-]{2}\>)/g )
    {
        my $replace_string = $&;
        my $code_html = build_code($post_name, $replace_string);
        $post_html_string =~ s/$replace_string/$code_html/;
    }


    # replace / build the COMMENTS section of the page
    while ($post_html_string =~ /(\<\![\-]{2}[\n\s]*?COMMENTS\n?[\-]{2}\>)/g )
    {
        my $comments_html = build_comments($post_name);
        my $replace_string = $&;
        $post_html_string =~ s/$replace_string/$comments_html/;
    }


    # replace / build the FILE section(s) of the page
    while ($post_html_string =~ /(\<\![\-]{2}[\n\s]*FILE[\w\s=\-\:\(\)\n\.\'\!\@\(\)\$\%\^\&\*\[\]\,\'\"\~\;]*[\-]{2}\>)/g )
    {
        my $replace_string = $&;
        my $file_html = build_file($replace_string);
        $post_html_string =~ s/$replace_string/$image_html/;
    }


    # replace / build the IMAGE_GALERY  section(s) of the page
    while ($post_html_string =~ /(\<\![\-]{2}[\n\s]*IMAGE_GALLERY[\w\s=\-\:\(\)\n\.\'\!\@\(\)\$\%\^\&\*\[\]\,\'\"\~\;]*[\-]{2}\>)/g )
    {
        my $replace_string = $&;
        my $gallery_html = build_gallery($post_name,$replace_string);
        $post_html_string =~ s/$replace_string/$gallery_html/;
    }

    # replace / build the IMAGE section(s) of the page
    while ($post_html_string =~ /(\<\![\-]{2}[\n\s]*?IMAGE[\n\s]+[\w\s=\-\:\(\)\n\.\'\!\@\(\)\$\%\^\&\*\[\]\,\'\"\~\;]*[\-]{2}\>)/g )
    {
        my $replace_string = $&;
        my $image_html = "";
        $image_html = build_image($post_name, $replace_string);
        $post_html_string =~ s/$replace_string/$image_html/;
    }



    while ($post_html_string =~ /(\<\![\-]{2}\n?VIDEO[\w\s=\-\:\(\)\n\.\']*[\-]{2}\>)/g )
    {
        my $replace_string = $&;
        my $video_html = build_video($replace_string,$post_name);
        $post_html_string =~ s/$replace_string/$video_html/;
    }



    # third,
    # open the template html file and insert the new content
    my $default_page_file = $BLOG_RESOURCES . "/default_page.html";
    my $default_page_string = read_file($default_page_file);
    $default_page_string =~ s/\<\![\-]{2}CONTENT[\-]{2}\>/$post_html_string/;


    # forth, write the new html file out to disk
    #        and say a silent prayer to god that this thing actually worked..... which was highly unlikely.
    my $post_html_file = $post_directory . "index.html";
    print ("\t\tWriting out post index.html file...");
    open(my $file, '>', $post_html_file) or die "Couldn't open file to write: $! [${post_html_file}]";
    print $file $default_page_string;
    close $file;
    print ("done.\n");

    return();

}



sub build_video
{
    # function to build the video embedding html from the raw post file
    my ($video_string, $post_name) = @_;
    my @video_string_lines = split("\n",$video_string);


    # extract information we need to embed video into page from comment tag
    my %embed_vars;
    my @video_details;
    foreach my $el (@video_string_lines)
    {
        if ($el =~ m/^embed_\w+/)
        {
            # add to embed vars hash
            my @bits = split("=",$el);
            $embed_vars{$bits[0]} = $bits[1];
        }
        elsif ($el =~ m/^[\w\_\s]+\=/)
        {
            # add to video details array
            push @video_details, $el;
        }
    }


    # create video preview still
    my $alt_text = $embed_vars{"embed_alt"};
    my $video_file_webm = $embed_vars{"embed_file_webm"};
    my $video_file_mp4 = $embed_vars{"embed_file_mp4"};
    my $video_file_ogv = $embed_vars{"embed_file_ogv"};
    my $video_preview_still_file = $video_file_mp4;
    $video_preview_still_file =~ s/(\.[\w]{3,4})$/_previewstillframe\.jpg/;
    my $video_file_disk_path               = $BLOG_POSTS_ROOT . "/${post_name}/$video_file_mp4";
    my $video_preview_still_file_disk_path = $BLOG_POSTS_ROOT . "/${post_name}/$video_preview_still_file";
    my $frame_number = $embed_vars{"embed_previewstillframe"};

    # creating still frame for video preview
    my @res = split("x",$embed_vars{"embed_res"});
    my $image_magick_command = "convert \"${video_file_disk_path}\"[${frame_number}] -quality 80 -resize $res[0]x$res[1] \"${video_preview_still_file_disk_path}\"";
    print "\t\tCreating stillframe for video preview: [$video_file_mp4] ...";
    system($image_magick_command);
    #print($image_magick_command);
    print "done.\n";

    # create embed tag for video
    my $video_webm = $embed_vars{"embed_file_webm"};
    my $video_mp4  = $embed_vars{"embed_file_mp4"};
    my $video_ogv  = $embed_vars{"embed_file_ogv"};

    my $embed_video_html = "<!-- \"Video For Everybody\" http://camendesign.com/code/video_for_everybody -->\n";
    $embed_video_html   .= "<video controls=\"controls\" poster=\"${video_preview_still_file}\" width=\"$res[0]\" height=\"$res[1]\">\n";
	$embed_video_html   .= "<source src=\"$video_webm\" type=\"video/webm\" />\n";
    $embed_video_html   .= "\t<source src=\"$video_mp4\" type=\"video/mp4\" />\n";
	$embed_video_html   .= "<source src=\"$video_ogv\" type=\"video/ogg\" />\n";
	$embed_video_html   .= "\t<object type=\"application/x-shockwave-flash\" data=\"http://releases.flowplayer.org/swf/flowplayer-3.2.1.swf\" width=\"$res[0]\" height=\"$res[1]\">\n";
	$embed_video_html   .= "\t\t<param name=\"movie\" value=\"http://releases.flowplayer.org/swf/flowplayer-3.2.1.swf\" />\n";
    $embed_video_html   .= "\t\t<param name=\"allowFullScreen\" value=\"true\" />\n";
	$embed_video_html   .= "\t\t<param name=\"wmode\" value=\"transparent\" />\n";
    $embed_video_html   .= "\t\t<param name=\"flashVars\" value=\"config={\'playlist\':[\'${video_preview_still_file}\',{\'url\':\'$video_mp4\',\'autoPlay\':false}]}\" />\n";
    $embed_video_html   .= "\t\t<img alt=\"${alt_text}\" src=\"${video_preview_still_file}\" width=\"$res[0]\" height=\"$res[1]\" title=\"No video playback capabilities, please download the video below\" />\n";
	$embed_video_html   .= "\t</object>\n";
    $embed_video_html   .= "</video>\n";
    #<p>
    #	<strong>Download video:</strong> <a href="http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4">MP4 format</a> | <a href="http://clips.vorwaerts-gmbh.de/big_buck_bunny.ogv">Ogg format</a> | <a href="http://clips.vorwaerts-gmbh.de/big_buck_bunny.webm">WebM format</a>
    #</p>


    return($embed_video_html);

}



sub find_posts
{
    # function to build a list of all the posts in the blog.
    my @dir_contents = [];
    my $dir_to_open = $BLOG_ROOT . "/posts";

    opendir(DIR,$dir_to_open) || die("Cannot open directory !\n");
    @dir_contents = readdir(DIR);
    closedir(DIR);

    my @filtered_contents;
    foreach my $file (@dir_contents)
    {
        if($file !~ m/^\./)
        {
            push  (@filtered_contents, $file);
        }
    }

    return(@filtered_contents); # array of post dir names
}





############
### MAIN ###
############


##################
### parse args ###
##################

# eventually I will pass arguments to this thing.


my @posts;
@posts = find_posts();
foreach my $post (@posts)
{
    print "\t[${post}]\n";
    build_post($post);
}


exit;
