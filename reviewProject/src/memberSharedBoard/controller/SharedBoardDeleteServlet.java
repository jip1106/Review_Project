package memberSharedBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memberSharedBoard.model.service.SharedBoardService;

/**
 * Servlet implementation class SharedBoardDeleteServlet
 */
@WebServlet("/sdelete")
public class SharedBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedBoardDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
	
		int currentPage = Integer.parseInt(request.getParameter("page"));
		int location = Integer.parseInt(request.getParameter("location")); // 0 이면 정보공유 게시판에서 삭제하는거
		int index = 0; 
		
		if(location==1){
			index = Integer.parseInt(request.getParameter("index")); //0이면 정보공유 게시판에서 제목 눌러서 디테일로 들어와서 삭제 버튼 누르는거
		}											//1이면 마이페이지에서 내가 쓴 정보공유 글 들어가서 제목 눌러서 디테일로 들어와서 삭제

		
		if(new SharedBoardService().deleteSharedBoard(Integer.parseInt(request.getParameter("no")) ) > 0) {
			if(location==0 && index ==0){		//정보공유 게시판에서 삭제		
				// 1이면 마이페이지 내가 쓴 정보공유 게시글 비고 에서 삭제하는거
				response.sendRedirect("/review/slist?page="+currentPage);
			}
			else if(location==1 && index ==1){	//마이페이지에서 삭제
				response.sendRedirect("/review/views/mypage/member/mysharewrite.jsp");
			}
			
		}else {
			RequestDispatcher view = request.getRequestDispatcher("views/shareboard/shareboardError.jsp");
			request.setAttribute("errorMessage", "정보공유 게시판 게시물 삭제 실패!");
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

