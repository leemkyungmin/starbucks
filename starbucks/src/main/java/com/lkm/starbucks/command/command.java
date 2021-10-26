package com.lkm.starbucks.command;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface command {

	public void execute(SqlSession sqlsession,Model model);
}
