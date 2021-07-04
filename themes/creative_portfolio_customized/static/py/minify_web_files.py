#!/usr/bin/env python

##################
#### libraries ###
##################
from css_html_js_minify import process_single_html_file, process_single_js_file, process_single_css_file, html_minify, js_minify, css_minify
import os, time, re, sys


#############
#### subs ###
#############

def build_files_to_min_dict(args):
    root_folder = args['root_folder']
    return_list = args['files']
    file_regex = "\.js$|\.css$"
    exclude_regex = "\.min\.\w{2,4}"

    # list the dir contents
    folder_items = os.listdir(root_folder)

    # add to list of files or recurse into folder
    for el in folder_items:
        path = '{0}/{1}'.format(root_folder,el).replace("\\","/")

        # add files
        if os.path.isfile(path):
            if (re.search(file_regex,el,flags=re.IGNORECASE)
                and not re.search(exclude_regex,el,flags=re.IGNORECASE)):
                print('\tfile: {0}'.format(path))
                return_list.append(path)

        # recurse into folder
        elif os.path.isdir(path):
            #print('folder: {0}'.format(el))
            return_list = build_files_to_min_dict(
                            {'root_folder':path,
                            'files':return_list})

    return (return_list)


############
### main ###
############
def main():

    # Get the current working directory
    cwd = os.getcwd()

    # build the root folder to recurse into
    root_folder = os.path.abspath("{0}/..".format(cwd))


    print("Looking for files to min...")
    list_of_files = build_files_to_min_dict(
                            {'root_folder':root_folder,
                            'files':[]})



    # only min files newer than current mins
    print("Building list of files newer than min counterparts....")
    list_of_files_to_min = []
    for el in list_of_files:
        # two files to compare mod time stamps
        unmin_file = el
        min_file = re.sub("(\w{2,4})$",r"min.\1",unmin_file)
        
        # unmin file stats
        unmin_file_stats = os.stat(unmin_file)
        unmin_mod_time = unmin_file_stats.st_mtime
        
        # min file states
        try:
            min_file_stats = os.stat(min_file)
            min_mod_time = min_file_stats.st_mtime
        except:
            # if the min file does't exist yet
            min_mod_time = 0

        # add unmin file to list if it's newer than min file 
        if unmin_mod_time > min_mod_time:
            print("\tWould min file: ", unmin_file)
            list_of_files_to_min.append(unmin_file)

    # minify files
    print("Minifying files...")
    for el in list_of_files_to_min:
        try:
            if re.search("\.html|\.htm$",el,flags=re.IGNORECASE):
                # HTML
                process_single_html_file(el, overwrite=False)
                print("\tminifying html: {0}".format(el))
                # 'test.html'
            elif re.search("\.js$",el,flags=re.IGNORECASE):
                # JS
                process_single_js_file(el, overwrite=False)
                print("\tminifying js: {0}".format(el))
                # 'test.min.js'
            elif re.search("\.css$",el,flags=re.IGNORECASE):
                # CSS
                process_single_css_file(el, overwrite=False)
                print("\tminifying css: {0}".format(el))
                # 'test.min.css'
        except:
            print("Unexpected error:", sys.exc_info()[0])
            raise




####################
### call to main ###
####################
if __name__ == "__main__":
    main()