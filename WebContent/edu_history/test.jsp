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
			value='{$oDocument->getTitle()}' title='���¸�'> <input
			type='hidden' name='LGD_BUYER' value='{$logged_info->user_name}'
			title='�̸�'> <input type='hidden' name='LGD_BUYERID'
			value='{$logged_info->user_id}' title='���̵�'> <input
			type='hidden' name='LGD_AMOUNT'
			value='{$oDocument->getExtraValueHTML(5)}' title='�ݾ�'> <input
			type='hidden' name='LGD_BUYERIP' value='{$oDocument->getIpaddress()}'
			title='������'> <input type='hidden' name='LGD_DOCUMENT_SRL'
			value='{$document_srl}' title='������ȣ'> <input type='hidden'
			name='LGD_BUYERIP' value='{$oDocument->getIpaddress()}' title='������'>
		<input type='hidden' name='LGD_BUYEREMAIL'
			value='{$logged_info->email_address}' title='�̸����ּ�'> <input
			type='hidden' name='LGD_OID' value='{$keynum}_{$document_srl}'
			title='�̸����ּ�'>
	</form>
	<input type='button' value='�����ϱ�' onclick='paycheck()'>

</body>
</html>