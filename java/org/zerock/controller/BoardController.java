package org.zerock.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	// 전체 목록 페이징 = Criteria 클래스의 파라미터 추가 -> 편리하게 하나의 타입만으로 파라미터나 리턴타입으로 사용가능 
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list + Criteria : " + cri);
		model.addAttribute("list",service.getList(cri));
		// 페이징 추가 코딩 = pageDTO객체를 Model에 담아서 뷰에 전달 => 전체데이터는 임의의수 지정
		// model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		// 최종 게시판 마무리 = 총 글 갯수대로 paging 숫자 나옴
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}	
	
	// 등록 처리
	@GetMapping("/register")
	public void register() {}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register: "+board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	// 게시물 조회 = 위에 GET방식을 /get /modify 함께 쓰므로 주의
//	public void get(@RequestParam("bno") Long bno, Model model) { // 좀더 명시적으로 bno값 얻기위해 어노테이션 사용
	public void get(Long bno, Model model, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("/get OR /modify => ");
		model.addAttribute("board", service.get(bno));
	}
	
	// 수정
	@PostMapping("/modify")
//	public String modify(BoardVO board, RedirectAttributes rttr) {
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify: " + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		// 페이징 추가작업 = pageNum과 amount값을 가지고 이동
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list";
	}
	
	// 삭제
	@PostMapping("/remove")
//	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove: " + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		// 페이징 추가작업 = pageNum과 amount값을 가지고 이동
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list";		
	}

	


} // EOC