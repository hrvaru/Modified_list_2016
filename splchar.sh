response (){
   read -p "        Do you want to keep this line : [ y | n ] : " f 
   if [ $f = y -o $f = Y -o $f = YES -o $f = yes -o $f = Yes ]; then
      echo "$i" >> file1.csv
   fi
}

   clear
   echo "\t---------------------------------------------------------------------------------------------------------------------------------"
   echo "\n\t                                 Removal of Special character "
   echo "\t---------------------------------------------------------------------------------------------------------------------------------"
   read -p "        Enter the filename : " file
   echo "\n\tPlease wait while your file being processed...\n"
   echo "\n\t."
   sleep 1
   echo "\n\t.."
   sleep 1
   echo "\n\t..."
   sleep 1
   for i in `cat $file`
   do
      a=`echo "$i"|grep "#NAME?"`
      if [ ! $? -eq 0 ]; then
         echo "$i" >> file1.csv
      else
         clear
         echo "\t---------------------------------------------------------------------------------------------------------------------------------"
         echo "\n\t                                 #NAME? Occurance Detected "
         echo "\t---------------------------------------------------------------------------------------------------------------------------------"
         
         echo "\t$i\n"
         read -p "        Do you want to keep this line : [ y | n ] : " f
         if [ $f = y ]; then
            echo "$i" >> file1.csv
         fi

      fi
   done 
   
   cat file1.csv |sed 's/[][\`.@":}{)#(;!]//g'|sed "s/\\// /g"|sed "s/-//g"|sed "s/'//g"|sed "s/_/ /" > $file\_out 

   echo "\n\tDone\n\n"
   rm -rf file1.csv
