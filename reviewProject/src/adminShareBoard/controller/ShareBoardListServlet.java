package adminShareBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminShareBoard.model.service.ShareBoardService;
import memberSharedBoard.model.vo.SharedBoard;

/**
 * Servlet implementation class ShareBoardListServlet
 */
@WebServlet("/adminsblist")
public class ShareBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShareBoardListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 정보공유 글목록 보기 (전체보기)
		response.setContentType("text/html; charset=utf-8");
		
		String selectSearch = request.getParameter("selectSearch");
		String inputValue = request.getParameter("inputValue");
		
		// 페이지 처리용
		int currentPage = 1;
		// 한 페이지에 출력할 페이지 갯수 지정
		int limit = 5;

		// 페이지 숫자가 전송이 왔을 경우
		if (request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		
		ShareBoardService sb = new ShareBoardService();
		
		int shareBoardListCount = 0;
		
		// 게시글 갯수 조회
		if(request.getParameter("inputValue")==null){
			shareBoardListCount = sb.getShareBoardListCount();
		}else{
			shareBoardListCount = sb.getSearchCount(selectSearch, inputValue);			
		}
		
		ArrayList<SharedBoard> list = sb.selectList(currentPage, limit);
		
		if(request.getParameter("inputValue")==null){
			list = sb.selectList(currentPage, limit);
		}else{
			if(selectSearch.equals("searchid")){ 			
				list = sb.shareBoardSearchId(inputValue, currentPage,limit);
			}
			else if(selectSearch.equals("searchtitle")){
				list = sb.shareBoardSearchTitle(inputValue, currentPage,limit);
			}
			
		}
		
		int maxPage = (int)((double)shareBoardListCount / limit + 0.9);
		int startPage = ((int)((double)currentPage / limit + 0.9) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		if (list != null) {
			view = request.getRequestDispatcher("views/admin/board/shareboard/adminshareboard.jsp");
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("shareBoardListCount", shareBoardListCount);
			request.setAttribute("limit", limit);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/admin/board/shareboard/adminshareboard.jsp");
			request.setAttribute("message", "정보공유 글목록 보기 실패!");
			view.forward(request, response);
		}
		
		if(request.getParameter("inputValue")!=null){
			request.setAttribute("inputValue", inputValue);
		}
		
		if(request.getParameter("selectSearch")!=null){
			request.setAttribute("selectSearch", selectSearch);
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
