package org.zerock.service;
/*
	BoardService 인터페이스
	 : 메서드명 관례에 따를것 = labeling기법 사용(의미있는 이름)
	 a. 모든 게시물 select = 반환데이터가 있음. 메서드에 리턴타입 지정 , getList()
	 b. 하나의 게시물 select = 반환데이터가 있음. 메서드에 리턴타입 지정, get()
 */

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	// 글등록
	public void register(BoardVO board);
	// 전체 목록
	public List<BoardVO> getList();
	// 읽기 = bno기준 하나의 게시물
	public BoardVO get(Long bno);
	// 수정
	public boolean modify(BoardVO board);
	// 삭제
	public boolean remove(Long bno);
	
	// 페이징
	public List<BoardVO> getList(Criteria cri);
	// 전체 데이터 객수 구하기
	public int getTotal(Criteria cri);
}
