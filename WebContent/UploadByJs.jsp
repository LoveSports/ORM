<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-2.1.3.js">
</script>
    <script>
    function uploadFile(){
    	  var formData = new FormData($("#frmUploadFile")[0]);
    	  $.ajax({
    	    url: '/LoveSports/api/upload/img',
    	    type: 'POST',
    	    data: formData,
    	    async: false,
    	    cache: false,
    	    contentType: false,
    	    processData: false,
    	    success: function(data){
    	      if(200 === data.code) {
    	        //$("#imgShow").attr('src', data.msg.url);
    	        $("#spanMessage").html("Upload Sucess");
    	      } else {
    	        $("#spanMessage").html("Upload Failure");
    	      }
    	      console.log('imgUploader upload success, data:', data);
    	    },
    	    error: function(){
    	      $("#spanMessage").html("Communication Error");
    	    }
    	  });
    }
    </script>
</head>
<body>
<div class="container">
      <div class="page-header">
        <h2>Node.js Ajax Upload File</h2>
      </div>
      <form class="form-horizontal" enctype="multipart/form-data" method="post" action="javascript:;" role="form" id="frmUploadFile">
            <input type="file" name="files" class="form-control">
            <button onclick="uploadFile()">Upload</button>
            <span class="help-inline" id="spanMessage">Select your upload file</span>
      </form>
    </div>
    <div><img id="imgShow"></div>

</body>
</html>