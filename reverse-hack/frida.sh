DESC="هوک رانتایم با frida"
REQ="frida-tools"
RISK="MED"

termux(){
cat <<'EOF'
pip install frida-tools
frida-ps -U
frida -U -f com.package.name -l script.js --no-pause
EOF
}

kali(){
cat <<'EOF'
pipx install frida-tools
frida-ps -Uai
frida-trace -U -f com.package.name -i "open*"
frida -U -f com.package.name -l script.js
# نمونه اسکریپت:
cat > script.js <<'JS'
Java.perform(function(){
  var S = Java.use("java.lang.String");
  S.toString.implementation = function(){ var r = this.toString(); console.log(r); return r; };
});
JS
EOF
}
