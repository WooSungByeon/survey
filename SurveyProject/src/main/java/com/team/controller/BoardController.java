package com.team.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.service.IBoardService;
import com.team.service.IReplyService;

@Controller
public class BoardController {

	@Autowired
	private IBoardService service;
	@Autowired
	private IReplyService rService;

	@RequestMapping(value = "mainpage")
	public String mainPage(Model model, HttpServletRequest request) {
		model.addAttribute("request",request);   
		service.page_board_list(model);
		service.pagingNum(model);
		return "Main/main";
	}

	@RequestMapping(value = "board")
	public String board() {
		return "board/board";
	}

	@RequestMapping(value = "surveySave")
	public String surveySave(Model model, HttpServletRequest request, RedirectAttributes redirect) {
		model.addAttribute("request", request);
		int num = service.surveySave(model);
		if(num != 0) {
			redirect.addAttribute("num",num);
			return "redirect:boarddetail";			
		} else {
			return "redirect:mainpage";		
		}
	}

	@RequestMapping(value = "boarddetail")
	public String surveySelect(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		service.surveySelect(model);
		rService.replySelect(model);
		return "board/boardDetail";
	}

	@RequestMapping(value = "boardmodify")
	public String surveyModify(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		service.surveyModify(model);
		return "board/boardModify";
	}

	@RequestMapping(value = "surveyUpdate")
	public String surveyUpdate(Model model, HttpServletRequest request, RedirectAttributes redirect) {
		model.addAttribute("request", request);
		int num = service.surveyUpdate(model);
		if(num != 0) {
			redirect.addAttribute("num",num);
			return "redirect:boarddetail";			
		} else {
			return "redirect:mainpage";		
		}
	}

	@RequestMapping(value="boardDelete")
	public String boardDelete(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		service.surveyDelete(model);
		return "redirect:mainpage";
	}

	@RequestMapping(value="search")
	public String search(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		service.surveySearch(model);
		return "board/search";
	}

	@RequestMapping(value="vote")
	public String vote(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		service.surveyVote(model);
		return "redirect:mainpage";
	}

	@RequestMapping(value = "result")
	public String resultpPage(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		service.surveySelect(model);
		return "board/result";
	}

	@RequestMapping(value = "result.do")
	@ResponseBody
	public String[] result(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		String[] answer = service.surveyResult(model);
		return answer;
	}

}
