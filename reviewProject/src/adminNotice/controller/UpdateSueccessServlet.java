package adminNotice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminNotice.model.service.NoticeService;

/**
 * Servlet implementation class UpdateSueccessServlet
 */
@WebServlet("/noticeUpdateSuccess")
public class UpdateSueccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateSueccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 수정 완료하기.
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int postNo = Integer.parseInt(request.getParameter("postno"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		System.out.println("서블릿 단 : " + postNo);
		System.out.println("서블릿 단 : " + title);
		System.out.println("서블릿 단 : " + content);
		
		int result = new NoticeService().updateNotice(postNo,title,content);
		
		if(result>0){
			response.sendRedirect("views/admin/main/adminMain.jsp");
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
