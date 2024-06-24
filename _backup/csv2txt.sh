echo "Files with 80chars+ wide :" > "wideFiles.txt"

find . -name "*.csv" -print0 | while read -d $'\0' file
do
  # print current file
  echo "${file}"

  # variables
  filepath="${file%/*}"
  filename="${file##*/}"
  newFile="${filepath}/${filename%.*}.txt"

  # Write a header for mentioning a table (title can be added later)
  #echo "Table :" > "${newFile}"
  #echo "" >> "${newFile}"

  # Execute pandoc
  #`pandoc -f csv "${file}" -t gfm >> "${newFile}"`
  `pandoc -f csv "${file}" -t gfm -o "${newFile}"`
  
  if ! [[ -f "${newFile}" ]]; then
    echo "ERROR !!!!!!!!!!!!!!!!! ${file}"
  fi
  
  # Check if maximum width
  charWidth=$(wc -L ${newFile})
  charWidth="${charWidth%% *}"
  if [ "${charWidth}" -gt 80 ]; then
    echo "${file} : ${charWidth} " >> "wideFiles.txt"
  fi
  
done


