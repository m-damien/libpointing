!include nsDialogs.nsh
!include MUI2.nsh
!include MultiUser.nsh
!include "FileFunc.nsh"
!include "nsProcess.nsh"
!include "pointingserver_english_text.nsh"


# ---- CHANGE VERSION HERE ---- #
!define APP_VERSION_MAJOR 1
!define APP_VERSION_MINOR 0
!define APP_VERSION_MINOR_A 0
!define APP_VERSION_MINOR_B 0
!define APP_VERSION ${APP_VERSION_MAJOR}.${APP_VERSION_MINOR}
!define APP_VERSION_LONG ${APP_VERSION}.${APP_VERSION_MINOR_A}.${APP_VERSION_MINOR_B}
# ----------------------------------- #


!define REG_DATA "Software\\loki.lille.inria.fr\\PointingServer"
!define ARP "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\PointingServer"

Name "PointingServer"
OutFile "pointingserver-${APP_VERSION}.${APP_VERSION_MINOR_A}-setup_x86.exe"

VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "PointingServer"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "Inria Lille"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "©2015-2019 INRIA"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "PointingServer"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${APP_VERSION}"
VIProductVersion "${APP_VERSION_LONG}"

InstallDir "$LOCALAPPDATA\PointingServer"

var Dialog
var Widget

RequestExecutionLevel user
!define MULTIUSER_EXECUTIONLEVEL Standard
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_DEFAULT_CURRENTUSER
!define MULTIUSER_UNINSTALLMODE_DEFAULT_CURRENTUSER

# Pages
!insertmacro MUI_PAGE_WELCOME
#!insertmacro MUI_PAGE_LICENSE licence.txt
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\PointingServer.exe"
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

Function .onInit
	!insertmacro MULTIUSER_INIT
	Sleep 2000
FunctionEnd

