set -x
manual (){
clear
chmod +x $0
echo "\n\t#############################################################################################################################################"
echo "\n\t\t                                                     sub_userlist (Manual)"
echo "\n\t#############################################################################################################################################"
echo "\n"
  read -p "        Enter filename to search into : " file
if [ ! -d final ]; then
   mkdir final
fi
origin=`cat $file|wc -l`
echo "\n\tFilename : $file \tNo. of lines in file : $origin\n"
sleep 2
read -p "        How many subjects are there : " b
z=`du -sh final|awk '{print $1}'`
while [ $b -gt 0 ];
do
     read -p "        Enter subject code to search for : " search
     echo "\n\tProcessing ..."
     sleep 2
     if [ ! $z -eq 4 ]; then
        wc final/*.csv|grep "$search" > /dev/null
           if [ $? -eq 0 ]; then
              echo "        users_$search.csv already exists in 'final' Directory."
              b=`expr $b - 1`
              sleep 5
           elif [ ! $? -eq 0 ]; then
                grep -w $search "$file" >> final/users_$search\.csv
                echo "        users_$search.csv successfully generated."
                sleep 2
                b=`expr $b - 1`
           fi
     else
           grep -w $search "$file" >> final/users_$search\.csv
           echo "        users_$search.csv successfully generated."
           sleep 2
           b=`expr $b - 1`

     fi

done
sleep 5
clear
echo "\n############ -->>> Userlists Present in 'final' Directory <<<-- ###########\n"
echo   "---------------------------------------------------------------------------"
echo "\tSubject Userlist      NO of lines"
echo   "---------------------------------------------------------------------------\n"
wc final/*.csv|awk '{printf "\t%s %10s\n",$4,$1}' > ../tmp01
sed -i 's/final\///g' ../tmp01
sed -i '/total/d' ../tmp01
cat ../tmp01
echo "\n###########################################################################\n\n"
rm -rf ../tmp01
}

auto (){
clear
chmod +x $0
echo "\n\t#############################################################################################################################################"
echo "\n\t\t                                                     sub_userlist (automatic)"
echo "\n\t#############################################################################################################################################"
echo "\n"
  read -p "        Enter filename to search into : " file
if [ ! -d final ]; then
   mkdir final
fi
origin=`cat $file|wc -l`
echo "\n\tFilename : $file \tNo. of lines in file : $origin"
sleep 2

echo "\n"
  read -p "        Enter filename which contains subjects codes : " sub_file
echo "\n        Processing ..."
sleep 2

b=`cat $sub_file|wc -l`

echo "\n"
z=`du -s final|awk '{print $1}'`
     
   for i in `cat $sub_file`
   do
      if [ ! $z -eq 4 ]; then   
        wc final/*.csv|grep "$i" > /dev/null
        if [ $? -eq 0 ]; then
           echo "        users_$i.csv already exists in 'final' Directory."
           sleep 2
        elif [ ! $? -eq 0 ]; then
           grep -w $i "$file" >> final/users_$i\.csv
           echo "        users_$i.csv successfully generated."
           sleep 2
           #b=`expr $b - 1`
        fi
      else
          j=`wc final/*.csv|grep "$i" > /dev/null`
          if [ $j -eq 0 ]; then
             echo "        users_$i.csv already exists in 'final' Directory."
             sleep 2
          else
             grep -w $i "$file" >> final/users_$i\.csv
             echo "        users_$i.csv successfully generated."
             sleep 2
            #b=`expr $b - 1`
          fi 
      fi
  done
sleep 5
clear
echo "\n############ -->>> Userlists Present in 'final' Directory <<<-- ###########\n"
echo   "---------------------------------------------------------------------------"
echo "\tSubject Userlist      NO of lines"
echo   "---------------------------------------------------------------------------\n"
wc final/*.csv|awk '{printf "\t%s %10s\n",$4,$1}' > ../tmp01
sed -i 's/final\///g' ../tmp01
sed -i '/total/d' ../tmp01
cat ../tmp01
echo "\n###########################################################################\n\n"
rm -rf ../tmp01
}

response (){
   read -p "        Do you want to Exit : [ y | n ] : " f 
   if [ $f = y -o $f = Y -o $f = YES -o $f = yes -o $f = Yes ]; then
      echo "\n\tExiting .............bye\n"
      exit
   else 
      continue
   fi
}

print_menu (){
clear
echo "\n\t!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i\n"
echo "\n\t                                 Userlist Generation\n"
echo "\n\t!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i\n"
echo "\n\t1. Manual mode : You can generate userlists as per your subject count. "
echo "\n\t2. Automatic mode : You can generate userlists through file containing subject codes."
echo "\n\t3. Exit\n"
echo "\n\t!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i!#!#!#i#i#i\n"
echo "\n\tNote : Userlists will be kept in final Directory in PWD\n"
sleep 5
read -p "        Enter your choice : " ch
sleep 1
case $ch in
1)manual
   response 
   ;;
2)auto
   response
   ;;
3)echo "\n\tExiting .............bye\n"
   exit
   ;;
*)echo "\n\tYou have entered invalid choice."  
   response
   ;;
esac
}
 
while [ 0 ]; 
      do
          print_menu
          response
      done
set +x
