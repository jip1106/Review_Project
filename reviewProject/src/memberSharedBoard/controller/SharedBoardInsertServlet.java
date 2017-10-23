package memberSharedBoard.controller;

import java.io.IOException;

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
 * Servlet implementation class SharedBoardInsertServlet
 */
@WebServlet("/sinsert")
public class SharedBoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedBoardInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		SharedBoard sharedboard= new SharedBoard();
		
		sharedboard.setId(id);
		sharedboard.setTitle(title);
		sharedboard.setContent(content);
		
		if(new SharedBoardService().insertSharedBoard(sharedboard) > 0){
			response.sendRedirect("/review/slist");
		}else{
			RequestDispatcher view = request.getRequestDispatcher("views/shareboard/shareboardError.jsp");
			request.setAttribute("errorMessage", "정보공유 게시판 게시물 등록 실패!");
			view.forward(request, response);
		}
		
		System.out.println("서블릿: " + sharedboard); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
