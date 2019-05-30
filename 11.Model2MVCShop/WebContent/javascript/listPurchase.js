	function fncGetList(currentPage){
		$("input[name=currentPage]").val(currentPage);
		
//		alert($("input[name=currentPage]").val());
		
//		alert($("form").serialize());
		
		$("form[name=detailForm]").attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	function fncUpdatePurchaseCode(target,tranNo,tranCode){		
		UpdateData("transaction","tran_status_code",tranCode,tranNo,"tran_no",function(output){
		
			if(output){
				
				if(tranCode == 2){
					$(target.parent().parent().find("td")[4]).text("배송중");
				}else if(tranCode == 3){
					$(target.parent().parent().find("td")[4]).text("거래완료");
					target.parent().append("<a>리뷰작성</a>");
				}
				target.remove();
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
