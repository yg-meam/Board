<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세 내용 보기</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
//좋아요, 싫어요 처리
var likeCnt; 
var dislikeCnt; 
var myLikeCheck; 
var myDislikeCheck; 
var username;

//view.jsp 화면 로딩 시 좋아요/싫어요 값 가져와서 화면 구성
/*
$(document).ready(function(){
	likeCnt = ${view.likecnt}; 
	dislikeCnt = ${view.dislikecnt}; 
	myLikeCheck = '${myLikeCheck}'; 
	myDislikeCheck = '${myDislikeCheck}'; 
	username = '${userid}';
	$("#like").html(likeCnt);
	$("#dislike").html(dislikeCnt);
	
	if(myLikeCheck == "Y") $(".likeClick").css("background-color", "#00B9FF"); 
	    else if(myDislikeCheck == "Y") $(".dislikeClick").css("background-color", "#00B9FF"); 
	
	if(myLikeCheck == "Y") $("#myChoice").html(username + "님의 선택은 좋아요입니다."); 
	        else if(myDislikeCheck == "Y") $("#myChoice").html(username + "님의 선택은 싫어요입니다."); 
	        else if(myLikeCheck == "N" && myDislikeCheck == "N") $("#myChoice").html(username + "님은 아직 선택을 안 했네요"); 
});
*/
const startLikeView = () => {
	likeCnt = ${view.likecnt}; 
	dislikeCnt = ${view.dislikecnt}; 
	myLikeCheck = '${myLikeCheck}'; 
	myDislikeCheck = '${myDislikeCheck}'; 
	username = '${userid}';
	
	document.querySelector("#like").innerHTML = likeCnt;
	document.querySelector("#dislike").innerHTML = dislikeCnt;
	
	if(myLikeCheck == "Y") {
		document.querySelector(".likeClick").style.backgroundColor = "#00B9FF";
	} else if(myDislikeCheck == "Y") {
		document.querySelector(".dislikeClick").style.backgroundColor = "#00B9FF";
	}
	
	if(myLikeCheck == "Y") {
		document.querySelector("#myChoice").innerHTML = username + "님의 선택은 좋아요입니다.";
	} else if(myDislikeCheck == "Y") {
		document.querySelector("#myChoice").innerHTML = username + "님의 선택은 싫어요입니다.";
	} else if(myLikeCheck == "N" && myDislikeCheck == "N") {
		document.querySelector("#myChoice").innerHTML = username + "님은 아직 선택하지 않았습니다.";
	}
}

/*
function likeView(){ 
    
    if(myLikeCheck == "Y" && myDislikeCheck =="N") {
        alert("좋아요를 취소합니다."); 
        var checkCnt = 1;  //likeCnt --;
        myLikeCheck = "N";
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt); 
        $(".likeClick").css("background-color", "#d2d2d2"); 
    }else if(myLikeCheck == "N" && myDislikeCheck =="Y") {
        alert("싫어요가 취소되고 좋아요가 등록됩니다.");
        var checkCnt = 2; // likeCnt ++ , dislikeCnt --
        myLikeCheck = "Y";
        myDislikeCheck = "N";
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);  
        $(".likeClick").css("background-color", "#00B9FF"); 
        $(".dislikeClick").css("background-color", "#d2d2d2");
    } else if(myLikeCheck == "N" && myDislikeCheck =="N") {
        alert("좋아요를 선택 했습니다.")
    	var checkCnt = 3; //likeCnt ++
        myLikeCheck = "Y";
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        $(".likeClick").css("background-color", "#00B9FF"); 
    }
    if(myLikeCheck == "Y") $("#myChoice").html(username + "님의 선택은 좋아요입니다."); 
        else if(myDislikeCheck == "Y") $("#myChoice").html(username + "님의 선택은 싫어요입니다."); 
        else if(myLikeCheck == "N" && myDislikeCheck == "N") $("#myChoice").html(username + "님은 아직 선택을 안 했네요"); 
}
*/
const likeView = () => {
	if(myLikeCheck == "Y" && myDislikeCheck =="N") {
		alert("좋아요를 취소합니다."); 
		
        const checkCnt = 1;  //likeCnt --;
        myLikeCheck = "N";
        
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        
        document.querySelector(".likeClick").style.backgroundColor = "#d2d2d2";
	} else if(myLikeCheck == "N" && myDislikeCheck =="Y") {
		alert("싫어요가 취소되고 좋아요가 등록됩니다.");
		
        const checkCnt = 2; // likeCnt ++ , dislikeCnt --
        myLikeCheck = "Y";
        myDislikeCheck = "N";
        
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        
        document.querySelector(".likeClick").style.backgroundColor = "#00B9FF";
        document.querySelector(".dislikeClick").style.backgroundColor = "#d2d2d2";
	} else if(myLikeCheck == "N" && myDislikeCheck =="N") {
		alert("좋아요를 선택 했습니다.");
		 
	    const checkCnt = 3; //likeCnt ++
	    myLikeCheck = "Y";
	    
	    sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
	    
	    document.querySelector(".likeClick").style.backgroundColor = "#00B9FF";
	}
	
	if(myLikeCheck == "Y") {
		document.querySelector("#myChoice").innerHTML = username + "님의 선택은 좋아요입니다.";
	} else if(myDislikeCheck == "Y") {
		document.querySelector("#myChoice").innerHTML = username + "님의 선택은 싫어요입니다.";
	} else if(myLikeCheck == "N" && myDislikeCheck == "N") {
		document.querySelector("#myChoice").innerHTML = username + "님은 아직 선택하지 않았습니다.";
	}
}

