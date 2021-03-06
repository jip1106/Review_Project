package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CryptTemplate;
import member.model.service.MemberService;
import member.model.vo.Member;
import member.model.vo.PasswordSecurity;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet implements CryptTemplate{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
				
		MemberService mservice = new MemberService();
		Member member = mservice.loginCheck(id,password);
		
		
		
		RequestDispatcher view = null;
		if(member!=null){
			PasswordSecurity ps = new PasswordSecurity(KEY_SIZE, ITERATION_COUNT);
			String decrypt = ps.decrypt(SALT, IV, PASSPHRASE, member.getPassword());
			member.setPassword(decrypt.trim());
			
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
				
			if(member.getUserType()==0){ //관리자
				response.sendRedirect("/review/views/admin/main/adminMain.jsp");
			}else{ //사용자
				response.sendRedirect("/review/views/main/main.jsp");
			}
		}else{
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			view.forward(request, response);
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
