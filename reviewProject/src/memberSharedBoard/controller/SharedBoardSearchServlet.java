package memberSharedBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memberSharedBoard.model.service.SharedBoardService;
import memberSharedBoard.model.vo.SharedBoard;

/**
 * Servlet implementation class SharedBoardSearchServlet
 */
@WebServlet("/ssearch")
public class SharedBoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedBoardSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		SharedBoardService sbService = new SharedBoardService();	
		
		int limit = 10;
		int currentPage = 1;
		String searchMenu = null;
		String keyword = null;
		
		if(request.getParameter("page")!= null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		
		searchMenu = request.getParameter("searchMenu");
		keyword = request.getParameter("keyword");
		
		//검색결과 목록 갯수 조회
		int listCount  = sbService.getListCount();
		int searchCount = sbService.getSearchCount(searchMenu, keyword);
		
		ArrayList<SharedBoard> list = null;
		
		if(request.getParameter("keyword")!=null || !request.getParameter("keyword").equals("")){
			list = sbService.titleSearch(currentPage, limit, searchMenu, keyword);
		}else{
			list = sbService.selectList(currentPage, limit);
		}
			
		
		int maxPage = (int)((double)searchCount / limit + 0.9);
		int startPage = ((int)((double) currentPage/ limit+ 0.9)-1) * limit + 1;
		
		int endPage = startPage + limit -1;
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		if(list != null) {
			view = request.getRequestDispatcher("views/shareboard/shareboard.jsp");
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("searchMenu", searchMenu);
			request.setAttribute("keyword", keyword);
			request.setAttribute("searchCount", searchCount);
	
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/shareboard/shareboardError.jsp");
			request.setAttribute("errorMessage", "정보공유 게시판 게시물 검색 실패!");
			view.forward(request, response);
		}
		System.out.println(keyword);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
