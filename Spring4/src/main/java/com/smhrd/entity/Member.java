package com.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor  // 기본생성자
@ToString
public class Member {
	
	private String id;
	private String pw;
	private String nick;

}
