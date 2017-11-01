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
 * Servlet implementation class ComplainUpdate
 */
@WebServlet("/cup")
public class ComplainUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ComplainUpdate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 공지글 수정 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int currentPage = Integer.parseInt(request.getParameter("Page"));
		ComplainBoard ComplainBoard = new ComplainBoard();
		
		ComplainBoard.setPostingNo(Integer.parseInt(request.getParameter("postno")));
		ComplainBoard.setTitle(request.getParameter("title"));
		ComplainBoard.setContent(request.getParameter("content"));
		
	
		// 처리결과에 따라 뷰 지정함
		if(new ComplainBoardService().ComplainBoardUpdate(ComplainBoard) > 0) {
			int bnum = ComplainBoard.getPostingNo();
			response.sendRedirect("/review/cdetail?bnum="+bnum+"&Page="+currentPage);
		}else
			System.out.println("헤헤.. 내가 나와버림");
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