/*
function disLikeView() {
    
    if(myDislikeCheck == "Y" && myLikeCheck =="N") {
        alert("싫어요를 취소합니다."); 
        var checkCnt = 4; // dislikeCnt --
        myDislikeCheck = "N";
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        $(".dislikeClick").css("background-color", "#d2d2d2"); 
    } else if(myDislikeCheck = "N" && myLikeCheck =="Y") {
        alert("좋아요가 취소되고 싫어요가 등록됩니다.");
        var checkCnt = 5; //likeCnt -- , dislikeCnt ++            
        myLikeCheck = "N";            
        myDislikeCheck = "Y";
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        $(".likeClick").css("background-color", "#d2d2d2"); 
        $(".dislikeClick").css("background-color", "#00B9FF"); 
    } else if(myDislikeCheck = "N" && myLikeCheck =="N") {
        alert("싫어요를 선택했습니다.");
    	var checkCnt = 6; //dislikeCnt ++
        myDislikeCheck = "Y";
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        $(".dislikeClick").css("background-color", "#00B9FF"); 
    }
    if(myLikeCheck == "Y") $("#myChoice").html(username + "님의 선택은 좋아요입니다."); 
        else if(myDislikeCheck == "Y") $("#myChoice").html(username + "님의 선택은 싫어요입니다."); 
        else if(myLikeCheck == "N" && myDislikeCheck == "N") $("#myChoice").html(username + "님은 아직 선택을 안 했네요"); 
}
*/
const disLikeView = () => {
	if(myDislikeCheck == "Y" && myLikeCheck =="N") {
		alert("싫어요를 취소합니다.");
		
        const checkCnt = 4; // dislikeCnt --
        myDislikeCheck = "N";
        
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        
        document.querySelector(".dislikeClick").style.backgroundColor = "#d2d2d2";
	} else if(myDislikeCheck = "N" && myLikeCheck =="Y") {
		alert("좋아요가 취소되고 싫어요가 등록됩니다.");
		
        const checkCnt = 5; //likeCnt -- , dislikeCnt ++            
        myLikeCheck = "N";            
        myDislikeCheck = "Y";
        
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        
        document.querySelector(".likeClick").style.backgroundColor = "#d2d2d2";
        document.querySelector(".dislikeClick").style.backgroundColor = "#00B9FF";
	} else if(myDislikeCheck = "N" && myLikeCheck =="N") {
		alert("싫어요를 선택했습니다.");
		
    	const checkCnt = 6; //dislikeCnt ++
        myDislikeCheck = "Y";
    	
        sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
        
        document.querySelector(".dislikeClick").style.backgroundColor = "#00B9FF";
	}
	
	if(myLikeCheck == "Y") {
		document.querySelector("#myChoice").innerHTML = username + "님의 선택은 좋아요입니다.";
	} else if(myDislikeCheck == "Y") {
		document.querySelector("#myChoice").innerHTML = username + "님의 선택은 싫어요입니다.";
	} else if(myLikeCheck == "N" && myDislikeCheck == "N") {
		document.querySelector("#myChoice").innerHTML = username + "님은 아직 선택하지 않았습니다.";
	}
}

