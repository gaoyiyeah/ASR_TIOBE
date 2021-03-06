#!/bin/bash

if [ $# -ne 2 ]; then
    echo "run.sh <dir>"
    echo "  e.g.: run.sh test_201909"
    echo "  pre-defined test_201909/{url.list,config.txt} are required."
    exit 1;
fi

youtube_dl=~/work/ASR_TIOBE/youtube_dl_env/bin/youtube-dl

dir=$1

if [ ! -f ${dir}/config.txt ] || [ ! -f ${dir}/url.list ]; then
    echo "Error: require config.txt and url.list in working dir"
    exit 1;
fi

mkdir -p $dir/{raw,wav}

cd $dir
$youtube_dl \
    --config-location config.txt \
    --batch-file url.list \
    --output "raw/%(id)s__%(title)s.%(ext)s" \
    --exec 'ffmpeg -i {} -ac 1 -ar 16000 wav/`basename {}`'
cd -

