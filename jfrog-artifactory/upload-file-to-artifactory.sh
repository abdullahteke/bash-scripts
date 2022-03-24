#!/bin/bash

source artifactory.properties

################################################################################
# Help                                                                         #
################################################################################

usage()
{
   # Display Help
   echo "Syntax: ./upload-file-to-artifactory [-f <file_name> -d <directory_name] | [-h]"
   echo "options:"
   echo "h     Print this Help."
   echo "f     File name that upload artifactory."
   echo "d     Directory path for upload file."
   echo "e     Enviroment Name (FONKSIYONEL|REGRESYON|BUGFIX)."
   echo "h     Print this Help."

   exit 1;
}



# Get the options
while getopts ":p:e:h:f:d:" option; do
   case $option in
      h) # display Help
         usage
         exit;;
      f) f=${OPTARG}
        ;;
      d) d=${OPTARG}
        ;;
      e) e=${OPTARG}
        ;;
      *)
        usage
        ;;
   esac
done

shift $((OPTIND-1))

if [ -z "${f}" ] || [ -z "${d}" ] || [ -z "${e}" ]; then
    usage
fi

md5sum $f | cut -d " " -f 1 > $f".md5"
sha1sum $f | cut -d " " -f 1  > $f".sha1"

md5file=$f".md5"
sha1file=$f".sha1"

curl -k -u $username:$password -X PUT "$url/$repository/$e/$d/$f" -T $f
curl -k -u $username:$password -X PUT "$url/$repository/$e/$d/$md5file" -T $md5file
curl -k -u $username:$password -X PUT "$url/$repository/$e/$d/$sha1file" -T $sha1file