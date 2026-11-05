DESC="دسترسی و ضبط استریم RTSP"
RISK="MED"

termux(){ echo "pkg install ffmpeg; ffplay rtsp://<IP>:554/Streaming/Channels/101"; }

kali(){
cat <<'EOF'
# مسیرهای رایج:
#   /Streaming/Channels/101     (Hikvision)
#   /cam/realmonitor?channel=1&subtype=0  (Dahua)
#   /live/ch0                    (عمومی)
ffprobe -v error -rtsp_transport tcp rtsp://<IP>:554/Streaming/Channels/101
ffmpeg -rtsp_transport tcp -i rtsp://<IP>:554/Streaming/Channels/101 -t 30 -c copy out.mp4
EOF
}
