<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language='javascript'>
	function paycheck() {
		var gsWin = window.open('about:blank', 'payviewer',
				'width=500,height=500');
		var frm = document.pay;
		frm.action = '/payment/payreq.php';
		frm.target = "payviewer";
		frm.method = "post";
		frm.submit();
	}
</script>
</head>
<body>
	<form name='pay' action='' method="post">
		<input type='hidden' name='LGD_PRODUCTINFO'
			value='{$oDocument->getTitle()}' title='강좌명'> <input
			type='hidden' name='LGD_BUYER' value='{$logged_info->user_name}'
			title='이름'> <input type='hidden' name='LGD_BUYERID'
			value='{$logged_info->user_id}' title='아이디'> <input
			type='hidden' name='LGD_AMOUNT'
			value='{$oDocument->getExtraValueHTML(5)}' title='금액'> <input
			type='hidden' name='LGD_BUYERIP' value='{$oDocument->getIpaddress()}'
			title='아이피'> <input type='hidden' name='LGD_DOCUMENT_SRL'
			value='{$document_srl}' title='문서번호'> <input type='hidden'
			name='LGD_BUYERIP' value='{$oDocument->getIpaddress()}' title='아이피'>
		<input type='hidden' name='LGD_BUYEREMAIL'
			value='{$logged_info->email_address}' title='이메일주소'> <input
			type='hidden' name='LGD_OID' value='{$keynum}_{$document_srl}'
			title='이메일주소'>
	</form>
	<input type='button' value='결제하기' onclick='paycheck()'>

</body>
</html>