json.items @users do |item|
	json.partial! "students/student", student: item
end