package org.zerock.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class BoardServiceImpl implements BoardService{
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;

	// 글등록
	@Override
	public void register(BoardVO board) {
		log.info("register => " + board);
		mapper.insertSelectKey(board);
	}
	// 전체 목록
	@Override
	public List<BoardVO> getList() {
		log.info("---getList 전체목록---");
		return mapper.getList();
	}
	// 읽기
	@Override
	public BoardVO get(Long bno) {
		log.info("---get 하나의 게시물---" + bno);
		return mapper.read(bno);
	}
	// 수정
	@Override
	public boolean modify(BoardVO board) {
		log.info("---modify 수정---" + board);
		return mapper.update(board) == 1;
	}
	// 삭제
	@Override
	public boolean remove(Long bno) {
		log.info("---remove 삭제---" + bno);		
		return mapper.delete(bno) == 1;
	}
	// 페이징
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("페이징 Criteria 사용 : " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	// 전체 게시글 갯수
	@Override
	public int getTotal(Criteria cri) {
		log.info("get totla count = " + cri);
		return mapper.getTotalCount(cri);
	}
	
}
