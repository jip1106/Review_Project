package adminComplainBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminComplainBoard.model.service.ComplainBoardService;
import memberComplainBoard.model.vo.ComplainBoard;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/cbsearch")
public class ComplainBoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainBoardSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 신고게시판 검색 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String searchMenu = request.getParameter("searchMenu");	//제목, 작성자
		String searchValue = request.getParameter("searchValue"); //검색 폼에 입력한 값.
		
		int currentPage = 1;
		
		if(request.getParameter("page") !=null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		} 
		
		int limit = 5; 
			
		ComplainBoardService cbservice = new ComplainBoardService();
		
		int listCount = cbservice.getSearchCount(searchValue,searchMenu);
		//제목, 아이디에 따라 검색했을때 나온 게시글의 수									
		int maxPage = (int)((double)(listCount)/limit+0.9);
		//총 페이지수를 계산할 때 검색한 게시글의 갯수 기준으로 해야되서 listCount
		int startPage =  ((int)((double)currentPage/limit + 0.9)-1)*limit +1 ;
		int endPage =  startPage + limit-1;
	
		
		if(maxPage < endPage){
			endPage = maxPage;
		}
		
		ArrayList<ComplainBoard> searchList = new ArrayList<ComplainBoard>();
					
		RequestDispatcher view = null;
		
		//System.out.println(searchMenu.equals("findByTitle"));
		
		if(searchMenu.equals("findByWriter")){ 			
			searchList = cbservice.viewSearchById(searchValue,currentPage,limit);
		}
		else if(searchMenu.equals("findByTitle")){
			searchList = cbservice.viewSearchByTitle(searchValue,currentPage,limit);
		}
		
				
		if(searchList!=null){			
			view = request.getRequestDispatcher("views/admin/board/complainboard/admincomplainboard.jsp");
			request.setAttribute("list", searchList);
			request.setAttribute("startPage", startPage);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("limit", limit);
			request.setAttribute("searchMenu",searchMenu );
			request.setAttribute("searchValue", searchValue);
					
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
