for n in $(find $(pwd) -maxdepth 1 -type d -not -path '*/\.*' | sort)
do
   echo "Working on $n file name now"  
   cd $n
   docker-compose up -d
done