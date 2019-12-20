package com.team.controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.service.IBoardService;
import com.team.service.IMemberService;
import com.team.service.IReplyService;

@Controller
public class BoardController {

	@Autowired
	private IBoardService bService;
	@Autowired
	private IReplyService rService;
	@Autowired
	private IMemberService mService;
	

	//[로그인 후 메인페이지]
	@RequestMapping(value = "mainpage")
	public String mainPage(Model model, HttpServletRequest request, HttpSession session) {
		System.out.println("mainPage Controller 시작 ");
		
		System.out.println("mainPage Controller >> session.getAttribute(lineupsession) >> " + session.getAttribute("lineupSession"));
		
		model.addAttribute("request",request);   
 
		mService.userPoint(model);
		bService.page_board_list(model);
		bService.pagingNum(model); 
		return "Main/main";
	}
	
	@RequestMapping(value="lineupMain")
	public String lineupMain(Model model, HttpServletRequest request,HttpSession session) {
		System.out.println("lineupMain 시작");

		System.out.println("requst getParemer linpu >>"+request.getParameter("lineup"));
		session.setAttribute("lineupSession", request.getParameter("lineup"));
		
		
		System.out.println("lineupMain 끝"); 
		return "redirect:mainpage";
	}
	

	//[게시글 작성 페이지]
	@RequestMapping(value = "board")
	public String board() {
		return "board/board";
	}

	//[게시글 저장]
	@RequestMapping(value = "surveySave")
	public String surveySave(Model model, HttpServletRequest request, RedirectAttributes redirect) {
		model.addAttribute("request", request);
		int num = bService.surveySave(model);
		if(num != 0) {
			redirect.addAttribute("num",num);
			return "redirect:boarddetail";			
		} else {
			return "redirect:mainpage";		
		}
	}

	//[게시글 보기]
	@RequestMapping(value = "boarddetail")
	public String surveySelect(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bService.surveySelect(model);
		rService.replySelect(model);
		return "board/boardDetail";
	}

	//[게시글 수정 페이지]
	@RequestMapping(value = "boardmodify")
	public String surveyModify(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bService.surveyModify(model);
		return "board/boardModify";
	}

	//[게시글 수정]
	@RequestMapping(value = "surveyUpdate")
	public String surveyUpdate(Model model, HttpServletRequest request, RedirectAttributes redirect) {
		model.addAttribute("request", request);
		int num = bService.surveyUpdate(model);
		if(num != 0) {
			redirect.addAttribute("num",num);
			return "redirect:boarddetail";			
		} else {
			return "redirect:mainpage";		
		}
	}

	//[게시글 삭제]
	@RequestMapping(value="boardDelete")
	public String boardDelete(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bService.surveyDelete(model);
		return "redirect:mainpage";
	}

	//[게시글 검색]
	@RequestMapping(value="search")
	public String search(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bService.surveySearch(model);
		return "board/search";
	}

	//[설문조사 투표]
	@RequestMapping(value="vote")
	public String vote(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bService.surveyVote(model);
		mService.addPoint(model);
		mService.userPoint(model);
		return "redirect:mainpage";
	}

	//[설문조사 결과 페이지]
	@RequestMapping(value = "result")
	public String resultpPage(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bService.surveySelect(model);
		return "board/result";
	}

	//[설문조사 결과 데이터 가져오기]
	@RequestMapping(value = "result.do")
	@ResponseBody
	public String[] result(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		String[] answer = bService.surveyResult(model);
		return answer;
	}
	
	
	
	
	
	

}
