#!/bin/bash

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

dpkg --add-architecture i386
apt-get -y -q update
apt-get -y -q install --no-install-recommends wine p7zip-full wget ca-certificates zip git curl

mkdir OUT
wget http://download.qt-project.org/official_releases/qt/5.3/5.3.2/qt-opensource-windows-x86-mingw482_opengl-5.3.2.exe
wine qt-opensource-windows-x86-mingw482_opengl-5.3.2.exe --dump-binary-data -o ./OUT
rm qt-opensource-windows-x86-mingw482_opengl-5.3.2.exe

7z x OUT/qt.53.win32_mingw482/5.3.2-0i686-4.8.2-release-posix-dwarf-rt_v3-rev3-runtime.7z
7z x OUT/qt.53.win32_mingw482/5.3.2-0icu_52_1_mingw_builds_32_4_8_2_posix_dwarf.7z
7z x OUT/qt.53.win32_mingw482/5.3.2-0qt5_essentials.7z
7z x OUT/qt.53.win32_mingw482/5.3.2-0qt5_addons.7z
7z x OUT/qt.tools.win32_mingw482/4.8.2i686-4.8.2-release-posix-dwarf-rt_v3-rev3.7z

rm -rf OUT

cat > 5.3/mingw482_32/bin/qt.conf << EOF
[Paths]
Prefix=..
EOF

cat > qttemp.reg <<EOF
[HKEY_CURRENT_USER\\Environment] 
"QMAKESPEC"="Z:\\\\root\\\\5.3\\\\mingw482_32\\\\mkspecs\\\\win32-g++"
"QTDIR"="Z:\\\\root\\\\5.3\\\\mingw482_32"
"PATH"="Z:\\\\root\\\\Tools\\\\mingw482_32\\\\libexec\\\\gcc\\\\i686-w64-mingw32;Z:\\\\root\\\\Tools\\\\mingw482_32\\\\bin;Z:\\\\root\\\\5.3\\\\mingw482_32\\\\bin"
EOF

wine regedit qttemp.reg
