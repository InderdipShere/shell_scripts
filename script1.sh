fileName="data_temp.dat"
read -p "Enter name:" name
grep -q $name $fileName
if grep -q $name $fileName; then
     employmentType=$(grep $name $fileName | cut -d, -f3)
     echo "EmploymentType", $employmentType
     emp_name=$(grep $name $fileName | cut -d, -f2)
     echo "Name", $emp_name
     emp_id=$(grep $name $fileName | cut -d, -f1)
     echo "Emp ID", $emp_id
     echo $name "is" $employmentType "staff"
     if [ $employmentType == "partTime" ] ; then
          echo "Enter hourly pay:"
          read hourlyPay
          #calculations for monthly salary(which I have not done)
          sed -i "s/^$emp_id.*$/&,$hourlyPay/g" $fileName
     elif [ $employmentType == "fullTime" ]; then
          echo "Enter monthly salary:"
          read monthlySalary
     fi
else
    echo "No record found"
fi

read -p "Press[Enter Key] to Contiune.." readEnterKey
