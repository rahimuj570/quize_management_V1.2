let changePassword = (url_loc)=>{
	  let password = prompt("Enter new password: \n[Must be greather than 3 charecter and less then 21 character]", "");
	  if(password==null || password=='' || password.length>20 || password.length<4);
	  else{
		  location = url_loc+"/ChangePasswordServlet?p="+password;
	  }
}
let showProfileInfo=(lname,email,id)=>{
	alert('Last Name: '+lname+'\nID: '+id+'\nEmail: '+email)
}