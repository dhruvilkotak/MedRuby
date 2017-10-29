<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>MedRuby | Registration</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
     <!-- Theme style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/AdminLTE.min.css">
    <!-- iCheck -->
    <script src="<%=request.getContextPath()%>/plugins/datepicker/bootstrap-datepicker.js"></script>
   
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/iCheck/square/blue.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datepicker/datepicker.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body class="hold-transition register-page">
    <div class="register-box">
      <div class="register-logo">
        <b>Med</b>Ruby</a>
      </div>
<%
												 if ((request.getParameter("failed") + "get").contains("1")) {
											%>
											<div class="alert alert-dismissable alert-danger">
												<i class="fa fa-fw fa-check"></i>&nbsp; Your Password and Confirm Password doesn't Match. Try Again.
												<button type="button" class="close" data-dismiss="alert"
													hidden="true">&times;</button>
											</div>
											<%
												}
												 else if ((request.getParameter("failed") + "get").contains("2")) {
														%>
														<div class="alert alert-dismissable alert-danger">
															<i class="fa fa-fw fa-check"></i>&nbsp; Something Went Wrong, Try Again.
															<button type="button" class="close" data-dismiss="alert"
																hidden="true">&times;</button>
														</div>
														<%
															}
													%>
											
      <div class="register-box-body">
        <p class="login-box-msg">Register a new membership</p>
      <form method="post" action="<%=request.getContextPath()%>/controller">
	<input type="hidden" value="doRegister" name="actionCode" />
		 <div class="form-group has-feedback">
            <input type="text" class="form-control" placeholder="First name" name="firstName" id="firstName">
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type="text" class="form-control" placeholder="Last name" name="lastName" id="lastName">
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type="email" class="form-control" placeholder="Email" name="userid" id="userid">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type="password" class="form-control" placeholder="Password" name="password" id="password">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type="password" class="form-control" placeholder="Retype password" name="rpass" id="rpass">
            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
          </div>
           <div class="row">
                    <div class="col-xs-7"> 
                     <div class="input-group">
						<div class="input-group-addon" >
						 <i class="fa fa-calendar"></i>
  						</div>
						<input class="datepicker" type="text"  placeholder="Birth Date" name="DOB" id="DOB">
  					  </div>
                    </div>
                    	<div class="col-xs-5"> 
                        		  <select class="form-control" name="Gender" id="Gender">
                        		  <option value="" disabled selected>Gender</option>
                      			    <option value="Male">Male</option>
			                        <option value="Female">Female</option>
			             
			                       </select>
		  					</div>
                 </div> <br>
          <div class="row">
                    <div class="col-xs-12"> 
                         <textarea class="form-control" rows="1" placeholder="Address" name="Address" id="Address"></textarea>
                    </div>
             </div>       <br>
              <div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-phone"></i>
			                  </div>
			                 <input type="text" class="form-control" data-inputmask="&quot;mask&quot;: &quot;(999) 999-9999&quot;" name="ContactNumber" id="ContactNumber" data-mask="">
                          
                      </div>
                    
             <br>   
          <div class="row">
            <div class="col-xs-8">
              <div class="checkbox icheck">
                <label>
                  <input type="checkbox" required> I agree to the <a href="#">terms</a>
                </label>
              </div>
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
            </div><!-- /.col -->
          </div>
        </form>

    

        <a href="<%=request.getContextPath()%>/wp-content/portal/login.jsp" class="text-center">I already have a membership</a>
      </div><!-- /.form-box -->
    </div><!-- /.register-box -->
   <!-- jQuery 2.1.4 -->
    <script src="<%=request.getContextPath()%>/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="<%=request.getContextPath()%>/plugins/iCheck/icheck.min.js"></script>
  	  <script src="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- datepicker -->
    <script src="<%=request.getContextPath()%>/plugins/datepicker/bootstrap-datepicker.js"></script>
    <script>
    $(function(){
		 $('.datepicker').datepicker();
		});
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
      
    </script>
  </body>
</html>
