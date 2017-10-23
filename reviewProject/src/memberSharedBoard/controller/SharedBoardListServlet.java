package memberSharedBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import memberSharedBoard.model.service.SharedBoardService;
import memberSharedBoard.model.vo.SharedBoard;

/**
 * Servlet implementation class SharedBoardListServlet
 */
@WebServlet("/slist")
public class SharedBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedBoardListServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//정보공유 게시판 페이지단위로 조회
		response.setContentType("text/html;charset=utf-8");
		
		int currentPage = 1;
		//한 페이지에 출력할 페이지 갯수
		int limit = 10;
		
		if(request.getParameter("page")!= null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		SharedBoardService sbService = new SharedBoardService();
		
		//전체목록 갯수 조회
		int listCount  = sbService.getListCount();
		
		ArrayList<SharedBoard> list = sbService.selectList(currentPage, limit);
		
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = ((int)((double) currentPage/ limit+ 0.9)-1) * limit + 1;
		
		int endPage = startPage + limit -1;
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		if(list != null){
			view = request.getRequestDispatcher("views/shareboard/shareboard.jsp");
			
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("views/shareboard/shareboardError.jsp");
			request.setAttribute("errorMessage", "정보공유 게시판 페이지별 조회 실패!");
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
