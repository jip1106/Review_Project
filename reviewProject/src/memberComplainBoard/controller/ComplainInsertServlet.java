package memberComplainBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memberComplainBoard.model.service.ComplainBoardService;
import memberComplainBoard.model.vo.ComplainBoard;

/**
 * Servlet implementation class ComplainInsertServlet
 */
@WebServlet("/cinsert")
public class ComplainInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ComplainInsertServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 게시글 원글 등록 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		ComplainBoard ComplainBoard = new ComplainBoard();
		ComplainBoard.setId(id);
		ComplainBoard.setTitle(title);
		ComplainBoard.setContent(content);
		


		// 처리결과에 따라 뷰 지정함
		if(new ComplainBoardService().insertBoard(ComplainBoard) > 0) {
			response.sendRedirect("/review/clist?page=1");
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
