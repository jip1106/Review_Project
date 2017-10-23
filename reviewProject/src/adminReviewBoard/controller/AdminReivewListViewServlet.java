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
 * Servlet implementation class AdminReivewListView
 */
@WebServlet("/adminReviewList")
public class AdminReivewListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReivewListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자 페이지에서 게시물들을 보여주는 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int currentPage = 1;
		
		int limit = 9;
		
		if(request.getParameter("page")!=null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		ReviewBoardService rservice = new ReviewBoardService();
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
			
		int listCount = rservice.getReviewListCount();
		int maxPage = (int)((double)listCount/limit + 0.9);
	
		int startPage = ((int)((double)currentPage / limit + 0.9) - 1) * limit + 1;
	
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage){
			endPage = maxPage;
		}
		
		list = rservice.viewAllReviewBoard(currentPage,limit);
		
		if(list != null){
			RequestDispatcher view = request.getRequestDispatcher("views/admin/board/reviewboard/adminreviewboard.jsp");
			
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			
			
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
