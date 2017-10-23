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
 * Servlet implementation class ComplainUpdateServlet
 */
@WebServlet("/cupdate")
public class ComplainUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				// 게시글 수정페이지 출력 처리용 컨트롤러
				response.setContentType("text/html; charset=utf-8");
				
				int bnum = Integer.parseInt(request.getParameter("bnum"));
				//int currentPage = Integer.parseInt(request.getParameter("currentPage"));
				
				ComplainBoard Complainboard = new ComplainBoardService().selectBoard(bnum);
				
				RequestDispatcher view = null;
				if(Complainboard != null){
					view = request.getRequestDispatcher("views/complainboard/complainUpdateForm.jsp");
					request.setAttribute("Complainboard", Complainboard);
					//request.setAttribute("currentPage", currentPage);
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
