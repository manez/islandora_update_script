#!/bin/sh
# test for number or arguments - if not exactly 2 then print instructions to user
if [ $# -ne 2 ]
then 
    echo "Two arguments are required, the first is the directory to hold the modules, the second is the repository branch"
    echo "e.g. install_islandora.sh modules 6.x"
    exit 0
fi
# first argument is the proposed directory - if it doesn't exist, build it
dir=$1
if [ ! -d "$dir" ]; then
    mkdir $dir
fi
# not strictly necessary, but this will ensure that the user is on the right branch for every repo
branch=$2
# these variables will be used to create url to pull from git
# uncomment the one you'd like to use.  This will normally be read only

# base_dir='https://github.com/Islandora/'        #http
#base_dir='git@github.com:Islandora/'             #ssh
base_dir='git://github.com/Islandora/'           #read-only

append='.git'
cd $dir

# an array of addresses for each of our basic modules - this list can be modified by the user
modules=(
# make sure you leave all of these intact
    'islandora'
    'islandora_xml_forms'
    'php_lib'
    'objective_forms'
    'islandora_solr_search'
#these modules are optional
    'islandora_solution_pack_large_image'
    'islandora_solution_pack_collection'
    'islandora_solution_pack_image'
    'islandora_solution_pack_pdf'
    'islandora_solution_pack_video'
    'islandora_solution_pack_book'
    'islandora_solution_pack_audio'
    'islandora_batch'
    'islandora_solution_pack_web_archive'
    'islandora_solution_pack_newspaper'
    'islandora_bagit'
    'islandora_book_batch'
    'islandora_bookmark'
    'islandora_checksum'
    'islandora_checksum_checker'
    'islandora_fits'
    'islandora_image_annotation'
    'islandora_internet_archive_bookreader'
    'islandora_importer'
    'islandora_jwplayer'
    'islandora_marcxml'
    'islandora_oai'
    'islandora_ocr'
    'islandora_openseadragon'
    'islandora_paged_content'
    'islandora_premis'
    'islandora_simple_workflow'
    'islandora_xacml_editor'
    'islandora_xmlsitemap'
    'islandora_solr_facet_pages'
    'islandora_solr_metadata'
    'islandora_sync'
    'islandora_scholar'
    )

# each repository is cloned to its own directory
for module in ${modules[@]}
    do
        echo $base_dir${module}$append
        git clone $base_dir${module}$append
    done
#for each subdirectory, cd in, checkout the specified branch, and cd back
for f in *
    do
        echo "Checking out $branch in $f"
        cd $f
        git checkout $branch
        cd ..
