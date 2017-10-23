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
 * Servlet implementation class SharedBoardDetailServlet
 */
@WebServlet("/sdetail")
public class SharedBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedBoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//정보공유 게시판 상세보기 
		response.setContentType("text/html;charset=utf-8");
		
		
		int index = 0;	//정보 공유 게시판에서 글 제목 눌렀을 때
		
		if(request.getParameter("index")!=null){
			index = Integer.parseInt(request.getParameter("index"));//마이 페이지 에서 글 제목 눌렀을 때
		}
		
		int no = Integer.parseInt(request.getParameter("no"));
		SharedBoardService sbService = new SharedBoardService();
		
		sbService.addReadCount(no);
		SharedBoard sharedBoard = sbService.selectSharedBoard(no);
		
		RequestDispatcher view = null;
		
		if(sharedBoard!=null){
			view = request.getRequestDispatcher("views/shareboard/shareboardDetail.jsp");
			request.setAttribute("sharedBoard", sharedBoard);
			request.setAttribute("index", index);
			view.forward(request, response);
			
		}else{
			view = request.getRequestDispatcher("views/shareboard/shareboardError.jsp");
			request.setAttribute("errorMessage", "정보공유 게시글 상세보기 실패!");
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
