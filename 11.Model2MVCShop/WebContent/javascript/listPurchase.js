
	$(function(){
// 		$("a").wrapInner("<ins></ins>");
		
		var tranNoList = [${tranNoList}];
		var prodNoList = [${prodNoList}];
		
		$( "#dialog" ).dialog({
		      autoOpen: false
		});
		
		$("tr.ct_list_pop td:nth-child(5)").wrapInner("<ins></ins>");
		$("tr.ct_list_pop td:nth-child(5)").on("click",function(){
			location.href = "/product/getProduct?prodNo="+prodNoList[$($("td",$(this).parent())[0]).text()-1];
		});	
		
		$("tr.ct_list_pop td:nth-child(1)").wrapInner("<ins></ins>");
		$("tr.ct_list_pop td:nth-child(1)").on("click",function(){
			location.href = "/purchase/getPurchase?tranNo="+tranNoList[$(this).text()-1];
		});	
		
		$("a:contains('배송출발')").on("click",function(){
			fncUpdatePurchaseCode($(this).parent(),tranNoList[$($("td",$(this).parent().parent())[0]).text()-1], 2);
		});
		
		$("a:contains('수취확인')").on("click",function(){
			fncUpdatePurchaseCode($(this).parent(),tranNoList[$($("td",$(this).parent().parent())[0]).text()-1], 3)
		});
		
		$("a:contains('리뷰작성')").on("click",function(){
			var clickObj = $(this).parent().parent();
			var dataString = "/review/addReviewView.jsp?tranNo="+tranNoList[$($("td",$(this).parent().parent())[0]).text()-1]
				+ "&prodNo=" + prodNoList[$($("td",$(this).parent().parent())[0]).text()-1] + "&userId='" + $($(clickObj.find('td')[2])).text() + "'";

			alert(dataString);
			
			location.href = dataString;
		});
		
		$("a:contains('리뷰확인')").on("click",function(){
			var tranNo = tranNoList[$($("td",$(this).parent().parent())[0]).text()-1];
// 			alert(tranNo);
			var jsonObj = {tranNo:tranNo};
			var jsonString = JSON.stringify(jsonObj);
// 			alert(jsonString);

			var target = $(this);
			
			$.ajax({
				url:"/review/json/getReviewBytranNo",
				method:"POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data: jsonString,
				dataType: "json",
				error:function(){
					alert("error");
				},
				success:function(data){
		        	for(i in data) {
			   			console.log("no is " + [i] + ", value is " + data[i]);
					}
	
		        	var appendString = data.text;
// 		        	for(i in data) {
// 			   			appendString += [i] + " : " + data[i] + "<br/>";
// 					}
		        	
					$("#dialog").empty().append(appendString);
					$(".ui-dialog-title").empty().append(data.title);
					$( "#dialog" ).dialog( "option", "position", { my: "left top", at: "left bottom", of: target } );
					$( "#dialog" ).dialog( "open" );
				}
			});
		});
		
		$(".sort").on("click",function(){
			fncSortList(${resultPage.currentPage},$(".sort").index($(this)));
		});
		
		$("select[name=pageSize]").on("change",function(){
			fncGetList(${resultPage.currentPage});
		});
		
		$("#reset").on("click",function(){
			fncResetSearchCondition();
		});
		
		$("#unHidding").on("click",function(){
			fncHiddingEmptyStock(${resultPage.currentPage},false);
		});
		$("#hidding").on("click",function(){
			fncHiddingEmptyStock(${resultPage.currentPage},true);
		});
		
		$("#prePage").on("click",function(){
			fncGetList(${resultPage.beginUnitPage-1});
		});
		$(".page").on("click",function(){
			fncGetList($(this).text());
		});
		$("#nextPage").on("click",function(){
			fncGetList(${resultPage.endUnitPage+1});
		});
	});
	
	function fncGetList(currentPage){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=menu]").val("${param.menu}");

		$("form[name=detailForm]").submit();
	}
	
	function fncUpdatePurchaseCode(target,tranNo,tranCode){		
		UpdateData("transaction","tran_status_code",tranCode,tranNo,"tran_no",function(output){
		
			if(output){
				target.empty();
				if($(target.parent().find("td")[8]).text() == "배송준비중"){
					$(target.parent().find("td")[8]).text("배송중");
				}else if($(target.parent().find("td")[8]).text() == "배송중"){
					$(target.parent().find("td")[8]).text("거래완료");
				}
			}
		});
	}

	function fncSortList(currentPage, sortCode){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=menu]").val("${param.menu}");
		$("input[name=sortCode]").val(sortCode);

		$("form").submit();
	}

	function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=hiddingEmptyStock]").val(hiddingEmptyStock);

		$("form").submit();
	}

	function fncResetSearchCondition(){
		location.href = "/purchase/listPurchase";
	}
