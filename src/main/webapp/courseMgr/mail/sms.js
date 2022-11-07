var MSG_LEN_80          = 80;
var CONTNET_80_BYTE_MSG = "메시지 입력은 80바이트까지만 가능합니다.";
var REGIST_80_BYTE      = "80바이트까지만 등록이 가능합니다.";
var TOG_WORD            = '%0D';
var m_iFlag             = 1;

//단문메시지에서 메시지의 길이를 체크하고 짜르는 함수
function checkShrtMsgLen(obj) {
  var bResult     = checkMsgLen(obj,MSG_LEN_80);
  var iCountByte  = 0;
  var sContentMsg = '';

  if (!bResult){
    alert(CONTNET_80_BYTE_MSG);
    sContentMsg = cutText(obj,MSG_LEN_80);
    obj.value = sContentMsg;
  }

  iCountByte = getByteLen(obj);
  sp1.innerText = iCountByte[0];
}

//변수의 길이를 체크하여 80byte가 넘으면 길이를 잘라준다.
function checkMsgLen(obj,sByteLen) {

  var iCounts = new Array();
  iCounts = getByteLen(obj);  //변수의 길이를 구하는 함수

  if (iCounts[0] > sByteLen)
    return false;
  else
    return true;
}

//80바이트 이상 되면 변수의 길이를 자르는 함수
function cutText(obj,sByteLen) {
  var sTmpMsg      = '';
  var iTmpMsgLen   = 0;
  var sOneChar     = '';
  var iCount       = 0;
  var sOneCharNext = '';

  sTmpMsg = new String(obj.value);
  iTmpMsgLen = sTmpMsg.length;

  for (var k = 0 ;k < iTmpMsgLen ; k++) {
    sOneChar = sTmpMsg.charAt(k);
    sOneCharNext = sTmpMsg.charAt(k+1);
    if (escape(sOneChar) == TOG_WORD) {
      iCount++;
      if (iCount > sByteLen - 1) {
        sTmpMsg = sTmpMsg.substring(0,k);
        break;
      }
    }
    else if (escape(sOneChar).length > 4) {
      iCount += 2;
    }
    else {
      iCount++;
    }
    if (iCount > sByteLen) {
      sTmpMsg = sTmpMsg.substring(0,k);
      break;
    }
  }
  return sTmpMsg;
}

//한글일 경우에는 2byte를 그외의 문자는 1byte로 계산하여  iCounts에 저장하여 return 해준다.
function getByteLen(obj) {
  var sMsg        = obj.value;
  var sTmpMsg     = '';      //메시지를 임시로 저장하는 변수
  var sTmpMsgLen  = 0;      //임시로 저장된 메시지의 길이를 저장하는 변수
  var sOneChar    = '';      //한문자를 저장하는 변수
  var iCounts     = new Array();  //총 바이트와 페이지당 바이트 수를 저장하는 배열

  iCounts[0]=0;          //총 바이트를 저장 하는 변수

  sTmpMsg  = new String(sMsg);
  sTmpMsgLen  = sTmpMsg.length;

  for (k = 0 ;k < sTmpMsgLen ;k++) {
    sOneChar = sTmpMsg.charAt(k);
    if (escape(sOneChar) == TOG_WORD) {
      iCounts[0]++;
    }
    else if (escape(sOneChar).length > 4) {
      iCounts[0] += 2;
    }
    else  {
      iCounts[0]++;
    }
  }

  return iCounts;
}

//처음 창을 클릭할시 창을 지운다.
function clearContent() {
  if(m_iFlag == 1) {
    frmsms.txtMessage.value = "";
    checkShrtMsgLen(frmsms.txtMessage);
    m_iFlag=0;
  }
}

//  문자 보내기
function send() {
	var frm = document.frmsms;

	if(frm.txtMessage.value == "" || frm.txtMessage.value == "문자를 입력하세요..") {
		alert("문자 메세지 내용을 입력하세요.");
		frm.txtMessage.focus();
	}
	else if(frm.selPhone.value == "0") {
		alert("메세지를 보내는 사람의 연락처를 입력하여 주시기 바랍니다.(국번)");
		frm.selPhone.focus();
	}

  else if(frm.txtPhone1.value == "") {
			alert("메세지를 보내는 사람의 연락처를 입력하여 주시기 바랍니다.(앞자리)");
			frm.txtPhone1.focus();
	}

	else if(frm.txtPhone2.value == "") {
		alert("메세지를 보내는 사람의 연락처를 입력하여 주시기 바랍니다.(뒷자리)");
		frm.txtPhone2.focus();
	}

	else if(get_rb_val() == "예약") {
		if(frm.selYear.value == "0") {
			alert("년도를 선택해 주세요!");
			frm.selYear.focus();
		}

		else if(frm.selMonth.value == "0") {
			alert("월을 선택해 주세요!");
			frm.selMonth.focus();
		}

		else if(frm.selDay.value == "0") {
			alert("일을 선택해 주세요!");
			frm.selDay.focus();
		}

		else if(frm.selHour.value == "0") {
			alert("시를 선택해 주세요!");
			frm.selHour.focus();
		}

		else if(frm.selMinute.value == "0") {
			alert("분을 선택해 주세요!");
			frm.selMinute.focus();
		}

		else {
			frm.method = "POST";
			frm.action = "./sms_ok.php";
			frm.submit();
		}
	}

	else if(get_rb_val() == "즉시") {
		frm.method = "POST";
		frm.action = "./sms_ok.php";
		frm.submit();
	}
}

// 라디오 버튼 컨트롤
function get_rb_val() {
	var frm = document.frmsms;
	var rb_val = "";
	
	if(frm.radType.length == undefined) {
		if(frm.radType.checked) {
			rb_val = frm.radType;
		}
	}
	else {
		for(var i = 0; i < frm.radType.length; i++) {
			if(frm.radType[i].checked) {
				rb_val = frm.radType[i].value;
			}
		}
	}
	return rb_val;
}
