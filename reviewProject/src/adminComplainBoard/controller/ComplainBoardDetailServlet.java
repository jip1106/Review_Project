package adminComplainBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminComplainBoard.model.service.ComplainBoardService;
import memberComplainBoard.model.vo.ComplainBoard;

/**
 * Servlet implementation class NoticeDetailServlet
 */
@WebServlet("/cbdetail")
public class ComplainBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainBoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//신고게시판 게시글 상세보기 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int postNo = Integer.parseInt(request.getParameter("postno"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int limit= Integer.parseInt(request.getParameter("limit"));
		int endPage = Integer.parseInt(request.getParameter("endPage"));
		
		
		ComplainBoardService cbservice = new ComplainBoardService();
		
		//조회수 증가 처리
		cbservice.addReadCount(postNo);
		
		ComplainBoard board = cbservice.viewComplainBoardDetail(postNo);
		
		
		if(board != null){
			RequestDispatcher view = request.getRequestDispatcher("views/admin/board/complainboard/admincomplainDetail.jsp");
			request.setAttribute("board", board);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("limit", limit);
			
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