Section
  IfSilent 0 +6
  Sleep 2000
  ReadRegStr $0 HKCU "${REG_DATA}" "path"
  ${If} $0 != ""
    StrCpy $INSTDIR $0
  ${Endif}
  IfFileExists $INSTDIR*.* +4 0
  CreateDirectory $INSTDIR
  IfErrors 0 +2
  Abort "Can't install to $INSTDIR" 
  SetOutPath $INSTDIR
  File build\pointingserver\win32\chromedriver.exe
  File build\pointingserver\win32\credits.html
  File build\pointingserver\win32\d3dcompiler_47.dll
  File build\pointingserver\win32\ffmpeg.dll
  File build\pointingserver\win32\icudtl.dat
  File build\pointingserver\win32\libEGL.dll
  File build\pointingserver\win32\libGLESv2.dll
  File build\pointingserver\win32\nacl_irt_x86_64.nexe
  File build\pointingserver\win32\natives_blob.bin
  File build\pointingserver\win32\node.dll
  File build\pointingserver\win32\notification_helper.exe
  File build\pointingserver\win32\nw.dll
  File build\pointingserver\win32\nwjc.exe
  File build\pointingserver\win32\nw_100_percent.pak
  File build\pointingserver\win32\nw_200_percent.pak
  File build\pointingserver\win32\nw_elf.dll
  File build\pointingserver\win32\payload.exe
  File build\pointingserver\win32\pointingserver.exe
  File build\pointingserver\win32\resources.pak
  File build\pointingserver\win32\v8_context_snapshot.bin
  IfFileExists $INSTDIR\locales\*.* +4 0
  CreateDirectory $INSTDIR\locales
  IfErrors 0 +2
  Abort "Can't install to $INSTDIR\locales" 
  SetOutPath $INSTDIR\locales
  File build\pointingserver\win32\locales\am.pak
  File build\pointingserver\win32\locales\am.pak.info
  File build\pointingserver\win32\locales\ar.pak
  File build\pointingserver\win32\locales\ar.pak.info
  File build\pointingserver\win32\locales\bg.pak
  File build\pointingserver\win32\locales\bg.pak.info
  File build\pointingserver\win32\locales\bn.pak
  File build\pointingserver\win32\locales\bn.pak.info
  File build\pointingserver\win32\locales\ca.pak
  File build\pointingserver\win32\locales\ca.pak.info
  File build\pointingserver\win32\locales\cs.pak
  File build\pointingserver\win32\locales\cs.pak.info
  File build\pointingserver\win32\locales\da.pak
  File build\pointingserver\win32\locales\da.pak.info
  File build\pointingserver\win32\locales\de.pak
  File build\pointingserver\win32\locales\de.pak.info
  File build\pointingserver\win32\locales\el.pak
  File build\pointingserver\win32\locales\el.pak.info
  File build\pointingserver\win32\locales\en-GB.pak
  File build\pointingserver\win32\locales\en-GB.pak.info
  File build\pointingserver\win32\locales\en-US.pak
  File build\pointingserver\win32\locales\en-US.pak.info
  File build\pointingserver\win32\locales\es-419.pak
  File build\pointingserver\win32\locales\es-419.pak.info
  File build\pointingserver\win32\locales\es.pak
  File build\pointingserver\win32\locales\es.pak.info
  File build\pointingserver\win32\locales\et.pak
  File build\pointingserver\win32\locales\et.pak.info
  File build\pointingserver\win32\locales\fa.pak
  File build\pointingserver\win32\locales\fa.pak.info
  File build\pointingserver\win32\locales\fi.pak
  File build\pointingserver\win32\locales\fi.pak.info
  File build\pointingserver\win32\locales\fil.pak
  File build\pointingserver\win32\locales\fil.pak.info
  File build\pointingserver\win32\locales\fr.pak
  File build\pointingserver\win32\locales\fr.pak.info
  File build\pointingserver\win32\locales\gu.pak
  File build\pointingserver\win32\locales\gu.pak.info
  File build\pointingserver\win32\locales\he.pak
  File build\pointingserver\win32\locales\he.pak.info
  File build\pointingserver\win32\locales\hi.pak
  File build\pointingserver\win32\locales\hi.pak.info
  File build\pointingserver\win32\locales\hr.pak
  File build\pointingserver\win32\locales\hr.pak.info
  File build\pointingserver\win32\locales\hu.pak
  File build\pointingserver\win32\locales\hu.pak.info
  File build\pointingserver\win32\locales\id.pak
  File build\pointingserver\win32\locales\id.pak.info
  File build\pointingserver\win32\locales\it.pak
  File build\pointingserver\win32\locales\it.pak.info
  File build\pointingserver\win32\locales\ja.pak
  File build\pointingserver\win32\locales\ja.pak.info
  File build\pointingserver\win32\locales\kn.pak
  File build\pointingserver\win32\locales\kn.pak.info
  File build\pointingserver\win32\locales\ko.pak
  File build\pointingserver\win32\locales\ko.pak.info
  File build\pointingserver\win32\locales\lt.pak
  File build\pointingserver\win32\locales\lt.pak.info
  File build\pointingserver\win32\locales\lv.pak
  File build\pointingserver\win32\locales\lv.pak.info
  File build\pointingserver\win32\locales\ml.pak
  File build\pointingserver\win32\locales\ml.pak.info
  File build\pointingserver\win32\locales\mr.pak
  File build\pointingserver\win32\locales\mr.pak.info
  File build\pointingserver\win32\locales\ms.pak
  File build\pointingserver\win32\locales\ms.pak.info
  File build\pointingserver\win32\locales\nb.pak
  File build\pointingserver\win32\locales\nb.pak.info
  File build\pointingserver\win32\locales\nl.pak
  File build\pointingserver\win32\locales\nl.pak.info
  File build\pointingserver\win32\locales\pl.pak
  File build\pointingserver\win32\locales\pl.pak.info
  File build\pointingserver\win32\locales\pt-BR.pak
  File build\pointingserver\win32\locales\pt-BR.pak.info
  File build\pointingserver\win32\locales\pt-PT.pak
  File build\pointingserver\win32\locales\pt-PT.pak.info
  File build\pointingserver\win32\locales\ro.pak
  File build\pointingserver\win32\locales\ro.pak.info
  File build\pointingserver\win32\locales\ru.pak
  File build\pointingserver\win32\locales\ru.pak.info
  File build\pointingserver\win32\locales\sk.pak
  File build\pointingserver\win32\locales\sk.pak.info
  File build\pointingserver\win32\locales\sl.pak
  File build\pointingserver\win32\locales\sl.pak.info
  File build\pointingserver\win32\locales\sr.pak
  File build\pointingserver\win32\locales\sr.pak.info
  File build\pointingserver\win32\locales\sv.pak
  File build\pointingserver\win32\locales\sv.pak.info
  File build\pointingserver\win32\locales\sw.pak
  File build\pointingserver\win32\locales\sw.pak.info
  File build\pointingserver\win32\locales\ta.pak
  File build\pointingserver\win32\locales\ta.pak.info
  File build\pointingserver\win32\locales\te.pak
  File build\pointingserver\win32\locales\te.pak.info
  File build\pointingserver\win32\locales\th.pak
  File build\pointingserver\win32\locales\th.pak.info
  File build\pointingserver\win32\locales\tr.pak
  File build\pointingserver\win32\locales\tr.pak.info
  File build\pointingserver\win32\locales\uk.pak
  File build\pointingserver\win32\locales\uk.pak.info
  File build\pointingserver\win32\locales\vi.pak
  File build\pointingserver\win32\locales\vi.pak.info
  File build\pointingserver\win32\locales\zh-CN.pak
  File build\pointingserver\win32\locales\zh-CN.pak.info
  File build\pointingserver\win32\locales\zh-TW.pak
  File build\pointingserver\win32\locales\zh-TW.pak.info
  IfFileExists $INSTDIR\pnacl\*.* +4 0
  CreateDirectory $INSTDIR\pnacl
  IfErrors 0 +2
  Abort "Can't install to $INSTDIR\pnacl" 
  SetOutPath $INSTDIR\pnacl
  File build\pointingserver\win32\pnacl\pnacl_public_pnacl_json
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_crtbegin_for_eh_o
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_crtbegin_o
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_crtend_o
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_ld_nexe
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_libcrt_platform_a
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_libgcc_a
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_libpnacl_irt_shim_dummy_a
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_pnacl_llc_nexe
  File build\pointingserver\win32\pnacl\pnacl_public_x86_32_pnacl_sz_nexe
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_crtbegin_for_eh_o
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_crtbegin_o
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_crtend_o
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_ld_nexe
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_libcrt_platform_a
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_libgcc_a
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_libpnacl_irt_shim_a
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_libpnacl_irt_shim_dummy_a
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_pnacl_llc_nexe
  File build\pointingserver\win32\pnacl\pnacl_public_x86_64_pnacl_sz_nexe
  IfFileExists $INSTDIR\swiftshader\*.* +4 0
  CreateDirectory $INSTDIR\swiftshader
  IfErrors 0 +2
  Abort "Can't install to $INSTDIR\swiftshader" 
  SetOutPath $INSTDIR\swiftshader
  File build\pointingserver\win64\swiftshader\libEGL.dll
  File build\pointingserver\win64\swiftshader\libGLESv2.dll
  FileOpen $9 "$INSTDIR\error.log" w
  FileWrite $9 "# ERROR LOG\n"
  FileClose $9
  AccessControl::GrantOnFile "$INSTDIR\error.log" "(BU)" "GenericRead + GenericWrite"
  WriteUninstaller $INSTDIR\uninstall.exe
  WriteRegStr HKCU "${ARP}" "DisplayName" "PointingServer (Current user)"
  WriteRegStr HKCU "${ARP}" "DisplayIcon" "$INSTDIR\PointingServer.exe"
  WriteRegStr HKCU "${ARP}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "${ARP}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "${ARP}" "Publisher" "Loki - Inria Lille"
  WriteRegStr HKCU "${ARP}" "DisplayVersion" "${APP_VERSION_LONG}"
  WriteRegStr HKCU "${ARP}" "VersionMajor" ${APP_VERSION_MAJOR}
  WriteRegStr HKCU "${ARP}" "VersionMinor" ${APP_VERSION_MINOR}
  WriteRegStr HKCU "${ARP}" "NoModify" 1
  WriteRegStr HKCU "${ARP}" "NoRepair" 1
  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" "$0"
  WriteRegDWORD HKCU "${ARP}" "EstimatedSize" $0
  WriteRegStr HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Run" "PointingServer" "$INSTDIR\PointingServer.exe"
  IfSilent 0 +3
  Exec '"$INSTDIR\PointingServer.exe"'
  Sleep 2000