/*
function sendDataToServer(myLike, myDislike, checkCount) {

    var myLikeCheck = myLike;
    var myDislikeCheck = myDislike;
    var checkCnt = checkCount;
    
    var queryString = {"seqno":${view.seqno},"userid":"${userid}",
    		"mylikecheck":myLikeCheck,"mydislikecheck":myDislikeCheck,"checkCnt":checkCnt};
    $.ajax({ //JSON --> MAP 타입일 경우 contentType를 반드시 입력...
        url: "/board/likeCheck",
        method: "POST",
        data: JSON.stringify(queryString),
        contentType: 'application/json; charset=UTF-8',
        dataType : "json",
        success: function(map) {
            $("#like").html(map["likeCnt"]);
            $("#dislike").html(map["dislikeCnt"]);
        },
        error: function(map) {
			alert("서버오류 문제로 좋아요/싫어요 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
  	    	return false;
		}
    }); //End of ajax

}
*/
const sendDataToServer = async(myLike, myDislike, checkCount) => {
	const myLikeCheck = myLike;
    const myDislikeCheck = myDislike;
    const checkCnt = checkCount;
    const data = {"seqno":${view.seqno},"userid":"${userid}",
    		"mylikecheck":myLikeCheck,"mydislikecheck":myDislikeCheck,"checkCnt":checkCnt};
    
    await fetch("/board/likeCheck", {
    	method: "POST",
    	headers: {
    		"content-type": "application/json"
    	},
    	body: JSON.stringify(data)
    }).then((response) => response.json())
    .then((map) => {
    	document.querySelector("#like").innerHTML = map["likeCnt"];
    	document.querySelector("#dislike").innerHTML = map["dislikeCnt"];
    })
    .catch((error) => {
    	console.log("error= " + error);
    	alert("서버오류 문제로 좋아요/싫어요 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
    })
}

//게시글 삭제
const deleteBoard = () => {
	if(confirm("정말로 삭제하시겠습니까?"))
		document.location.href='/board/delete?seqno=${view.seqno}';
}
	
//댓글
const replyRegister = async () => { //form 데이터 전송 --> 반드시 serialize()를 해야 한다.
/*	
	if($("#replycontent").val() == "") {alert("댓글을 입력하세요."); $("#replycontent").focus(); return false;}
		
	var queryString = $("form[name=replyForm]").serialize();
	//serialize --> 데이터를 스트림으로 보내기 위한 타입으로 바꾸는 함수.
	$.ajax({
		url : "reply?option=I",
		type : "post",
		datatype : "json",
		data : queryString,
		success : replyList,
		error : function(data) {
			alert("서버오류 문제로 댓글 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
	        return false;
		}
	}); //End of ajax
	
	$("#replycontent").val("");	
	*/
	const replycontent = document.querySelector('#replycontent');
	
	if(replycontent.value == '') {
		alert("댓글을 입력하세요.");
		replycontent.focus();
		return false;
	}
	
	const data = {			
		replywriter: replywriter.value, 
		replycontent: replycontent.value,
		userid: userid.value,
		seqno: seqno.value			
	}
	
	await fetch('/board/reply?option=I', {
		method: 'POST',
		headers: {"content-type":"application/json"},
		body: JSON.stringify(data)		
	}).then((response) => response.json())
	  .then((data) => replyList(data))
	  .catch((error)=> {
		  console.log("error = " + error);
		  alert("시스템 장애로 댓글 등록이 실패했습니다.");
	});
	
	replycontent.value = '';
}

const replyList = (data) => {
		
	var session_userid = '${userid}';
	const jsonInfo = data;
		
	let replyList = document.querySelector('#replyList');
	
	replyList.innerHTML = '';
		
	var result = "";
	
	for(const i in jsonInfo){
		let elm = document.createElement('div'); //<div></div>
		
		elm.setAttribute("id", "s" + data[i].replyseqno); //<div id='s3'></div>
		elm.setAttribute("style", "font-size: 0.8em"); //<div id='s3' style='font-size: 0.8em'></div>
			
		let result = "";
			
		//result += "<div id='replyListView'>";
		//result += "<div id = '" + jsonInfo[i].replyseqno + "' style='font-size: 0.8em'>";

		result += "작성자 : " + jsonInfo[i].replywriter;
						
		if(jsonInfo[i].userid == session_userid) {
			result += "[<a href=" + "'javascript:replyModify(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>수정</a> | " ;
			result += "<a href=" + "'javascript:replyDelete(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>삭제</a>]" ;
		}
			
		result += "&nbsp;&nbsp;" + jsonInfo[i].replyregdate
		result += "<div style='width:90%; height: auto; border-top: 1px solid gray; overflow: auto;'>";
		result += "<pre id='c" + jsonInfo[i].replyseqno + "'>" + jsonInfo[i].replycontent + "</pre></div>";
		//result += "</div>";
		//result += "</div><br>";
		result += "<br>";
			
		elm.innerHTML = result;
		
		replyList.appendChild(elm);
	}
	//$("#replyListView").remove();
	//$("#replyList").html(result);
}

const startupPage = async () => {	
	/*	
	var queryString = { "seqno": "${view.seqno}" };
		$.ajax({
			url : "reply?option=L",
			type : "post",
			datatype : "json",
			data : queryString,
			success : replyList,
			error : function(data) {
				alert("서버 오류로 댓글 불러 오기가 실패했습니다.");
	            return false;
	            }
		});
	*/
	const data = { seqno: "${view.seqno}" };
		
	await fetch('/board/reply?option=L', {
		method: 'POST',
		headers: {"content-type":"application/json"},
		body: JSON.stringify(data)		
	}).then((response) => response.json())
	.then((data) => replyList(data))
	.catch((error)=> {
		console.log("error = " + error);
		alert("시스템 장애로 댓글 등록이 실패했습니다.");
	});
}

const replyDelete = async (replyseqno) => { 
	if(confirm("정말로 삭제하시겠습니까?") == true) {
		/*	var queryString = { "replyseqno": replyseqno, "seqno":${view.seqno} };
			$.ajax({
				url : "reply?option=D",
				type : "post",
				data : queryString,
				dataType : "json",
				success : replyList,
				error : function(data) {
							alert("서버오류 문제로 댓글 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
		            		return false;
				}
			});
		*/
		const data = { replyseqno: replyseqno, seqno: ${view.seqno}};
		
		await fetch('/board/reply?option=D',{
			method: 'POST',
			headers: {
				"content-type": "application/json"
			},
			body: JSON.stringify(data)				
		}).then((response) => response.json())
		.then((data) => replyList(data))
		.catch((error) => {
			console.log("error =" + error);
			alert("서버 장애로 댓글 삭제가 실패했습니다.");
			});
	}
}

const replyModify = (replyseqno) => {
	//var replyContent = $("." + replyseqno).html();
	const modifyReplyContent = document.querySelector('#c' + replyseqno);
		
	var strReplyList = "작성자 : ${session_userid}&nbsp;"
					+ "<input type='button' id='btn_replyModify' value='수정'>"
					+ "<input type='button' id='btn_replyModifyCancel' value='취소'>"
					+ "<input type='hidden' name='replyseqno' value='" + replyseqno + "'>"
					+ "<input type='hidden' name='seqno' value='${view.seqno}'>"
					+ "<input type='hidden' id='writer' name='replywriter' value='${session_username}'>"
					+ "<input type='hidden' id='uerid' name='userid' value='${session_userid}'><br>"
					+ "<textarea id='modify_replycontent' name='replycontent' cols='80' rows='5' maxlength='150' placeholder='글자수:150자 이내'>" + modifyReplyContent.innerHTML + "</textarea><br>";
		
	let elm = document.createElement('div');
	
	elm.innerHTML = strReplyList;
		
	let parentDiv = document.querySelector('#s' + replyseqno).parentNode;
	
	parentDiv.insertBefore(elm, document.querySelector('#s' + replyseqno));
	
	document.querySelector('#s' + replyseqno).style.display = 'none';
						
	//$('#' + replyseqno).after(strReplyList);				
	//$('#' + replyseqno).remove();
	/*
	$("#btn_replyModify").on("click", function(){
		var queryString = $("form[name=formModify]").serialize();
		$.ajax({
			url : "reply?option=U",
			type : "post",
			dataType : "json",
			data : queryString,
			success : replyList,
			error : function(data) {
				alert("서버오류 문제로 댓글 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
		        return false;
		        }
		});
	});
		
	$("#btn_replyModifyCancel").on("click", function(){
		if(confirm("정말로 취소하시겠습니까?") == true  ) {
			$("#replyListView").remove();
			startupPage();
		}
	});	 
	*/
		
	const btnReplyModify = document.querySelector('#btn_replyModify');
	const btnReplyModifyCancel = document.querySelector('#btn_replyModifyCancel');
		
	btnReplyModify.addEventListener('click', async ()=> {
		const data = {
				replyseqno: replyseqno,
				replycontent: modify_replycontent.value
				};
	
		await fetch('/board/reply?option=U',{
			method: 'POST',
			headers: {
				"content-type": "application/json"
				},
				body: JSON.stringify(data)
				}).catch((error) => {
					console.log("error = " + error);
					alert("서버 장애로 댓글 수정이 실패했습니다.");
					});
		
		document.querySelector('#replyList').innerHTML = '';
			
		startupPage();				
	});
		
	btnReplyModifyCancel.addEventListener('click',()=> {
		if(confirm("정말로 취소하시겠습니까?") == true){
			document.querySelector('#replyList').innerHTML = '';
		
			startupPage();	
		}
	});	
}
		
const replyCancel = () => { 
	if(confirm("정말로 취소 하시겠습니까?") == true) { 
		replycontent.value = '';
		
		replycontent.focus();
	}
}
</script>
</head>

<body onload="startupPage(); startLikeView();">
<%
	String userid = (String)session.getAttribute("userid");
	if(userid == null) response.sendRedirect("/user/login");
%>

<div>
	<img id="topBanner" src="/resources/images/logo.jpg" title="서울기술교육센터">	
</div>

<div class="main" align="center">
	<h1>게시물 내용</h1><br>
	
	<div class="boardView">
		<div class="field">이름 : ${view.writer}</div>
		<div class="field">제목 : ${view.title}</div>
		<div class="field">날짜 : ${view.regdate}</div>
		<div class="content"><pre>${view.content}</pre></div>
		<div class="likeForm" style="width: auto; margin: auto; text-align: center;">
         	<span id='like'></span>&nbsp;<a href='javascript:likeView()' id="likeClick" class="likeClick">좋아요</a>
        	<a href="javascript:disLikeView()" id="disLikeClick" class="dislikeClick">싫어요</a>&nbsp;<span id="dislike"></span><br>
  			<span id='myChoice' style='color:red;'></span>
        </div><br>
		<c:if test="${fileListView != null}">
        	<c:forEach items="${fileListView}" var="fileView">
				<div class="field">파일명 : <a href="/board/fileDownload?fileseqno=${fileView.fileseqno}">${fileView.org_filename}</a> ( ${fileView.filesize} Byte )</div>
			</c:forEach>
		</c:if>
		<c:if test="${fileListView == null}">
			<div class="field">업로드된 파일이 없습니다.</div>
		</c:if><br><br>
	</div><br>
	
	<div class="bottom_menu">
		<c:if test="${pre_seq != 0}">
			&nbsp;&nbsp;<a href="/board/view?seqno=${pre_seq}&page=${page}&keyword=${keyword}">이전글▼</a>&nbsp;&nbsp;
		</c:if>
		<a href="/board/list?page=${page}&keyword=${keyword}">목록보기</a>&nbsp;&nbsp;
		<c:if test="${next_seqno != 0}">
			<a href="/board/view?seqno=${next_seqno}&page=${page}&keyword=${keyword}">다음글▲</a>&nbsp;&nbsp;
		</c:if>
		<a href="/board/write">글 작성</a>&nbsp;&nbsp;
		<c:if test="${userid == view.userid}">
			<a href="/board/modify?seqno=${view.seqno}&page=${page}&keyword=${keyword}">글 수정</a>&nbsp;&nbsp;
			<a href="javascript:deleteBoard()">글 삭제</a>
		</c:if>
	</div><br>
	
	<div class="replyDiv" style="width:60%; height:300px; margin:auto; text-align:left;">
		<p id="replyNotice">댓글을 작성해 주세요</p>
		
		<form id="replyForm" name="replyForm" method="POST"> 
			작성자 : <input type="text" id="replywriter" name="replywriter" value="${userid}" readonly><br>
	    	<textarea id='replycontent' name='replycontent' cols='80' rows='5' maxlength='150' placeholder='글자수:150자 이내'></textarea><br>
	    	<input type="hidden" id="seqno" name="seqno" value="${view.seqno}">
	    	<input type="hidden" id="userid" name="userid" value="${userid}">
		</form>
		
		<input type="button" id="btn_reply" value="댓글등록" onclick="replyRegister()">
		<input type="button" id="btn_cancel" value="취소" onclick="replyCancel()"><br>
		
		<div id="replyList" style="width:100%; height:600px; overflow:auto;"></div>		
	</div>
</div><br><br>
</body>
</html>