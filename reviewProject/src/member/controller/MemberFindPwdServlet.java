package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CryptTemplate;
import member.model.service.MemberService;
import member.model.vo.PasswordSecurity;
import member.model.vo.RandomPassword;

/**
 * Servlet implementation class MemberFindPwdServlet
 */
@WebServlet("/memberFindPwd")
public class MemberFindPwdServlet extends HttpServlet implements CryptTemplate{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberFindPwdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String id = request.getParameter("id");
		
		String name = request.getParameter("name");
		
		String email = request.getParameter("email");
		
		
		MemberService service = new MemberService();
		String pwd = service.memberfindPwd(id,name,email);
		String value = "";
		
		if(pwd != null){
			
			int num = 5;
			RandomPassword rp = new RandomPassword();
			pwd = rp.getRandomPassword(num);
			
			service.insertChangePassword(id,pwd);
			String changePwd = service.selectPwd(id);
			PasswordSecurity ps = new PasswordSecurity(KEY_SIZE, ITERATION_COUNT);
			String decrypt = ps.decrypt(SALT, IV, PASSPHRASE, changePwd);
		
			value = decrypt;
			
			PrintWriter pw = response.getWriter();
			pw.println(value);
			pw.flush();
			pw.close();
		}else{
			value = "fail";
			PrintWriter pw = response.getWriter();
			pw.println(value);
			pw.flush();
			pw.close();
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
