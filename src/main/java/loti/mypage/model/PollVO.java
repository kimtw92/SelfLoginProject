package loti.mypage.model;

import java.util.List;

public class PollVO {

	private String title_no = "";
	private String set_no = "";
	private String question_no = "";
	private String answer_no = "";
	private String answer = "";
	private String answer_kind = "";
	private List<String> txtAns = null;
	private int totalCnt = 0;
	
	public String getTitle_no() {
		return title_no;
	}
	public void setTitle_no(String title_no) {
		this.title_no = title_no;
	}
	public String getSet_no() {
		return set_no;
	}
	public void setSet_no(String set_no) {
		this.set_no = set_no;
	}
	public String getQuestion_no() {
		return question_no;
	}
	public void setQuestion_no(String question_no) {
		this.question_no = question_no;
	}
	public String getAnswer_no() {
		return answer_no;
	}
	public void setAnswer_no(String answer_no) {
		this.answer_no = answer_no;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getAnswer_kind() {
		return answer_kind;
	}
	public void setAnswer_kind(String answer_kind) {
		this.answer_kind = answer_kind;
	}
	public List<String> getTxtAns() {
		return txtAns;
	}
	public void setTxtAns(List<String> txtAns) {
		this.txtAns = txtAns;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
}
