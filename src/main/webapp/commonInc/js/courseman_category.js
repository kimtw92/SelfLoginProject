// 관리자용 카테고리

// 홈 인덱스 용
function fnHomeUrl(authValue){
	var url = "/";
	
	if(authValue == "8"){
		url = "/homepage/index.do?mode=homepage";
	}else{
		url = "/index/sysAdminIndex.do?mode=sysAdmin";
	}
	
	/*
	switch(authValue){
		case "0":
			// 시스템관리자
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "2":
			// 과정운영자			
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "3":
			// 기관담당자
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "5":
			// 평가담당자
			//url = "/index/evalAdminIndex.do?mode=evalAdmin";
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "7":
			// 강사
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "A":
			// 과정장
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "B":
			// 홈페이지관리자
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "C":
			// 부서담당자
			url = "/index/sysAdminIndex.do?mode=sysAdmin";
			break;
		case "8":
			// 학생
			url = "/homepage/index.do?mode=homepage";
			break;			
	}
	*/
	
	return url;
}


// 시간표(시스템관리자)
function fnGoTimeTableByAdmin(){
	location.href = "/courseMgr/timeTable.do?mode=list&menuId=1-1-3";
}

// 과정기수관리(시스템관리자)
function fnGoCourseSeqByAdmin(){
	location.href = "/courseMgr/courseSeq.do?mode=list&menuId=1-1-1";
}

// 강사등급화면(시스템관리자)
function fnGoTutorLevelForm(){
	location.href = "/tutorMgr/allowance.do?mode=list&menuId=4-1-7";
}

// 강사지정(시스템 관리자)
function fnGoTutorSetting(){
	location.href = "/tutorMgr/tclass.do?mode=list&menuId=1-1-2";
}

// 과목별학습현황(시스템 관리자)
function fnGoStudyStaSubjByAdmin(){
	location.href = "/courseMgr/studySta.do?mode=subj_list&menuId=1-3-1";
}
// 전체학습현황(시스템 관리자)
function fnGoStudyStaTotalByAdmin(){
	location.href = "/courseMgr/studySta.do?mode=total_list&menuId=1-3-3";
}
// 사이버학습현황(시스템 관리자)
function fnGoStudyStaCyberByAdmin(){
	location.href = "/courseMgr/studySta.do?mode=cyber_list&menuId=2-3-3";
}
// 혼합교육학습현황(시스템 관리자)
function fnGoStudyStaMixByAdmin(){
	location.href = "/courseMgr/studySta.do?mode=mix_list&menuId=2-3-4";
}
// 온라인평가현황(시스템 관리자) 
function fnGoStudyStaOnlineByAdmin(){
	location.href = "/courseMgr/studySta.do?mode=online_list&menuId=2-3-5";
}