package memberSharedBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memberSharedBoard.model.service.SharedBoardService;
import memberSharedBoard.model.vo.SharedBoard;

/**
 * Servlet implementation class SharedBoardUpdateServlet
 */
@WebServlet("/supdate")
public class SharedBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedBoardUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//수정 처리용 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		SharedBoard sb = new SharedBoard();
		sb.setPostingNum(Integer.parseInt(request.getParameter("no")));
		sb.setTitle(request.getParameter("title"));
		sb.setContent(request.getParameter("content"));
		
		if(new SharedBoardService().updateSharedBoard(sb)>0){
			response.sendRedirect("/review/slist");
		}else{
			RequestDispatcher view = request.getRequestDispatcher("views/shareboard/shareboardError.jsp");
			request.setAttribute("errorMessage", "정보공유 게시판 게시물 수정 실패!");
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
