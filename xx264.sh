git clone https://gerrit.chromium.org/gerrit/p/webm/libwebm.git
git clone https://gerrit.chromium.org/gerrit/p/webm/webm-tools.git
x264 --output peliculas/intermediate_2400k.264 --fps 24 --preset slower --bitrate 960 --vbv-maxrate 1920 --vbv-bufsize 3840 --min-keyint 52 --keyint 52 --scenecut 0 --no-scenecut --pass 1 --video-filter $1
