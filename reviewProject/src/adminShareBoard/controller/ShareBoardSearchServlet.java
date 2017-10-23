package adminShareBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminShareBoard.model.service.ShareBoardService;
import memberSharedBoard.model.vo.SharedBoard;

/**
 * Servlet implementation class ShareBoardSearchServlet
 */
@WebServlet("/adminsbsearch")
public class ShareBoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShareBoardSearchServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 정보공유게시판 검색 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String selectSearch = request.getParameter("selectSearch"); // 제목 또는 작성자 선택
		String inputValue = request.getParameter("inputValue"); // 검색할 값

		// 페이지 처리용
		int currentPage = 1;

		// 페이지 숫자가 전송이 왔을 경우
		if (request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));

		// 한 페이지에 출력할 페이지 갯수 지정
		int limit = 5;

		ShareBoardService sb = new ShareBoardService();

		int shareBoardListCount = sb.getSearchCount(selectSearch, inputValue);

		int maxPage = (int) ((double) (shareBoardListCount) / limit + 0.9);
		int startPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		if (maxPage < endPage)
			endPage = maxPage;

		ArrayList<SharedBoard> list = new ArrayList<SharedBoard>();
		
		RequestDispatcher view = null;

		if (selectSearch.equals("searchid")) {
			list = sb.shareBoardSearchId(inputValue, currentPage, limit);
		} else if (selectSearch.equals("searchtitle")) {
			list = sb.shareBoardSearchTitle(inputValue, currentPage, limit);
		}

		if (list != null) {
			view = request.getRequestDispatcher("views/admin/board/shareboard/adminshareboard.jsp");
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("shareBoardListCount", shareBoardListCount);
			request.setAttribute("limit", limit);
			request.setAttribute("selectSearch", selectSearch);
			request.setAttribute("inputValue", inputValue);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/admin/board/shareboard/adminshareboard.jsp");
			request.setAttribute("message", "정보공유 글 검색 보기 실패!");
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
