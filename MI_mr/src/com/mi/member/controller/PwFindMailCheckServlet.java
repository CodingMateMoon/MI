package com.mi.member.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.member.controller.MailCheck.MyAuthentication;
import com.mi.member.model.service.MemberService;
import com.mi.member.model.vo.Member;

/**
 * Servlet implementation class PwFind
 */
@WebServlet("/pwfindMailcheck")
public class PwFindMailCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PwFindMailCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Properties props=System.getProperties();
		props.put("mail.smtp.user","skskdi12345@gmail.com");
		props.put("mail.smtp.host","smtp.gmail.com");
		props.put("mail.smtp.port","465");
		props.put("mail.smtp.starttls.enable","true");
		props.put("mail.smtp.auth","true");
		props.put("mail.smtp.socketFactory.port","465");
		props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback","false");
		
		Authenticator auth=new MyAuthentication();
		
		Session session = Session.getDefaultInstance(props, auth);
		MimeMessage msg=new MimeMessage(session);
		try {
			//편지보낸시간
			msg.setSentDate(new Date());
			
			InternetAddress from = new InternetAddress("admin");
			
			//이메일 발신자
			msg.setFrom(from);
			
			//이메일 수신자
			String email=request.getParameter("pwEmail");//사용자 입력한 이메일 받아오기
			InternetAddress to=new InternetAddress(email);
			msg.setRecipient(Message.RecipientType.TO, to);
			
			//이메일 제목
			msg.setSubject("비밀번호 인증번호","UTF-8");
			
			//이메일 내용
			String code=request.getParameter("code_check");//인증번호값 받기
			request.setAttribute("code", code);
			msg.setText(code,"UTF-8");
			
			//이메일 헤더
			msg.setHeader("content-Type", "text/html");
			
			//메일보내기
			javax.mail.Transport.send(msg);
		}catch(AddressException addr_e) {
			addr_e.printStackTrace();
		}catch(MessagingException msg_e) {
			msg_e.printStackTrace();
		}

		RequestDispatcher rd=request.getRequestDispatcher("/views/member/pwfindCheckcode.jsp");
				rd.forward(request, response);
	}
	class MyAuthentication extends Authenticator{
		PasswordAuthentication pa;
		
		public MyAuthentication() {
			String id="skskdi12345";//구글 ID
			String pw="1q2w3e4r!#@";//구글 비밀번호
			
			//ID와 비밀번호를 입력한다.
			pa=new PasswordAuthentication(id,pw);
		}
		
		public PasswordAuthentication getPasswordAuthentication() {
			return pa;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
