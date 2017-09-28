/*Form validation */
function message() {
        var firstName = document.main_form.firstName.value;
        var lastName = document.main_form.lastName.value;
        var email = document.main_form.email.value;
        var phone = document.main_form.phone.value;
        var companyName = document.main_form.companyName.value;
        var industry = document.main_form.industry.value;
        var message = document.main_form.message.value;
        var alertMessage ="";
        var info = {
            'first name': firstName, 
            'last name': lastName, 
            'email': email, 
            'phone': phone, 
            'company name': companyName,
            'industry': industry, 
            'message': message };

        for (var key in info)
        {
            if(info[key] == "" || info[key] == null || info[key] == NaN)
            {
                //var s = key.toString;
                if(key != 'message'){
                    alertMessage = alertMessage.concat(key, ", ");
                }
                else {
                    alertMessage = alertMessage.concat(key, '.');
                } 

            }

        }
        return alertMessage;
        /*
        if (alertMessage !='')
        {
            alertMessage = "Please input your ".concat(alertMessage);
            alert(alertMessage);
            return false;
        } */
        
        
}

function validateForm() { 
    var alertMsg = "";
    var email = document.main_form.email.value;
    if(email != "") {
        atpos = email.indexOf("@");
        dotpos = email.lastIndexOf(".");
        
        if (atpos < 1 || ( dotpos - atpos < 2 )) 
        {
            alert("Please enter correct email address.")
            document.main_form.email.focus() ;
            return false;
        }
        alertMsg = message(); 
        if(alertMsg != "")
        {
            alertMsg = "Please enter ".concat(alertMsg);
            alert(alertMsg);
            return false;   
        } 
    }   
    else {
        alertMsg = message();
        if(alertMsg != "")
        {
            alertMsg = "Please enter ".concat(alertMsg);
            alert(alertMsg);
            return false;   
        }   
    }
   
}

