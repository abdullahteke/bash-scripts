#!/bin/bash

source artifactory.properties

################################################################################
# Help                                                                         #
################################################################################

usage()
{
   # Display Help
   echo "Syntax: ./get-directory-list-from-artifactory [-e <environment>] | [-h]"
   echo "options:"
   echo "-e     Enviroment Name (FONKSIYONEL|REGRESYON|BUGFIX)."
   echo "-h     Print this Help."

   exit 1;
}



# Get the options
while getopts ":p:e:h:" option; do
   case $option in
      h) # display Help
         usage
         exit;;
      e) e=${OPTARG}
        ;;
      *)
        usage
        ;;
   esac
done

shift $((OPTIND-1))

if [ -z "${e}" ]; then
    usage
fi

curl -k -u $username:$password "$url/api/storage/$repository/$e"