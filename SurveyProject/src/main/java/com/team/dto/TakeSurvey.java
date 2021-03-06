package com.team.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter @Getter
public class TakeSurvey {
	
	private int bnum;
	private int num;
	private int hit;
	private int point;
	private Date deadline;
	private String title;
	private String nick;
	private Timestamp dt;
	private String to_char;
	
}
