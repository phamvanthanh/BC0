/*Form validation */
function message() {
        var first_name = document.main_form.first_name.value;
        var last_name = document.main_form.last_name.value;
        var email = document.main_form.email.value;
        var phone = document.main_form.phone.value;
        var company = document.main_form.company.value;
    
        var message = document.main_form.message.value;
        var alertMessage ="";
        var info = {
            'first name': first_name, 
            'last name': last_name, 
            'email': email, 
            'phone': phone, 
            'company name': company,            
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
        if(document.getElementById("subscribe").checked) {
            document.getElementById('subscribehidden').disabled = true;
        }

        return alertMessage;
      
        
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

