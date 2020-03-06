json.extract! user, :id, :uid, :provider, :email, :name

# if user.patient?
#   json.extract! user, :patient_status, :birth_date
#   json.doctor_name (( user.doctor.name rescue '' ))
#   json.doctor_surname (( user.doctor.surname rescue '' ))
# end