SectionEnd

Function un.onInit
	!insertmacro MULTIUSER_UNINIT
	Sleep 2000
FunctionEnd

Section Uninstall
  Delete $INSTDIR\chromedriver.exe
  Delete $INSTDIR\chromedriver.exe
  Delete $INSTDIR\credits.html
  Delete $INSTDIR\credits.html
  Delete $INSTDIR\d3dcompiler_47.dll
  Delete $INSTDIR\d3dcompiler_47.dll
  Delete $INSTDIR\ffmpeg.dll
  Delete $INSTDIR\ffmpeg.dll
  Delete $INSTDIR\icudtl.dat
  Delete $INSTDIR\icudtl.dat
  Delete $INSTDIR\libEGL.dll
  Delete $INSTDIR\libEGL.dll
  Delete $INSTDIR\libGLESv2.dll
  Delete $INSTDIR\libGLESv2.dll
  Delete $INSTDIR\nacl_irt_x86_64.nexe
  Delete $INSTDIR\nacl_irt_x86_64.nexe
  Delete $INSTDIR\natives_blob.bin
  Delete $INSTDIR\natives_blob.bin
  Delete $INSTDIR\node.dll
  Delete $INSTDIR\node.dll
  Delete $INSTDIR\notification_helper.exe
  Delete $INSTDIR\notification_helper.exe
  Delete $INSTDIR\nw.dll
  Delete $INSTDIR\nw.dll
  Delete $INSTDIR\nwjc.exe
  Delete $INSTDIR\nwjc.exe
  Delete $INSTDIR\nw_100_percent.pak
  Delete $INSTDIR\nw_100_percent.pak
  Delete $INSTDIR\nw_200_percent.pak
  Delete $INSTDIR\nw_200_percent.pak
  Delete $INSTDIR\nw_elf.dll
  Delete $INSTDIR\nw_elf.dll
  Delete $INSTDIR\payload.exe
  Delete $INSTDIR\payload.exe
  Delete $INSTDIR\pointingserver.exe
  Delete $INSTDIR\pointingserver.exe
  Delete $INSTDIR\resources.pak
  Delete $INSTDIR\resources.pak
  Delete $INSTDIR\v8_context_snapshot.bin
  Delete $INSTDIR\v8_context_snapshot.bin
  Delete $INSTDIR\locales\am.pak
  Delete $INSTDIR\locales\am.pak.info
  Delete $INSTDIR\locales\ar.pak
  Delete $INSTDIR\locales\ar.pak.info
  Delete $INSTDIR\locales\bg.pak
  Delete $INSTDIR\locales\bg.pak.info
  Delete $INSTDIR\locales\bn.pak
  Delete $INSTDIR\locales\bn.pak.info
  Delete $INSTDIR\locales\ca.pak
  Delete $INSTDIR\locales\ca.pak.info
  Delete $INSTDIR\locales\cs.pak
  Delete $INSTDIR\locales\cs.pak.info
  Delete $INSTDIR\locales\da.pak
  Delete $INSTDIR\locales\da.pak.info
  Delete $INSTDIR\locales\de.pak
  Delete $INSTDIR\locales\de.pak.info
  Delete $INSTDIR\locales\el.pak
  Delete $INSTDIR\locales\el.pak.info
  Delete $INSTDIR\locales\en-GB.pak
  Delete $INSTDIR\locales\en-GB.pak.info
  Delete $INSTDIR\locales\en-US.pak
  Delete $INSTDIR\locales\en-US.pak.info
  Delete $INSTDIR\locales\es-419.pak
  Delete $INSTDIR\locales\es-419.pak.info
  Delete $INSTDIR\locales\es.pak
  Delete $INSTDIR\locales\es.pak.info
  Delete $INSTDIR\locales\et.pak
  Delete $INSTDIR\locales\et.pak.info
  Delete $INSTDIR\locales\fa.pak
  Delete $INSTDIR\locales\fa.pak.info
  Delete $INSTDIR\locales\fi.pak
  Delete $INSTDIR\locales\fi.pak.info
  Delete $INSTDIR\locales\fil.pak
  Delete $INSTDIR\locales\fil.pak.info
  Delete $INSTDIR\locales\fr.pak
  Delete $INSTDIR\locales\fr.pak.info
  Delete $INSTDIR\locales\gu.pak
  Delete $INSTDIR\locales\gu.pak.info
  Delete $INSTDIR\locales\he.pak
  Delete $INSTDIR\locales\he.pak.info
  Delete $INSTDIR\locales\hi.pak
  Delete $INSTDIR\locales\hi.pak.info
  Delete $INSTDIR\locales\hr.pak
  Delete $INSTDIR\locales\hr.pak.info
  Delete $INSTDIR\locales\hu.pak
  Delete $INSTDIR\locales\hu.pak.info
  Delete $INSTDIR\locales\id.pak
  Delete $INSTDIR\locales\id.pak.info
  Delete $INSTDIR\locales\it.pak
  Delete $INSTDIR\locales\it.pak.info
  Delete $INSTDIR\locales\ja.pak
  Delete $INSTDIR\locales\ja.pak.info
  Delete $INSTDIR\locales\kn.pak
  Delete $INSTDIR\locales\kn.pak.info
  Delete $INSTDIR\locales\ko.pak
  Delete $INSTDIR\locales\ko.pak.info
  Delete $INSTDIR\locales\lt.pak
  Delete $INSTDIR\locales\lt.pak.info
  Delete $INSTDIR\locales\lv.pak
  Delete $INSTDIR\locales\lv.pak.info
  Delete $INSTDIR\locales\ml.pak
  Delete $INSTDIR\locales\ml.pak.info
  Delete $INSTDIR\locales\mr.pak
  Delete $INSTDIR\locales\mr.pak.info
  Delete $INSTDIR\locales\ms.pak
  Delete $INSTDIR\locales\ms.pak.info
  Delete $INSTDIR\locales\nb.pak
  Delete $INSTDIR\locales\nb.pak.info
  Delete $INSTDIR\locales\nl.pak
  Delete $INSTDIR\locales\nl.pak.info
  Delete $INSTDIR\locales\pl.pak
  Delete $INSTDIR\locales\pl.pak.info
  Delete $INSTDIR\locales\pt-BR.pak
  Delete $INSTDIR\locales\pt-BR.pak.info
  Delete $INSTDIR\locales\pt-PT.pak
  Delete $INSTDIR\locales\pt-PT.pak.info
  Delete $INSTDIR\locales\ro.pak
  Delete $INSTDIR\locales\ro.pak.info
  Delete $INSTDIR\locales\ru.pak
  Delete $INSTDIR\locales\ru.pak.info
  Delete $INSTDIR\locales\sk.pak
  Delete $INSTDIR\locales\sk.pak.info
  Delete $INSTDIR\locales\sl.pak
  Delete $INSTDIR\locales\sl.pak.info
  Delete $INSTDIR\locales\sr.pak
  Delete $INSTDIR\locales\sr.pak.info
  Delete $INSTDIR\locales\sv.pak
  Delete $INSTDIR\locales\sv.pak.info
  Delete $INSTDIR\locales\sw.pak
  Delete $INSTDIR\locales\sw.pak.info
  Delete $INSTDIR\locales\ta.pak
  Delete $INSTDIR\locales\ta.pak.info
  Delete $INSTDIR\locales\te.pak
  Delete $INSTDIR\locales\te.pak.info
  Delete $INSTDIR\locales\th.pak
  Delete $INSTDIR\locales\th.pak.info
  Delete $INSTDIR\locales\tr.pak
  Delete $INSTDIR\locales\tr.pak.info
  Delete $INSTDIR\locales\uk.pak
  Delete $INSTDIR\locales\uk.pak.info
  Delete $INSTDIR\locales\vi.pak
  Delete $INSTDIR\locales\vi.pak.info
  Delete $INSTDIR\locales\zh-CN.pak
  Delete $INSTDIR\locales\zh-CN.pak.info
  Delete $INSTDIR\locales\zh-TW.pak
  Delete $INSTDIR\locales\zh-TW.pak.info
  Delete $INSTDIR\pnacl\pnacl_public_pnacl_json
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_crtbegin_for_eh_o
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_crtbegin_o
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_crtend_o
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_ld_nexe
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_libcrt_platform_a
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_libgcc_a
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_libpnacl_irt_shim_dummy_a
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_pnacl_llc_nexe
  Delete $INSTDIR\pnacl\pnacl_public_x86_32_pnacl_sz_nexe
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_crtbegin_for_eh_o
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_crtbegin_o
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_crtend_o
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_ld_nexe
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_libcrt_platform_a
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_libgcc_a
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_libpnacl_irt_shim_a
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_libpnacl_irt_shim_dummy_a
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_pnacl_llc_nexe
  Delete $INSTDIR\pnacl\pnacl_public_x86_64_pnacl_sz_nexe
  Delete $INSTDIR\swiftshader\libEGL.dll
  Delete $INSTDIR\swiftshader\libGLESv2.dll
  RMDir $INSTDIR

  DeleteRegValue HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\StartupApproved\\Run" "PointingServer"
  DeleteRegValue HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Run" "PointingServer"
  DeleteRegKey HKCU "${REG_DATA}"
  DeleteRegKey /ifempty HKCU "Software\\loki.lille.inria.fr"
  DeleteRegKey HKCU "${ARP}"
SectionEnd
