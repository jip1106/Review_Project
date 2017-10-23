package adminShareBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminShareBoard.model.service.ShareBoardService;
import memberSharedBoard.model.vo.SharedBoard;

/**
 * Servlet implementation class ShareBoardDetailServlet
 */
@WebServlet("/adminsbdetail")
public class ShareBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShareBoardDetailServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//정보공육게시판 글 상세조회 처리용 컨트롤러
		response.setContentType("text/html; charset=utf-8");

		int no = Integer.parseInt(request.getParameter("no"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int limit = Integer.parseInt(request.getParameter("limit"));
		int endPage = Integer.parseInt(request.getParameter("endPage"));
		
		ShareBoardService sbservice = new ShareBoardService();
		
		int listCount = sbservice.getShareBoardListCount();
		int pagelistCount = 0;
		
		if(currentPage == endPage){
			pagelistCount = listCount%limit;
		}else{
			pagelistCount = limit;
		}
		
		// 조회수 1증가 처리
		sbservice.hitsUp(no);

		SharedBoard sb = sbservice.detailSharedBoard(no);

		RequestDispatcher view = null;
		if (sb != null) {
			view = request.getRequestDispatcher("views/admin/board/shareboard/adminshareDetail.jsp");
			request.setAttribute("sb", sb);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("limit", limit);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/admin/board/shareboard/adminshareDetail.jsp");
			request.setAttribute("message", "정보공유게시판 게시글 상세보기 실패!");
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
