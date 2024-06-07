package com.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.smhrd.entity.Board;
import com.smhrd.entity.Member;
import com.smhrd.entity.Reply;

@Mapper
public interface BoardMapper {
	
	public List<Board> boardList();


	public Board boardContent(int idx);
	
	public void boardInsert(Board vo);


	public void boardDelete(int idx);


	public void boardUpdate(Board vo);


	public void boardCount(int idx);


	public void replyInsert(Reply vo);


	public List<Reply> replyList(int idx);


	public void join(Member vo);


	public Member login(Member vo);


	


	

	

}
