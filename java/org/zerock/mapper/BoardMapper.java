package org.zerock.mapper;
/*
	BoardMapper 인터페이스
	= BoardVO 활용 -> SQL을 처리함
	= (주의) SQL 작성시 반드시 마지막에 ;이 없도록 작성
	= 쿼리문 Sql Developer에서 테스트 하고 사용
*/
import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	public List<BoardVO> getList();
	public void insert(BoardVO board);
	public void insertSelectKey(BoardVO board);
	public BoardVO read(Long bno);
	public int delete(Long bno);
	public int update(BoardVO board);
	
//	페이징
	public List<BoardVO> getListWithPaging(Criteria cri);
// 전체 데이터 갯수 처리
	public int getTotalCount(Criteria cri);
	

} //EOI
