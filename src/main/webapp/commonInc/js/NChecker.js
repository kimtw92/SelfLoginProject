	//history
	//	2006-10-27 : text, password 타입 오브젝트에서 다른 오브젝트 밸류값과 비교하는 항목 추가 (2006-10-27 로 검색)


	
	String.prototype.equals = UDF_equals;
	String.prototype.trim = UDF_trim;
	String.prototype.ltrim = UDF_ltrim;
	String.prototype.rtrim = UDF_rtrim;
	String.prototype.match2 = UDF_match;
	String.prototype.getByteLength = UDF_getByteLength;
	String.prototype.getFileExt = UDF_getFileExt;
	String.prototype.msg = VF_msg;
	String.prototype.checkPhone = VF_checkPhone;
	String.prototype.checkFax = VF_checkFax;
	String.prototype.checkMobile = VF_checkMobile;
	String.prototype.checkSsn = VF_checkSsn;
	String.prototype.checkZip = VF_checkZip;
	String.prototype.checkEmail = VF_checkEmail;
	String.prototype.checkUrl = VF_checkUrl;
	String.prototype.checkNum = VF_checkNum;
	String.prototype.checkDate = VF_checkDateType;	//날짜형식 체크 함수 추가 2007-08-21
	







	//text, password 타입의 엘리먼트가 가질수 있는 어트리뷰트 배열
	var attributeForText = new Array(
			new Array("required", "VF_validRequired"),
			new Array("requiredifchecked", "VF_validRequiredIfChecked"),	//2007-08-21 추가(특정라디오버튼이나 체크박스가 선택되었을경우 필수 입력)
			new Array("minchar", "VF_validMinChar"),
			new Array("maxchar", "VF_validMaxChar"),
			new Array("charlength", "VF_validCharLength"),
			new Array("minbyte", "VF_validMinByte"),
			new Array("maxbyte", "VF_validMaxByte"),
			new Array("bytelength", "VF_validByteLength"),
			new Array("datatype", "VF_validDataType"),
			new Array("dataform", "VF_validDataForm"),
			new Array("pattern", "VF_validPattern"),
			new Array("samevalue", "VF_validSameValue"), //2006-10-27 추가
			new Array("datetype", "VF_checkDate") //2007-07-27 추가
			);

	//textarea 엘리먼트가 가질수 있는 어트리뷰트 배열
	var attributeForTextArea = new Array(
			new Array("required", "VF_validRequired"),
			new Array("minchar", "VF_validMinChar"),
			new Array("maxchar", "VF_validMaxChar"),
			new Array("charlength", "VF_validCharLength"),
			new Array("minbyte", "VF_validMinByte"),
			new Array("maxbyte", "VF_validMaxByte"),
			new Array("bytelength", "VF_validByteLength")
		);

	//select 엘리먼트가 가질수 있는 어트리뷰트 배열
	var attributeForSelect = new Array(
			new Array("selectrequired", "VF_validSelectRequired")
		);

	//checkbox 타입의 엘리먼트가 가질수 있는 어트리뷰트 배열
	var attributeForCheckbox =
		new Array(
			new Array("minchecked", "VF_validMinChecked"),
			new Array("maxchecked", "VF_validMaxChecked"),
			new Array("checkedcount", "VF_validCheckedCount")
		);

	//radio 타입의 엘리먼트가 가질수 있는 어트리뷰트 배열
	var attributeForRadio =
		new Array(
			new Array("checkedrequired", "VF_validCheckedRequired")
		);

	//file 타입의 엘리먼트가 가질수 있는 어트리뷰트 배열
	var attributeForFile =
		new Array(
			new Array("required", "VF_validRequired"),
			new Array("limitext", "VF_validLimitExt")
		);

	//디폴트 메세지
	var defaultMsg = new Array(
		new Array("required", "필수 입력입니다."),
		new Array("minchar", "입력한 글자수가 적습니다."),
		new Array("maxchar", "입력한 글자수가 많습니다."),
		new Array("charlength", "입력한 글자수가 맞지 않습니다."),
		new Array("minbyte", "입력한 글자수가 적습니다."),
		new Array("maxbyte", "입력한 글자수가 많습니다."),
		new Array("bytelength", "입력한 글자수가 맞지 않습니다."),
		new Array("datatype", "데이타가 유효하지 않습니다."),
		new Array("dataform", "데이타가 형식에 맞지 않습니다."),
		new Array("pattern", "데이타가 형식에 맞지 않습니다."),
		new Array("selectrequired", "선택하세요."),
		new Array("minchecked", "선택한 갯수가 적습니다."),
		new Array("maxchecked", "선택한 갯수가 많습니다.."),
		new Array("checkedcount", "선택한 갯수가 맞지 않습니다."),
		new Array("checkedrequired", "선택하세요."),
		new Array("limitext", "업로드 할수 없는 파일입니다."),
		new Array("samevalue", "입력된 값이 서로 다릅니다."), //2006-10-27 추가
		new Array("datetype", "날짜 형식과 맞지 않습니다.") //2007-07-27 추가
	);

	//데이타 타입
	var dataType = new Array(
		new Array("1", "no", "0-9"),
		new Array("2", "kr", "ㄱ-?"),
		new Array("4", "enl", "a-z"),
		new Array("8", "enu", "A-Z")
	);

	//데이타 형식
	var dataForm = new Array(
		new Array("phone", "checkPhone"),
		new Array("fax", "checkFax"),
		new Array("mobile", "checkMobile"),
		new Array("zip", "checkZip"),
		new Array("ssn", "checkSsn"),
		new Array("email", "checkEmail"),
		new Array("url", "checkUrl"),
		new Array("num", "checkNum"),
		new Array("date", "checkDate")	//날짜형식 체크 함수 추가 2007-08-21
	);

	//엘리먼트의 타입에 맞는 어트리뷰트 배열을 저장하는 오브젝트
	function ValidAttribute(type) {

		switch (type) {
			case "text":
			case "password" :
				this.attrList = attributeForText;
				break;
			case "textarea":
				this.attrList = attributeForTextArea;
				break;
			case "select-one":
			case "select-multiple":
				this.attrList = attributeForSelect;
				break;
			case "checkbox":
				this.attrList = attributeForCheckbox;
				break;
			case "radio":
				this.attrList = attributeForRadio;
				break;
			case "file":
				this.attrList = attributeForFile;
				break;
			case "button":
			case "submit":
			case "image":
			case "hidden":
			case "":
				this.attrList = new Array();
				break;
		}


	}

	//엘리먼트 객체와 검사할 어트리뷰트를 저장하는 오브젝트
	function CheckElement(ele) {
		this.attr = new Array();
		this.ele = ele;

		this.add = function(func, value) {
			this.attr[this.attr.length] = new Array(func, value);
		}
	}

	//엘리먼트에 대한 유효성 검사
	function validCheck(ce) {
		var flag = true;
		for (var i = 0; i < ce.attr.length; i++) {
			var func = ce.attr[i][0];
			var arg = ce.attr[i][1];
			var attrVal = "";
			var attrMsg = "";

			if (arg.indexOf("!") > -1) {
				attrVal = arg.substring(0, arg.indexOf("!"));
				attrMsg = arg.substring(arg.indexOf("!") + 1);
			} else {
				attrVal = arg;
				attrMsg = "";
			}
			if (!eval(func + "(ce.ele, '" + attrVal.trim() + "')")) {
				flag = false;
				func.msg(attrMsg);
				ce.ele.focus();
				break;
			}
		}

		return flag;
	}

	//체크할 폼 전역변수
	var frm;

	//폼 유효성 검사 기본 호출 함수
	function NChecker() {



		var args = NChecker.arguments;
		frm = null;

		if (args.length > 0) { //전달받은 폼오브젝트가 있을경우.
			frm = args[0];
		} else {	//전달받은 폼 오브젝트가 없을경우
			frm = event.srcElement;	 //이벤트를 발생시킨 폼 오브젝트
		}



		var elementList = frm.elements;	//해당 폼의 엘리먼트 리스트


		for (var i = 0; i < elementList.length; i++) { //엘리먼트 갯수만큼 반복하면서 검사.

			var ele = elementList[i];

			var validAttr = new ValidAttribute(ele.type);	//유효성 검사를 할수 있는 어트리뷰트 목록을 받아옴.

			var attribute = ele.attributes;	//해당 엘리먼트가 가지고 있는 어트리뷰트

			var chkAttr = new CheckElement(ele);	 //엘리먼트 객체와 검사할 어트리뷰트를 저장할 오브젝트



			for (var j = 0; j < validAttr.attrList.length; j++) {
				var tmpAttr = attribute.getNamedItem(validAttr.attrList[j][0]);

				if (tmpAttr != null) {
					chkAttr.add(validAttr.attrList[j][1], tmpAttr.nodeValue);
				}
			}

			if (chkAttr.attr.length > 0) {

				if (!validCheck(chkAttr)) {
					return false;
				}
			}

		}



		return true;
	}

	//문자열 비교
	function UDF_equals(val) {
		if (this == val)
			return true;
		else
			return false;
	}

	//문자열 앞뒤 공백 제거
	function UDF_trim() { return this.replace(/^\s*/ ,"").replace(/\s*$/ ,""); }

	//문자열 앞 공백 제거
	function UDF_ltrim() { return this.replace(/^\s*/ ,""); }

	//문자열 뒤 공백 제거
	function UDF_rtrim() {return this.replace(/\s*$/ ,""); }

	//정규식 패턴 매치
	function UDF_match(pattern) { return pattern.test(this) }

	//2바이트 문자 길이
	function UDF_getByteLength() {
      var str;
      var cnt = 0;

      for(var i = 0; i < this.length; i++ ){
         str = this.charAt(i);

         if(escape(str).length > 4) cnt += 2;
         else cnt++;
      }

      return cnt;
   }

	//파일 확장자 가져오기
   function UDF_getFileExt() {
		return this.substring(this.lastIndexOf("\.") + 1);
   }

   //전화번호
	function VF_checkPhone() {
		var pattern = /^0\d{1,2}-\d{3,4}-\d{4}$/;

		return this.match2(pattern);
	}

   //팩스번호
	function VF_checkFax() {
		var pattern = /^0\d{1,2}-\d{3,4}-\d{4}$/;

		return this.match2(pattern);
	}



	//핸드폰 번호
	function VF_checkMobile() {
		var pattern = /^(010|011|016|017|018|019)-\d{3,4}-\d{4}$/

		return this.match2(pattern);
	}

	//주민번호
	function VF_checkSsn() {
		return true;
	}

	//우편번호
	function VF_checkZip() {
		var pattern = /^\d{3}-\d{3}$/;

		return this.match2(pattern);
	}

	//이메일주소
	function VF_checkEmail() {
		var pattern = /^[a-z0-9-]+@[a-z0-9-]+\.[a-z]+(\.[a-z]+)?$/;

		return this.match2(pattern);
	}

	//URL
	function VF_checkUrl() {
		var pattern = /^(http:\/\/)?[a-z0-9-]+\.[a-z]+(\.[a-z]+)*$/;

		return this.match2(pattern);
	}

	// 숫자 확인
	function VF_checkNum() {
		var pattern = /^[0-9]+$/;
		return this.match2(pattern);
	}

	//날짜형식 체크 함수 추가 2007-08-21
	//날짜는 yyyy-mm-dd, yyyymmdd, yyyy/mm/dd 등의 형식으로 연도 네자리, 월 두자리, 일 두자리가 숫자로 입력되어야 한다.
	//날짜형식 확인
	function VF_checkDateType() {
		var str = "";

		for (var i = 0; i < this.length; i++) {
			var tmpN = this.substring(i, i + 1);
			if (!isNaN(tmpN)) {
				str += "" + tmpN;
			}
		}

		var y = str.substring(0, 4);
		var m = str.substring(4, 6);
		var d = str.substring(6, 8)
		var dt = new Date(y, m - 1, d);

		return (dt.getFullYear() == y && dt.getMonth() == m - 1 && dt.getDate() == d);
	}

	//메세지 출력
	function VF_msg(msg) {
		if (msg.equals("")) {	 //해당 메세지가 없을경우 디폴트 메세지 출력
			for (var i = 0; i < defaultMsg.length; i++) {
				if (this.equals(defaultMsg[i][0])) {
					alert(defaultMsg[i][1]);
					break;
				}
			}
		} else {
			alert(msg);
		}
	}

	//필수입력항목 체크
	function VF_validRequired(ele, attrVal) {
		if (attrVal.trim().equals("true")) {
			if (ele.value.trim().equals(""))  return false; else return true;
		}

		return true;
	}

	//2007-08-21 추가
	//특정라디오버튼이나 체크박스가 선택되었을경우 필수 입력항목 체크
	function VF_validRequiredIfChecked(ele, attrVal) {
		var basisElement = eval("document.all." + attrVal.trim());

		if (basisElement.checked) {
			if (ele.value.trim().equals(""))  return false; else return true;
		}

		return true;
	}

	//입력항목 문자열 최소길이 체크
	function VF_validMinChar(ele, attrVal) {
		if (attrVal.match2(/^\d+$/)) {
			if (ele.value.trim().length > 0) {
				if (ele.value.trim().length < parseInt(attrVal)) return false; else return true;
			}
		}

		return true;
	}

	//입력항목 문자열 최대길이 체크
	function VF_validMaxChar(ele, attrVal) {
		if (attrVal.match2(/^\d+$/)) {

			//if (ele.value.trim().length > 0) {
			if (toValueLength(ele.value.trim()) > 0) {
				if (toValueLength(ele.value.trim()) > parseInt(attrVal)) return false; else return true;
			}


		}

		return true;
	}

	function toValueLength(str)
{
	    // 한글이면 1글자당 2씩 반환
	    // 영문,숫자는 1글자당 1씩 반환
	    var cvt = "";
	    var len = str.length;
	    var i, code;
	    var plength;

	    plength = 0;
	    for(i=0; i<len; i++)
	    {
	        if ( (str.charCodeAt(i)<0)||(str.charCodeAt(i)>127) )
	        {
	            cvt = cvt + "ko";
	        }
	        else
	        {
	            cvt = cvt + str.charAt(i);
	        }
	    }

	    plength = cvt.length;
	    return plength;
	}



	//입력항목 문자열 길이 체크
	function VF_validCharLength(ele, attrVal) {
		if (attrVal.match2(/^\d+-\d+$/)) {
			if (ele.value.trim().length > 0) {
				if (parseInt(attrVal.substring(0, attrVal.indexOf("-"))) <= parseInt(attrVal.substring(attrVal.indexOf("-") + 1))) {
					if (ele.value.trim().length < parseInt(attrVal.substring(0, attrVal.indexOf("-"))) || ele.value.trim().length > parseInt(attrVal.substring(attrVal.indexOf("-") + 1))) {
						return false;
					} else {
						return true;
					}
				}
			}
		}

		return true;
	}

	//입력항목 문자열 최소 바이트 체크
	function VF_validMinByte(ele, attrVal) {
		if (attrVal.match2(/^\d+$/)) {
			if (ele.value.trim().length > 0) {
				if (ele.value.trim().getByteLength() < parseInt(attrVal)) return false; else return true;
			}
		}

		return true;
	}

	//입력항목 문자열 최대바이트 체크
	function VF_validMaxByte(ele, attrVal) {
		if (attrVal.match2(/^\d+$/)) {
			if (ele.value.trim().length > 0) {
				if (ele.value.trim().getByteLength() > parseInt(attrVal)) return false; else return true;
			}
		}

		return true;
	}

	//입력항목 문자열 바이트 체크
	function VF_validByteLength(ele, attrVal) {
		if (attrVal.match2(/^\d+-\d+$/)) {
			if (ele.value.trim().length > 0) {
				if (parseInt(attrVal.substring(0, attrVal.indexOf("-"))) <= parseInt(attrVal.substring(attrVal.indexOf("-") + 1))) {
					if (ele.value.trim().getByteLength() < parseInt(attrVal.substring(0, attrVal.indexOf("-"))) || ele.value.trim().getByteLength() > parseInt(attrVal.substring(attrVal.indexOf("-") + 1))) {
						return false;
					} else {
						return true;
					}
				}
			}
		}

		return true;
	}

	//데이타 타입 체크
	function VF_validDataType(ele, attrVal) {
		var str = "";

		for (var i = 0; i < dataType.length; i++) {
			if ((parseInt(attrVal) & parseInt(dataType[i][0])) == parseInt(dataType[i][0])) {
				str += dataType[i][2];
			}
		}

		var pattern = eval("/^[" + str + "]+$/");

		if (ele.value.trim().length > 0) {
			if (!str.equals("")) return ele.value.match2(pattern);
		}

		return true;
	}

	//데이타 형식 체크
	function VF_validDataForm(ele, attrVal) {
		var func = "";
		for (var i = 0; i < dataForm.length; i++) {
			if (dataForm[i][0].equals(attrVal)) {
				func = dataForm[i][1];
				break;
			}
		}

		if (ele.value.trim().length > 0) {
			if (!func.equals("")) return eval("ele.value." + func + "()");
		}

		return true;
	}

	//패턴 체크
	function VF_validPattern(ele, attrVal) {
		if (ele.value.trim().length > 0) {
			if (!attrVal.equals("")) {
				var pattern = eval(attrVal);

				return ele.value.match2(pattern);
			}
		}

		return true;
	}

	//2006-10-27 추가
	//다른 인풋 엘리먼트 값과 비교
	function VF_validSameValue(ele, attrVal) {
		if (ele.value.equals(document.getElementsByName(attrVal))) return true; else return false;

		return true;
	}

	//셀렉트박스 선택 체크
	function VF_validSelectRequired(ele, attrVal) {
		if (attrVal.equals("true")) {
			if (ele.value.equals("")) return false; else return true;
		}

		return true;
	}

	//체크박스 선택 체크(최소갯수)
	function VF_validMincCecked(ele, attrVal) {
		if (attrVal.match2(/^\d+$/)) {
			var f = frm;

			var flag = false;
			var cnt = 0;

			if (!isNaN(eval("f." + ele.name + ".length"))) {
				for (var i = 0; i < eval("f." + ele.name + ".length"); i++) {
					if (eval("f." + ele.name + "[" + i + "].checked")) {
						cnt++;
					}
				}
			} else {
				if (ele.checked) {
					cnt++;
				}
			}

			if (cnt >= parseInt(attrVal)) return true; else return false;
		}

		return true;
	}

	//체크박스 선택 체크(최대갯수)
	function VF_validMaxChecked(ele, attrVal) {
		if (attrVal.match2(/^\d+$/)) {
			var f = frm;

			var flag = false;
			var cnt = 0;

			if (!isNaN(eval("f." + ele.name + ".length"))) {
				for (var i = 0; i < eval("f." + ele.name + ".length"); i++) {
					if (eval("f." + ele.name + "[" + i + "].checked")) {
						cnt++;
					}
				}
			} else {
				if (ele.checked) {
					cnt++;
				}
			}

			if (cnt <= parseInt(attrVal)) return true; else return false;
		}

		return true;
	}

	//체크박스 선택 체크(갯수지정)
	function VF_validCheckedCount(ele, attrVal) {
		if (attrVal.match2(/^\d+-\d+$/)) {
			var f = frm;

			var flag = false;
			var cnt = 0;

			if (!isNaN(eval("f." + ele.name + ".length"))) {
				for (var i = 0; i < eval("f." + ele.name + ".length"); i++) {
					if (eval("f." + ele.name + "[" + i + "].checked")) {
						cnt++;
					}
				}
			} else {
				if (ele.checked) {
					cnt++;
				}
			}

			if (cnt < parseInt(attrVal.substring(0, attrVal.indexOf("-"))) || cnt > parseInt(attrVal.substring(attrVal.indexOf("-") + 1))) {
				return false;
			} else {
				return true;
			}
		}

		return true;
	}

	//라디오버튼 체크
	function VF_validCheckedRequired(ele, attrVal) {
		if (attrVal.equals("true")) {
			var f = frm;

			var flag = false;
			var cnt = 0;

			if (!isNaN(eval("f." + ele.name + ".length"))) {
				for (var i = 0; i < eval("f." + ele.name + ".length"); i++) {
					if (eval("f." + ele.name + "[" + i + "].checked")) {
						cnt++;
					}
				}
			} else {
				if (ele.checked) {
					cnt++;
				}
			}

			if (cnt >= 1) return true; else return false;
		}

		return true;
	}

	//파일 확장자 제한 체크
	function VF_validLimitExt(ele, attrVal) {
		if (ele.value.trim().length > 0) {
			if (attrVal.match2(/^[a-zA-Z0-9]+(\|[a-zA-Z0-9]+)*$/)) {
				var value = ele.value;

				if (value.equals("")) {
					return true;
				} else {
					var ext = value.getFileExt().toLowerCase();
					var pattern = eval("/^(" + attrVal.toLowerCase() + "){1}$/");

					if (ext.match2(pattern)) return true; else return false;
				}
			}
		}

		return true;
	}

	//날짜 형식 체크
	function VF_checkDate(ele, attrVal) {
		var pattern = /^[1|2][0-9]{3}[\-]([0][0-9]|[1][0-2])[\-]([0-2][0-9]|[3][0-1])/;
		return (pattern.test(ele.value)) ? true : false;
	}


