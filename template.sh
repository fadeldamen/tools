#!/bin/bash

####################
# Developed by Luiz Felipe
# GitHub: https://github.com/Silva97
#
# Distributed under the MIT License.
####################

tdir=~/.templates
editor1="nano"
editor2="vim"

if [[ ! -d "${tdir}" ]]; then
    mkdir ${tdir}
fi

if [[ $# -eq 0 ]]; then
    echo    "Developed by Luiz Felipe"
    echo -e "GitHub: https://github.com/Silva97\n"

    echo -e "Use: ./template.sh template_name\n"
    echo -e "template_name - Is the name of the template.\n"
    echo -e "For create or edit a template you must add a '+' in the start of the name."
    echo -e "    Example: ./template.sh +c_main\n"
    echo -e "For delete a template just add '-' in the start of the name."
    echo -e "    Example: ./template.sh -old_c_template\n"
    echo    "For list all created templates, just put '@' has the template_name."
    echo -e "    Example: ./template.sh @\n\n"

    echo    "All templates can have a description for help you remember for what it's serves."
    echo    "Just add in the first line the character ':' and a description."
    echo -e "Example:\n"
    echo    ":C main template"
    echo -e "#include <stdio.h>\n"
    echo    "int main(){"
    echo    "    return 0;"
    echo -e "}\n"
    echo    "This description is shown in the listing of the templates, but not when getting the content."
    exit
fi


if [[ "${1}" == "@" ]]; then
    # List templates

    for i in $(ls "$tdir/"); do
        first=$(head -n 1 $tdir/$i)

        if [[ "${first:0:1}" == ":" ]]; then
            echo -e "${i}\t\t- ${first:1}"
        else
            echo "${i}"
        fi
    done
elif [[ "${1:0:1}" == "+" ]]; then
    # Create or edit a template
    $editor1 "${tdir}/${1:1}" 2>/dev/null || (
        $editor2 "${tdir}/${1:1}"
    )
elif [[ "${1:0:1}" == "-" ]]; then
    # Delete a template
    rm "${tdir}/${1:1}" 2>/dev/null || (
        echo "Template '${1:1}' not exist."
        echo "For see help, just run without a parameter."
        exit
    )

    echo "Deletation done."
else
    fpath="${tdir}/${1}"
    if [[ ! -f "${fpath}" ]]; then
        echo "Template '${1}' not exist."
        echo "For create, run: ./template.sh +${1}"
        exit
    fi

    first=$(head -n 1 ${fpath})

    if [[ "${first:0:1}" == ":" ]]; then
        tail -n +2 "${fpath}"
    else
        cat "${fpath}"
    fi
fi