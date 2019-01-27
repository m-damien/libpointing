# Gery Casiez

# this script helps writing pointingserver_installer.nsi

import os

root = 'build\pointingserver\win64\\'

subdirs = [x[0] for x in os.walk(root)]

delete = ""

for sd in subdirs:
	res = sd.split('\\')
	d = res[len(res)-1]
	if d == "":
		print("""IfFileExists $INSTDIR*.* +4 0
CreateDirectory $INSTDIR
IfErrors 0 +2
Abort "Can't install to $INSTDIR"	
SetOutPath $INSTDIR""")
	else:
		print("""IfFileExists $INSTDIR\%s\*.* +4 0
CreateDirectory $INSTDIR\%s
IfErrors 0 +2
Abort "Can't install to $INSTDIR\%s"	
SetOutPath $INSTDIR\%s"""%(d,d,d,d))
	files = (file for file in os.listdir(sd) 
         if os.path.isfile(os.path.join(sd, file)))
	for name in files:
		if d == "":
			print('File %s%s'%(root,os.path.join(name)))
			delete = delete + "Delete $INSTDIR\\" + os.path.join(name) + "\n"
		else:
	   		print('File %s%s\%s'%(root,d,os.path.join(name)))
	        delete = delete + "Delete $INSTDIR\\" + os.path.join(d, name) + "\n"

print("\n\n\n")
print(delete)