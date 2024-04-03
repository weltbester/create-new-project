#!/usr/bin/env bash
# This script creates a new project folder, depending on the programming language in use.

# Get projet data from user
echo "This script creates a new programming project."
read -p "Enter new project name (snake_case_style): " project_name
read -p "Enter programming language suffix, e.g.: c, cpp, sh, py: " programming_suffix

# Delete folder if already existent
if [ -d "$programming_suffix/$project_name" ]; then
    rm -Rf $programming_suffix/$project_name;
fi

# Create project
project_path="$programming_suffix/$project_name" # e.g: cpp/project_name
printf "\n\nCreate project folder '${project_name}' in '${project_path}'.\n\n"
mkdir $project_path
cd $project_path
filename="${project_name}.${programming_suffix}"

printf "Load/Create templates for a "
# Load relevant templates
if [[ "$programming_suffix" == "py" ]]; then 
    cp -r ../../gitvorlagen/python-vorlage/* .
    mv main.py $filename
    printf "Python"
elif [[ "$programming_suffix" == "sh" ]]; then 
    cp ../../gitvorlagen/shell_template.sh .
    mv shell_template.sh $filename
    printf "Shell"
elif [[ "$programming_suffix" == "c" ]]; then 
    cp -r ../../gitvorlagen/c_template/* .
    mv src/main.c src/$filename
    printf "C"
elif [[ "$programming_suffix" == "cpp" ]]; then
    cp -r ../../gitvorlagen/cpp_template/* .
    mv src/main.cpp src/$filename
    printf "C++"
fi
printf " program.\n\n"

# Make file executable
 chmod +x $filename

# Initialze git repo
printf "Initialize git for repository '${project_name}'\n\n"
pwd
git init

if [[ "$programming_suffix" == "py" || "$programming_suffix" == "sh"  ]]; then
    echo "# $filename" > README.md
fi

git add .
git commit -m "Initial commit"
# git remote add origin https://gitlab.devops.telekom.de/georg.pohl/$filename.git
# git remote add origin https://gitlab.devops.telekom.de/ip-core/$filename.git
# git push -u origin main
git status

# Startup Emacs
# printf "\n\nOpen '${filename}' in emacs\n\n" 
# if [[ "$programming_suffix" == "c" || "$programming_suffix" == "cpp"  ]]; then
#     cd $project_path/src # Jump into 'src' folder to open code file
#     pwd
# else
#     cd $project_path
#     pwd
# fi

# pwd
# printf "${filename}\n"
# emacs $filename &
