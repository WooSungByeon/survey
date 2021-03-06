package com.team.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team.dto.BoardDTO;
import com.team.dto.PageCount;
import com.team.dto.TakeSurvey;
import com.team.dto.VoteDTO;

@Repository
public class BoardDAO {

	private static final String namespaceBoard = "Board";
	private static final String namespaceReply = "Reply";

	@Autowired
	private SqlSession sqlsession;

	//[게시글 저장]
	public int surveySave(BoardDTO dto) {	
		int num = 0;
		try {
			sqlsession.insert(namespaceBoard + ".surveySave", dto);				
			num = sqlsession.selectOne(namespaceBoard + ".currentNum");
		} catch (Exception e) { System.out.println(e); }
		return num;
	}

	//[지정 게시글 가져오기]
	public BoardDTO surveySelect(int num) {
		/*조회수 증가*/
		sqlsession.update(namespaceBoard + ".up", num);
		return sqlsession.selectOne(namespaceBoard + ".surveySelect", num);
	}
	
	//[설문조사 중복참여 검사]
	public List<String> voteSelect(int num) {
		return sqlsession.selectList(namespaceBoard + ".VoteSelect", num);
	}

	//[수정할 게시글 가져오기]
	public BoardDTO surveyModify(int num) {
		return sqlsession.selectOne(namespaceBoard + ".surveySelect", num);
	}

	//[게시글 수정하기]
	public int surveyUpdate(BoardDTO dto) {
		int num = dto.getNum();
		int Rnum = 0;
		try {
			sqlsession.delete(namespaceBoard + ".voteDelete", num);
			sqlsession.delete(namespaceBoard + ".takesurveyDelete", num);
			sqlsession.insert(namespaceBoard + ".surveyUpdate", dto);				
			Rnum = sqlsession.selectOne(namespaceBoard + ".currentNum");
		} catch (Exception e) { }
		return Rnum;
	}

	//[모든 게시글 가져오기]
	public List<BoardDTO> surveyAllSelect() {
		return sqlsession.selectList(namespaceBoard + ".surveyAllSelect");
	}

	//[게시글 삭제하기]
	public Object surveyDelete(int num) {
		sqlsession.delete(namespaceBoard + ".voteDelete", num);
		sqlsession.delete(namespaceBoard + ".takesurveyDelete", num);
		sqlsession.delete(namespaceReply + ".replyAllDelete", num);
		return sqlsession.delete(namespaceBoard + ".surveyDelete", num);
	}

	//[게시글 검색하기]
	public List<BoardDTO> surveySearch(String hashtag) {
		return sqlsession.selectList(namespaceBoard + ".surveySearch",hashtag);
	}

	//[투표 결과 저장하기]
	public void surveyVote(VoteDTO dto) {
		sqlsession.insert(namespaceBoard + ".surveyVote", dto);
	}

	//[투표 결과 가져오기]
	public List<VoteDTO> surveyResult(int num) {
		return sqlsession.selectList(namespaceBoard + ".surveyResult", num);
	}

	/*---------------------------Paging 메소드-----------------------------*/
	
	//[전체 페이지 가져오기]
	public int getTotalPage() {
		return sqlsession.selectOne(namespaceBoard+".board_getTotalPage");
	}
	
	//[최신순으로 정렬하기]
	public List<BoardDTO> pageBoardList(PageCount pc) {
		return sqlsession.selectList(namespaceBoard+".board_pagingList",pc);
	}

	//[마이페이지 - 등록한 설문조사]
	public int getTotalPageNick(String loginUser) {
		return sqlsession.selectOne(namespaceBoard+".board_getTotalPage_nick", loginUser);
	}
	public List<BoardDTO> pageBoardListNick(PageCount pc2) {
		return sqlsession.selectList(namespaceBoard+".board_pagingList_nick",pc2);
	}
	
	//[마이페이지 - 최근 설문조사]
	public int getTotalPageTake(String loginUser) {
		return sqlsession.selectOne(namespaceBoard+".getTotalPage_take", loginUser);
	}
	public List<TakeSurvey> pageBoardListTake(PageCount pc3) {
		return sqlsession.selectList(namespaceBoard+".board_pagingList_take",pc3);
	}
	
	/*---------------------------Paging 메소드-----------------------------*/

	//[참여 설문조사 등록]
	public void takeSurvey(TakeSurvey tdto) {
		sqlsession.insert(namespaceBoard+".takeSurbey",tdto);	
	}
	
	//[참여 설문조사 가져오기]
	public List<TakeSurvey> takeSurveySearch(String loginUser) {
		return sqlsession.selectList(namespaceBoard+".TakeSurbeySearch",loginUser);
	}
	
	//[마감 날짜로 정렬하기]
	public List<BoardDTO> pageBoardListDead(PageCount pc) {
		return sqlsession.selectList(namespaceBoard+".board_pagingList_deadline",pc);
	}
	
	//[조회순으로 정렬하기]
	public List<BoardDTO> pageBoardListHit(PageCount pc) {
		return sqlsession.selectList(namespaceBoard+".board_pagingList_hit",pc);
	}

	//[포인트 히스토리(적립된 날짜순 정렬)]
	public List<TakeSurvey> pointHistory(String loginUser) {
		return sqlsession.selectList(namespaceBoard+".pointHistory",loginUser);
	}
	
	//[]
	public List<String> dateSecond(String loginUser) {	
		return sqlsession.selectList(namespaceBoard+".dateSecond",loginUser);
	}
	
	//[best 설문조사 가져오기]
	public List<BoardDTO> bestSurvey(){
		return sqlsession.selectList(namespaceBoard + ".bestServey");
	}
	
	//[]
	public List<TakeSurvey> pointLogLast(String loginUser) {
		return sqlsession.selectList(namespaceBoard+".pointlog",loginUser);
	}

}
