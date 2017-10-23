package adminNotice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminNotice.model.service.NoticeService;
import adminNotice.model.vo.Notice;

/**
 * Servlet implementation class ViewNoticeDetail
 */
@WebServlet("/noticeDetail")
public class ViewNoticeDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewNoticeDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 상세보기 위한 서블릿 
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int postNo = Integer.parseInt(request.getParameter("postno"));
		
		NoticeService nservice = new NoticeService();
		nservice.addReadCount(postNo); //조회수 추가 메서드
		
		Notice notice = nservice.viewNoticeDetail(postNo);
		System.out.println("notice ::  " + notice);
	
		RequestDispatcher view = null;
		
		if(notice!=null){
			view = request.getRequestDispatcher("views/admin/notice/noticeDetail.jsp");
			request.setAttribute("notice", notice);
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
