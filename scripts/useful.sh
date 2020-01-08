# take every file and move it to the current folder
#
# with in parent folder you want, run flattenSubfolders
flattenSubfolders () {
    find . -type f -exec mv -n -- {} . \;
}

# used after you use flattenSubfolders to remove empty subfolders
#
# with in parent folder you want, run removeEmptySubdirs
removeEmptySubdirs () {
    find . -depth -mindepth 1 -type d -empty -exec rmdir {} \;
}

# will open chrome and turn your README.md in to a nice web view, requires https://github.com/joeyespo/grip 
#
# rmd ./README.md
rmd () {
    grip -b $1 &
    TASK_PID=$!
    sleep 10
    kill $TASK_PID
}

# video helpers 
#
# genWebMp4 ./movie.ext ./newmovie.mp4
genWebMp4 () {
    ffmpeg -i $1 -vcodec h264 -acodec aac -strict -2 $2
}

#
# genWebm ./movie.ext ./newmovie.webm
genWebm () {
    ffmpeg -i $1 -c:v libvpx-vp9 -b:v 2M -pass 1 -c:a libopus -f webm /dev/null && \
        ffmpeg -i $1 -c:v libvpx-vp9 -b:v 2M -pass 2 -c:a libopus $2
}

#
# wavToMp3 ./file
wavToMp3() {
    ffmpeg -i $1.wav -codec:a libmp3lame -qscale:a 2 $1.mp3
}

#
# with in folder of all mp3s, run mp3ToOgg
mp3ToOgg() {
    for file in *.mp3
        do ffmpeg -i "${file}" "${file/%mp3/ogg}"
    done
}

#
# genVideoThumb ./video.ext ./thumbnail.ext
# you can use jpg and png for thumbnail ext
genVideoThumb () {
    ffmpeg -ss 00:00:01  -i $1 -vframes 1 -q:v 2 $2
}

#
# spl word
spl () {
    aspell -a <<< "$1"
}

#
# gitCleanBranches
gitCleanBranches() {
    git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d
}
