menu() {
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
echo "Address Book"
echo "--------------------------------------------------------"
echo "1.Create / Select Address Book"
echo "2.View Address Book"
echo "3.Insert Record"
echo "4.Search Record"
echo "5.Delete Record"
echo "6.Modify Record"
echo "7.Exit"
echo "Choice: "
read ch
echo "--------------------------------------------------------"
}

createbook(){
echo "Enter File Name: "
read fname
touch $fname.txt
}

viewbook(){
echo -e "Id\tName\tMobile No.\tAddress"
echo "--------------------------------------------------------"
cat $fname.txt
}

insert(){
echo "Enter Your ID: "
read id
if grep -q $id $fname.txt
then
	echo "ID already Exists Use Another One"
	echo "Enter Your ID: "
	read id
fi
echo "Enter Your Name: "
read name
echo "Enter Your Mobile No."
read mob
if (( ${#mob} != 10 ))
then
	echo "Kindly Enter a 10 digit Mobile Number"
	echo "Enter Your Mobile No."
	read mob
fi
echo "Enter Your Address: "
read address
echo -e "$id\t$name\t$mob\t$address" >>"$fname.txt"
echo "Record Added Successfully"
}

search(){
echo "Enter the ID: "
read ip
if grep -q $ip $fname.txt
then
	echo -e "Id\tName\tMobile No.\tAddress"
	echo "--------------------------------------------------------"
	grep -i $ip $fname.txt
else
	echo "Record Not Found"
fi
}

delete(){
echo "Enter the ID: "
read ip
if grep -q $ip $fname.txt
then
	sed -i "/^$ip/d" "$fname.txt"
echo "Record Deleted Successfully"
else
	echo "Record Not Found"
fi
}

modify() {
    echo "Enter the ID: "
    read ip
    if grep -q ^$ip $fname.txt; then
        echo "Select the field to modify:"
        echo "1) ID"
        echo "2) Name"
        echo "3) Mobile No."
        echo "4) Address"
        read field_choice

        case $field_choice in
            1) echo "Enter Old ID: "
               read old_id
               echo "Enter New ID: "
               read new_id
		if grep -q $new_id $fname.txt
			then
				echo "ID already Exists Use Another One"
				echo "Enter Your ID: "
				read new_id
		fi
               sed -i "/^$old_id\t/ s/^[^\t]*\t/$new_id\t/" $fname.txt
               echo "ID Modified Successfully" ;;
            2) echo "Enter Old Name: "
               read old_name
               echo "Enter New Name: "
               read new_name
               sed -i "/^$ip\t/ s/\t$old_name\t/\t$new_name\t/" $fname.txt
               echo "Name Modified Successfully" ;;
            3) echo "Enter Old Mobile No.: "
               read old_mob
               echo "Enter New Mobile No.: "
               read new_mob
		if (( ${#new_mob} != 10 ))
			then
				echo "Kindly Enter a 10 digit Mobile Number"
				echo "Enter Your Mobile No."
				read new_mob
		fi
               sed -i "/^$ip\t/ s/\t$old_mob\t/\t$new_mob\t/" $fname.txt
               echo "Mobile No. Modified Successfully" ;;
            4) echo "Enter Old Address: "
               read old_add
               echo "Enter New Address: "
               read new_add
               sed -i "/^$ip\t/ s/\t$old_add$/\t$new_add/" $fname.txt
               echo "Address Modified Successfully" ;;
            *) echo "Invalid Choice" ;;
        esac
    else
        echo "Record Not Found"
    fi
}



alt() {
case $ch in
1)
createbook
;;
2)
viewbook
;;
3)
insert
;;
4)
search
;;
5)
delete
;;
6)
modify
;;
7)
echo "Exiting Address Book";
Exit=True
echo "--------------------------------------------------------"
;;
*)
echo "Invalid Choice"
;;
esac
}

Exit=False
while [[ $Exit == False ]];
do
	menu
	alt
done
