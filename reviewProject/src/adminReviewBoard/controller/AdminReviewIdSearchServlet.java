package adminReviewBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminReviewBoard.model.service.ReviewBoardService;
import memberReviewBoard.model.vo.ReviewBoard;

/**
 * Servlet implementation class AdminReviewIdSearchServlet
 */
@WebServlet("/adminReviewIdSearch")
public class AdminReviewIdSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReviewIdSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// id로 리뷰게시판 게시글 검색해주는 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("type/html; charset=utf-8");
		
		String id = request.getParameter("id");
		int currentPage = Integer.parseInt(request.getParameter("page"));
		int limit = 9;
	
		ReviewBoardService rservice = new ReviewBoardService();
		
		ArrayList<ReviewBoard> list = rservice.viewSearchByID(id, currentPage, limit);
		
		
		int listCount = rservice.getSearchIdCount(id);
		System.out.println("=============="+listCount);
		int maxPage = (int)((double)listCount/limit + 0.9);
		
		int startPage = ((int)((double)currentPage / limit + 0.9) - 1) * limit + 1;
	
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage){
			endPage = maxPage;
		}
		
		if(list!=null){
			RequestDispatcher view = request.getRequestDispatcher("views/admin/board/reviewboard/adminreviewboard.jsp");
			request.setAttribute("list", list);
			request.setAttribute("listCount", listCount);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("id", id);
			
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
