package com.mi.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.member.model.service.MemberService;
import com.mi.member.model.vo.Member;

/**
 * Servlet implementation class PwFindChange
 */
@WebServlet("/pwFind")
public class PwFindChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PwFindChange() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member m=new Member();
		String memberId=request.getParameter("memberId");
		String email=request.getParameter("pwEmail");
		m.setMemberId(memberId);
		m.setEmail(email);
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("email", email);
		Member result=new MemberService().FindPw(m);
		
		String msg="";
		String loc="";
		String view="/views/common/msg.jsp";
		if(result!=null)
		{
			view="/views/member/FindPasswordChange.jsp";
		}
		else
		{
			msg="이름과 이메일을 확인해주세요.";
			loc="/views/member/IdPwForget.jsp";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher(view).forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
