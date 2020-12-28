rm -f cscope*
currentPath=$(pwd )
echo $currentPath
find $currentPath  -name "*.h" -type f -o -name "*.c" -type f -o\
                   -name "*.cc" -type f -o -name "*.cpp" -type f > filepath.txt
# if necessary use vim filter src file
# vimreg: g/^\s*[a-zA-Z0-9._\-/]*_hf[a-zA-Z0-9._\-/]*$/d

echo "running cscope"
cscope -bkq -i filepath.txt